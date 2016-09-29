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
    var ambientIntensity: Float
    var direction: (Float, Float, Float)
    var diffuseIntensity: Float
    var shininess: Float
    var specularIntensity: Float
    
    static func size() -> Int {
        return MemoryLayout<Float>.size * 12
    }
    
    func raw() -> [Float] {
        let raw = [color.0, color.1, color.2, ambientIntensity, direction.0, direction.1, direction.2, diffuseIntensity, shininess, specularIntensity]
        return raw
    }
}
