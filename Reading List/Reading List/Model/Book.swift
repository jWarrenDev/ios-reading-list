//
//  Book.swift
//  Reading List
//
//  Created by Welinkton on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    let title:String
    let reasonToRead:String
    var hasBeenRead:Bool
    
    
    init(title:String, reasonToRead:String, hasBeenRead:Bool) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = true
    }
}


