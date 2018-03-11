//
//  EventsViewController.swift
//  sjoao
//
//  Created by Ribeiro, P. on 11/03/2018.
//  Copyright © 2018 Ribeiro, P. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var eventsTable:UITableView!
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        createViews()
        createViewHierarchy()
        createViewConstraints()
        fetchData()

    }
    
    func createViews() {
        eventsTable = createTableView()
    }
    
    func createTableView() -> UITableView {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "type1ReuseIdentifier")
        return table
    }

    func createStackView() -> UIStackView {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }
    
    func createViewHierarchy() {
        
        self.view.addSubview(eventsTable)
        
    }
    
    func createViewConstraints() {
        
        eventsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        eventsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        eventsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        eventsTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "type1ReuseIdentifier", for: indexPath)
        
        let item:Event = events[indexPath.row]
        cell.textLabel!.text =  item.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item:Event = events[indexPath.row]
        let detailVC = EventDetailViewController()
        detailVC.eventId = item.parentKey
        present(detailVC, animated: true, completion: nil)
    }
    
    func fetchData() {
        let ref = Database.database().reference()
        
        
        ref.child("Events").observeSingleEvent(of: .value) { (snapshot) in
            
            
            if !snapshot.exists() {
                
            } else {
                
                if let snapshotValue = snapshot.children.allObjects as? [DataSnapshot]{
                    //then I iterate over the values
                    for snapDict in snapshotValue{
                        if let postDictionary = snapDict.value as? Dictionary<String, AnyObject> {
                            let item = Event(parentKey: snapDict.key, dictionary: postDictionary)
                            self.events.append(item)
                            self.eventsTable.reloadData()
                        }
                    }
                    
                }
                
            }
        }
        
    }

}
