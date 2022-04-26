//
//  MapHeaderView.swift
//  CarbonAtlas
//
//  Created by Matthew Danbury on 4/25/22.
//

import SwiftUI

struct MapHeaderView: View {
    @Binding var isInMapMode: Bool
    @Binding var isInLayoutMode: Bool
    var body: some View {
        HStack{
            Button(action: {isInMapMode.toggle()}) {
                Image(systemName: "text.justify")
            }
            Spacer()
            Text("Carbon Atlas")
                .font(.title2)
            Spacer()
            Button(action: {isInLayoutMode.toggle()}) {
                Image(systemName: "circle.dashed")
            }
            .accessibilityLabel("New Footprint")
        }.padding()
    }
}

struct MapHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MapHeaderView(isInMapMode: .constant(true), isInLayoutMode: .constant(false))
    }
}
