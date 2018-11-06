//
//  ListModel.swift
//  Excercise
//
//  Created by Umesh Verma on 06/11/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Response {
    let title:String
    var rows = [ItemData]()
    
    init(json:JSON) {
        self.title = json["title"].stringValue
        
        if let data = json["rows"].array {
            self.rows = data.map( { ItemData(json:$0) } )
        }
    }
}

struct ItemData {
    var title:String? = nil
    var description:String? = nil
    var imageHref:String? = nil
    
    init(json:JSON) {
        
        if let title = json["title"].string {
            self.title = title
        }
        
        if let description = json["description"].string {
            self.description = description
        }
        
        if let imageHref = json["imageHref"].string {
            self.imageHref = imageHref
        }
    }
}
