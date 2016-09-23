//
//  MySceneViewController.swift
//  SwiftMetalTest
//
//  Created by Terje Urnes on 23.09.2016.
//  Followed tutorial by Ray Wenderlich, see README.md
//

import UIKit
import simd

class MySceneViewController: MetalViewController, MetalViewControllerDelegate {
    
    var worldModelMatrix: float4x4!
    var objectToDraw: Cube!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        worldModelMatrix = float4x4()
        worldModelMatrix.translate(0.0, y: 0.0, z: -7.0)
        worldModelMatrix.rotateAroundX(float4x4.degrees(toRad: 25), y: 0.0, z: 0.0)
        
        objectToDraw = Cube(device: device, commandQ: commandQueue)
        self.metalViewControllerDelegate = self
    }
    
    func renderObjects(drawable: CAMetalDrawable) {
        objectToDraw.render(
            commandQueue: commandQueue,
            pipelineState: pipelineState,
            drawable: drawable,
            parentModelViewMatrix: worldModelMatrix,
            projectionMatrix: projectionMatrix,
            clearColor: nil)
    }
    
    func updateLogic(timeSinceLastUpdate: CFTimeInterval) {
        objectToDraw.updateWithDelta(delta: timeSinceLastUpdate)
    }
    
}
