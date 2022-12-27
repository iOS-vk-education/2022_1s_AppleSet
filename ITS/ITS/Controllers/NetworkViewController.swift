//
//  NetworkViewController.swift
//  ITS
//
//  Created by Всеволод on 27.12.2022.
//

import UIKit
import Alamofire
import PinLayout


struct WiFiModel: Decodable {
    let ssid: String
    let isOpen: Bool
}

struct Networks: Decodable {
    let networks: [WiFiModel]
}

struct Status: Decodable {
    let status: StatusName
}

struct DeviceInfo: Decodable {
    let topic: String
    let ip: String
}

enum StatusName: Int, Decodable {
    case WL_IDLE_STATUS = 0
    case WL_NO_SSID_AVAIL = 1
    case WL_CONNECTED = 3
    case WL_CONNECT_FAILED = 4
    case WL_CONNECT_WRONG_PASSWORD = 6
    case WL_DISCONNECTED = 7
}

class NetworkViewController: UIViewController {

    private let tableView = UITableView()
    private let networkTextField = UITextField()
    private let passwordTextField = UITextField()
    private let buttonConnect = UIButton()
    
    private var models: [WiFiModel] = []
    
    private var timer: Timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    
    private func setup() {
        view.addSubview(tableView)
        view.addSubview(networkTextField)
        view.addSubview(passwordTextField)
        view.addSubview(buttonConnect)
        view.backgroundColor = .white
        
        tableView.frame = view.frame
        tableView.frame.size = CGSize(width: tableView.frame.width, height: 400)
        tableView.layer.borderWidth = 3
        tableView.layer.borderColor = UIColor.systemGray5.cgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NetworkCell.self, forCellReuseIdentifier: "NetworkCell")
        
//        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(scanNetworks))
//        navigationItem.rightBarButtonItem = rightBarButtonItem
        title = "Networks"
        
        networkTextField.placeholder = "SSID"
        networkTextField.borderStyle = UITextField.BorderStyle.roundedRect
        networkTextField.delegate = self
        networkTextField.autocorrectionType = UITextAutocorrectionType.no
        networkTextField.autocapitalizationType = UITextAutocapitalizationType.none
        networkTextField.isUserInteractionEnabled = false
        
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.delegate = self
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        buttonConnect.setTitle("Connect", for: .normal)
        buttonConnect.layer.cornerRadius = 10
        buttonConnect.isUserInteractionEnabled = false
        buttonConnect.addTarget(self, action: #selector(sendNetwork), for: .touchUpInside)
        updateButtonConnect(with: false)
        
        timer.tolerance = 0.2
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { _ in
            self.scanNetworks()
        })
    }
    
    private func updateButtonConnect(with state: Bool) {
        buttonConnect.backgroundColor = state ? .link : .systemGray
        buttonConnect.isUserInteractionEnabled = state
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        networkTextField.pin
            .below(of: tableView)
            .marginTop(20)
            .hCenter()
            .size(CGSize(width: view.frame.width / 2, height: 30))
        
        passwordTextField.pin
            .below(of: networkTextField)
            .marginTop(10)
            .hCenter()
            .size(CGSize(width: view.frame.width / 2, height: 30))
        
        buttonConnect.pin
            .below(of: passwordTextField)
            .marginTop(20)
            .hCenter()
            .height(40)
            .width(view.frame.width / 4)
    }
    
    private func addNetwork(with ssid: String, isOpen: Bool) {
        let model = WiFiModel(ssid: ssid, isOpen: isOpen)
        
        models.append(model)
        tableView.reloadData()
    }
    
    private func getDeviceInfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            AF.request("http://" + Connectivity.getRouteIP()! + ":80/getInfo", method: .get).responseDecodable(of: DeviceInfo.self) { response in
                guard let deviceInfo = response.value else {
                    print(response)
                    print("no response")
                    return
                }
                print(deviceInfo.topic, deviceInfo.ip)
            }
        })
    }
    
    private func getStatusOfConnection() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            AF.request("http://" + Connectivity.getRouteIP()! + ":80/getStatus", method: .get).responseDecodable(of: Status.self) { response in
                guard let status = response.value?.status else {
                    print("no response")
                    return
                }
                print(status)
                if status == StatusName.WL_IDLE_STATUS {
                    self.getStatusOfConnection()
                } else if status == StatusName.WL_CONNECTED {
                    self.getDeviceInfo()
                }
            }
        }
    }
    
    @objc
    private func sendNetwork() {
        timer.invalidate()
        let parameters = ["ssid": networkTextField.text, "password": passwordTextField.text]
        AF.request("http://" + Connectivity.getRouteIP()! + ":80/configureNetwork", method: .post, parameters: parameters)
            .responseDecodable(of: Status.self) { response in
            guard let status = response.value?.status else {
                print("no response")
                return
            }
            print(status)
        }
        self.getStatusOfConnection()
    }
    
    private func dismissAll() {
        timer.invalidate()
        dismiss(animated: true)
    }
    
    private func scanNetworks() {
        DispatchQueue.main.async {
            if Connectivity.isConnected() {
                self.models.removeAll()
                AF.request("http://" + Connectivity.getRouteIP()! + ":80/scanNetworks", method: .get)
                {$0.timeoutInterval = 3}
                .responseDecodable(of: Networks.self) { [weak self] response in
                    switch response.result {
                    case .success:
                        response.value?.networks.forEach { network in
                            self?.addNetwork(with: network.ssid, isOpen: network.isOpen)
                        }
                    case .failure(let error):
                        switch error {
                        case .sessionTaskFailed(let error):
                            print("[DEBUG] Session Task Failed, description: \(error.localizedDescription)")
                        default:
                            print("[DEBUG] unhandled error")
                        }
                        self?.dismissAll()
                    }
                }
            } else {
                self.dismissAll()
            }
        }
    }
}


extension NetworkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NetworkCell", for: indexPath) as? NetworkCell
        
        cell?.configure(with: models[indexPath.row])
        
        return cell ?? .init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < models.count else {
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedNetworkSsid = models[indexPath.row].ssid
        networkTextField.text = selectedNetworkSsid
    }
}

extension NetworkViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let network = networkTextField.text, let password = passwordTextField.text, !network.isEmpty, password.count >= 8 else {
            updateButtonConnect(with: false)
            return
        }
        updateButtonConnect(with: true)
    }
}
