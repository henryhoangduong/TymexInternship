//
//  CurrencyConverterModel.swift
//  CurrencyConverter
//
//  Created by mac on 15/12/2567 BE.
//

import Foundation

struct ExchangeRatesResponse: Decodable {
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String: Double]
}

class CurrencyConverterModel {
    private var apiKey = "b543712767122774be971b0819a51d6f"
    
    func fetchCurrencies(completion: @escaping ([String: String]?, Error?) -> Void) {
        guard let url = URL(string: "https://openexchangerates.org/api/currencies.json?app_id=\(apiKey)") else {
            completion(nil, NSError(domain: "Invalid URL", code: 400, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([String: String].self, from: data)
                    completion(decodedResponse, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    func convertCurrency(to: String, amount: Double, completion: @escaping (Double?, Error?) -> Void) {
        guard let url = URL(string: "https://api.exchangeratesapi.io/v1/latest?access_key=\(apiKey)&symbols=\(to)") else {
            completion(nil, NSError(domain: "Invalid URL", code: 400, userInfo: nil))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "No Data", code: 500, userInfo: nil))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(ExchangeRatesResponse.self, from: data)
                guard let toRate = decodedResponse.rates[to] else {
                    completion(nil, NSError(domain: "Invalid Response", code: 500, userInfo: nil))
                    return
                }

                let convertedAmount = amount * toRate
                completion(convertedAmount, nil)
                
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
