//
//  WebviewController.swift
//  ArmaMad
//
//  Created by PrashantDixit on 24/08/23.
//

import UIKit
import WebKit


public protocol OnrampKitDelegate: AnyObject {
    func onDataChanged(_ data: OnrampEventResponse)
}

@available(iOS 13.0, *)
public class WebviewViewController: UIViewController,WKNavigationDelegate {

    public var webView: WKWebView!
    public var loadingSpinner: UIActivityIndicatorView!
    public weak var delegate: OnrampKitDelegate?
    public var url: String?
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @available(iOS 13.0, *)
    public override func viewDidLoad() {
        super.viewDidLoad()

        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        navigationItem.hidesBackButton = true

        userContentController.add(self, name: "iosNativeEvent")
        
        config.userContentController = userContentController

        webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        
        loadingSpinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorView.Style.medium)

        view.addSubview(webView)
        
        
        view.addSubview(loadingSpinner)

        let layoutGuide = view.safeAreaLayoutGuide

        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        loadingSpinner.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor, constant: 0.0).isActive = true
        loadingSpinner.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor, constant: 0.0).isActive = true
        
        guard let url = URL(string: url ?? "https://test.bitbns.com/onramp/main/buy/?appId=1&mode=overlay&origin=OnrampSdkIos") else {return}
        
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: url))
        }
        
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


@available(iOS 13.0, *)
extension WebviewViewController: WKScriptMessageHandler {
    
    func showCancelTransactionAlert() {
        let alertController = UIAlertController(title: "Cancel Transaction? ", message: "Are you sure you want to cancel & exit the transaction?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        let okAction = UIAlertAction(title: "Yes, Cancel", style: .destructive) { _ in
            self.dismiss(animated: true)
            self.delegate?.onDataChanged(OnrampEventResponse(type: "ONRAMP_WIDGET_APP_CLOSED", data: EventData(msg: "Transaction Cancelled!", fiatAmount: nil, cryptoAmount: nil, coinRate: nil, paymentMethod: nil), isOnramp: true))
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }

    public func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {

        if message.name == "iosNativeEvent" {
            print("response_from_sdk", message.body)
            if let jsonData = (message.body as? String)?.data(using: .utf8) {
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(OnrampEventResponse.self, from: jsonData)
                    if(decodedResponse.type == "ONRAMP_WIDGET_CLOSE_REQUEST" ){
                        showCancelTransactionAlert()
                    }
                    delegate?.onDataChanged(decodedResponse)
                } catch {
                    print("Error decoding JSON:", error)
                }
            }
        }
    }
}
