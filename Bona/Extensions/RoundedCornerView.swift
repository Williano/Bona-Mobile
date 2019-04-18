//
//  RoundedCornerView.swift
//  Bona
//
//  Created by William Kpabitey Kwabla on 4/11/19.
//  Copyright © 2019 William Kpabitey Kwabla. All rights reserved.
//

import UIKit


@IBDesignable
class RoundedCornerView: UIView {

    // if cornerRadius variable is set/changed, change the corner radius of the UIView
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    

}
