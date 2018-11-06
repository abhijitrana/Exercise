//
//  Connectivity.swift
//  Excercise
//
//  Created by Umesh Verma on 06/11/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    
    //Class Stuf here
    
    //For Observing Device is connected to Internet or not
    class func isConnectedToInternet() ->Bool   {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
