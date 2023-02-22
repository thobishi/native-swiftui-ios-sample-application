//
//  ManualReportValuesView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 24.01.23.
//

import SwiftUI
import Dynatrace

struct ManualReportValuesView: View {
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
                            let action = DTXAction.enter(withName: "Touch on Report string value")
                            action?.reportValue(withName: "My string value", stringValue: txtString)
                            action?.leave()
                        })
                    }
                }
                Section(){
                    HStack{
                        TextField("Int", text: $txtInt)
                            .keyboardType(.numberPad)
                        Button("Report int value", action: {
                            let action = DTXAction.enter(withName: "Touch on Report int value")
                            action?.reportValue(withName: "My int value", intValue: Int64.init(txtInt)!)
                            action?.leave()
                        })
                    }
                }
                Section(){
                    HStack{
                        TextField("Double", text: $txtDouble)
                            .keyboardType(.decimalPad)
                        Button("Report double value", action: {
                            let action = DTXAction.enter(withName: "Touch on Report double value")
                            action?.reportValue(withName: "My double value", doubleValue: Double.init(txtDouble)!)
                            action?.leave()
                        })
                    }
                }
               
            }
            InformationView( text: "The reportValue method allows you to report your own metrics. These metrics must be part of a custom action or an autogenerated user action. Reported values are displayed in the user action waterfall analysis.\n\nThe OneAgent SDK allows you to report int, double, and string values.\n\nCheck also\n https://www.dynatrace.com/support/help/shortlink/define-mobile-action-and-session-properties)",canHideKeyboard: true)

        }.uiKitOnAppear{
            let action = DTXAction.enter(withName: "Loading of \(Self.self)")
            action?.leave()
        }
    }
}
struct ManualReportValuesView_Previews: PreviewProvider {
    static var previews: some View {
        ManualReportValuesView()
    }
}