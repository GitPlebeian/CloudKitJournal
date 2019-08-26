//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by Jackson Tubbs on 8/26/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    let publicDB = CKContainer(identifier: "iCloud.Decknot.JournalCloudKit").publicCloudDatabase
    
    // MARK: - CRUD
    
    func saveEntry(title: String, text: String, completion: @escaping (Bool) -> Void) {
        let entry = Entry(title: title, text: text)
        let entryRecord = CKRecord(entry: entry)
        publicDB.save(entryRecord) { (_, error) in
            if let error = error {
                print("Error at \(#function) Error: \(error)\nLocallized Description: \(error.localizedDescription)")
                completion(false)
                return
            }
            self.entries.append(entry)
            completion(true)
        }
    }
    
    func fetchEntryies(completion: @escaping (Bool) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Constants.recordTypeKey, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error at \(#function) Error: \(error)\nLocallized Description: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let records = records else {completion(false); return}
            
            let entries = records.compactMap({Entry(ckRecord: $0)})
            self.entries = entries
            completion(true)
        }
    }
}
