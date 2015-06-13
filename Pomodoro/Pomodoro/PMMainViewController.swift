//
//  ViewController.swift
//  Pomodoro
//
//  Created by Tomasz Szulc on 13/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class PMMainViewController: UIViewController {
    
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var stopButton: UIButton!
    @IBOutlet private weak var resumeButton: UIButton!
    @IBOutlet private weak var pauseButton: UIButton!
    
    private var _timerState: PMTimerState = .Stopped
    private var timerState: PMTimerState {
        set {
            _timerState = newValue
            NSUserDefaults.standardUserDefaults().setTimerState(newValue)
        }
        
        get { return _timerState }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _timerState = NSUserDefaults.standardUserDefaults().getTimerState()
        self.startButton.backgroundColor = UIColor.clearColor()
        self.stopButton.backgroundColor = UIColor.clearColor()
        self.resumeButton.backgroundColor = UIColor.clearColor()
        self.pauseButton.backgroundColor = UIColor.clearColor()
        
        self.updateButtons(false)
    }
    
    
    /// MARK: - Buttons Logic
    @IBAction func startPressed(sender: AnyObject) {
        self.timerState = .Running
        self.updateButtons(true)
    }
    
    @IBAction func stopPressed(sender: AnyObject) {
        self.timerState = .Stopped
        self.updateButtons(true)
    }
    
    @IBAction func resumePressed(sender: AnyObject) {
        self.timerState = .Running
        self.updateButtons(true)
    }
    
    @IBAction func pausePressed(sender: AnyObject) {
        self.timerState = .Paused
        self.updateButtons(true)
    }
    
    private func updateButtons(animated: Bool) {
        let duration = animated ? 0.3 : 0
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.changeStateOfButton(self.startButton, visible: self.timerState == .Stopped)
            self.changeStateOfButton(self.stopButton, visible: self.timerState == .Paused)
            self.changeStateOfButton(self.pauseButton, visible: self.timerState == .Running)
            self.changeStateOfButton(self.resumeButton, visible: self.timerState == .Paused)
        })
    }
    
    private func changeStateOfButton(button: UIButton, visible: Bool) {
        button.alpha = visible ? 1 : 0
        button.enabled = visible == true
    }
}

