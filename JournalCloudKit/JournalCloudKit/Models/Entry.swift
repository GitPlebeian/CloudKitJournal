//
//  Entry.swift
//  JournalCloudKit
//
//  Created by Jackson Tubbs on 8/26/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import Foundation
import CloudKit

struct Constants {
    static let recordTypeKey = "Entry"
    static let recordTitleKey = "Title"
    static let recordTextKey = "Text"
    static let recordTimestampKey = "Timestamp"
}

class Entry {
    
    let title: String
    let text: String
    let timestamp: Date
    
    init(title: String, text: String, timestamp: Date = Date()) {
        self.title = title
        self.text = text
        self.timestamp = timestamp
    }
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: Constants.recordTypeKey)
        self.setValue(entry.title, forKey: Constants.recordTitleKey)
        self.setValue(entry.text, forKey: Constants.recordTextKey)
        self.setValue(entry.timestamp, forKey: Constants.recordTimestampKey)
    }
}

extension Entry {
    
    convenience init?(ckRecord: CKRecord) {
        guard let entryTitle = ckRecord[Constants.recordTitleKey] as? String, let entryText = ckRecord[Constants.recordTextKey] as? String, let entryTimestamp = ckRecord[Constants.recordTimestampKey] as? Date else {return nil}
        
        self.init(title: entryTitle, text: entryText, timestamp: entryTimestamp)
    }
}
