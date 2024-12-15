//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by mac on 14/12/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CurrencyConverterViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.loading {
                    ProgressView("Loading currencies...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    List {
                        Picker("From", selection: $viewModel.selectedFrom) {
                            ForEach(viewModel.sortedCurrencyCodes, id: \.self) { code in
                                Text("\(viewModel.currencies[code] ?? code) (\(code))")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(10)
                        .background(Color(hex: "#fbf9f9"))
                        .frame(maxWidth: .infinity)
                        .disabled(true)

                        Picker("To", selection: $viewModel.selectedTo) {
                            ForEach(viewModel.sortedCurrencyCodes, id: \.self) { code in
                                Text("\(viewModel.currencies[code] ?? code) (\(code))")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(10)
                        .background(Color(hex: "#fbf9f9"))
                        .frame(maxWidth: .infinity)

                        TextField("Amount", text: $viewModel.amount)
                            .keyboardType(.decimalPad)
                            .padding(10)
                            .background(Color(hex: "#fbf9f9"))
                            .frame(maxWidth: .infinity)
                            .onChange(of: viewModel.amount) { _ in
                                viewModel.result = ""  
                            }
                    }
                    .scrollContentBackground(.hidden)
                    .background(.white)
                    .listRowBackground(Color.clear)
                    .frame(height: 250)

                    Button(action: {
                        viewModel.convertCurrency()
                    }) {
                        if viewModel.converting {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                                .frame(maxWidth: .infinity)
                        } else {
                            Text("Convert")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(
                            title: Text("Missing Selection"),
                            message: Text(viewModel.alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }

                    Text(viewModel.result)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(viewModel.result.contains("Error") ? .red : .green)
                        .padding()
                        .background(Color.white)
               
                        
                        .padding(.horizontal)
                        .padding(.top, 10)
                    Text("Note: Due to the limitations of the free API, conversions can only be made from USD to other currencies.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                        .padding()
                }
            }
            .onAppear {
                viewModel.fetchCurrencies()
            }
            .navigationTitle("Currency Converter")
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
    }
}



#Preview {
    ContentView()
}
