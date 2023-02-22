//
//  AutoOtherActionsUIView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 24.01.23.
//

import SwiftUI

struct AutoOtherActionsUIView: View {
    @State var textResult = "Press test,";
   
    var body: some View {
        VStack{
            Text(textResult)
                .onLongPressGesture(minimumDuration: 1) {
                    
                    textResult = "Long pressed,\nuse manaual action to capture it."
                 } onPressingChanged: { inProgress in
                   
                    if(textResult == "Press test,")
                    {
                        textResult = "inProgress"
                    }
                }
        }.uiKitOnAppear(Self.self)
       }
   }

struct AutoOtherActionsUIView_Previews: PreviewProvider {
    static var previews: some View {
        AutoOtherActionsUIView()
    }
}
