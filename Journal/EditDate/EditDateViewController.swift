//
//  EditDateViewController.swift
//  Journal
//
//  Created by gohpeijin on 28/07/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class EditDateViewController: UIViewController {
    
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    let dateFormatter = DateFormatter()
    var dateSelected: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSave.layer.borderColor = UIColor.init(red: 32/255, green: 176/255, blue: 156/255, alpha: 1).cgColor // popup ok buttong effect
        
        let now = Date()
        datePicker.maximumDate = now
        dateFormatter.dateFormat = "dd MMM yyyy"
        datePicker.setDate(dateFormatter.date(from: dateSelected!)!, animated: true)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        let addJournalVC = presentingViewController as! AddJournalViewController
        addJournalVC.labelDate.text = dateFormatter.string(from: datePicker.date)
        
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
