//
//  ViewController.swift
//  Pomodoro
//
//  Created by Tomasz Szulc on 13/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class PMMainViewController: UIViewController {
    
    private enum PMButtonState {
        case Stopped, Running, Paused
    }

    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var stopButton: UIButton!
    @IBOutlet private weak var resumeButton: UIButton!
    @IBOutlet private weak var pauseButton: UIButton!
    
    private var buttonState: PMButtonState = .Stopped
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startButton.backgroundColor = UIColor.clearColor()
        self.stopButton.backgroundColor = UIColor.clearColor()
        self.resumeButton.backgroundColor = UIColor.clearColor()
        self.pauseButton.backgroundColor = UIColor.clearColor()
        
        self.updateButtons(false)
    }
    
    
    /// MARK: - Buttons Logic
    @IBAction func startPressed(sender: AnyObject) {
        self.buttonState = .Running
        self.updateButtons(true)
    }
    
    @IBAction func stopPressed(sender: AnyObject) {
        self.buttonState = .Stopped
        self.updateButtons(true)
    }
    
    @IBAction func resumePressed(sender: AnyObject) {
        self.buttonState = .Running
        self.updateButtons(true)
    }
    
    @IBAction func pausePressed(sender: AnyObject) {
        self.buttonState = .Paused
        self.updateButtons(true)
    }
    
    private func updateButtons(animated: Bool) {
        let duration = animated ? 0.3 : 0
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.changeStateOfButton(self.startButton, visible: self.buttonState == .Stopped)
            self.changeStateOfButton(self.stopButton, visible: self.buttonState == .Paused)
            self.changeStateOfButton(self.pauseButton, visible: self.buttonState == .Running)
            self.changeStateOfButton(self.resumeButton, visible: self.buttonState == .Paused)
        })
    }
    
    private func changeStateOfButton(button: UIButton, visible: Bool) {
        button.alpha = visible ? 1 : 0
        button.enabled = visible == true
    }
}

