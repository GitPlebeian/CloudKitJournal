//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by Jackson Tubbs on 8/26/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Properties
    
    var entry: Entry? {
        didSet {
            updateViewWithEntry()
        }
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    @IBAction func doneWithEditingButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, let text = bodyTextView.text, !title.isEmpty, !text.isEmpty else {return}
        
        EntryController.shared.saveEntry(title: title, text: text) { (success) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //MARK: - Custom Functions
    
    func updateViewWithEntry() {
        guard let entry = entry else {return}
        loadViewIfNeeded()
        
        titleTextField.text = entry.title
        bodyTextView.text = entry.text
    }
}
