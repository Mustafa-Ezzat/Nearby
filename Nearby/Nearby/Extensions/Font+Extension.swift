//
//  Font+Extension.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/17/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import UIKit

enum FontStyle: String {
    case SFProDisplayThin     = "SFProDisplay-Thin"
    case SFProDisplayLight    = "SFProDisplay-Light"
    case SFProDisplayBold     = "SFProDisplay-Bold"
    case SFProDisplayMedium   = "SFProDisplay-Medium"
    case SFProDisplayRegular  = "SFProDisplay-Regular"
    case SFProDisplaySemibold = "SFProDisplay-Semibold"
    case robotoLight          = "Roboto-Light"
}
extension UIFont {
    convenience init?(fontStyle: FontStyle, size: CGFloat) {
        self.init(name: fontStyle.rawValue, size: size)
    }
}
