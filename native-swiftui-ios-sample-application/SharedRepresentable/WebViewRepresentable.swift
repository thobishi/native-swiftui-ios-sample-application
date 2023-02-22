//
//  WebViewView.swift
//  native-swiftui-ios-sample-application
//
//  Created by Sabry, Ahmad on 25.01.23.
//

import SwiftUI
import WebKit

struct WebViewRepresentable : UIViewRepresentable  {
 
    @State var url: String
    
    
     
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
      
        let request = URLRequest(url: url)
        let webView = WKWebView()
      
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: url) ?? URL(string: "https://dynatrace.com")!))
          
       }
    func makeWKWebViewKit() -> WKWebViewKit {
        WKWebViewKit(self)
       }
    
    
    class WKWebViewKit: NSObject, WKNavigationDelegate {
           let parent: WebViewRepresentable
           
           init(_ parent: WebViewRepresentable) {
               self.parent = parent
           }

        func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            guard let serverTrust = challenge.protectionSpace.serverTrust else { return completionHandler(.useCredential, nil) }
            let exceptions = SecTrustCopyExceptions(serverTrust)
            SecTrustSetExceptions(serverTrust, exceptions)
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        }
           
       }

 
}
 

struct WebViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        WebViewRepresentable(url: "https://dynatrace.com")
    }
}
