//
//  InformationViewWithCallBack.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 25.01.23.
//

import SwiftUI

struct InformationViewWithCallBack: View {
    @State var text: String
    var action : () -> ()
    var body: some View {
        
        VStack{
            InformationRepresentable(text: text)
            Button("Got it!", action: {
                self.action()
            })
        }
    }
}

struct InformationViewWithCallBack_Previews: PreviewProvider {
    static var previews: some View {
        InformationViewWithCallBack(text: "Information center!", action: {})
    }
}
