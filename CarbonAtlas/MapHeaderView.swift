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
            Button(action: {isInMapMode = false}) {
                Image(systemName: "text.justify")
            }
            Spacer()
            Text("Carbon Atlas")
                .font(.title2)
            Spacer()
            Button(action: {
                isInLayoutMode = !isInLayoutMode
            }) {
                if isInLayoutMode {
                    Image(systemName: "aqi.low")}
                else {
                    Image(systemName: "circle.dashed")
                }
            }
        }.padding()
    }
}

struct MapHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MapHeaderView(isInMapMode: .constant(true), isInLayoutMode: .constant(false))
    }
}
