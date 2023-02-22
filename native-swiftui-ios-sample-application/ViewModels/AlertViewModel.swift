//
//  AlertViewModel.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 25.01.23.
//

import Foundation
import SwiftUI

class AlertViewModel : ObservableObject
{
    @Published var message = ""
    @Published var title = ""
    @Published var showOk = true
    @Published var present = false
}
