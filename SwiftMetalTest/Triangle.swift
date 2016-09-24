//
//  Triangle.swift
//  SwiftMetalTest
//
//  Created by Terje Urnes on 22.09.2016.
//  Followed tutorial by Ray Wenderlich, see README.md
//

import Foundation
import Metal

class Triangle: Node {
    
    init(device: MTLDevice) {
        
        let V0 = Vertex(x:  0.0, y:  1.0, z: 0.0, r: 1.0, g: 0.0, b: 0.0, a: 1.0, s: 0.0, t: 0.0, nX: 0.0, nY: 0.0, nZ: 0.0)
        let V1 = Vertex(x: -1.0, y: -1.0, z: 0.0, r: 0.0, g: 1.0, b: 0.0, a: 1.0, s: 0.0, t: 0.0, nX: 0.0, nY: 0.0, nZ: 0.0)
        let V2 = Vertex(x:  1.0, y: -1.0, z: 0.0, r: 0.0, g: 0.0, b: 1.0, a: 1.0, s: 0.0, t: 0.0, nX: 0.0, nY: 0.0, nZ: 0.0)
        
        let verticesArray = [V0, V1, V2]
        
        let textureDescriptore = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: MTLPixelFormat.r8Uint,
                                                                          width: 1, height: 1, mipmapped: false)
        let texture: MTLTexture = device.makeTexture(descriptor: textureDescriptore)
        super.init(name: "Triangle", vertices: verticesArray, device: device, texture: texture)
        
    }
}
