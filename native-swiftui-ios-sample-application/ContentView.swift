//
//  ContentView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 17.01.23.
//

import SwiftUI
import Dynatrace
struct ContentView: View {
    
    //.dynatrace/DTSwiftInstrumentor install native-swiftui-ios-sample-application.xcodeproj --scheme native-swiftui-ios-sample-application --target native-swiftui-ios-sample-application
    
    //
   
 
    @StateObject var alertViewModel =  AlertViewModel()
    var body: some View {
        if alertViewModel.present {
            AlertView(title: alertViewModel.title, message: alertViewModel.message, showOk: alertViewModel.showOk, action:
                        {
                alertViewModel.present = false
            })
        }
        VStack{
            NavigationView {
                Form {
                    Section(header: Text("Info.plist details")){
                        MenuTextCell(destinationView: Text("Application ID:\(dtConfigKeys().ApplicationId)"), title: nil, canNavigate: false, action: {})
                        MenuTextCell(destinationView: Text("Auto Action Enabled:\(String(dtConfigKeys().IsAutoInstrumentationOn))"), title: nil, canNavigate: false, action: {})
                        MenuTextCell(destinationView: Text("Data privacy: \(String(dtConfigKeys().IsUserOptIn))"), title: nil, canNavigate: false, action: {})
                        MenuLinkCell(menuText: "LogLevel:\(dtConfigKeys().LogLevel)", menuLink: "https://www.dynatrace.com", canNavigate: true)
                        MenuLinkCell(menuText: "More Config info:", menuLink: "https://www.dynatrace.com/support/help/shortlink/ios-configuration-keys", canNavigate: true)
                        MenuLinkCell(menuText: "Public documentation:", menuLink: "https://www.dynatrace.com", canNavigate: true)
                        Link("Swift-Help document:", destination: URL(string: "https://www.dynatrace.com")!)
                    }
                    Section(header: Text("Demo")){
                        if dtConfigKeys().IsAutoInstrumentationOn
                        {
                            MenuTextCell(destinationView: AutoInstrumentMenuUIView(), title: "Auto instrumentation", canNavigate: true, action: {})
                        }
                        else
                        {
                            MenuTextCell(destinationView: ManualInstrumentMenuUIView(), title: "Manual instrumentation", canNavigate: true, action: {
                                let action = DTXAction.enter(withName: "Touch on Manual instrumentation")
                                
                                action?.leave()
                            })
                        }
                    }
                    Section(header: Text("Crash report")){
                        VStack
                        {
                            HStack {
                                Button("Crash me", action: {
                                    let debugger = DebuggerInfo()
                                    if (!debugger.isDebuggerAttached)
                                    {
                                        fatalError("Test crash")
                                    }
                                    else
                                    {
                                        alertViewModel.title = "Debugger attached"
                                        alertViewModel.message = "Crash report wont be collected by dynatrace.\nWhen xcode debugger is attached to the process, it will hold the crash report and will not pass it to dynatrace."
                                        alertViewModel.present = true
                                    }
                                })
                            }
                        }
                    } 
                    .navigationTitle("Dynatrace swiftui demo")
                } 
            }.onAppear(){
            
            }
        }
       

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
