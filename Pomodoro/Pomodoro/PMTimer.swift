//
//  PMTimer.swift
//  Pomodoro
//
//  Created by Marcin on 13/06/15.
//  Copyright © 2015 Tomasz Szulc. All rights reserved.
//

import Foundation
import UIKit

class PMTimer : NSObject {
    
    var onUpdate: ((Int) -> ())?
    var onCycleFinished: (() -> ())?
    
    var timer: NSTimer?
    
    var secondsLeft:Int = 0
    var minutesInCycle:Int = 0
    
    enum TimerState{case Running; case Stopped; case Paused}
    var timerState : TimerState = .Stopped
    
    
    func update()
    {
        if (timerState == TimerState.Running)
        {
            
            
            if secondsLeft > 0
            {
                secondsLeft--;
                onUpdate!(secondsLeft)
            }
            else
            {
                secondsLeft = minutesInCycle * 60;
                onCycleFinished!()
            }
            
            
        }
        else
        {
            print("WTF? update called in state \(timerState)")
        }
    }
    
    
    func start(minutes: Int)
    {
        timerState = TimerState.Running
  
        minutesInCycle = 1+minutes
        secondsLeft = minutesInCycle * 60
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        
    }
    
    func resume()
    {
        timerState = TimerState.Running
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
    }
    
    func stop()
    {
        timerState = TimerState.Stopped
        timer?.invalidate()
        onUpdate!(minutesInCycle*60)
    }
    
    
    func pause()
    {
        
        timerState = TimerState.Paused
        timer?.invalidate()
    }
    
    
    
}
