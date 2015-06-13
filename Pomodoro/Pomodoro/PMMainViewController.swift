//
//  ViewController.swift
//  Pomodoro
//
//  Created by Tomasz Szulc on 13/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class PMMainViewController: UIViewController, UIPickerViewDelegate , UIPickerViewDataSource {
    
    
    let MaxMinutesCount:Int = 25
    
    private enum PMButtonState {
        case Stopped, Running, Paused
    }
    

    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var stopButton: UIButton!
    @IBOutlet private weak var resumeButton: UIButton!
    @IBOutlet private weak var pauseButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    private var buttonState: PMButtonState = .Stopped
    
    var timerController : PMTimer?;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startButton.backgroundColor = UIColor.clearColor()
        self.stopButton.backgroundColor = UIColor.clearColor()
        self.resumeButton.backgroundColor = UIColor.clearColor()
        self.pauseButton.backgroundColor = UIColor.clearColor()
        
        self.updateButtons(false)
        
        self.picker.dataSource = self;
        self.picker.delegate = self;
        
        self.timerController = PMTimer()
        self.timerController?.onUpdate = self.onTimerTick
        self.timerController?.onCycleFinished = self.onCycleFinished
        
        
        print("View Did load!")
        
    }
    
    
    
    
    /// MARK: - Buttons Logic
    @IBAction func startPressed(sender: AnyObject) {
        self.buttonState = .Running
        self.updateButtons(true)
        timerController?.start(picker.selectedRowInComponent(0))
        
        NSUserDefaults.standardUserDefaults().setStartTimeInterval(NSTimeInterval())
    }
    
    @IBAction func stopPressed(sender: AnyObject) {
        self.buttonState = .Stopped
        self.updateButtons(true)
        timerController?.stop()
        
        NSUserDefaults.standardUserDefaults().removeStartTime()
        NSUserDefaults.standardUserDefaults().removeTimeInterval()
        NSUserDefaults.standardUserDefaults().removeTimeLeft()
        NSUserDefaults.standardUserDefaults().removeTomatosCount()
        
        
    }
    
    @IBAction func resumePressed(sender: AnyObject) {
        self.buttonState = .Running
        self.updateButtons(true)
        timerController?.resume()
        
        
    }
    
    @IBAction func pausePressed(sender: AnyObject) {
        self.buttonState = .Paused
        self.updateButtons(true)
        timerController?.pause()
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MaxMinutesCount;
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String("\(1+row) min")
    }
    

    
    func onTimerTick(secondsLeft: Int)
    {
        
        let seconds = secondsLeft % 60
        let minutes = (secondsLeft / 60) % 60
        
        timerLabel.text = String(format: "%02d:%02d", arguments: [minutes , seconds])
        
    }
    
    
    func onCycleFinished()
    {
        
        print("tu dodaj pomidora!!!")
        
    }

}

