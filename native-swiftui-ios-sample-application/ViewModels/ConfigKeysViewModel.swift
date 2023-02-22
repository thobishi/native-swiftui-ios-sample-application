//
//  configKeysViewModel.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 17.01.23.
//

import Foundation
import SwiftUI

struct ConfigKeysViewModel
{
    
    public var ApplicationId : String = "Not Configured"
    public var BeaconURL : String = "Not Configured"
    public var IsUserOptIn :Bool = false
    public var IsAutoStart :Bool = true
    public var IsHybridApplication :Bool = false
    public var LogLevel : String = "OFF"
    public var IsInstrumentWebRequestTiming :Bool = true
    public var IsAutoInstrumentationOn :Bool = true
}

