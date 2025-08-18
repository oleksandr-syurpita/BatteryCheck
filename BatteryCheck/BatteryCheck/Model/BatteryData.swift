//
//  BatteryData.swift
//  BatteryCheck
//
//  Created by Oleksandr Syurpita on 18.08.2025.
//

struct BatteryData: Codable {
    let timestamp: String
    let level: Int
    let state: String
}
