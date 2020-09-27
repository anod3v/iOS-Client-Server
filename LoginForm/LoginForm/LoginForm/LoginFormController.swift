//
//  LoginFormController.swift
//  LoginForm
//
//  Created by Andrey on 30/07/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import WebKit

class LoginFormController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView! { didSet { webview.navigationDelegate = self } }
    
    var networkService = NetworkService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let credentialsRequest = networkService.getLoginForm()
        webview.load(credentialsRequest)
        
    }
    
}

extension LoginFormController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
//        debugPrint("url:", url)
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        
        let userId = params["user_id"]
        
        Session.shared.token = token
        
        Session.shared.userId = Int(userId!)
        
        let newsFeedVC = storyboard?.instantiateViewController(withIdentifier: "NewsFeedViewController") as! NewsFeedViewController
        
        newsFeedVC.modalPresentationStyle = .fullScreen
        self.present(newsFeedVC, animated: true, completion: nil)
        
        decisionHandler(.cancel)
    }
}
