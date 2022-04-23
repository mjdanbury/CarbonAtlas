//
//  FootprintStore.swift
//  CarbonAtlas
//
//  Created by Matthew Danbury on 4/23/22.
//

import Foundation
import SwiftUI

class FootprintStore: ObservableObject {
    @Published var footprints: [Footprint] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("footprints.data")
    }
    
    static func load() async throws -> [Footprint] {
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let footprints):
                    continuation.resume(returning: footprints)
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<[Footprint], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let footprints = try JSONDecoder().decode([Footprint].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(footprints))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func save(footprints: [Footprint]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(footprints: footprints) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let footprintsSaved):
                    continuation.resume(returning: footprintsSaved)
                }
            }
        }
    }
    
    static func save(footprints: [Footprint], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(footprints)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(footprints.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
