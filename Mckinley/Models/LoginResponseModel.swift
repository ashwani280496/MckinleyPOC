//
//  LoginResponseModel.swift
//  Mckinley
//
//  Created by ASHWANI  KUMAR on 25/03/20.
//  Copyright © 2020 ASHWANI  KUMAR. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON


struct LoginResponseModel :Codable{
    var token:String!
}

class APIErrorModel: Codable {
    var status_code : Int?
    var detail : String?
}
