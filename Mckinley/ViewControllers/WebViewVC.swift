//
//  WebViewVC.swift
//  McKinleyPOC
//
//  Created by ASHWANI  KUMAR on 22/12/19.
//  Copyright © 2019 ASHWANI  KUMAR. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {

    @IBOutlet var wkWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let token = UserDefaultsHelper.readPreferencesString(key: UserDefaultKeys.token) {
            let url = URL(string: "https://www.mckinleyrice.com?token=\(token)*")
            let requestObj = URLRequest(url: url! as URL)
            wkWebView.load(requestObj)

        }
        
                // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
