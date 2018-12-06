//
//  ViewController.swift
//  ARTRY
//
//  Created by Brezonje on 05.12.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class StuffPlacerVC: UIViewController, ARSCNViewDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var selectedStuff: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/mainScene.scn")!
        sceneView.autoenablesDefaultLighting = true
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let results = sceneView.hitTest(touch.location(in: sceneView), types: [.featurePoint])
        guard let hitFeature = results.last else {return}
        let hitTransform = SCNMatrix4(hitFeature.worldTransform)
        let hitPosition = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        placeStuff(position: hitPosition)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func stuffButtonPressed(_ sender: UIButton) {
        let stuffPickerVC = StuffPickerVC.init(size: CGSize(width: 250, height: 500))
        stuffPickerVC.stuffPlacerVC = self
        
        stuffPickerVC.modalPresentationStyle = .popover
        stuffPickerVC.popoverPresentationController?.delegate = self
        present(stuffPickerVC, animated: true, completion: nil)
        
        stuffPickerVC.popoverPresentationController?.sourceView = sender
        stuffPickerVC.popoverPresentationController?.sourceRect = sender.bounds
    }
    
    func stuffSelected(_ stuffName: String) {
        selectedStuff = stuffName
    }
    
    func placeStuff(position: SCNVector3) {
        if let stuffName = selectedStuff {
            let stuff = Stuff.getStuffByName(stuffName: stuffName)
            stuff.position = position
            stuff.scale = SCNVector3Make(0.01, 0.01, 0.01)
            sceneView.scene.rootNode.addChildNode(stuff)
            
        }
    }
}
