//
//  AddJournalViewController.swift
//  Journal
//
//  Created by gohpeijin on 28/07/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class AddJournalViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var labelDate: UILabel!
    let dateFormatter = DateFormatter()
    let now = Date()
//    var journal:JournalRecord?
    
    @IBOutlet weak var labelEmptyThought: UILabel!
    @IBOutlet weak var imageEmotionSelected: UIImageView!
    @IBOutlet weak var labelEmotionSelected: UILabel!

    @IBOutlet weak var textViewThought: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        dateFormatter.dateFormat="dd MMM yyyy"
        labelDate.text = dateFormatter.string(from: now)
        
        textViewThought.delegate = self
        
        // to have the text view selected as soon as the view loads
        textViewThought.becomeFirstResponder()
        textViewDefaultState()
        
        labelEmptyThought.isHidden = true
        buttonSubmit.layer.borderColor = UIColor.init(red: 32/255, green: 176/255, blue: 156/255, alpha: 1).cgColor // popup ok buttong effect
        
    }
    
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
    
    // add placeholder to the text view, show it when empty string even is selected
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        labelEmptyThought.isHidden = true
        let currentText: String = textViewThought.text
        let updatedText = ( currentText as NSString).replacingCharacters(in: range, with: text)
        
        if updatedText.isEmpty{
           textViewDefaultState()
        }
        else if textViewThought.textColor == UIColor.lightGray && !text.isEmpty {
             textViewThought.textColor = UIColor.black
            textViewThought.text = text
        }
        else
        {
            return true
        }
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil{
            if textViewThought.textColor == UIColor.lightGray{
                textViewThought.selectedTextRange = textViewThought.textRange(from: textViewThought.beginningOfDocument, to: textViewThought.beginningOfDocument)
            }
        }
    }
    
    func textViewDefaultState(){
        textViewThought.text = "Type your thought here..."
        textViewThought.textColor = UIColor.lightGray
        textViewThought.selectedTextRange = textViewThought.textRange(from: textViewThought.beginningOfDocument, to: textViewThought.beginningOfDocument)
    }
    
    
    @IBAction func submitPressed(_ sender: UIButton) {
        if textViewThought.textColor == UIColor.lightGray{
            labelEmptyThought.isHidden = false
        }
        else{
            let addedJournal = JournalRecord(emotion: labelEmotionSelected.text!,thought: textViewThought.text,date: labelDate.text!)
            
            let journalRecordVC = presentingViewController as! JournalRecordViewController
            journalRecordVC.journalRecords.append(addedJournal)
            
            journalRecordVC.journalTableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


