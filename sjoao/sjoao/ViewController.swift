
import UIKit
import FirebaseDatabase
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    var arView:ARSCNView!
    var eventsCreateButton:UIButton!
    var locationsCreateButton:UIButton!
    var buttonsStackView:UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        view.backgroundColor = UIColor.gray

        createViews()
        createViewHierarchy()
        createViewConstraints()

    }

    func createViews() {
        eventsCreateButton = createButton(title:"events")
        eventsCreateButton.tag = 0
        locationsCreateButton = createButton(title:"locations")
        locationsCreateButton.tag = 1
        buttonsStackView = createStackView()
    }
    
    func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }
    
    func createButton(title:String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.addTarget(self, action:#selector(buttonActions), for: .touchUpInside)
        return button
    }
    
    func createViewHierarchy() {
        
        buttonsStackView.addArrangedSubview(eventsCreateButton)
        buttonsStackView.addArrangedSubview(locationsCreateButton)
        view.addSubview(buttonsStackView)
    }
    
    func createViewConstraints() {
        
         buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
         buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        buttonsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant:30).isActive = true
       /* arView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        arView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        arView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        arView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true*/
    }
    
    @objc func buttonActions(sender:UIButton) {
        
        if (sender.tag == 0) {
            let vc = CreateEventsViewController()
            present(vc, animated: true, completion: nil)
        } else if (sender.tag == 1) {
            let vc = EventsViewController()
            present(vc, animated: true, completion: nil)
        }
    }

    
    func tests()
    {
        
        arView = ARSCNView()
        arView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arView)
        view.backgroundColor = UIColor.red
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration)
        arView.delegate = self
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        let ref = Database.database().reference()
        
        
        ref.child("outros").observeSingleEvent(of: .value) { (snapshot) in
            
            
            if !snapshot.exists() {
            } else {
                
                
            }
        }
        
        // if !snapshot.exists() { return }
        
        /*
         
         let itemRef = ref.child("grocery1")
         
         let dictionary: [String:Int] = [
         "one" : 1,
         "two" : 2,
         "three" : 3
         ]
         itemRef.setValue(dictionary)
         
         ref.observe(.value) { (data) in
         
         }*/
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        // 1
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        // 3
        plane.materials.first?.diffuse.contents = UIColor.blue
        
        // 4
        let planeNode = SCNNode(geometry: plane)
        
        // 5
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        // 6
        node.addChildNode(planeNode)
        
        
    }


}

