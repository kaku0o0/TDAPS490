
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
    var arView = ARView(frame: .zero)

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, ARSessionDelegate{
        var parent: ARViewContainer
        var videoPlayer: AVPlayer!
        
        init(parent: ARViewContainer) {
            self.parent = parent
        }
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let imageAnchor = anchors[0] as? ARImageAnchor else {
                print("Problems loading anchor.")
                return
            }
            
            //Assigns reference image that will be detected
            if let imageName = imageAnchor.name {
                print(imageName)
            }
        }
        
        //Checks for tracking status
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            guard let imageAnchor = anchors[0] as? ARImageAnchor else {
                print("Problems loading anchor.")
                return
            }
            
            //tracked/loses
            if imageAnchor.isTracked {
                print("yes")
            } else {
                print("not")
            }
        }
    }
    
    func makeUIView(context: Context) -> ARView {
        guard let referenceImages = ARReferenceImage.referenceImages(
                    inGroupNamed: "AR Resources", bundle: nil) else {
                    fatalError("Missing expected asset catalog resources.")
                }
        
        //Assigns coordinator to delegate the AR View
        arView.session.delegate = context.coordinator
        
        let configuration = ARImageTrackingConfiguration()
        configuration.isAutoFocusEnabled = true
        configuration.trackingImages = referenceImages
        configuration.maximumNumberOfTrackedImages = 1
        


        arView.session.run(configuration)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
