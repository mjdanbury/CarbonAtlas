//
//  MapView.swift
//  CarbonAtlas
//
//  Created by Matthew Danbury on 4/25/22.
//

import SwiftUI

struct MapView: View {
    @Binding var footprints: [Footprint]
    @Binding var isInMapMode: Bool
    @State private var currentSelection: Footprint? = nil
    @State private var isInLayoutMode = false
    
    var body: some View {
        VStack {
            MapHeaderView(isInMapMode: $isInMapMode, isInLayoutMode: $isInLayoutMode)
            GeometryReader { geo in
                ZStack{
                    Rectangle().fill(Color.white)
                    ForEach($footprints) { $footprint in
                        Circle()
                            .fill(Color.gray)
                            .offset(x: footprint.x, y: footprint.y)
//                            .gesture( isInLayoutMode ? DragGesture()
//                                .onChanged { value in
//                                    //footprint.x = initialPosition.x + value.x
//                                    //footprint.y = initialPosition.y + value.y
//                                }
//                                .onEnded { value in
//                                    // initial position = nil
//                                } : nil ) //ill need to do something similar on the magnification gesture
                    }
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .clipShape(Rectangle().size(width: geo.size.width, height: geo.size.height))
            }
            HStack {
                if let selection = currentSelection {
                    Text(selection.name)
                    Text(CO2Format(selection.c02e))
                    Button(action: {currentSelection = nil}) {
                        Image(systemName: "xmark.circle")
                    }
                    
                } else {
                    EmptyView()
                }
            }
        }
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

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(footprints: .constant(Footprint.sampleData), isInMapMode: .constant(true))
    }
}
