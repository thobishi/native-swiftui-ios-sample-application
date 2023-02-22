//
//  ManualWebRequestsUIView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 24.01.23.
//

import SwiftUI
import Dynatrace

struct ManualWebRequestsUIView: View {
    @State private var txtRequest = "https://localhost/api/user/1"
    @State private var txtInformation = "You can tag each user of your mobile apps with a unique user name. This enables you to search and filter specific user sessions and analyze individual user behavior over time.\n\nThe following steps explain how to manually tag an individual user via the Dynatrace API. You can tag users when they log in or when an already logged in session is used or restored upon app relaunch, as the tag isn't persisted over app restarts."
    
    let webCalls = WebRequests()
    
    func AutoWebRequest() {
        webCalls.getRequest_Auto(url: txtRequest)
    }

    func ManualWebRequest( parentAction: DTXAction?) {
        webCalls.getRequest_Manual(url: txtRequest, parentAction: parentAction)
    }
    
    var body: some View {
        VStack{
            Form{
                Section(){
                    TextField("Request URL", text: $txtRequest)
                }
               
                Section(){
                    if dtConfigKeys().IsInstrumentWebRequestTiming
                    {
                        Button("Auto instrumented web request", action: {
                            let action = DTXAction.enter(withName: "Touch on Auto instrumented web request")
                        
                            AutoWebRequest()
                            txtInformation =  "OneAgent automatically instruments and tags your web requests. To track web requests, OneAgent adds the x-dynatrace HTTP header with a unique value to the web request. This is required to correlate the server-side monitoring data to the corresponding mobile web request.\n\nhttps://www.dynatrace.com/support/help/shortlink/ios-oneagent-sdk#measure-web-requests"
                            action?.leave()
                        })
                    }
                    else
                    {
                        Button("Manual instrumented web request", action: {
                            let action = DTXAction.enter(withName: "Touch on Manual instrumented web request")
                            ManualWebRequest(parentAction: action)
                            txtInformation = "OneAgent automatically instruments and tags your web requests. To track web requests, OneAgent adds the x-dynatrace HTTP header with a unique value to the web request. This is required to correlate the server-side monitoring data to the corresponding mobile web request.\n\nhttps://www.dynatrace.com/support/help/shortlink/ios-oneagent-sdk#measure-web-requests"
                            action?.leave()
                        })
                    }
                }
            }
            InformationView( text: txtInformation ,canHideKeyboard: true)
        }.uiKitOnAppear{
            let action = DTXAction.enter(withName: "Loading of \(Self.self)")
            action?.leave()
        }
    }
}

struct ManualWebRequestsUIView_Previews: PreviewProvider {
    static var previews: some View {
        ManualWebRequestsUIView()
    }
}
