//
//  AutoButtonActionUIView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 24.01.23.
//

import SwiftUI
import Dynatrace

struct AutoButtonActionUIView: View {
    
    @State private var txtInformation = "https://www.dynatrace.com/support/help/shortlink/swiftui-instrumentation#supported-controls"
    
    @State private var vibrateOnRing = false
    
    @State private var value = 0
       let colors: [Color] = [.orange, .red, .gray, .blue,
                              .green, .purple, .pink]

       func incrementStep() {
           value += 1
           if value >= colors.count { value = 0 }
       }

       func decrementStep() {
           value -= 1
           if value < 0 { value = colors.count - 1 }
       }
    
    
    enum Flavor: String, CaseIterable, Identifiable {
        case chocolate, vanilla, strawberry
        var id: Self { self }
    }
    
    @State private var speed = 50.0
    @State private var isEditing = false

    @State private var selectedFlavor: Flavor = .chocolate
    var body: some View {
        VStack{
            Form{
                Section(header: Text("Buttons")){
                    Button(action: {
                        
                    }) {
                        Text("Sign In")
                        
                    }
                    Button("update", action: {   })
                    Button("Modify Action", action: {
                        Dynatrace.modifyUserAction( { (action) -> () in
                                let oldName = action?.getName()
                            action?.setName("This is a renamed auto user action (was '\(String(describing: oldName))')")
                            txtInformation = "This is a renamed auto user action (was '\(String(describing: oldName))')\nhttps://www.dynatrace.com/support/help/shortlink/ios-oneagent-sdk#modify-auto-actions"
                            })
                    })
                    Button("Mask Action", action: {
                        
                    })
                }
                Section(header: Text("Picker")){
                    List {
                        Picker("Flavor", selection: $selectedFlavor) {
                            Text("Chocolate").tag(Flavor.chocolate)
                            Text("Vanilla").tag(Flavor.vanilla)
                            Text("Strawberry").tag(Flavor.strawberry)
                        }
                  
                    }
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
                Section(header: Text("Toggle")){
                    Toggle("Vibrate on Ring", isOn: $vibrateOnRing)
                }
                
                Section(header: Text("Slider")){
                    Slider(
                        value: $speed,
                        in: 0...100,
                        onEditingChanged: { editing in
                            isEditing = editing
                        }
                    )
                    Text("\(speed)")
                }
            
            }
            InformationView( text: txtInformation ,canHideKeyboard: false)
        }
        .uiKitOnAppear(Self.self)
    }
}

struct AutoButtonActionUIView_Previews: PreviewProvider {
    static var previews: some View {
        AutoButtonActionUIView()
    }
}
