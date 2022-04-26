//
//  Footprint.swift
//  CarbonAtlas
//
//  Created by Matthew Danbury on 4/23/22.
//

import Foundation
import SwiftUI

struct Footprint: Identifiable, Codable, Equatable {
    var id: UUID
    
    //A CGPoint is something with CGFloat's called x and y. Would it be better just to have a variable called position?
    var position: CGPoint
    var name: String
    var notes: String = ""
    var possibleImageName: String
    var c02e: Double {
        willSet {
            drawingRadius = CGFloat(abs(newValue*5000).squareRoot())
        }
    }
    //This too lol
    var drawingRadius: CGFloat
    
    
    
    init(id: UUID = UUID(), position: CGPoint, name: String, possibleImageName: String, c02e: Double){
        self.id = id
        self.position = position
        self.name = name
        self.possibleImageName = possibleImageName
        self.c02e = c02e
        self.drawingRadius = CGFloat(abs(self.c02e).squareRoot())
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
    
    init(id: UUID = UUID(), data: Data) {
        self.id = id
        self.name = data.name
        self.possibleImageName = data.possibleImageName
        self.notes = data.notes
        self.c02e = Double(data.c02e) ?? 0
        self.drawingRadius = CGFloat(abs(self.c02e*5000).squareRoot())
        
        let drawingAngle = Double.random(in: 0..<6.28)
        self.position = CGPoint(x: 3 * self.drawingRadius * cos(drawingAngle), y: 3 * self.drawingRadius * sin(drawingAngle))
    }
}

extension Footprint {
    static let sampleData: [Footprint] =
    [
        Footprint(position: CGPoint(x: -11.35569, y: 94.18624), name: "A Short Email Sent from Laptop to Laptop", possibleImageName: "email", c02e: 0.3),
        Footprint(position: CGPoint(x: 88.53660, y: -121.0837), name: "A Google Search", possibleImageName: "google search", c02e: 0.5),
        Footprint(position: CGPoint(x: 127.46331, y: 140.5457), name: "A Text Message", possibleImageName: "text", c02e: 0.8),
        Footprint(position: CGPoint(x: 96.0256, y: -284.21658), name: "Using the Dyson Airblade Hand Dryer", possibleImageName: "hand dryer", c02e: 2),
        Footprint(position: CGPoint(x: 299.8398, y: 9.800349), name: "An Hour-Long Zoom Meeting on the 2020 13-inch MacBook Pro", possibleImageName: "zoom call", c02e: 2),
        Footprint(position: CGPoint(x: 223.2253, y: 291.83972), name: "A Lightweight Plastic Bag", possibleImageName: "plastic bag", c02e: 3)
        
    ]
}
