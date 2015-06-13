//
//  PMTimerState.swift
//  Pomodoro
//
//  Created by Tomasz Szulc on 13/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

enum PMTimerState: Int {
    case Stopped = 0
    case Running
    case Paused
}