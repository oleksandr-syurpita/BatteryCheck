//
//  HomeVie.swift
//  BatteryCheck
//
//  Created by Oleksandr Syurpita on 18.08.2025.
//

import Foundation
import UIKit
import SwiftUI

class BatteryViewModel: ObservableObject {
    
    @Published var isMonitoringEnabled = false

    @Published var batteryService = BatteryService()
    @Published var networkService = NetworkService()
    private var timer: Timer?
    private var backgroundTaskID: UIBackgroundTaskIdentifier = .invalid
    private let interval: TimeInterval = 120

    func toggleMonitoring(_ enabled: Bool) {
        isMonitoringEnabled = enabled
        enabled ? startMonitoring() : stopMonitoring()
    }

    private func startMonitoring() {
        stopMonitoring()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.collectAndSend()
        }
        collectAndSend() 
    }

    private func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }

    private func collectAndSend() {
        beginBackgroundTask()
        let data = batteryService.getBatteryInfo()
        networkService.sendBatteryData(data)
        endBackgroundTask()
    }

    private func beginBackgroundTask() {
        backgroundTaskID = UIApplication.shared.beginBackgroundTask(withName: "BatteryMonitor") {
            self.endBackgroundTask()
        }
    }

    private func endBackgroundTask() {
        if backgroundTaskID != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTaskID)
            backgroundTaskID = .invalid
        }
    }

    deinit {
        stopMonitoring()
        endBackgroundTask()
    }
}
