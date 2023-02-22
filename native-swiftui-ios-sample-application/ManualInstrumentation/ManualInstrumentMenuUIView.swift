//
//  ManualInstrumentMenuUIView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 24.01.23.
//

import SwiftUI
import Dynatrace

struct ManualInstrumentMenuUIView: View {
    @State var selectedPrivacyIndex : DTX_DataCollectionLevel = Dynatrace.userPrivacyOptions().dataCollectionLevel
    
    @StateObject var alertViewModel =  AlertViewModel()
    
    private func privacyCallBack(dataCollectionLevel: DTX_DataCollectionLevel){
        
        switch dataCollectionLevel {
            
        case .userBehavior:
            alertViewModel.message = "What this means?\n- userBehavior / DTX_DataCollectionUserBehavior (Performance data and user data is captured.\nIn this mode, OneAgent recognizes and reports users who revisit in the future.\nIf you haven't configured user tagging or custom value reporting, this level works similar to the Performance level.)\nOneAgent persists the data privacy settings and automatically applies them when the app is restarted.\nEach time the user changes the data collection level, OneAgent generates a new session with new settings."
        case .performance:
            alertViewModel.message = "What this means?\n- performance / DTX_DataCollectionPerformance (Only performance data is captured. Monitoring data that can be used to identify individual users, such as user tags and custom values, isn't captured.).\nEach time the user changes the data collection level, OneAgent generates a new session with new settings."
        case .off:
            alertViewModel.message = "What this means?\n- off / DTX_DataCollectionOff (Monitoring data isn't captured.)\nOneAgent generates a new session with new settings.\nEach time the user changes the data collection level, OneAgent generates a new session with new settings."
            
        @unknown default:
            fatalError()
        }
        alertViewModel.title = "Privacy Changed"
        
        alertViewModel.present = true
    }
    
    
    
    var body: some View {
        if alertViewModel.present {
            AlertView(title: alertViewModel.title, message: alertViewModel.message, showOk: alertViewModel.showOk, action:
                        {
                alertViewModel.present = false
            })
        }
        VStack {
            Form {
                Section(header: Text("Privacy options")){
                    VStack{
                        Picker("", selection: $selectedPrivacyIndex, content: {
                            Text("Off").tag(DTX_DataCollectionLevel.off)
                            Text("Performance").tag(DTX_DataCollectionLevel.performance)
                            Text("User behaviour").tag(DTX_DataCollectionLevel.userBehavior)
                        }
                        )
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: selectedPrivacyIndex, perform: { index in
                            let action = DTXAction.enter(withName: "Changing Privacy to \(selectedPrivacyIndex)")
                            privacyCallBack(dataCollectionLevel: selectedPrivacyIndex)
                            let privacyConfig = Dynatrace.userPrivacyOptions()
                            privacyConfig.dataCollectionLevel = selectedPrivacyIndex
                            privacyConfig.crashReportingOptedIn = true
                            privacyConfig.crashReplayOptedIn = true
                            Dynatrace.applyUserPrivacyOptions(privacyConfig) { (successful) in
                                selectedPrivacyIndex =     Dynatrace.userPrivacyOptions().dataCollectionLevel
                            }
                            action?.leave()
                        })
                    }
                }
                
                Section(header: Text("Actions")){
                    MenuTextCell(destinationView: ManualButtonActionUIView(), title: "Actions", canNavigate: true,action: {
                        let action = DTXAction.enter(withName: "Touch on Button actions")
                        
                        action?.leave()
                    })
                    MenuTextCell(destinationView: ManualOtherActionsUIView(), title: "Custom actions", canNavigate: true,action: {
                        let action = DTXAction.enter(withName: "Touch on Other actions")
                        
                        action?.leave()})
                    MenuTextCell(destinationView: AutoWebRequestsUIView(), title: "Web requests", canNavigate: true,action: {
                 
                        let action = DTXAction.enter(withName: "Touch on Web requests")
                        
                        action?.leave()
                    })
                 }
                Section(header: Text("Send values")){
                    MenuTextCell(destinationView: ManualIdentifyUserView(), title: "Identify user", canNavigate: true,action: {
                        let action = DTXAction.enter(withName: "Touch on Identify user")
                        
                        action?.leave()
                    })
                    MenuTextCell(destinationView: ManualReportValuesView(), title: "Report values", canNavigate: true,action: {
                        let action = DTXAction.enter(withName: "Touch on Report values")
                        
                        action?.leave()
                    })
                    MenuTextCell(destinationView: ManualBizEventUIView(), title: "BizEvents", canNavigate: true,action: {
                        let action = DTXAction.enter(withName: "Touch on Report User action error")
                        
                        action?.leave()
                    })
                    MenuTextCell(destinationView: ManualReportErrorsView(), title: "Report User action error", canNavigate: true,action: {})
                    MenuTextCell(destinationView: ManualReportGlobalErrorUIView(), title: "Report global error", canNavigate: true,action: {})
                }
                .navigationTitle("Manual instrumentation")
            }
        }
        .uiKitOnAppear {
            let action = DTXAction.enter(withName: "Loading \(Self.self)")
            selectedPrivacyIndex   = Dynatrace.userPrivacyOptions().dataCollectionLevel
            action?.leave()
        }
    }
}


struct ManualInstrumentMenuUIView_Previews: PreviewProvider {
    static var previews: some View {
        ManualInstrumentMenuUIView()
    }
}
