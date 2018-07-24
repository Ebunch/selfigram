//
//  Post.swift
//  selfigram
//
//  Created by Inderpal Lehal on 2018-07-11.
//  Copyright © 2018 Inderpal Lehal. All rights reserved.
//

import Foundation
import UIKit

class Post {
    
    let imageURL:URL
    let user:User
    let comment:String
    
     init(imageURL:URL, user:User, comment:String){
        self.imageURL = imageURL
        self.user = user
        self.comment = comment
}
}
