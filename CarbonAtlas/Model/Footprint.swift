//
//  Footprint.swift
//  CarbonAtlas
//
//  Created by Matthew Danbury on 4/23/22.
//

import Foundation

struct Footprint: Identifiable, Codable {
    var id: UUID
    var x: Double
    var y: Double
    var name: String
    var notes: String = ""
    var possibleImageName: String
    var c02e: Double
    
    init(id: UUID = UUID(), x: Double, y: Double, name: String, possibleImageName: String, c02e: Double){
        self.id = id
        self.x = x
        self.y = y
        self.name = name
        self.possibleImageName = possibleImageName
        self.c02e = c02e
    }
}

extension Footprint {
    struct Data {
        var name: String = ""
        var notes: String = ""
        var possibleImageName: String = ""
        var c02e: String = "0"
    }
    
    var data: Data {
        Data(name: name, notes: notes, possibleImageName: possibleImageName, c02e: String(c02e))
    }
    
    // idek if I will need to call this... I haven't yet used DetailView
    mutating func update(from data: Data) {
        name = data.name
        notes = data.notes
        possibleImageName = data.possibleImageName
        c02e = Double(data.c02e) ?? 0
        
        let drawingAngle = Double.random(in: 0..<6.28)
        let drawingRadius = 3*(((Double(data.c02e) ?? 0)*5000).squareRoot())
        x = drawingRadius * cos(drawingAngle)
        y = drawingRadius * sin(drawingAngle)
    }
    
    init(id: UUID = UUID(), data: Data) {
        self.id = id
        self.name = data.name
        self.possibleImageName = data.possibleImageName
        self.notes = data.notes
        self.c02e = Double(data.c02e) ?? 0
        
        let drawingAngle = Double.random(in: 0..<6.28)
        let drawingRadius = 3*(((Double(data.c02e) ?? 0)*5000).squareRoot())
        self.x = drawingRadius * cos(drawingAngle)
        self.y = drawingRadius * sin(drawingAngle)
    }
}

extension Footprint {
    static let sampleData: [Footprint] =
    [
        Footprint(x: -11.35569, y: 94.18624, name: "A Short Email Sent from Laptop to Laptop", possibleImageName: "email", c02e: 0.3),
        Footprint(x: 88.53660, y: -121.0837, name: "A Google Search", possibleImageName: "google search", c02e: 0.5),
        Footprint(x: 127.46331, y: 140.5457, name: "A Text Message", possibleImageName: "text", c02e: 0.8),
        Footprint(x: 96.0256, y: -284.21658, name: "Using the Dyson Airblade Hand Dryer", possibleImageName: "hand dryer", c02e: 2),
        Footprint(x: 299.8398, y: 9.800349, name: "An Hour-Long Zoom Meeting on the 2020 13-inch MacBook Pro", possibleImageName: "zoom call", c02e: 2),
        Footprint(x: 223.2253, y: 291.83972, name: "A Lightweight Plastic Bag", possibleImageName: "plastic bag", c02e: 3),
        
    ]
}
