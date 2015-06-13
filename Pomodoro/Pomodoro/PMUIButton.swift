//
//  PMUIButton.swift
//  Pomodoro
//
//  Created by Tomasz Szulc on 13/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

extension UIButton {
    func makeWhiteWithRedText() {
        self.backgroundColor = UIColor.whiteColor()
        self.setTitleColor(UIColor.customRed(), forState: UIControlState.Normal)
    }
}