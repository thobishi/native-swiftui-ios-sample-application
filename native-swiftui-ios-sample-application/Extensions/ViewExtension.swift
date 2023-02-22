//
//  ViewExtension.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 25.01.23.
//

import Foundation
import SwiftUI
import Dynatrace

enum Side: Equatable, Hashable {
    case left
    case right
}

extension View {
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func _padding(sides: [Side], value: CGFloat = 8) -> some View {
            HStack(spacing: 0) {
                if sides.contains(.left) {
                    Spacer().frame(width: value)
                }
                self
                if sides.contains(.right) {
                    Spacer().frame(width: value)
                }
            }
        }
    
   
    func uiKitOnAppear(_ perform: @escaping () -> Void) -> some View {
      self.background(UIKitAppear(action: perform))
  
    }
    func uiKitOnAppear(_ SelfselfViewName : Any) -> some View {
        self.background(UIKitAppear(action: {
            let action = DTXAction.enter(withName: "Loading \(SelfselfViewName)")
            action?.leave()
        })) 
    }
}
