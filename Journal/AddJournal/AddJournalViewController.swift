//
//  AddJournalViewController.swift
//  Journal
//
//  Created by gohpeijin on 28/07/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class AddJournalViewController: UIViewController {
    
    @IBOutlet weak var labelDate: UILabel!
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var imageEmotionSelected: UIImageView!
    @IBOutlet weak var labelEmotionSelected: UILabel!

    @IBOutlet weak var textViewThought: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        dateFormatter.dateFormat="dd MMM yyyy"
        labelDate.text = dateFormatter.string(from: now)
    }
    
//    func feat
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditDate"{
            let editDateVC = segue.destination as! EditDateViewController
            editDateVC.dateSelected = labelDate.text
        }
        else if segue.identifier == "toEditEmotion"{
            let editEmotionVC = segue.destination as! EditEmotionViewController
            editEmotionVC.emotionSelected = labelEmotionSelected.text!
        }
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
