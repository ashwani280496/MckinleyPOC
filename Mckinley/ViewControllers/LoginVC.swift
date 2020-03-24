//
//  LoginVC.swift
//  McKinleyPOC
//
//  Created by ASHWANI  KUMAR on 21/12/19.
//  Copyright © 2019 ASHWANI  KUMAR. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var posswordTextField: UITextField!
    var currTF :UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate=self
        posswordTextField.delegate=self
        if UserDefaultsHelper.readPreferencesBoolean(key: UserDefaultKeys.isLogin){
            openWebViewController()
        }
    }
    
    @IBAction func LoginButtonAction(_ sender: Any) {
        
        if validateData(){
            login()
        }
    }
    
    var frameForKeyboard : CGFloat? = 400 //default size
    func moveScrollUp(){
        if currTF != nil {
            if (self.currTF?.frame.origin.y)! - scrollView.contentOffset.y > self.view.frame.height - (frameForKeyboard)! - 50
            {
                self.scrollView.contentOffset.y += (self.currTF?.frame.origin.y)! - scrollView.contentOffset.y - self.view.frame.height + (frameForKeyboard)! + 50
                
                self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width, height: scrollView.frame.height + frameForKeyboard!)
                
            }
        }
    }
    
    func moveScrollDown(){
        if currTF != nil {
            self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width, height: scrollView.frame.height)
            self.scrollView.contentOffset.y -= 0
            currTF = nil
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func validateData() -> Bool {
        if (idTextField.text?.elementsEqual(""))!{
            showToast(controller: self, message : "Please enter Valid ID", seconds: 2.0)
            return false
        }
        else if (posswordTextField.text?.elementsEqual(""))!{
            showToast(controller: self, message : "Please enter Password", seconds: 2.0)
            return false
        }
        return true
    }
    
    func login(){
        
        print("API Call for login")
        var params:[String:Any] = [:]
        params["email"] = idTextField.text
        params["password"] = posswordTextField.text
        
        let request = APIRequestHelper.loginTask(parameters: params as [String : AnyObject])
        
        request.perform(withSuccess: {response in
            self.idTextField.text = ""
            self.posswordTextField.text = ""
            UserDefaultsHelper.saveBooleanPreferences(key: UserDefaultKeys.isLogin, value: true)
            UserDefaultsHelper.saveStringPreferences(key: UserDefaultKeys.token, value: response.token)
            self.openWebViewController()
            
        }, failure: {error in
            print("error")
        })
    }
    
    func openWebViewController(){
        
        let webViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewVC") as? WebViewVC
        self.navigationController?.pushViewController(webViewController!, animated: true)
        
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ action in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)

    }
}


extension LoginVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.currTF = self.idTextField
        self.moveScrollUp()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.moveScrollDown()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           if (textField == idTextField){
               return posswordTextField.becomeFirstResponder()
           }else if (textField == posswordTextField){
            posswordTextField.resignFirstResponder()
               if validateData(){
                   login()
               }
           }
           return true
       }
}
