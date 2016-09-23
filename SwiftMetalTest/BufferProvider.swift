//
//  BufferProvider.swift
//  SwiftMetalTest
//
//  Created by Terje Urnes on 23.09.2016.
//  Copyright © 2016 Terje Urnes. All rights reserved.
//

import Metal
import simd

class BufferProvider: NSObject {
    
    let inflightBuffersCount: Int
    private var uniformsBuffers: [MTLBuffer]
    private var avaliableBufferIndex: Int = 0
    
    init(device: MTLDevice, inflightBuffersCount: Int, sizeOfUniformBuffer: Int) {
        
        self.inflightBuffersCount = inflightBuffersCount
        uniformsBuffers = [MTLBuffer]()
        
        for _ in 0..<inflightBuffersCount {
            let uniformsBuffer = device.makeBuffer(length: sizeOfUniformBuffer)
            uniformsBuffers.append(uniformsBuffer)
        }
    }
    
    func nextUniformsBuffer(projectionMatrix: float4x4, modelViewMatrix: float4x4) -> MTLBuffer {
        let buffer = uniformsBuffers[avaliableBufferIndex]
        let bufferPointer = buffer.contents()
        
        let sizeOfMatrix = MemoryLayout<Float>.size * float4x4.numberOfElements()
        var projectionMatrix = projectionMatrix
        var modelViewMatrix = modelViewMatrix
        memcpy(bufferPointer, &modelViewMatrix, sizeOfMatrix)
        memcpy(bufferPointer + sizeOfMatrix, &projectionMatrix, sizeOfMatrix)
        
        avaliableBufferIndex = (avaliableBufferIndex + 1) % inflightBuffersCount
        
        return buffer
    }
    
}
