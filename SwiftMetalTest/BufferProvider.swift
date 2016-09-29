//
//  BufferProvider.swift
//  SwiftMetalTest
//
//  Created by Terje Urnes on 23.09.2016.
//  Followed tutorial by  Andriy Kharchyshyn @ raywenderlich.com, see README.md
//

import Metal
import simd

class BufferProvider: NSObject {
    
    var avaliableResourcesSemaphore: DispatchSemaphore
    let inflightBuffersCount: Int
    fileprivate var uniformsBuffers: [MTLBuffer]
    fileprivate var avaliableBufferIndex: Int = 0
    
    init(device: MTLDevice, inflightBuffersCount: Int, sizeOfUniformBuffer: Int) {
        
        avaliableResourcesSemaphore = DispatchSemaphore(value: inflightBuffersCount)
        self.inflightBuffersCount = inflightBuffersCount
        uniformsBuffers = [MTLBuffer]()
        
        for _ in 0..<inflightBuffersCount {
            let uniformsBuffer = device.makeBuffer(length: sizeOfUniformBuffer)
            uniformsBuffers.append(uniformsBuffer)
        }
    }
    
    func nextUniformsBuffer(_ projectionMatrix: float4x4, modelViewMatrix: float4x4, light: Light) -> MTLBuffer {
        let buffer = uniformsBuffers[avaliableBufferIndex]
        let bufferPointer = buffer.contents()
        
        let sizeOfMatrix = MemoryLayout<Float>.size * float4x4.numberOfElements()
        var projectionMatrix = projectionMatrix
        var modelViewMatrix = modelViewMatrix
        memcpy(bufferPointer, &modelViewMatrix, sizeOfMatrix)
        memcpy(bufferPointer + sizeOfMatrix, &projectionMatrix, sizeOfMatrix)
        memcpy(bufferPointer + 2*sizeOfMatrix, light.raw(), Light.size())
        
        avaliableBufferIndex = (avaliableBufferIndex + 1) % inflightBuffersCount
        
        return buffer
    }
    
    deinit {
        for _ in 0..<self.inflightBuffersCount {
            self.avaliableResourcesSemaphore.signal()
        }
    }
    
}
