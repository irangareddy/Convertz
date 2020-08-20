//
//  ContentView.swift
//  Convertz
//
//  Created by RANGA REDDY NUKALA on 20/08/20.
//

import SwiftUI

struct ContentView: View {
    
    let unitTypeLabels = ["Temp", "Length", "Area", "Volume"]
    let unitTemperatures: [UnitTemperature] = [.celsius,.fahrenheit,.kelvin]
    let unitLengths: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    let unitAreas: [UnitArea] = [.squareMeters, .hectares, .squareFeet, .acres]
    let unitVolumes: [UnitVolume] = [.milliliters, .liters, .cups, .pints, .gallons, .cubicInches]
    
    
    var unitTypes: [Dimension] {
        let types: [[Dimension]] = [unitTemperatures,unitLengths, unitAreas, unitVolumes]
        return types[typeIndex]
    }
    
    var units: [String] {
        unitTypes.map {$0.symbol}
    }
    
    var output: Double {
        let inputValue = Double(input) ?? 0
        
        if inputIndex < unitTypes.count && outputIndex < unitTypes.count {
            return Measurement(value: inputValue, unit: unitTypes[inputIndex]).converted(to: unitTypes[outputIndex]).value
        }
            
           
        return 0
    }
    
    @State private var input = ""
    @State private var typeIndex = 0
    @State private var inputIndex = 2
    @State private var outputIndex = 0
    
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section(header: Text("From")) {
                    HStack {
                        TextField("Value", text: $input)
                         .frame(width: 150)
                         .keyboardType(.decimalPad)
                         Text(inputIndex < units.count ? units[inputIndex] : "")
                         Spacer()
                        }
                }

                Section(header: Text("Unit Type")) {
                    UnitPicker(units: unitTypeLabels, unit: $typeIndex)
                    }
                
                Section(header: Text("From Unit")) {
                    UnitPicker(units: units, unit: $inputIndex)
                    }
                
                Section(header: Text("To Unit")) {
                    UnitPicker(units: units, unit: $outputIndex)
                    }
                
                Section(header: Text("To:")) {
                    HStack {
                     Text("\(output, specifier: "%g") ")
                        .bold()
                     Text(outputIndex < units.count ? units[outputIndex] : "")
                    }.font(.title)
                    
                    }
                
            }.navigationBarTitle("Convertz")
        }
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
