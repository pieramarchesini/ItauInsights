//
//  Message.swift
//  ItauInsights
//
//  Created by Piera Marchesini on 26/08/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import Foundation

class Message {
    var id: Int
    var message: String
    
    init(id: Int, message: String) {
        self.id = id
        self.message = message
    }
}
