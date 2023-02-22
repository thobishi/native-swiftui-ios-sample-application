//
//  UIKitAppear.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 30.01.23.
//

import SwiftUI

struct UIKitAppear: UIViewControllerRepresentable {
    let action: () -> Void
    func makeUIViewController(context: Context) -> UIAppearViewController {
        let vc = UIAppearViewController()
        vc.action = action
        return vc
    
    }
    func updateUIViewController(_ controller: UIAppearViewController, context: Context) {
        
    }
}

struct UIKitAppear_Previews: PreviewProvider {
    static var previews: some View {
        UIKitAppear(action: {})
    }
}
