//
//  AutoInstrumentMenuUIView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 24.01.23.
//

import SwiftUI
import Dynatrace

struct AutoInstrumentMenuUIView: View {
    
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
        VStack{
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
                            privacyCallBack(dataCollectionLevel: selectedPrivacyIndex)
                            let privacyConfig = Dynatrace.userPrivacyOptions()
                            privacyConfig.dataCollectionLevel = selectedPrivacyIndex
                            privacyConfig.crashReportingOptedIn = true
                            privacyConfig.crashReplayOptedIn = true
                            Dynatrace.applyUserPrivacyOptions(privacyConfig) { (successful) in
                                selectedPrivacyIndex =     Dynatrace.userPrivacyOptions().dataCollectionLevel
                            }
                        })
                    }
                }
                Section(header: Text("Actions")){
                    MenuTextCell(destinationView: AutoButtonActionUIView(), title: "Actions", canNavigate: true, action: {})
                    MenuTextCell(destinationView: AutoOtherActionsUIView(), title: "Custom actions", canNavigate: true, action: {})
                    MenuTextCell(destinationView: AutoWebRequestsUIView(), title: "Web requests", canNavigate: true, action: {})
                  
                }
                Section(header: Text("Send values")){
                    if selectedPrivacyIndex == .userBehavior
                    {
                    MenuTextCell(destinationView: AutoIdentifyUserUIView(), title: "Identify user", canNavigate: true, action: {})
                   
                    MenuTextCell(destinationView: AutoReportValuesUIView(), title: "Report values", canNavigate: true, action: {})
                    }
                    MenuTextCell(destinationView: AutoBizEventUIView(), title: "BizEvents", canNavigate: true, action: {})
                    MenuTextCell(destinationView: AutoReportErrorsUIView(), title: "Report User action error", canNavigate: true, action: {})
                    MenuTextCell(destinationView: AutoReportGlobalUIView(), title: "Report global error", canNavigate: true, action: {})
                }
                .navigationTitle("Auto instrumentation")
                
            }
            .onAppear(){
                selectedPrivacyIndex   = Dynatrace.userPrivacyOptions().dataCollectionLevel 
            }
            .uiKitOnAppear(Self.self)
        }
    }
}

struct AutoInstrumentMenuUIView_Previews: PreviewProvider {
    static var previews: some View {
        AutoInstrumentMenuUIView()
    }
}
