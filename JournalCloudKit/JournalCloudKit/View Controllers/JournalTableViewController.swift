//
//  JournalTableViewController.swift
//  JournalCloudKit
//
//  Created by Jackson Tubbs on 8/26/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import UIKit

class JournalTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadEntries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Custom Functions
    
    func loadEntries() {
        EntryController.shared.fetchEntryies { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entry = EntryController.shared.entries[indexPath.row]

        cell.textLabel?.text = entry.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd yyyy"
        cell.detailTextLabel?.text = dateFormatter.string(from: entry.timestamp)
        
        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEntry" {
            
            guard let index = tableView.indexPathForSelectedRow, let destinationViewController = segue.destination as? EntryDetailViewController else {return}
            let entry = EntryController.shared.entries[index.row]
            
            destinationViewController.entry = entry
        }
    }
}
