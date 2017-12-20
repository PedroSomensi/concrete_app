//
//  ImageExtensions.swift
//  desafio-ios
//
//  Created by Pedro on 03/11/17.
//  Copyright © 2017 pedrosomensi. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func round() {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
    
}
