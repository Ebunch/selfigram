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
    
    let image:UIImage
    let user:User
    let comment:String
    
     init(image:UIImage, user:User, comment:String){
        self.image = image
        self.user = user
        self.comment = comment
}
}
