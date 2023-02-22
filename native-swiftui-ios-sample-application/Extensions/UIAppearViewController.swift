//
//  UIAppearViewController.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 30.01.23.
//

import Foundation
import UIKit

class UIAppearViewController: UIViewController {
    var action: () -> Void = {}
    override func viewDidLoad() { 
        view.addSubview(UILabel())
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline:.now()) { [weak self] in
            self?.action()
        }
        
    }
}
