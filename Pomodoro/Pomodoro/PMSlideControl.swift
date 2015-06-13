//
//  PMSlideControl.swift
//  Pomodoro
//
//  Created by Tomasz Szulc on 13/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class PMSlideControl: UIControl {

    private var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.createScrollView()
        self.createPattern()
    }
    
    private func createScrollView() {
        self.scrollView = UIScrollView(frame: CGRectZero)
        self.scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(self.scrollView)
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[scrollView]-(0)-|", options: nil, metrics: nil, views: ["scrollView": self.scrollView])
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[scrollView]-(0)-|", options: nil, metrics: nil, views: ["scrollView": self.scrollView])
        
        self.addConstraints(horizontalConstraints)
        self.addConstraints(verticalConstraints)
        
        self.scrollView.backgroundColor = UIColor.blueColor()
    }
    
    private func createPattern() {
        let scaleImage = UIImage(named: "scale")
        
        var previousView: UIView = self.scrollView
        
        for idx in 0..<12 {
            var patternView = UIImageView(image: scaleImage)
            patternView.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.scrollView.addSubview(patternView)
            
            let top = NSLayoutConstraint(item: patternView, attribute: .Top, relatedBy: .Equal, toItem: self.scrollView, attribute: .Top, multiplier: 1, constant: 0)
            
            var attribute = NSLayoutAttribute.Trailing
            if previousView is UIScrollView {
                attribute = .Leading
            }
            
            let leading = NSLayoutConstraint(item: patternView, attribute: .Leading, relatedBy: .Equal, toItem: previousView, attribute: attribute, multiplier: 1, constant: 0)


            self.scrollView.addConstraints([top, leading])
            
            previousView = patternView
        }
        
        var lastView = UIImageView(image: UIImage(named: "scale-end"))
        lastView.setTranslatesAutoresizingMaskIntoConstraints(false)
        lastView.backgroundColor = UIColor.greenColor()
        self.scrollView.addSubview(lastView)
        
        let top = NSLayoutConstraint(item: lastView, attribute: .Top, relatedBy: .Equal, toItem: self.scrollView, attribute: .Top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: lastView, attribute: .Leading, relatedBy: .Equal, toItem: previousView, attribute: .Trailing, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: lastView, attribute: .Trailing, relatedBy: .Equal, toItem: self.scrollView, attribute: .Trailing, multiplier: 1, constant: 0)
        
        self.scrollView.addConstraints([leading, top, trailing])
    }
}
