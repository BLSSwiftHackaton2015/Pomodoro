//
//  PMSlideControl.swift
//  Pomodoro
//
//  Created by Tomasz Szulc on 13/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

protocol PMSlideControlDelegate {
    func slideControlDidSelectTimeInterval(ti: NSTimeInterval)
}

class PMSlideControl: UIControl, UIScrollViewDelegate {
    
    var delegate: PMSlideControlDelegate?

    private var scrollView: UIScrollView!
    private var mainLeadingConstraint: NSLayoutConstraint?
    private var mainTrailingConstraint: NSLayoutConstraint?
    private var firstElement: UIView!
    private var lastElement: UIView!
    private var offsetXAtStart: CGFloat = 0
    private var update = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.createScrollView()
        self.createPattern()
        self.createArrow()
    }
    
    private func createScrollView() {
        self.scrollView = UIScrollView(frame: CGRectZero)
        self.scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.delegate = self
        self.addSubview(self.scrollView)
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[scrollView]-(0)-|", options: nil, metrics: nil, views: ["scrollView": self.scrollView])
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[scrollView]-(0)-|", options: nil, metrics: nil, views: ["scrollView": self.scrollView])
        
        self.addConstraints(horizontalConstraints)
        self.addConstraints(verticalConstraints)        
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
            
            if previousView is UIScrollView {
                self.mainLeadingConstraint = leading
            }

            self.scrollView.addConstraints([top, leading])
            
            if previousView is UIScrollView {
                self.createLabelWithText("\(idx)", attachToView: patternView, isFirst: true)
                self.firstElement = patternView
            }
            
            self.createLabelWithText("\(5 + (idx * 5))", attachToView: patternView, isFirst: false)
            
            previousView = patternView
        }
        
        var lastView = UIImageView(image: UIImage(named: "scale-end"))
        lastView.setTranslatesAutoresizingMaskIntoConstraints(false)
        lastView.backgroundColor = UIColor.greenColor()
        self.scrollView.addSubview(lastView)
        
        let top = NSLayoutConstraint(item: lastView, attribute: .Top, relatedBy: .Equal, toItem: self.scrollView, attribute: .Top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: lastView, attribute: .Leading, relatedBy: .Equal, toItem: previousView, attribute: .Trailing, multiplier: 1, constant: 0)
        self.mainTrailingConstraint = NSLayoutConstraint(item: lastView, attribute: .Trailing, relatedBy: .Equal, toItem: self.scrollView, attribute: .Trailing, multiplier: 1, constant: 0)
        
        self.lastElement = lastView
        
        self.scrollView.addConstraints([leading, top, self.mainTrailingConstraint!])
    }
    
    private func createLabelWithText(text: String, attachToView: UIView, isFirst: Bool) {
        var label = UILabel(frame: CGRectZero)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        label.text = text
        label.font = UIFont.systemFontOfSize(16)
        
        self.scrollView.addSubview(label)
        
        let width = NSLayoutConstraint(item: label, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 30)
        label.addConstraint(width)
        
        let top = NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: attachToView, attribute: .Bottom, multiplier: 1, constant: 10)

        let centerX: NSLayoutConstraint?
        
        if isFirst {
            centerX = NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: attachToView, attribute: .Leading, multiplier: 1, constant: 2)
        } else {
            centerX = NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: attachToView, attribute: .Trailing, multiplier: 1, constant: 2)
        }
        
        self.scrollView.addConstraints([top, centerX!])
    }
    
    private func createArrow() {
        let arrowView = UIImageView(image: UIImage(named: "marker"))
        arrowView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(arrowView)
        
        let centerX = NSLayoutConstraint(item: arrowView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: arrowView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        
        self.addConstraints([centerX, bottom])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainLeadingConstraint?.constant = (CGRectGetWidth(self.frame) / 2.0) - 1
        self.mainTrailingConstraint?.constant = -(CGRectGetWidth(self.frame) / 2.0)
    }
    
    func prepareToPlay() {
        self.update = false
        self.offsetXAtStart = self.scrollView.contentOffset.x
    }

    func endPlay() {
        self.update = true
    }
    
    func reportTime(ti: NSTimeInterval) {
//        var percentage: CGFloat = CGFloat((ti + 60) / (60 * 60))
//        var offsetX = (percentage * self.offsetXAtStart) * 10
//        println(offsetX)
//        self.scrollView.setContentOffset(CGPoint(x:offsetX, y: 0), animated: true)
    }
    
    
    /// MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.calculateSeconds(scrollView.contentOffset.x)
    }
    
    private func calculateSeconds(offsetX: CGFloat) {
        if self.update == false {
            return
        }
        if (offsetX < 0) {
            return
        }
        
        let width = self.rangeWidth()
        let percentage = fabs(offsetX / width)
        
        var calculatedValue: NSTimeInterval = NSTimeInterval(percentage) * 60
        let seconds = calculatedValue % 60
        if seconds < 30 {
            calculatedValue = floor(calculatedValue)
        } else {
            calculatedValue = ceil(calculatedValue)
        }
        
        calculatedValue = max(0, min(calculatedValue, 60))
        
        self.delegate?.slideControlDidSelectTimeInterval(calculatedValue * 60.0)
    }
    
    private func rangeWidth() -> CGFloat {
        return CGRectGetMinX(self.firstElement.frame) - CGRectGetMinX(self.lastElement.frame)
    }
}
