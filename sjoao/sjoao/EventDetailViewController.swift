//
//  EventDetailViewController.swift
//  sjoao
//
//  Created by Ribeiro, P. on 11/03/2018.
//  Copyright © 2018 Ribeiro, P. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EventDetailViewController: UIViewController {

    var eventId:String!
    var titleLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    
        fetchData()
    }
    
    func fetchData() {
        
        let ref = Database.database().reference()

        //I am registering to listen to a specific answer to appear
        ref.child("Events").child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
            let snapDict = snapshot.value as! Dictionary<String, AnyObject>
            let item = Event(parentKey: self.eventId, dictionary: snapDict)
            self.titleLabel.text = item.title

        })
    }

}
