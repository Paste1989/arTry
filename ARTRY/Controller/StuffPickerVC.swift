//
//  StuffPickerVC.swift
//  ARTRY
//
//  Created by Brezonje on 05.12.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit
import SceneKit

class StuffPickerVC: UIViewController {
    
    var sceneView: SCNView!
    var size: CGSize!
    weak var stuffPlacerVC: StuffPlacerVC!
    
    
    init(size: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.insertSubview(sceneView, at: 0)
        
        preferredContentSize = size
        
        let scene = SCNScene(named: "art.scnassets/stuff.scn")!
        sceneView.scene = scene
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tap)
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene.rootNode.camera = camera
        
        let eye = Stuff.getEye()
        Stuff.startRotation(node: eye)
        scene.rootNode.addChildNode(eye)
        
        let pistol = Stuff.getPistol()
        Stuff.startRotation(node: pistol)
        scene.rootNode.addChildNode(pistol)
        
        let table = Stuff.getTable()
        Stuff.startRotation(node: table)
        scene.rootNode.addChildNode(table)
    }
    
    
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        let p = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(p, options: [:])
        
        if hitResults.count > 0 {
            let node = hitResults[0].node
            stuffPlacerVC.stuffSelected(node.name!)
            dismiss(animated: true, completion: nil)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
