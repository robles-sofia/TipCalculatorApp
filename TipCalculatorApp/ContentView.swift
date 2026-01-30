//
//  ContentView.swift
//  TipCalculatorApp
//
//
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount: Double = 0
    @State private var tipPercentage: Double = 0
    @State private var numberOfPeople: Double = 1
    @State private var showResults: Bool = false
    @State private var selectedCurrency: String = "USD"
    
    let currencies = ["USD", "EUR", "GBP", "JPY"]
    
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Tip Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Currency")
                    .font(.headline)
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            VStack(alignment: .leading) {
                Text("Bill Amount")
                
                Slider(value: $billAmount, in: 0...500, step: 1)
                    .tint(.pink)
                
                Text("\(billAmount, format: .currency(code: selectedCurrency))")
                    .foregroundColor(.pink)
                    .fontWeight(.semibold)
            }
            
            VStack(alignment: .leading) {
                Text("Tip Percentage")
                
                Slider(value: $tipPercentage, in: 0...30, step: 1)
                    .tint(.blue)
                
                Text("\(Int(tipPercentage))%")
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                    
            }
            
            VStack(alignment: .leading) {
                Text("Number of People")
                
                Slider(value: $numberOfPeople, in: 1...20, step: 1)
                    .tint(.purple)
                
                Text("\(Int(numberOfPeople))")
                    .foregroundColor(.purple)
                    .fontWeight(.semibold)
            }
            
            if showResults {
                VStack(spacing: 10) {
                    Text("Tip: \(tipAmount, format: .currency(code: "USD"))")
                    Text("Total: \(totalAmount, format: .currency(code: "USD"))")
                    Text("Per Person: \(amountPerPerson, format: .currency(code: "USD"))")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 5)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                showResults.toggle()
                }
            } label: {
                Text(showResults ? "Hide Results" : "Calculate")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(showResults ? Color.red : Color.blue)
                    .cornerRadius(12)
                    
            }
            
            Spacer()
        }
        .padding()
    }
    
    var tipAmount: Double {
        billAmount * (tipPercentage / 100)
    }
    var totalAmount: Double {
        billAmount + tipAmount
    }
    var amountPerPerson: Double {
        totalAmount / max(numberOfPeople, 1)
    }
    
}

#Preview {
    ContentView()
}
