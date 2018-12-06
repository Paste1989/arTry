//
//  Stuff.swift
//  ARTRY
//
//  Created by Brezonje on 06.12.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import Foundation
import SceneKit

class Stuff {
    
    class func getEye() -> SCNNode {
        let obj = SCNScene(named: "art.scnassets/eye.dae")
        let node = obj?.rootNode.childNode(withName: "eye", recursively: true)!
        node?.scale = SCNVector3Make(0.1, 0.1, 0.1)
        node?.position = SCNVector3Make(-1, 0.7, -1)
        return node!
    }
    
    class func getPistol() -> SCNNode {
        let obj = SCNScene(named: "art.scnassets/pistol.dae")
        let node = obj?.rootNode.childNode(withName: "pistol", recursively: true)!
        node?.scale = SCNVector3Make(0.5, 0.5, 0.5)
        node?.position = SCNVector3Make(-1, -0.5, -1)
        return node!
    }
    
    class func getTable() -> SCNNode {
        let obj = SCNScene(named: "art.scnassets/table.dae")
        let node = obj?.rootNode.childNode(withName: "table", recursively: true)!
        node?.scale = SCNVector3Make(1, 1, 1)
        node?.position = SCNVector3Make(-1, -2.3, -1)
        return node!
    }
    
    
    class func getStuffByName(stuffName: String) -> SCNNode {
        switch stuffName {
        case "pipe":
            return Stuff.getEye()
        case "pistol":
            return Stuff.getPistol()
        case "table":
            return Stuff.getTable()
        default:
            return Stuff.getEye()
        }
    }
    
    class func startRotation(node: SCNNode) {
        let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.1))
        node.runAction(rotate)
    }
}
