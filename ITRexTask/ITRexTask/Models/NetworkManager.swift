//
//  NetworkManager.swift
//  ITRexTask
//
//  Created by Valera Sysov on 18.02.22.
//

import Foundation

final class NetworkManager {
    func fetchJSON(firstCurrent: String, completioHendler: @escaping (ExchangeRates) -> Void) {
        let stringUrl = "https://open.er-api.com/v6/latest/\(firstCurrent)"
        guard let url = URL(string: stringUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(ExchangeRates.self, from: data)
                completioHendler(results)
            } catch {
                print(error)
            }
        }.resume()
    }
}
