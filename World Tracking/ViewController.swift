//
//  ViewController.swift
//  World Tracking
//
//  Created by Bruno Feres Villela on 23/12/21.
//

import UIKit
import ARKit

let NODE = SCNNode()
let DIFFUSE_COLOR = "#F2F2F2"

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!

    let configuration = ARWorldTrackingConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }

    //
    // Actions
    //

    @IBAction func add(_ sender: Any) {
        let node = cylinder()

        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        node.geometry?.firstMaterial?.diffuse.contents = DIFFUSE_COLOR
        node.position = SCNVector3(0,0,-0.3)
        node.eulerAngles = SCNVector3(Float(90.degreesToRadians),0,0) // Rotation
        self.sceneView.scene.rootNode.addChildNode(node)
        
        let pyramid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        pyramid.position = SCNVector3(0,0,-0.5)
        
        node.addChildNode(pyramid)
    }

    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }

    //
    // Methods
    //

    func restartSession(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes{(node, _) in
            node.removeFromParentNode()
        }
        
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func box() -> SCNNode {
        NODE.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)

        return NODE
    }

    func capsule() -> SCNNode {
        NODE.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)

        return NODE
    }
    
    func cone() -> SCNNode {
        NODE.geometry = SCNCone(topRadius: 0.3, bottomRadius: 0.3, height: 0.5)

        return NODE
    }
    
    func cylinder() -> SCNNode {
        NODE.geometry = SCNCylinder(radius: 0.1, height: 0.3)

        return NODE
    }
    
    func sphere() -> SCNNode {
        NODE.geometry = SCNSphere(radius: 0.15)

        return NODE
    }
    
    func tube() -> SCNNode {
        NODE.geometry = SCNTube(innerRadius: 0.1, outerRadius: 0.1, height: 0.3)

        return NODE
    }
    
    func torus() -> SCNNode {
        NODE.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.05)

        return NODE
    }
    
    func plane() -> SCNNode {
        NODE.geometry = SCNPlane(width: 0.3, height: 0.3)

        return NODE
    }
    
    func pyramid() -> SCNNode {
        NODE.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)

        return NODE
    }
    
    func randomPosition() -> Array<CGFloat> {
        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        
        return [x, y, z]
    }
    
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
