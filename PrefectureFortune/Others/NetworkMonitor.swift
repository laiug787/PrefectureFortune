//
//  NetworkMonitor.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/03
//

import Foundation
import Network

// https://www.danijelavrzan.com/posts/2022/11/network-connection-alert-swiftui/
class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
