//
//  Currencies.swift
//  ITRexTask
//
//  Created by Valera Sysov on 18.02.22.
//

import Foundation

var currencyArray = ["BYN", "EUR", "RUB", "USD"]

struct ExchangeRates: Codable {
    let rates: [String: Double]
}
