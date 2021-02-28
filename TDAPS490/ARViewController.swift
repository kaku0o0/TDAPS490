//
//  ViewController.swift
//  TDAPS490
//
//  Created by Kakujojo on 2021-02-20.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var canadaNode: SCNNode?
    var usaNode: SCNNode?
    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
        ".serialSceneKitQueue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false//
        
        // Create a new scene
        let canada = SCNScene(named: "art.scnassets/canada_flag.scn")
        canadaNode = canada?.rootNode
        // Create a new scene
        let usa = SCNScene(named: "art.scnassets/usa_flag.scn")
        usaNode = usa?.rootNode

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        //let configuration = ARImageTrackingConfiguration()
        let configuration = ARWorldTrackingConfiguration()
        
        if let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main){
            //configuration.trackingImages = referenceImages
            configuration.detectionImages = referenceImages
            configuration.maximumNumberOfTrackedImages = 12
            
         }
        
        // Run the view's session
//sceneView.session.run(configuration)
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        
        updateQueue.async {
            let size = imageAnchor.referenceImage.physicalSize
            let plane = SCNPlane(width: size.width, height: size.height)
            plane.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.5)
            plane.cornerRadius = 0.005
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
            
            var shapeNode: SCNNode?
            let imageName=imageAnchor.referenceImage.name ?? "[Can't read currency name]"
            let s = imageName.split(separator: "-") // e.g. 5-CAD-A
            if "\(s[1])" == "USD"{
                shapeNode=self.usaNode
            }else{
                shapeNode=self.canadaNode
            }
        
            guard let shape = shapeNode else { return}
            node.addChildNode(shape)
            let anchorNode = SCNScene(named: "art.scnassets/currency.scn")!.rootNode.childNodes[0]
            
            let converter = CurrencyConverter()
            let converted = converter.convert(fromImageName: imageName, targetCurrency: "CAD")
            if let textGeometry = anchorNode.childNodes[0].geometry as? SCNText {
                textGeometry.string = "\(converted.formattedAmount)"
                print("\(converted.formattedAmount)")
            }
            
            if let textGeometry = anchorNode.childNodes[1].geometry as? SCNText {
                textGeometry.string = "\(converted.country)"
            }
            
            
            if let tubeNode = anchorNode.childNodes[2] as? SCNNode {
                let graphHeight = Float(converted.amount) * 0.3 // height multiplier
                tubeNode.pivot = SCNMatrix4MakeTranslation(0.0, -(graphHeight/2), 0.0)
                if let tubeGeometry = tubeNode.geometry as? SCNTube {
//                    let action = SCNAction.scale(to: CGFloat(graphHeight), duration: 0.4)
//                    tubeNode.runAction(action)
                    tubeGeometry.height = CGFloat(graphHeight)
            }
            }
            

            anchorNode.opacity = 0.9 // occlusion only works with != 1.0 opacity!
            node.addChildNode(anchorNode)
        }
    }
    /*
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let size = imageAnchor.referenceImage.physicalSize
            let plane = SCNPlane(width: size.width, height: size.height)
            plane.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.5)
            plane.cornerRadius = 0.005
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
            
            var shapeNode: SCNNode?
            if imageAnchor.referenceImage.name == "1USD"{
                shapeNode=usaNode
            }else{
                shapeNode=canadaNode
            }
        
            guard let shape = shapeNode else { return nil}
            node.addChildNode(shape)
            
        }
        return node
    }
 */

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
}
