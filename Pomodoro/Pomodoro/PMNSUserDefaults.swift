//
//  PMNSUserDefaults.swift
//  Pomodoro
//
//  Created by Tomasz Szulc on 13/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

extension NSUserDefaults {
    
    private static let PMStartTimeInterval = "PMStartTimeInterval"
    private static let PMTimeInterval = "PMTimeInterval"
    private static let PMTimeLeft = "PMTimeLeft"
    private static let PMTomatosCount = "PMTomatosCount"
    
    /// Start Time
    func setStartTimeInterval(ti: NSTimeInterval) {
        self.setDouble(ti, forKey: NSUserDefaults.PMStartTimeInterval)
        self.synchronize()
    }

    func getStartTime() ->NSTimeInterval {
        return NSTimeInterval(self.doubleForKey(NSUserDefaults.PMStartTimeInterval))
    }
    
    func removeStartTime() {
        self.removeObjectForKey(NSUserDefaults.PMStartTimeInterval)
    }
    
    /// Time Interval
    func setTimeInterval(ti: NSTimeInterval) {
        self.setDouble(ti, forKey: NSUserDefaults.PMTimeInterval)
        self.synchronize()
    }
    
    func getTimeInterval() -> NSTimeInterval {
        return NSTimeInterval(self.doubleForKey(NSUserDefaults.PMTimeInterval))
    }
    
    func removeTimeInterval() {
        self.removeObjectForKey(NSUserDefaults.PMTimeInterval)
    }
    
    /// Time left
    func setTimeLeft(ti: NSTimeInterval) {
        self.setDouble(ti, forKey: NSUserDefaults.PMTimeLeft)
        self.synchronize()
    }
    
    func getTimeLeft() -> NSTimeInterval {
        return NSTimeInterval(self.doubleForKey(NSUserDefaults.PMTimeLeft))
    }
    
    func removeTimeLeft() {
        self.removeObjectForKey(NSUserDefaults.PMTimeLeft)
    }
    
    /// Tomatos count
    func setTomatosCount(count: Int) {
        self.setInteger(count, forKey: NSUserDefaults.PMTomatosCount)
        self.synchronize()
    }
    
    func getTomatosCount() -> Int{
    
        return self.integerForKey(NSUserDefaults.PMTomatosCount)
    }
    
    func removeTomatosCount() {
        self.removeObjectForKey(NSUserDefaults.PMTomatosCount)
    }
}