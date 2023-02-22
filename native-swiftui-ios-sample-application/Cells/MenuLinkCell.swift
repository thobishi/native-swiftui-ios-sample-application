//
//  MenuLinkCell.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 18.01.23.
//

import SwiftUI

struct MenuLinkCell: View {
    @State var menuText : String = ""
    @State var menuLink : String = "https://dynatrace.com"
    @State var canNavigate : Bool = true

    var body: some View {
        VStack{
            HStack {
                Link(menuText, destination: URL(string: menuLink )!)
                if canNavigate
                {
                    Spacer()
                    NavigationLink {
                    } label: {
                    }
                }
            }
        }
        .padding(4)
    }
}

struct MenuLinkCell_Previews: PreviewProvider {
    static var previews: some View {
        MenuLinkCell()
    }
}
