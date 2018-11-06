//
//  APIClient.swift
//  Excercise
//
//  Created by Umesh Verma on 06/11/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Either<T> {
    case success(Response)
    case error(Error)
}

enum APIError: Error {
    case unknown, badResponse, jsonDecoder
}

class APIClient {
    
    //Class Stuff here
    
    //MARK: - Url of the API
    let baseUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    //MARK: - Fetch API Response Using Alamofire
    func fetch(_ completion: @escaping (Either<Response>) -> Void) {
        
        let utilityQueue = DispatchQueue.global(qos: .background)
        
        //MAR: - Convert String to iSO Latin for encoding Then send to Server
        Alamofire.request(baseUrl).responseString(queue: utilityQueue, encoding: .isoLatin1) { (response) in
            if let jsonString  = response.result.value, let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
                
                do {
                    //Parse Data to JSON
                    let json = try JSON(data: dataFromString)
                    print(json)
                    
                    let responseJson = Response(json: json)
                    DispatchQueue.main.async {
                        //Success fully Parse Json
                        completion(.success(responseJson))
                    }
                }catch _ {
                    //Failed to Parse
                    completion(.error(APIError.jsonDecoder))
                }
            }else {
                //Failed to Fetch
                completion(.error(APIError.badResponse))
            }
        }
    }
}
