//
//  Vertex.swift
//  SwiftMetalTest
//
//  Created by Terje Urnes on 22.09.2016.
//  Followed tutorial by Ray Wenderlich, see README.md
//

struct Vertex {
    
    var x, y, z: Float
    var r, g, b, a: Float
    
    func floatBuffer() -> [Float] {
        return [x, y, z, r, g, b, a]
    }
    
}
