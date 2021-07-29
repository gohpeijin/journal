//
//  File.swift
//  Journal
//
//  Created by gohpeijin on 29/07/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class JournalRecord {
    
    var emotion: String
    var thought: String
    var date : String
    
    init(emotion:String, thought:String, date: String) {
        self.emotion = emotion
        self.thought = thought
        self.date = date
    }
}
