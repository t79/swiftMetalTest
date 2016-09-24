//
//  Light.swift
//  SwiftMetalTest
//
//  Created by Terje Urnes on 25.09.2016.
//  Followed tutorial by Ray Wenderlich, see README.md
//

import Foundation

struct Light {
    
    var color: (Float, Float, Float)
    var ambientLintensity: Float
    
    static func size() -> Int {
        return MemoryLayout<Float>.size * 4
    }
    
    func raw() -> [Float] {
        let raw = [color.0, color.1, color.2, ambientLintensity]
        return raw
    }
}
