//
//  ListHeaderView.swift
//  CarbonAtlas
//
//  Created by Matthew Danbury on 4/25/22.
//

import SwiftUI

struct ListHeaderView: View {
    @Binding var isInMapMode: Bool
    @Binding var isPresentingNewFootprintView: Bool
    var body: some View {
        HStack{
            Button(action: {
                isInMapMode = true
            }) {
                Image(systemName: "circle.grid.cross")
            }
            Spacer()
            Text("Carbon Atlas")
                .font(.title2)
            Spacer()
            Button(action: {
                isPresentingNewFootprintView = true
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Footprint")
        }.padding()
    }
}

struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderView(isInMapMode: .constant(false), isPresentingNewFootprintView: .constant(false))
    }
}
