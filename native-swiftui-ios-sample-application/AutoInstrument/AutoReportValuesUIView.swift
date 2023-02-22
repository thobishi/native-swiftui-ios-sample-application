//
//  AutoReportValuesUIView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 24.01.23.
//

import SwiftUI
import Dynatrace

struct AutoReportValuesUIView: View {
    @State private var txtString = ""
    @State private var txtInt = ""
    @State private var txtDouble = ""
    var body: some View {
        VStack{
            Form{
                Section(){
                    HStack{
                        TextField("String", text: $txtString)
                        Button("Report string value", action: {
                            Dynatrace.modifyUserAction( { (action) -> () in
                                action?.reportValue(withName: "My string value", stringValue: txtString)
                               })
                        })
                    }
                }
                Section(){
                    HStack{
                        TextField("Int", text: $txtInt) .keyboardType(.numberPad)
                        Button("Report int value", action: {
                            Dynatrace.modifyUserAction( { (action) -> () in
                                action?.reportValue(withName: "My int value", intValue: Int64.init(txtInt)!)
                               })
                        })
                    }
                }
                Section(){
                    HStack{
                        TextField("Double", text: $txtDouble)  .keyboardType(.decimalPad)
                        Button("Report double value", action: {
                            Dynatrace.modifyUserAction( { (action) -> () in
                                action?.reportValue(withName: "My double value", doubleValue: Double.init(txtDouble)!)
                               })
                        })
                      
                    }
                }
               
            }
            InformationView( text: "The reportValue method allows you to report your own metrics. These metrics must be part of a custom action or an autogenerated user action. Reported values are displayed in the user action waterfall analysis.\n\nThe OneAgent SDK allows you to report int, double, and string values.\n\nCheck also\n https://www.dynatrace.com/support/help/shortlink/define-mobile-action-and-session-properties)",canHideKeyboard: true)

        }.uiKitOnAppear(Self.self)
    }
}

struct AutoReportValuesUIView_Previews: PreviewProvider {
    static var previews: some View {
        AutoReportValuesUIView()
    }
}