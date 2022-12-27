//
//  UDPListener.swift
//  ITS
//
//  Created by Всеволод on 27.12.2022.
//

import Foundation
import Network


class UDPListener {

    var listener: NWListener?
    var connection: NWConnection?
    var queue = DispatchQueue.global(qos: .userInitiated)
    /// New data will be place in this variable to be received by observers
    var messageReceived: Data?
    /// When there is an active listening NWConnection this will be `true`
    var isReady: Bool = false
    /// Default value `true`, this will become false if the UDPListener ceases listening for any reason
    public var listening: Bool = true

    /// A convenience init using Int instead of NWEndpoint.Port
    convenience init(on port: Int) {
        self.init(on: NWEndpoint.Port(integerLiteral: NWEndpoint.Port.IntegerLiteralType(port)))
    }
    /// Use this init or the one that takes an Int to start the listener
    init(on port: NWEndpoint.Port) {
        let params = NWParameters.udp
        params.allowFastOpen = true
        self.listener = try? NWListener(using: params, on: port)
        self.listener?.stateUpdateHandler = { update in
            switch update {
            case .ready:
                self.isReady = true
                print("Listener connected to port \(port)")
            case .failed, .cancelled:
                // Announce we are no longer able to listen
                self.listening = false
                self.isReady = false
                print("Listener disconnected from port \(port)")
            default:
                print("Listener connecting to port \(port)...")
            }
        }
        self.listener?.newConnectionHandler = { connection in
            print("Listener receiving new message")
            self.createConnection(connection: connection)
        }
        self.listener?.start(queue: self.queue)
    }

    func createConnection(connection: NWConnection) {
        self.connection = connection
        self.connection?.stateUpdateHandler = { (newState) in
            switch (newState) {
            case .ready:
                print("Listener ready to receive message - \(connection)")
                self.receive()
            case .cancelled, .failed:
                print("Listener failed to receive message - \(connection)")
                // Cancel the listener, something went wrong
                self.listener?.cancel()
                // Announce we are no longer able to listen
                self.listening = false
            default:
                print("Listener waiting to receive message - \(connection)")
            }
        }
        self.connection?.start(queue: .global())
    }

    func receive() {
        self.connection?.receiveMessage { [weak self] data, context, isComplete, error in
            if let unwrappedError = error {
                print("Error: NWError received in \(#function) - \(unwrappedError)")
                return
            }
            guard isComplete, let data = data else {
                print("Error: Received nil Data with context - \(String(describing: context))")
                return
            }
            self?.messageReceived = data
            self?.send(message: data)
//            if self?.listening {
//                self?.receive()
//            }
            self?.cancel()
        }
    }
    
    func send(message payload: Data) {
        connection?.send(content: payload, completion: NWConnection.SendCompletion.contentProcessed(({ (NWError) in
                    if (NWError == nil) {
                        print("Data was sent to UDP")
                    } else {
                        print("ERROR! Error when data (Type: Data) sending. NWError: \n \(NWError!)")
                    }
                })))
    }

    func cancel() {
        self.listening = false
        self.connection?.cancel()
    }
}
