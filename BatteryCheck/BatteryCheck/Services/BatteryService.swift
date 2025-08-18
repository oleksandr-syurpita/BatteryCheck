//
//  Battery.swift
//  BatteryCheck
//
//  Created by Oleksandr Syurpita on 18.08.2025.
//

import UIKit

class BatteryService {
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }

    func getBatteryInfo() -> BatteryData {
        let level = Int(UIDevice.current.batteryLevel * 100)
        let state: String

        switch UIDevice.current.batteryState {
        case .charging: state = "charging"
        case .full: state = "full"
        case .unplugged: state = "unplugged"
        default: state = "unknown"
        }

        let timestamp = ISO8601DateFormatter().string(from: Date())
        return BatteryData(timestamp: timestamp, level: level, state: state)
    }
}
