//
//  ViewController.swift
//  ArmaMad
//
//  Created by 32432618 on 08/24/2023.
//  Copyright (c) 2023 32432618. All rights reserved.
//

import UIKit
import ArmaMad

@available(iOS 13.0, *)
class ViewController: UIViewController, OnrampKitDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                let myButton: UIButton = {
                    let button = UIButton(type: .system)
                    button.setTitle("Buy Crypto", for: .normal)
                    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                    button.setTitleColor(.white, for: .normal)
                    button.layer.cornerRadius = 8
                    button.backgroundColor = .blue
                    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                    button.translatesAutoresizingMaskIntoConstraints = false
                    return button
                }()
        
                // Add the button to the view hierarchy
                view.addSubview(myButton)
        
                // Set button constraints
                NSLayoutConstraint.activate([
                    myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    myButton.widthAnchor.constraint(equalToConstant: 120),
                    myButton.heightAnchor.constraint(equalToConstant: 40)
                ])
            }
        
            @objc func buttonTapped() {
                ArmaMad.startOnrampSDK(self, self, appId: 1, flowType: 1)
            }
        
//            // retrieve to the latest onramp transaction state
             func onDataChanged(_ data: OnrampEventResponse) {
                 print("data: ",data)
                showEvent(type: data.type, data: data.data, isOnramp: data.isOnramp)
            }
        
        
            private func showEvent(type: Any,data: EventData, isOnramp: Any) {

                var userDescription = "From Event Listener: \n\(type) \n\(isOnramp)"
                if(data.msg != nil){
                    userDescription = userDescription + " " + data.msg!
                }
                if(data.coinRate != nil){
                    userDescription = userDescription + " " + String(data.coinRate!)
                }
                if(data.cryptoAmount != nil){
                    userDescription = userDescription + " " + String(data.cryptoAmount!)
                }
                if(data.fiatAmount != nil){
                    userDescription = userDescription + " " + String(data.fiatAmount!)
                }
                if(data.paymentMethod != nil ){
                    userDescription = userDescription + " " + data.paymentMethod!
                }

                let alertController = UIAlertController(title: "OnrampEvent", message: userDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true)
            }
    }
    

