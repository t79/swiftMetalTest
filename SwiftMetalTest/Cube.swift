//
//  Cube.swift
//  SwiftMetalTest
//
//  Created by Terje Urnes on 22.09.2016.
//  Copyright © 2016 Terje Urnes. All rights reserved.
//

import Foundation
import Metal

class Cube: Node {
    
    init(device: MTLDevice) {
        
        let A = Vertex(x: -0.3, y:  0.3, z: 0.3, r: 1.0, g: 0.0, b: 0.0, a: 1.0)
        let B = Vertex(x: -0.3, y: -0.3, z: 0.3, r: 0.0, g: 1.0, b: 0.0, a: 1.0)
        let C = Vertex(x:  0.3, y: -0.3, z: 0.3, r: 0.0, g: 0.0, b: 1.0, a: 1.0)
        let D = Vertex(x:  0.3, y:  0.3, z: 0.3, r: 0.1, g: 0.6, b: 0.4, a: 1.0)
        
        let Q = Vertex(x: -0.3, y:  0.3, z: -0.3, r: 1.0, g: 0.0, b: 0.0, a: 1.0)
        let R = Vertex(x:  0.3, y:  0.3, z: -0.3, r: 0.0, g: 1.0, b: 0.0, a: 1.0)
        let S = Vertex(x: -0.3, y: -0.3, z: -0.3, r: 0.0, g: 0.0, b: 1.0, a: 1.0)
        let T = Vertex(x:  0.3, y: -0.3, z: -0.3, r: 0.1, g: 0.6, b: 0.4, a: 1.0)
        
        let verticesArray: Array<Vertex> = [
            A, B, C,    A, C, D,
            R, T, S,    Q, R, S,
            
            Q, S, B,    Q, B, A,
            D, C, T,    D, T, R,
            
            Q, A, D,    Q, D, R,
            B, S, T,    B, T, C
        ]
        
        super.init(name: "Cube", vertices: verticesArray, device: device)
        
    }
}

