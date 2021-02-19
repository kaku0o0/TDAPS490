//
//  ARView.swift
//  TDAPS490
//
//  Created by Yangfan Li on 2021-02-18.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    typealias UIViewType = ARView
    
    func makeUIView(context: UIViewRepresentableContext<ARViewContainer>) -> ARView {
        
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)

        arView.enableImageRec()
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

extension ARView: ARSessionDelegate {
    func enableImageRec() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
          fatalError("Missing expected asset catalog resources.")
        }
              
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
              
        self.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

        self.session.delegate = self
      }

    public func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        if !anchors.isEmpty {
            for anchor in anchors {
                if let imageAnchor = anchor as? ARImageAnchor {
                    let imageName = imageAnchor.referenceImage.name
                    // 能看到你加进去的图片的名字print出来
                    print(imageName)
                }
            }
        }
    }
}
