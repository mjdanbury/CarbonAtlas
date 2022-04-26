//
//  ContentView.swift
//  CarbonAtlas
//
//  Created by Matthew Danbury on 3/7/22.
//

import SwiftUI

struct ContentView: View {
    @Binding var footprints: [Footprint]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isInMapMode = false
    let saveAction: ()->Void
    
    var body: some View {
        
        if isInMapMode {
            MapView(footprints: $footprints, isInMapMode: $isInMapMode)
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        } else {
            ListView(footprints: $footprints, isInMapMode: $isInMapMode)
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(footprints: .constant(Footprint.sampleData), saveAction: {})
    }
}
