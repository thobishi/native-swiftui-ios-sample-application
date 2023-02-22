//
//  AlertView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 25.01.23.
//

import SwiftUI

struct AlertView: View {
    @State var title: String
    @State var message: String
    @State var showOk: Bool
    var action : () -> ()
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white)
                VStack {
                    Text(title).font(Font.largeTitle)
                    HStack(alignment: .center, spacing: 0) {
                        InformationRepresentable(text: message)
                    }.padding([.leading,.trailing])
                    if (showOk)
                    {
                        Button(action: {
                            self.action()
                        }) {
                        Text("Got it!  ").font(Font.callout).foregroundColor(Color.white)
                    }
                        .padding()
                        .background(Color.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .cornerRadius(25)
                        .padding(.bottom, 50)
                }
                }
            }.frame(minHeight: UIScreen.main.bounds.height - 300, idealHeight: UIScreen.main.bounds.height - 150, maxHeight: UIScreen.main.bounds.height - 50)
                .padding()
            Spacer()
            
        }.background(VisualEffectView(effect: UIBlurEffect(style: .dark))
            .edgesIgnoringSafeArea(.all))
    }
    
    struct VisualEffectView: UIViewRepresentable {
        var effect: UIVisualEffect?
        func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
        func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
    }
}
struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(title: "Title", message: "Message", showOk: true,action: {} )
    }
}
