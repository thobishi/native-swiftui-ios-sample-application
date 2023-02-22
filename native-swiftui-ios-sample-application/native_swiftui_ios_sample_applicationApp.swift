//
//  native_swiftui_ios_sample_applicationApp.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 17.01.23.
//

import SwiftUI
import Dynatrace
let startupDictionary: [String : Any?] = [
    kDTXApplicationID: "App Id Here",
    kDTXBeaconURL: "Beacon URL Here",
    kDTXLogLevel: "ALL",
    kDTXUserOptIn: true,
    kDTXStartupLoadBalancing: true,
    kDTXInstrumentAutoUserAction: true
   
] ;
func dtConfigKeys() -> ConfigKeysViewModel {
    var configfiles = ConfigKeysViewModel()
    // More information on iOS configuration keys can be found here https://www.dynatrace.com/support/help/shortlink/ios-configuration-keys
 
    /*
     <key>DTXApplicationID</key>
     Identifies your mobile app. Auto-instrumentation reports an error if the key isn't present.
     */
    if let appId = startupDictionary[kDTXApplicationID] {
        configfiles.ApplicationId = appId as! String
    }
     
    /*
     <key>DTXBeaconURL</key>
     This key's value is used to identify your environment within Dynatrace. Auto-instrumentation reports an error if the key is not present.
     */
    if let beacon = startupDictionary[kDTXBeaconURL] {
        configfiles.BeaconURL = beacon as! String
    }
    
    /*
     <key>DTXAutoStart</key>
     When set to false, OneAgent doesn't start automatically, so you should start it manually.
     */
    if let autostart = startupDictionary[kDTXAutoStart] {
        configfiles.IsAutoStart = autostart as! Bool
    }
    
    
    /*
     <key>DTXInstrumentAutoUserAction</key>
     Turns on the ability to automatically create user actions for user interactions with the app, such as button clicks. Set the value to false to disable automatic creation of user actions.
     
     NOTE: Auto actions can work together with manual actions, you can test it out to see outcome
     */
    if let autouseraction = startupDictionary[kDTXInstrumentAutoUserAction] {
        configfiles.IsAutoInstrumentationOn = autouseraction as! Bool
    }
    
    
    /*
     <key>DTXUserOptIn</key>
     When set to true, activates the privacy mode. The user consent needs to be queried and set. The privacy settings for data collection and crash reporting can be changed via the OneAgent SDK for Mobile like described in Configure data privacy (user opt-in mode).
     */
    if let useroptin = startupDictionary[kDTXUserOptIn] {
        configfiles.IsUserOptIn = useroptin as! Bool
    }
    
    
    /*
     <key>DTXHybridApplication</key>
     For hybrid apps, set the value to true. This is necessary to share the same visit for user actions created by the RUM JavaScript.
     */
    if let hybridapp = startupDictionary[kDTXHybridApplication] {
        configfiles.IsHybridApplication = hybridapp as! Bool
    }
    
    
    
    /*
     <key>DTXInstrumentWebRequestTiming</key>
     Turns on automatic web request timing and tagging. To disable automatic web request timing and tagging, set the value to false.
     */
    if let autowebrequests = startupDictionary[kDTXInstrumentWebRequestTiming] {
        configfiles.IsInstrumentWebRequestTiming = autowebrequests as! Bool
    }
 
    
    /*
     <key>DTXLogLevel</key>
     If this key is present with a valid value, OneAgent logging is automatically enabled with the set value. If a key isn't present or doesn't have a valid value, automatic logging is turned off and must be turned on manually in the app.
     Possible values: OFF, SEVERE, WARNING, INFO, ALL
     */
    if let log = startupDictionary[kDTXLogLevel] {
        configfiles.LogLevel = log as! String
    }
   
    
    return configfiles
}
@main
struct native_swiftui_ios_sample_applicationApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: startDynatrace)
            
        }
    }
    
    func startDynatrace(){
        /*
        let startupDictionary: [String : Any?] = [
            kDTXApplicationID: "41ec3d32-353f-4fed-851c-ba86652cd019",
            kDTXBeaconURL: "https://bf66706ckp.bf.dynatrace.com/mbeacon",
            kDTXLogLevel: "ALL",
            kDTXUserOptIn: true,
            kDTXStartupLoadBalancing: true
        ] ;
         */
        Dynatrace.startup(withConfig: startupDictionary as [String : Any])
        
        
        
        // Privacy settings configured below are only provided
        // to allow a quick start with capturing monitoring data.
        // This has to be requested from the user
        // (e.g. in a privacy settings screen) and the user decision
        // has to be applied similar to this example.
        let privacyConfig = Dynatrace.userPrivacyOptions()
        privacyConfig.dataCollectionLevel = .userBehavior
        privacyConfig.crashReportingOptedIn = true
        privacyConfig.crashReplayOptedIn = true
        Dynatrace.applyUserPrivacyOptions(privacyConfig) { (successful) in
            // callback after privacy changed
            print("###### privacy changed")
        }
    }
    
}
