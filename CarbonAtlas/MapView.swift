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
    @State private var isInLayoutMode = true
    
    //Zooming
    @State private var zoomScale: CGFloat = 0.5
    @State private var initialZoomScale: CGFloat?
    
    //Dragging
    @State private var dragSelection: Footprint? = nil
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        VStack {
            MapHeaderView(isInMapMode: $isInMapMode, isInLayoutMode: $isInLayoutMode)
            GeometryReader { geo in
                ZStack{
                    Rectangle().fill(Color.white)
                    ForEach($footprints) { $footprint in
                        Circle()
                            .fill(Color.gray)
                            .frame(width: footprint.drawingRadius, height: footprint.drawingRadius)
                            .offset(x: dragSelection == footprint ? footprint.position.x + dragOffset.width : footprint.position.x,
                                    y: dragSelection == footprint ? footprint.position.y + dragOffset.height : footprint.position.y)
                            .gesture( isInLayoutMode ? DragGesture()
                                .onChanged { gesture in
                                    dragSelection = footprint
                                    dragOffset = gesture.translation
                                }
                                .onEnded { value in
                                    footprint.position.x += dragOffset.width
                                    footprint.position.y += dragOffset.height
                                    dragSelection = nil
                                    dragOffset = .zero
                                } : nil )
                            .gesture( !isInLayoutMode ? TapGesture()
                                .onEnded {
                                    currentSelection = footprint
                                } : nil )
                    }
                    .scaleEffect(self.zoomScale)
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .clipShape(Rectangle().size(width: geo.size.width, height: geo.size.height))
                .gesture(MagnificationGesture()
                    .onChanged { value in
                        if self.initialZoomScale == nil {
                            self.initialZoomScale = self.zoomScale
                        }
                    zoomScale = value.magnitude * (initialZoomScale ?? 4.0)
                    }
                    .onEnded { value in
                        zoomScale = value.magnitude * (initialZoomScale ?? 4.0)
                        self.initialZoomScale = nil
                    })
            }
            HStack {
                if let selection = currentSelection {
                    Text(selection.name)
                    Text(CO2Format(selection.c02e))
                    Button(action: {currentSelection = nil}) {
                        Image(systemName: "xmark.circle")
                    }
                    
                } else {
                    Text("")
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
