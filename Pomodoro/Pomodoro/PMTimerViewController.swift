//
//  PMTimerViewController.swift
//  Pomodoro
//
//  Created by Marcin on 13/06/15.
//  Copyright © 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class PMTimerViewController: UIViewController, UIPickerViewDelegate , UIPickerViewDataSource {

    @IBOutlet weak var startOrPauseButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pickerr: UIPickerView!
    
    let MaxMinutesCount:Int = 25
    var secondsLefts:Int = 0;
    
    enum TimerState{case Running; case Stopped; case Paused; case Finished}
    var timerState : TimerState = .Stopped
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerr.dataSource = self;
        self.pickerr.delegate = self;
        
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MaxMinutesCount;
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String("\(1+row) min")
    }
    
    
    @IBAction func startClicked() {
        if timerState == TimerState.Running
        {
            onPause()
        }
        else
        {
            onResume()
    
        }
    }
    
    func callForWait()
    {
        if (timerState == TimerState.Running)
        {
        
            let delay = Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
            self.onTimerTick()
            }
        }
        else
        {
            print("WTF? wait called in state \(timerState)")
        }
    }
    
    func onTimerTick()
    {
        if secondsLefts>0
        {
            
            let seconds = secondsLefts % 60
            let minutes = (secondsLefts / 60) % 60
            
            timerLabel.text = String(format: "%02d:%02d", arguments: [minutes , seconds])
            secondsLefts--;
            callForWait()
        }
        else
        {
            onCycleFinished()
        }
    }
    
    func onStart()
    {
        timerState = TimerState.Running
        let minutes = 1 + pickerr.selectedRowInComponent(0)
        secondsLefts = minutes * 60;
        
        startOrPauseButton.setTitle("Pause",forState: UIControlState.Normal)
        
        callForWait()
    }
    
    func onResume()
    {
        timerState = TimerState.Running
        
        startOrPauseButton.setTitle("Pause",forState: UIControlState.Normal)
        
        callForWait()
    }
    
    func onStop()
    {
        timerState = TimerState.Stopped
    }
    

    func onPause()
    {
        
        timerState = TimerState.Paused
        startOrPauseButton.setTitle("Resume",forState: UIControlState.Normal)
    }
    
    func onCycleFinished()
    {
        timerState = TimerState.Finished
        //tutaj wolanie Tomka! elo cykl minal
        onStart()
        
    
    }
    

}
