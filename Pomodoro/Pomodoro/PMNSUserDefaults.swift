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
    
    /// Start Time
    func setStartTimeInterval(ti: NSTimeInterval) {
        self.setDouble(ti, forKey: NSUserDefaults.PMStartTimeInterval)
        self.synchronize()
    }

    func getStartTime() {
        self.doubleForKey(NSUserDefaults.PMStartTimeInterval)
    }
    
    func removeStartTime() {
        self.removeObjectForKey(NSUserDefaults.PMStartTimeInterval)
    }
    
    /// Time Interval
    func setTimeInterval(ti: NSTimeInterval) {
        self.setDouble(ti, forKey: NSUserDefaults.PMTimeInterval)
        self.synchronize()
    }
    
    func getTimeInterval() {
        self.doubleForKey(NSUserDefaults.PMTimeInterval)
    }
    
    func removeTimeInterval() {
        self.removeObjectForKey(NSUserDefaults.PMTimeInterval)
    }
}