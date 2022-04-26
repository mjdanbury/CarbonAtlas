//
//  ListView.swift
//  CarbonAtlas
//
//  Created by Matthew Danbury on 4/25/22.
//

import SwiftUI

struct ListView: View {
    @Binding var footprints: [Footprint]
    @Binding var isInMapMode: Bool
    @State private var isPresentingNewFootprintView = false
    @State private var newFootprintData = Footprint.Data()
    
    var body: some View {
        VStack{
            ListHeaderView(isInMapMode: $isInMapMode, isPresentingNewFootprintView: $isPresentingNewFootprintView)
            List {
                ForEach($footprints) { $footprint in
                    VStack {
                        HStack {
                            Text(footprint.name)
                            Spacer()
                            Text(CO2Format(footprint.c02e))
                        }
                        Spacer()
                        Text("x: "+String(Double(footprint.position.x)))
                        Text("y: "+String(Double(footprint.position.y)))
                    }//.onTapGesture(perform: {currentSelection = footprint})
                }
                .onDelete(perform: deleteItems)
            }
            .sheet(isPresented: $isPresentingNewFootprintView) {
                NavigationView {
                    DetailEditView(data: $newFootprintData)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingNewFootprintView = false
                                    newFootprintData = Footprint.Data()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    let newFootprint = Footprint(data: newFootprintData)
                                    footprints.append(newFootprint)
                                    isPresentingNewFootprintView = false
                                    newFootprintData = Footprint.Data()
                                }
                            }
                        }
                }
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        footprints.remove(atOffsets: offsets)
    }
    
    func CO2Format(_ value: Double) -> String {
        let absValue = abs(value)
        switch absValue {
        case 1000..<1000000:
            return String(value/1000) + "kg CO2e"
        case 1000000..<1000000000:
            return String(value/1000000) + "t CO2e"
        case 1000000000..<1000000000000:
            return String(value/1000000000) + "kt CO2e"
        case 1000000000000..<1000000000000000:
            return String(value/1000000000000) + "Mt CO2e"
        case 1000000000000000..<1000000000000000000:
            return String(value/1000000000000000) + "Gt CO2e"
        default:
            return String(value) + "g CO2e"
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(footprints: .constant(Footprint.sampleData), isInMapMode: .constant(false))
    }
}
