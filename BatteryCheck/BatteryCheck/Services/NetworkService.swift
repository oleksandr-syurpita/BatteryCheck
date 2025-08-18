//
//  NetworkService.swift
//  BatteryCheck
//
//  Created by Oleksandr Syurpita on 18.08.2025.
//

import Foundation

class NetworkService {
    func sendBatteryData(_ data: BatteryData) {
        guard let jsonData = try? JSONEncoder().encode(data) else {
            print("problem with JSONEncoder")
            return
        }

        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print("кодування JSON:\n\(jsonString)")
        }

        let base64Encoded = jsonData.base64EncodedString()
        print("Base64-кодований JSON:\n\(base64Encoded)")

        let payload = ["payload": base64Encoded]
        guard let body = try? JSONSerialization.data(withJSONObject: payload) else {
            print("Не вдалося створити тіло запиту")
            return
        }

        if let bodyString = String(data: body, encoding: .utf8) {
            print("Тіло запиту:\n\(bodyString)")
        }

        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Помилка при надсиланні: \(error.localizedDescription)")
            } else {
                print("все ok")
            }
        }.resume()
    }
}

