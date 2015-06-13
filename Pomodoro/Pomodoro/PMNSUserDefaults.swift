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
    private static let PMTimeLeftKey = "PMTimeLeft"
    private static let PMTomatosCountKey = "PMTomatosCount"

    
    func pmRegisterDefaults() {
        self.registerDefaults([NSUserDefaults.PMTimerStateKey: PMTimerState.Stopped.rawValue])
    }
    
    /// Start Time
    func setStartTimeInterval(ti: NSTimeInterval) {
        self.setDouble(ti, forKey: NSUserDefaults.PMStartTimeIntervalKey)
        self.synchronize()
    }

    func getStartTime() -> NSTimeInterval {
        return NSTimeInterval(self.doubleForKey(NSUserDefaults.PMStartTimeIntervalKey))
    }
    
    func removeStartTime() {
        self.removeObjectForKey(NSUserDefaults.PMStartTimeIntervalKey)
    }
    
    /// Time Interval
    func setTimeInterval(ti: NSTimeInterval) {
        self.setDouble(ti, forKey: NSUserDefaults.PMTimeIntervalKey)
        self.synchronize()
    }
    

    func getTimeInterval() -> NSTimeInterval {
        return NSTimeInterval(self.doubleForKey(NSUserDefaults.PMTimeIntervalKey))
    }
    
    func removeTimeInterval() {
        self.removeObjectForKey(NSUserDefaults.PMTimeIntervalKey)
    }
    
    
    /// Timer State
    func setTimerState(ts: PMTimerState) {
        self.setInteger(ts.rawValue, forKey: NSUserDefaults.PMTimerStateKey)
        self.synchronize()
    }
    
    func getTimerState() -> PMTimerState {
        return PMTimerState(rawValue: self.integerForKey(NSUserDefaults.PMTimerStateKey))!
    }
    
    /// Time left
    func setTimeLeft(ti: NSTimeInterval) {
        self.setDouble(ti, forKey: NSUserDefaults.PMTimeLeftKey)
        self.synchronize()
    }
    
    func getTimeLeft() -> NSTimeInterval {
        return NSTimeInterval(self.doubleForKey(NSUserDefaults.PMTimeLeftKey))
    }
    
    func removeTimeLeft() {
        self.removeObjectForKey(NSUserDefaults.PMTimeLeftKey)
    }
    
    /// Tomatos count
    func setTomatosCount(count: Int) {
        self.setInteger(count, forKey: NSUserDefaults.PMTomatosCountKey)
        self.synchronize()
    }
    
    func getTomatosCount() -> Int{
    
        return self.integerForKey(NSUserDefaults.PMTomatosCountKey)
    }
    
    func removeTomatosCount() {
        self.removeObjectForKey(NSUserDefaults.PMTomatosCountKey)
    }
}