//
//  InformationView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 25.01.23.
//

import SwiftUI 

struct InformationRepresentable: UIViewRepresentable {
    @State var text: String
 
     
        func makeUIView(context: Context) -> UITextView {
            let textView = UITextView()
            textView.dataDetectorTypes = .link
            textView.autocapitalizationType = .sentences
            textView.isSelectable = true
            textView.isEditable = false
            textView.font = UIFont.systemFont(ofSize: 24) 
            textView.isUserInteractionEnabled = true 
            return textView
        }
    func updateUIView(_ uiView: UITextView, context: Context) {
           uiView.text = text 
       }
}

struct InformationRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        InformationRepresentable(text: "text")
    }
}
