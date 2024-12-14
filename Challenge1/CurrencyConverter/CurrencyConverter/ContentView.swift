//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by mac on 14/12/2567 BE.
//

import SwiftUI


extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        let scanner = Scanner(string: hexSanitized)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

struct ExchangeRatesResponse: Decodable {
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String: Double]
}

struct ContentView: View {
    @State private var selectedFrom: String = "USD"
    @State private var selectedTo: String = "VND"
    @State private var currencies: [String: String] = [:]
    @State private var loading: Bool = true
    @State private var result: String = ""
    @State private var amount: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    private var apiKey = "b543712767122774be971b0819a51d6f"
        
    func fetchCurrencies() {
        guard let url = URL(string: "https://openexchangerates.org/api/currencies.json?app_id=\(apiKey)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([String: String].self, from: data)
                    DispatchQueue.main.async {
                        self.currencies = decodedResponse
                    }
                    self.loading = false
                } catch {
                    print("Error decoding currencies response: \(error)")
                    self.loading = false
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

                let convertedAmount = (amount ) * toRate
                completion(convertedAmount, nil)
                
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

    private var sortedCurrencyCodes: [String] {
        return currencies.keys.sorted()
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                if loading {
                    ProgressView("Loading currencies...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    List {
                        Picker("From", selection: $selectedFrom) {
                            ForEach(sortedCurrencyCodes, id: \.self) { code in
                                Text("\(currencies[code] ?? code) (\(code))")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(10)
                        .background(Color(hex: "#fbf9f9"))
                        .frame(maxWidth: .infinity)
                        .disabled(true)

                        Picker("To", selection: $selectedTo) {
                            ForEach(sortedCurrencyCodes, id: \.self) { code in
                                Text("\(currencies[code] ?? code) (\(code))")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(10)
                        .background(Color(hex: "#fbf9f9"))
                        .frame(maxWidth: .infinity)

                        TextField("Amount", text: $amount)
                            .keyboardType(.decimalPad)
                            .padding(10)
                            .background(Color(hex: "#fbf9f9"))
                            .frame(maxWidth: .infinity)
                    }
                    .scrollContentBackground(.hidden)
                    .background(.white)
                    .listRowBackground(Color.clear)
                    .frame(height: 250)
                    

                    Button(action: {
                        if selectedTo.isEmpty {
                            alertMessage = "Please select a currency to convert to."
                            showAlert = true
                        } else if amount.isEmpty || Double(amount) == nil {
                            alertMessage = "Please enter a valid amount."
                            showAlert = true
                        } else if let amountValue = Double(amount) {
                            convertCurrency(to: selectedTo, amount: amountValue) { convertedAmount, error in
                                if let convertedAmount = convertedAmount {
                                    result = "Converted Amount: \(convertedAmount)"
                                } else {
                                    result = "Error: \(error?.localizedDescription ?? "Unknown error")"
                                }
                            }
                        }
                    })
                    {
                        Text("Convert")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Missing Selection"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    Text(result)
                        .padding()
                    Text("Note: Due to the limitations of the free API, conversions can only be made from USD to other currencies.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                        .padding()

                }
            }
            .onAppear {
                fetchCurrencies()
            }
            .navigationTitle("Currency Converter")
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
    }
}




#Preview {
    ContentView()
}
