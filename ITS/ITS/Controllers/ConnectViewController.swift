//
//  ConnectViewController.swift
//  ITS
//
//  Created by Всеволод on 27.12.2022.
//

import UIKit
import PinLayout
import Alamofire
import Network


protocol ConnectViewControllerDelegate {
    func update(isAdded: Bool)
}


class ConnectViewController: UIViewController, ConnectViewControllerDelegate  {
    
    private var isAdded = false
    
    private var udplistener: UDPListener?

    private let connectLabel: UILabel = UILabel()
    
    private var timer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        title = "Connecting"
        
        connectLabel.font = UIFont(name: "Menlo", size: 20)
        connectLabel.textAlignment = .center
        connectLabel.text = "Processing..."
        
        view.addSubview(connectLabel)
    }
    
    private func setupNavBar() {
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapButton))
        
        navigationItem.leftBarButtonItem = backButtonItem
        navigationController?.navigationBar.tintColor = .systemPink
        title = "Profile"
    }
    
    @objc
    private func didTapButton() {
        dismissAll()
    }
    
    func update(isAdded: Bool) {
        self.isAdded = isAdded
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NetworkViewController else { return }
        destination.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavBar()
        
        udplistener = UDPListener(on: 54321)
        
        timer.tolerance = 0.2
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
            self.updateConnection()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isAdded {
            dismissAll()
        }
    }
    
    private func dismissAll() {
        timer.invalidate()
        udplistener?.cancel()
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        connectLabel.pin
            .vCenter()
            .horizontally(12)
            .sizeToFit(.width)
    }
    
    private func configureDevice() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let networkViewController = NetworkViewController()
            
            let navigationController = UINavigationController(rootViewController: networkViewController)
            navigationController.modalPresentationStyle = .fullScreen
            
            self.present(navigationController, animated: true)
        })
    }
    
    private func updateConnection() {
        DispatchQueue.main.async {
            if Connectivity.isConnected() {
                    if let udplistener = self.udplistener, udplistener.messageReceived != nil {
                        udplistener.messageReceived = nil
                        AF.request("http://" + Connectivity.getRouteIP()! + ":80/getStatus", method: .get)
                        {$0.timeoutInterval = 1}
                            .responseDecodable(of: Status.self) { [weak self] response in
                                switch response.result {
                                case .success:
                                    self?.connectLabel.text = "Connected"
                                    self?.connectLabel.textColor = .green
                                    self?.timer.invalidate()
                                    self?.configureDevice()
                                case .failure(let error):
                                    self?.connectLabel.text = "Smth with device"
                                    self?.connectLabel.textColor = .orange
                                    switch error {
                                    case .sessionTaskFailed(let error):
                                        debugPrint("[DEBUG] Session Task Failed, description: \(error.localizedDescription)")
                                    default:
                                        print("[DEBUG] unhandled error")
                                    }
                                    return
                                }
                            }
                    } else {
                        self.connectLabel.text = "Device not connected"
                        self.connectLabel.textColor = .orange
                    }
            } else {
                self.connectLabel.text = "Not connected"
                self.connectLabel.textColor = .red
            }
            
        }
    }
}
