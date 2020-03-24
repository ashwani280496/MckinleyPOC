//
//  APIRequestHelper.swift
//  Mckinley
//
//  Created by ASHWANI  KUMAR on 25/03/20.
//  Copyright © 2020 ASHWANI  KUMAR. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON
import Alamofire

class APIRequestHelper{

static let tron = TRON(baseURL: APIRequestConstants.baseUrl)

static func loginTask(parameters: [String:AnyObject]) -> APIRequest<LoginResponseModel, APIErrorModel> {

    let request: APIRequest<LoginResponseModel, APIErrorModel> = tron.codable.request(APIRequestConstants.loginUrl)
    request.method = .post
    request.parameters = parameters
    request.parameterEncoding = JSONEncoding.default
    return request
}
}
