//
//  ManualBizEventUIView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 24.01.23.
//

import SwiftUI
import Dynatrace

struct ManualBizEventUIView: View {
    @State private var txtOne = ""
    
    func bizEvent(){
        let attributes: [String: Any] = [
            "event.name": "Confirmed Booking",
            "screen": "booking-confirmation",
            "product": "Danube Anna Hotel",
            "amount": 358.35,
            "currency": "USD",
            "reviewScore": 4.8,
            "arrivalDate": "2022-11-05",
            "departureDate": "2022-11-15",
            "journeyDuration": 10,
            "adultTravelers": 2,
            "childrenTravelers": 0
        ]
        Dynatrace.sendBizEvent(withType: "com.easytravel.funnel.booking-finished", attributes: attributes)
    }
    var body: some View {
        VStack{
            Form{
                Section(){
                    Button("Report BizEvents", action: {
                        let action = DTXAction.enter(withName: "Report BizEvents")
                        bizEvent()
                        action?.leave()
                    })
                }
               
            }
            InformationView( text: "For more information\n\nhttps://www.dynatrace.com/support/help/how-to-use-dynatrace/business-analytics")

        }.uiKitOnAppear {
            let action = DTXAction.enter(withName: "Loading of \(Self.self)")
            action?.leave()
        }
    }
}
struct ManualBizEventUIView_Previews: PreviewProvider {
    static var previews: some View {
        ManualBizEventUIView()
    }
}
