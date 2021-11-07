//
//  ContentView.swift
//  Tip Calculator
//
//  Created by Paul Serbanescu on 11/7/21.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var isFocused : Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var currency: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currency)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                    .foregroundColor(.primary)
                } header: {
                    Text("Bill amount")
                        .foregroundColor(.primary)
                }
                .foregroundColor(Color(red: 0, green: 139/255, blue: 0, opacity: 1))
                
                Section {
                    Picker ("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                        .pickerStyle(.segmented)
                    }
                    .foregroundColor(.blue)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: currency)
                } header: {
                    Text("payment per person")
                }
                .foregroundColor(Color(red: 0, green: 0, blue: 139/255, opacity: 1))
                
                Section {
                    Text(totalPerPerson * Double(numberOfPeople + 2), format: currency)
                } header: {
                    Text("Total bill")
                }
                .foregroundColor(Color(red: 139/255, green: 0, blue: 0, opacity: 1))
            }
            .navigationTitle("Tip Calculator")
            .foregroundColor(.primary)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
