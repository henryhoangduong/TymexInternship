//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by mac on 15/12/2567 BE.
//

import SwiftUI

class CurrencyConverterViewModel: ObservableObject {
    @Published var selectedFrom: String = "USD"
    @Published var selectedTo: String = "VND"
    @Published var currencies: [String: String] = [:]
    @Published var loading: Bool = true
    @Published var result: String = ""
    @Published var amount: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var converting: Bool = false
    
    private var model = CurrencyConverterModel()
    
    func fetchCurrencies() {
        model.fetchCurrencies { [weak self] currencies, error in
            DispatchQueue.main.async {
                if let currencies = currencies {
                    self?.currencies = currencies
                    self?.loading = false
                } else {
                    self?.loading = false
                    self?.alertMessage = error?.localizedDescription ?? "Unknown error"
                    self?.showAlert = true
                }
            }
        }
    }
    
    func convertCurrency() {
            converting = true
            
            guard let amountValue = Double(amount), amountValue > 0 else {
                alertMessage = "Please enter a valid positive amount."
                showAlert = true
                converting = false
                return
            }

            guard !selectedTo.isEmpty else {
                alertMessage = "Please select a currency."
                showAlert = true
                converting = false
                return
            }

            model.convertCurrency(to: selectedTo, amount: amountValue) { [weak self] convertedAmount, error in
                DispatchQueue.main.async {
                    if let convertedAmount = convertedAmount {
                        self?.result = "Converted Amount: \(convertedAmount)"
                    } else {
                        self?.result = "Error: \(error?.localizedDescription ?? "Unknown error")"
                    }
                    self?.converting = false // Set converting to false once the conversion is done
                }
            }
        }
    var sortedCurrencyCodes: [String] {
        return currencies.keys.sorted()
    }
}
