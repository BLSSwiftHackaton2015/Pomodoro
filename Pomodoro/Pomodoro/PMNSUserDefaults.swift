//
//  PMNSUserDefaults.swift
//  Pomodoro
//
//  Created by Tomasz Szulc on 13/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

extension NSUserDefaults {
    
    private static let PMStartTimeIntervalKey = "PMStartTimeInterval"
    private static let PMTimeIntervalKey = "PMTimeInterval"
    private static let PMTimerStateKey = "PMTimerState"
    
    func pmRegisterDefaults() {
        self.registerDefaults([NSUserDefaults.PMTimerStateKey: PMTimerState.Stopped.rawValue])
    }
    
    /// Start Time
    func setStartTimeInterval(ti: NSTimeInterval) {
        self.setDouble(ti, forKey: NSUserDefaults.PMStartTimeIntervalKey)
        self.synchronize()
    }

    func getStartTime() {
        self.doubleForKey(NSUserDefaults.PMStartTimeIntervalKey)
    }
    
    func removeStartTime() {
        self.removeObjectForKey(NSUserDefaults.PMStartTimeIntervalKey)
    }
    
    /// Time Interval
    func setTimeInterval(ti: NSTimeInterval) {
        self.setDouble(ti, forKey: NSUserDefaults.PMTimeIntervalKey)
        self.synchronize()
    }
    
    func getTimeInterval() {
        self.doubleForKey(NSUserDefaults.PMTimeIntervalKey)
    }
    
    func removeTimeInterval() {
        self.removeObjectForKey(NSUserDefaults.PMTimeIntervalKey)
    }
    
    
    /// Timer State
    func setTimerState(ts: PMTimerState) {
        self.setInteger(ts.rawValue, forKey: "")
        self.synchronize()
    }
    
    func getTimerState() -> PMTimerState {
        return PMTimerState(rawValue: self.integerForKey(""))!
    }
}