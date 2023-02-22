//
//  ManualOtherActionsUIView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 24.01.23.
//

import SwiftUI
import Dynatrace
struct ManualOtherActionsUIView: View {
   
    @State var textResult = "Press test,";
   
    var body: some View {
        VStack{
            Text(textResult)
                .onLongPressGesture(minimumDuration: 1) {
                    let action = DTXAction.enter(withName: "Gesture Long pressed")
                    textResult = "Long pressed"
                    action?.leave()
                } onPressingChanged: { inProgress in
                   
                    if(textResult == "Press test,")
                    {
                        let action = DTXAction.enter(withName: "Gesture Long inProgress")
                        textResult = "inProgress"
                        action?.leave()
                    }
                }
           
            
        }.uiKitOnAppear{
            let action = DTXAction.enter(withName: "Loading of \(Self.self)")
            action?.leave()
        }
       }
   }

struct ManualOtherActionsUIView_Previews: PreviewProvider {
    static var previews: some View {
        ManualOtherActionsUIView()
    }
}
