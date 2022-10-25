//
//  NetworkManager.swift
//  NoteApp
//
//  Created by Vinoth Priyan on 16/09/22.
//

import Foundation
import Network

class NetworkManager: ObservableObject{
    
    let networkMonitor = NWPathMonitor()
    let makeQueue = DispatchQueue(label: "NetworkManager")
    @Published var networkConnected: Bool = false
    
    init(){
        self.networkMonitor.pathUpdateHandler = { networkPath in
            DispatchQueue.main.async {
                self.networkConnected = networkPath.status == .satisfied
            }
        }
        networkMonitor.start(queue: makeQueue)
    }
}
