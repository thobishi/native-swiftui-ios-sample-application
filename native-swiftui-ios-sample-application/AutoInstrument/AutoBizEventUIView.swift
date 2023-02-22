//
//  utoBizEventUIView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 24.01.23.
//

import SwiftUI
import Dynatrace

struct AutoBizEventUIView: View {
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
                        bizEvent()
                    })
                }
               
            }
            InformationView( text: "For more information\n\nhttps://www.dynatrace.com/support/help/how-to-use-dynatrace/business-analytics")

        }.uiKitOnAppear(Self.self)
    }
}

struct AutoBizEventUIView_Previews: PreviewProvider {
    static var previews: some View {
        AutoBizEventUIView()
    }
}
