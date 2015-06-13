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
    @IBOutlet private weak var sliderControl: PMSlideControl!
    
    private var _timerState: PMTimerState = .Stopped
    private var timerState: PMTimerState {
        set {
            _timerState = newValue
            NSUserDefaults.standardUserDefaults().setTimerState(newValue)
        }
        
        get { return _timerState }
    }
    
    var timerController : PMTimer?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _timerState = NSUserDefaults.standardUserDefaults().getTimerState()
        
        self.view.backgroundColor = UIColor.customRed()
        self.startButton.makeWhiteWithRedText()
        self.stopButton.makeWhiteWithRedText()
        self.resumeButton.makeWhiteWithRedText()
        self.pauseButton.makeWhiteWithRedText()
        
        self.updateButtons(false)
        
        self.timerController = PMTimer()
        self.timerController?.onUpdate = { (secondsLeft: Int) in
            let seconds = secondsLeft % 60
            let minutes = (secondsLeft / 60) % 60
//            timerLabel.text = String(format: "%02d:%02d", arguments: [minutes , seconds])
        }
        
        self.timerController?.onCycleFinished = {
            println("tu dodaj pomidora!!!")
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    
    /// MARK: - Buttons Logic
    @IBAction func startPressed(sender: AnyObject) {
//        self.timerState = .Running
//        self.updateButtons(true)
//        timerController?.start(picker.selectedRowInComponent(0))
        
//        NSUserDefaults.standardUserDefaults().setStartTimeInterval(NSTimeInterval())
    }
    
    @IBAction func stopPressed(sender: AnyObject) {
        self.timerState = .Stopped
        self.updateButtons(true)
        timerController?.stop()
        
        NSUserDefaults.standardUserDefaults().removeStartTime()
        NSUserDefaults.standardUserDefaults().removeTimeInterval()
        NSUserDefaults.standardUserDefaults().removeTimeLeft()
        NSUserDefaults.standardUserDefaults().removeTomatosCount()
    }
    
    @IBAction func resumePressed(sender: AnyObject) {
        self.timerState = .Running
        self.updateButtons(true)
        timerController?.resume()
    }
    
    @IBAction func pausePressed(sender: AnyObject) {
        self.timerState = .Paused
        self.updateButtons(true)
        timerController?.pause()
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

