//
//  ViewController.swift
//  Journal
//
//  Created by gohpeijin on 28/07/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class JournalRecordViewController: UIViewController {

    @IBOutlet weak var noRecordView: UIView!
    @IBOutlet weak var journalTableView: UITableView!
    
    var journalRecords = [JournalRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        journalTableView.register(JournalTableViewCell.nib(), forCellReuseIdentifier: JournalTableViewCell.identifier)
        journalTableView.dataSource = self
    }
}

extension JournalRecordViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JournalTableViewCell.identifier, for: indexPath) as! JournalTableViewCell
        
        let backgroundview = UIView()
        backgroundview.backgroundColor = UIColor.init(red: 183/255, green: 222/255, blue: 230/255, alpha: 0.2)
        cell.selectedBackgroundView = backgroundview
        
        let selectedJournal = journalRecords[indexPath.row]
        cell.labelEmotion.text = "~\(selectedJournal.emotion) Day~"
        cell.imageEmotion.image = UIImage(named: selectedJournal.emotion.lowercased())
        cell.labelDate.text = selectedJournal.date
        cell.labelThought.text = selectedJournal.thought
        return cell
    }
}

