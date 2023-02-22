//
//  AutoIdentifyUserUIView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 24.01.23.
//

import SwiftUI
import Dynatrace
struct AutoIdentifyUserUIView: View {
        
    @State private var txtUserName = ""
    @State private var txtInformation = "You can tag each user of your mobile apps with a unique user name. This enables you to search and filter specific user sessions and analyze individual user behavior over time.\n\n\nThe following steps explain how to manually tag an individual user via the Dynatrace API. You can tag users when they log in or when an already logged in session is used or restored upon app relaunch, as the tag isn't persisted over app restarts.\nhttps://www.dynatrace.com/support/help/shortlink/ios-oneagent-sdk#tag-specific-users"
    var body: some View {
        VStack{
            Form {
                Section(){
                    TextField("User name", text: $txtUserName)
                } 
                Section(){
                    Button("Identify User", action: {
                        Dynatrace.modifyUserAction( { (action) -> () in
                            _ = action?.getName()
                            action?.setName("Identify user button")
                            Dynatrace.identifyUser(txtUserName)
                            })
                       
                    })
                }
               
            }
            InformationView( text: txtInformation,canHideKeyboard: true)

        } .uiKitOnAppear("\(Self.self)")
    }
}

struct AutoIdentifyUserUIView_Previews: PreviewProvider {
    static var previews: some View {
        AutoIdentifyUserUIView()
    }
}
