//
//  InformationView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 25.01.23.
//

import SwiftUI

struct InformationView: View {
    @State  var text: String
    @State  var canHideKeyboard: Bool = false
    var body: some View {
        
        VStack{
            InformationRepresentable(text: text)
            if(canHideKeyboard)
            {
                Button("Got it!", action: {
                    self.hideKeyboard()
                })
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(text: "Information center!")
    }
}
