//
//  Coordinator.swift
//  AR Tester
//
//  Created by 箕作勇輝 on 2/22/23.
//

import Foundation
import ARKit
import RealityKit

class Coordinator: NSObject, ARSessionDelegate {
    //why do you have to use weak variable? ->https://www.youtube.com/watch?v=I2mu9gMUbF0
    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer){
        //viewが渡されていたら下のコードが実行される
        guard let view = self.view else { return }
        //引数から　recognizer.locationでタップされた場所を取得
        let tapLocation = recognizer.location(in: view)
        //as? , as! の使い方->　https://fukatsu.tech/swift-cast#i-2
        if let entity = view.entity(at: tapLocation) as? ModelEntity {
            let material = SimpleMaterial(color: .yellow, isMetallic: true)
            entity.model?.materials = [material]
    
        }
    
        
    }
    
    
}
