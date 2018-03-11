//
//  File.swift
//  sjoao
//
//  Created by Ribeiro, P. on 11/03/2018.
//  Copyright © 2018 Ribeiro, P. All rights reserved.
//

import Foundation

class Event {
    var parentKey: String?
    
    var id: String?
    var description: String?
    var title: String?
    
    init(parentKey: String, dictionary: [String : AnyObject]) {
        self.parentKey = parentKey
        
        id = dictionary["id"] as? String
        description = dictionary["description"] as? String
        title = dictionary["title"] as? String
    }
}
