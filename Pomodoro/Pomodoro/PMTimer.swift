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
    typealias UpdateBlock = (NSTimeInterval) -> ()
    typealias FinishedBlock = Void -> Void
    
    var onUpdate: UpdateBlock?
    var onCycleFinished: FinishedBlock?
    
    private var timer: NSTimer?
    
    private var secondsLeft: NSTimeInterval = 0
    private var totalSeconds: NSTimeInterval = 0
    
    func update() {
        if secondsLeft > 1 {
            onUpdate?(secondsLeft)
            secondsLeft--;
        } else {
            onUpdate?(secondsLeft)
            secondsLeft = self.totalSeconds;
            onCycleFinished?()
        }
    }
    
    func start(totalSeconds: NSTimeInterval) {
        self.totalSeconds = totalSeconds
        self.secondsLeft = self.totalSeconds
        self.update()
        self.scheduleTimer()
    }
    
    func resume() {
        self.scheduleTimer()
    }
    
    
    func stop() {
        timer?.invalidate()
        onUpdate?(self.totalSeconds)
    }
    
    
    func pause() {
        timer?.invalidate()
    }
    
    private func scheduleTimer() {
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
}
