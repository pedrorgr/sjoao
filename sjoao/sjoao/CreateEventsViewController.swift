//
//  CreateEventsViewController.swift
//  sjoao
//
//  Created by Ribeiro, P. on 10/03/2018.
//  Copyright © 2018 Ribeiro, P. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CreateEventsViewController: UIViewController, UITextFieldDelegate{

    var formStackView:UIStackView!
    var descriptionStackView:UIStackView!
    var titleStackView:UIStackView!
    var titleTextField:UITextField!
    var descriptionTextField:UITextField!
    var descriptionLabel:UILabel!
    var titleLabel:UILabel!
    
    var titleText:String!
    var descriptionText:String!
    
    var submitButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        createViews()
        createViewHierarchy()
        createViewConstraints()

    }
    
    func createViews() {
    
        formStackView = createStackView()
        formStackView.axis = .vertical
        descriptionStackView = createStackView()
        descriptionStackView.axis = .horizontal
        titleStackView = createStackView()
        titleStackView.axis = .horizontal
        titleLabel = createLabel()
        titleLabel.text = "event title"
        titleTextField = createTextField()
        titleTextField.tag = 0
        descriptionTextField = createTextField()
        descriptionTextField.tag = 1
        descriptionLabel = createLabel()
        descriptionLabel.text = "event description"
        submitButton = createButton()
        
    }
    
    func createStackView() -> UIStackView {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }
    
    func createTextField() -> UITextField {
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }
    
    
    func createLabel() -> UILabel {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func createButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button .setTitle("Submit Event", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(submitValues), for: .touchUpInside)
        return button
    }
    
    func createViewHierarchy() {
        
        formStackView.addArrangedSubview(descriptionStackView)
        formStackView.addArrangedSubview(titleStackView)
        formStackView.addArrangedSubview(submitButton)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        descriptionStackView.addArrangedSubview(descriptionTextField)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(titleTextField)
        view.addSubview(formStackView)
    }
    
    func createViewConstraints() {
        
        formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        formStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        formStackView.topAnchor.constraint(equalTo: view.topAnchor, constant:30).isActive = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case 0:
            titleText = textField.text
            break
        case 1:
            descriptionText = textField.text
            break
        default:
            break
        }
    }
    
    @objc func submitValues() {
        
        let ref = Database.database().reference()
        let newEventRef = ref.child("Events").childByAutoId()
        let newEventData = [
            "title": titleText,
            "description": descriptionText
        ]
         newEventRef.setValue(newEventData)
        
        dismiss(animated: true, completion: nil)
    }
    
}
