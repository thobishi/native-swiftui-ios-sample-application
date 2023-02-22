//
//  MenuTextCell.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 17.01.23.
//

import SwiftUI


struct MenuTextCell<Content: View>: View {
    //https://stackoverflow.com/questions/57666620/is-it-possible-for-a-navigationlink-to-perform-an-action-in-addition-to-navigati
    /*@State var menuText : String = ""
     @State var canNavigate : Bool = true
     @State var destinationView: Content
     //@State var destination : View = View()*/
    var destinationView: Content
    var title: String
    var canNavigate : Bool = true
  @State  private var exec = false
    init(destinationView: Content, title: String?, canNavigate: Bool, action: () -> Void) {
        
        self.title = title ?? ""
        self.destinationView = destinationView 
        self.canNavigate = canNavigate
        //to avoid trigerring the action on initialize
        if (exec)
        {
            action()
        }
        else
        {
            exec = !exec
        }
        
     
    }
 
    var body: some View {
        if (!canNavigate)
        {
            destinationView
        }
        else
        {
            NavigationLink(destination: destinationView){
                Text(title)
            }
        }
        
    }
}

struct MenuTextCell_Previews: PreviewProvider {
    static var previews: some View {
   
        MenuTextCell(destinationView: Text("View1"), title: "1st", canNavigate: true,action: {})
    }
}
