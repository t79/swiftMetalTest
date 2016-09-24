//
//  Cube.swift
//  SwiftMetalTest
//
//  Created by Terje Urnes on 22.09.2016.
//  Copyright © 2016 Terje Urnes. All rights reserved.
//

import Foundation
import MetalKit

class Cube: Node {
    
    init(device: MTLDevice, commandQ: MTLCommandQueue, textureLoader: MTKTextureLoader) {
        
        let A = Vertex(x: -1.0, y:  1.0, z: 1.0, r: 1.0, g: 0.0, b: 0.0, a: 1.0, s: 0.25, t: 0.25)
        let B = Vertex(x: -1.0, y: -1.0, z: 1.0, r: 0.0, g: 1.0, b: 0.0, a: 1.0, s: 0.25, t: 0.50)
        let C = Vertex(x:  1.0, y: -1.0, z: 1.0, r: 0.0, g: 0.0, b: 1.0, a: 1.0, s: 0.50, t: 0.50)
        let D = Vertex(x:  1.0, y:  1.0, z: 1.0, r: 0.1, g: 0.6, b: 0.4, a: 1.0, s: 0.50, t: 0.25)
        
        let E = Vertex(x: -1.0, y:  1.0, z: -1.0, r: 1.0, g: 0.0, b: 0.0, a: 1.0, s: 0.00, t: 0.25)
        let F = Vertex(x: -1.0, y: -1.0, z: -1.0, r: 0.0, g: 1.0, b: 0.0, a: 1.0, s: 0.00, t: 0.50)
        let G = Vertex(x: -1.0, y: -1.0, z:  1.0, r: 0.0, g: 0.0, b: 1.0, a: 1.0, s: 0.25, t: 0.50)
        let H = Vertex(x: -1.0, y:  1.0, z:  1.0, r: 0.1, g: 0.6, b: 0.4, a: 1.0, s: 0.25, t: 0.25)
        
        let I = Vertex(x: 1.0, y:  1.0, z:  1.0, r: 1.0, g: 0.0, b: 0.0, a: 1.0, s: 0.50, t: 0.25)
        let J = Vertex(x: 1.0, y: -1.0, z:  1.0, r: 0.0, g: 1.0, b: 0.0, a: 1.0, s: 0.50, t: 0.50)
        let K = Vertex(x: 1.0, y: -1.0, z: -1.0, r: 0.0, g: 0.0, b: 1.0, a: 1.0, s: 0.75, t: 0.50)
        let L = Vertex(x: 1.0, y:  1.0, z: -1.0, r: 0.1, g: 0.6, b: 0.4, a: 1.0, s: 0.75, t: 0.25)
        
        let M = Vertex(x: -1.0, y: 1.0, z: -1.0, r: 1.0, g: 0.0, b: 0.0, a: 1.0, s: 0.25, t: 0.00)
        let N = Vertex(x: -1.0, y: 1.0, z:  1.0, r: 0.0, g: 1.0, b: 0.0, a: 1.0, s: 0.25, t: 0.25)
        let O = Vertex(x:  1.0, y: 1.0, z:  1.0, r: 0.0, g: 0.0, b: 1.0, a: 1.0, s: 0.50, t: 0.25)
        let P = Vertex(x:  1.0, y: 1.0, z: -1.0, r: 0.1, g: 0.6, b: 0.4, a: 1.0, s: 0.50, t: 0.00)
        
        let Q = Vertex(x: -1.0, y: -1.0, z:  1.0, r: 1.0, g: 0.0, b: 0.0, a: 1.0, s: 0.25, t: 0.50)
        let R = Vertex(x: -1.0, y: -1.0, z: -1.0, r: 0.0, g: 1.0, b: 0.0, a: 1.0, s: 0.25, t: 0.75)
        let S = Vertex(x:  1.0, y: -1.0, z: -1.0, r: 0.0, g: 0.0, b: 1.0, a: 1.0, s: 0.50, t: 0.75)
        let T = Vertex(x:  1.0, y: -1.0, z:  1.0, r: 0.1, g: 0.6, b: 0.4, a: 1.0, s: 0.50, t: 0.50)
        
        let U = Vertex(x:  1.0, y:  1.0, z: -1.0, r: 1.0, g: 0.0, b:  0.0, a: 1.0, s: 0.75, t: 0.25)
        let V = Vertex(x:  1.0, y: -1.0, z: -1.0, r: 0.0, g: 1.0, b:  0.0, a: 1.0, s: 0.75, t: 0.50)
        let W = Vertex(x: -1.0, y: -1.0, z: -1.0, r: 0.0, g: 0.0, b:  1.0, a: 1.0, s: 1.00, t: 0.50)
        let X = Vertex(x: -1.0, y:  1.0, z: -1.0, r: 0.1, g: 0.6, b:  0.4, a: 1.0, s: 1.00, t: 0.25)
        
        let verticesArray: Array<Vertex> = [
            A, B, C,    A, C, D,
            E, F, G,    E, G, H,
            
            I, J, K,    I, K, L,
            M, N, O,    M, O, P,
            
            Q, R, S,    Q, S, T,
            U, V, W,    U, W, X
        ]
        
        let path = Bundle.main.path(forResource: "cube", ofType: "png")!
        let data = NSData(contentsOfFile: path) as! Data
        let texture = try! textureLoader.newTexture(with: data, options: [MTKTextureLoaderOptionSRGB: (false as NSNumber)])
        
        super.init(name: "Cube", vertices: verticesArray, device: device, texture: texture)
        
    }
    
    override func updateWithDelta(delta: CFTimeInterval) {
        super.updateWithDelta(delta: delta)
        
        let secsPerMove: Float = 6.0
        //rotationY = sinf( Float(time) * 2.0 * Float(M_PI) / secsPerMove)
        //rotationX = sinf( Float(time) * 2.0 * Float(M_PI) / secsPerMove)
    }
}

