//
//  ChatStruct.swift
//  one tone
//
//  Created by Love on 26/03/18.
//  Copyright © 2018 Love. All rights reserved.
//

import Foundation



struct ChatStruct {
    
    var message:String!
    var type:String!
    var id:String!
    var imageDp:String!
    
    
    init(message:String,type:String,id:String,imageDp:String) {
        
        
        self.message = message
        self.type = type
        self.id = id
        self.imageDp = imageDp
        
        
        
    }
    
}
