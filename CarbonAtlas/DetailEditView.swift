//
//  EditView.swift
//  Scrumdinger
//
//  Created by Matthew Danbury on 1/28/22.
//

import SwiftUI

struct DetailEditView: View {
    //reimplement this as a custom binding that handles the type conversion on set
    @Binding var data: Footprint.Data
    
    var body: some View {
        Form {
            Section(header: Text("Carbon Footprint Info")) {
                TextField("Name", text: $data.name)
                TextField("Carbon Dioxide Equivalent", text: $data.c02e)
                    .keyboardType(.decimalPad)
                TextField("System Image", text: $data.possibleImageName)
            }
            Section(header: Text("Notes")) {
                TextEditor(text: $data.notes)
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(Footprint.sampleData[0].data))
    }
}
