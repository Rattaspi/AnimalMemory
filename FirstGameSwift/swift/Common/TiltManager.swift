//
//  TiltManager.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 16/05/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit
import CoreMotion


class TiltManager {
    let motionManager = CMMotionManager()
    
    var tiltX: CGFloat = 0.0
    private let alpha: CGFloat = 0.1
    
    init(){
        if(motionManager.isAccelerometerAvailable) {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startGyroUpdates(to: .main) { [weak self] (data, error) in
                if let motionManager = self, let data = data {
                    motionManager.tiltX = motionManager.tiltX * (1-motionManager.alpha) + CGFloat(data.rotationRate.x) * motionManager.alpha
                }
            }
        }
    }
}
