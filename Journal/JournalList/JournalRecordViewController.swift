//
//  ViewController.swift
//  Journal
//
//  Created by gohpeijin on 28/07/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class JournalRecordViewController: UIViewController {

    @IBOutlet weak var noRecordView: UIView! // display when there is no record found in the journalRecords
    @IBOutlet weak var journalTableView: UITableView!
    
    var journalRecords = [JournalRecord]() // array to store the added journal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register the table cell to the tabl view
        journalTableView.register(JournalTableViewCell.nib(), forCellReuseIdentifier: JournalTableViewCell.identifier)
        journalTableView.dataSource = self
        journalTableView.delegate = self
    }
}

extension JournalRecordViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JournalTableViewCell.identifier, for: indexPath) as! JournalTableViewCell
        
        // change the selected background color to light green
        let backgroundview = UIView()
        backgroundview.backgroundColor = UIColor.init(red: 183/255, green: 222/255, blue: 230/255, alpha: 0.2)
        cell.selectedBackgroundView = backgroundview
        
        // set the cell's objects
        let selectedJournal = journalRecords[indexPath.row]
        cell.labelEmotion.text = "~Feel \(selectedJournal.emotion)~"
        cell.imageEmotion.image = UIImage(named: selectedJournal.emotion.lowercased())
        cell.labelDate.text = selectedJournal.date
        cell.labelThought.text = selectedJournal.thought
        return cell
    }
}

extension JournalRecordViewController: UITableViewDelegate{
    // straight away deselect the row - just to prevent selected background color cover the shadow =D
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

