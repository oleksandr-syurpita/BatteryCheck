//
//  ContentView.swift
//  BatteryCheck
//
//  Created by Oleksandr Syurpita on 18.08.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = BatteryViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Toggle("Моніторинг батареї", isOn: Binding(
                get: { viewModel.isMonitoringEnabled },
                set: { viewModel.toggleMonitoring($0) }
            ))
            .padding()
            Text("\(viewModel.batteryService.getBatteryInfo().level)")
            Text(viewModel.isMonitoringEnabled ? "Активний моніторинг" : "Вимкнено")
                .foregroundColor(viewModel.isMonitoringEnabled ? .green : .gray)
        }
        .padding()
    }
}


#Preview {
    HomeView()
}
