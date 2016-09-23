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
import simd

class Node {
    
    let name: String
    var vertexCount: Int
    var vertexBuffer: MTLBuffer
    var bufferProvider: BufferProvider
    var device: MTLDevice
    var time: CFTimeInterval = 0.0
    
    var positionX: Float = 0.0
    var positionY: Float = 0.0
    var positionZ: Float = 0.0
    
    var rotationX: Float = 0.0
    var rotationY: Float = 0.0
    var rotationZ: Float = 0.0
    
    var scale: Float = 1.0

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
        
        self.bufferProvider = BufferProvider(device: device, inflightBuffersCount: 3, sizeOfUniformBuffer: MemoryLayout<Float>.size * float4x4.numberOfElements() * 2)
    }
    
    func render(
            commandQueue: MTLCommandQueue,
            pipelineState: MTLRenderPipelineState,
            drawable: CAMetalDrawable,
            parentModelViewMatrix: float4x4,
            projectionMatrix: float4x4,
            clearColor: MTLClearColor?) {
        
        (bufferProvider.avaliableResourcesSemaphore).wait(timeout: DispatchTime.distantFuture)
        
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].clearColor =
                MTLClearColor(red: 0.0, green: 104.0/255.0, blue: 5.0/255.0, alpha: 1.0)
        renderPassDescriptor.colorAttachments[0].storeAction = .store
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        commandBuffer.addCompletedHandler { (commandBuffer) -> Void in
            (self.bufferProvider.avaliableResourcesSemaphore).signal()
        }
        
        let renderEncoderOpt = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        renderEncoderOpt.setCullMode(MTLCullMode.front)
        renderEncoderOpt.setRenderPipelineState(pipelineState)
        renderEncoderOpt.setVertexBuffer(vertexBuffer, offset: 0, at: 0)
        
        var nodeModelMatrix = self.modelMatrix()
        nodeModelMatrix.multiplyLeft(parentModelViewMatrix)
        
        let uniformBuffer = bufferProvider.nextUniformsBuffer(projectionMatrix: projectionMatrix, modelViewMatrix: nodeModelMatrix)
        renderEncoderOpt.setVertexBuffer(uniformBuffer, offset: 0, at: 1)
        
        renderEncoderOpt.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount, instanceCount: vertexCount/3)
        renderEncoderOpt.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
        
    }
    
    func modelMatrix() -> float4x4 {
        var matrix = float4x4()
        matrix.translate(positionX, y: positionY, z: positionZ)
        matrix.rotateAroundX(rotationX, y: rotationY, z: rotationZ)
        matrix.scale(scale, y: scale, z: scale)
        return matrix
    }
    
    func updateWithDelta(delta: CFTimeInterval) {
        time += delta
    }
}
