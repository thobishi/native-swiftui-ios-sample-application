//
//  ManualButtonActionUIView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 24.01.23.
//

import SwiftUI
import Dynatrace

struct ManualButtonActionUIView: View {
    @State private var vibrateOnRing = false
    
    @State private var value = 0
       let colors: [Color] = [.orange, .red, .gray, .blue,
                              .green, .purple, .pink]

       func incrementStep() {
           let action = DTXAction.enter(withName: "increment-Step")
           value += 1
           if value >= colors.count { value = 0 }
           action?.leave()
       }

       func decrementStep() {
           let action = DTXAction.enter(withName: "decrement-Step")
           value -= 1
           if value < 0 { value = colors.count - 1 }
           action?.leave()
       }
      
    @State private var speed = 50.0
    @State private var isEditing = false
    var body: some View {
        VStack{
            Form{
                Section(header: Text("Buttons")){
                    Button(action: { let action = DTXAction.enter(withName: "Touch on Sign In")
                        action?.leave()
                    }) {
                        Text("Sign In")
                    }
                    Button("update", action: {
                        let action = DTXAction.enter(withName: "Touch on Update")
                        action?.leave()
                        
                    })
                }
                Section(header: Text("Stepper")){
                    Stepper {
                               Text("Value: \(value) Color: \(colors[value].description)")
                           } onIncrement: {
                               incrementStep()
                           } onDecrement: {
                               decrementStep()
                           }
                           .padding(5)
                }
                Section(header: Text("Slider")){
                    Slider(
                                value: $speed,
                                in: 0...100,
                                onEditingChanged: { editing in
                                    isEditing = editing
                                    if speed == 100
                                    {
                                        let action = DTXAction.enter(withName: "Slider on required value")
                                        action?.leave()
                                    }
                                }
                            )
                    Text("\(speed)")
                }
            }
            InformationView( text: "https://www.dynatrace.com/support/help/shortlink/swiftui-instrumentation#supported-controls",canHideKeyboard: false)
            
        }.uiKitOnAppear {
            let action = DTXAction.enter(withName: "Loading of \(Self.self)")
            action?.leave() 
        }
    }
        
}

struct ManualButtonActionUIView_Previews: PreviewProvider {
    static var previews: some View {
        ManualButtonActionUIView()
    }
}
