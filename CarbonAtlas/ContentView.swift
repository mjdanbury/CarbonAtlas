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
    let saveAction: ()->Void
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                Rectangle().fill(Color.white)
                ForEach($footprints) { $footprint in
                    Circle()
                        .fill(Color.gray)
                        .offset(x: footprint.x, y: footprint.y)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .clipShape(Rectangle().size(width: geo.size.width, height: geo.size.height))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(footprints: .constant(Footprint.sampleData), saveAction: {})
    }
}
