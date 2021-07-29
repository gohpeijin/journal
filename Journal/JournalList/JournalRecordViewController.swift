//
//  ViewController.swift
//  Journal
//
//  Created by gohpeijin on 28/07/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class JournalRecordViewController: UIViewController {

    var journalRecords = [JournalRecord]()
    @IBOutlet weak var journalTableView: UITableView!
    
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
        

        let selectedJournal = journalRecords[indexPath.row]
        cell.labelEmotion.text = "\(selectedJournal.emotion) Day~"
        print(selectedJournal.emotion)
        cell.imageEmotion.image = UIImage(named: selectedJournal.emotion.lowercased())
        cell.labelDate.text = selectedJournal.date
        cell.labelThought.text = selectedJournal.thought
        return cell
    }
}

