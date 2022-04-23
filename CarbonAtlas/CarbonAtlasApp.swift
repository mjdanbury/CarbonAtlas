//
//  CarbonAtlasApp.swift
//  CarbonAtlas
//
//  Created by Matthew Danbury on 3/7/22.
//

import SwiftUI

@main
struct CarbonAtlasApp: App {
    @StateObject private var store = FootprintStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            ContentView(footprints: $store.footprints) {
                Task {
                    do {
                        try await FootprintStore.save(footprints: store.footprints)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            .task {
                do {
                    store.footprints = try await FootprintStore.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Carbon Atlas will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                store.footprints = Footprint.sampleData
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
