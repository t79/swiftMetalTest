//
//  Node.Swift
//  SwiftMetalTest
//
//  Created by Terje Urnes on 22.09.2016.
//  Followed tutorial by Ray Wenderlich, see README.md
//

import Foundation
import Metal
import QuartzCore

class Node {
    
    let name: String
    var vertexCount: Int
    var vertexBuffer: MTLBuffer
    var device: MTLDevice

    init(name: String, vertices: Array<Vertex>, device: MTLDevice) {
        
        var vertexData = Array<Float>()
        for vertex in vertices {
            vertexData += vertex.floatBuffer()
        }
        
        let dataSize = vertexData.count * MemoryLayout.size(ofValue: vertexData[0])
        vertexBuffer = device.makeBuffer(bytes: vertexData, length: dataSize)
        
        self.name = name
        self.device = device
        vertexCount = vertices.count
        
    }
}
