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
    @IBOutlet weak var labelEmptyThought: UILabel!
    @IBOutlet weak var imageEmotionSelected: UIImageView!
    @IBOutlet weak var labelEmotionSelected: UILabel!
    @IBOutlet weak var textViewThought: UITextView!
    
    let dateFormatter = DateFormatter()
    let now = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the date to now
        let now = Date()
        dateFormatter.dateFormat="dd MMM yyyy"
        labelDate.text = dateFormatter.string(from: now)
        
        textViewThought.delegate = self
        
        labelEmptyThought.isHidden = true
        
        // to have the text view selected as soon as the view loads
        textViewThought.becomeFirstResponder()
        textViewDefaultState()
        
        // confirm button effect
        buttonSubmit.layer.borderColor = UIColor.init(red: 32/255, green: 176/255, blue: 156/255, alpha: 1).cgColor
        
    }
    
    func textViewDefaultState(){
        textViewThought.text = "Type your thought here... (max 1000 characters)"
        textViewThought.textColor = UIColor.lightGray
        // set the pointer to the beginning of text view
        textViewThought.selectedTextRange = textViewThought.textRange(from: textViewThought.beginningOfDocument, to: textViewThought.beginningOfDocument)
    }
    
    
    // add placeholder to the text view, show it when empty string even is selected
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        labelEmptyThought.isHidden = true
        let currentText: String = textViewThought.text
        // combine current text view's text with replacement text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if (updatedText.isEmpty){
            textViewDefaultState()
        }
        else if (textViewThought.textColor == UIColor.lightGray && !text.isEmpty) {
            textViewThought.textColor = UIColor.black
            textViewThought.text = text
        }
        else
        {
            return self.textLimit(currentText: textView.text,newText: text,limit: 1000)
        }
        return false
    }
    // set the text limit to 1000 character
    private func textLimit(currentText: String?, newText: String,limit: Int) -> Bool {
        let text = currentText ?? ""
        let isLimitReached = text.count + newText.count <= limit
        return isLimitReached
    }
    
    // prevent user changing the pointer position in text view
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil{
            if textViewThought.textColor == UIColor.lightGray{
                textViewThought.selectedTextRange = textViewThought.textRange(from: textViewThought.beginningOfDocument, to: textViewThought.beginningOfDocument)
            }
        }
    }
    
    // pass data to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditDate"{
            let editDateVC = segue.destination as! EditDateViewController
            editDateVC.dateSelected = labelDate.text
        }
        else if segue.identifier == "toEditEmotion"{
            let editEmotionVC = segue.destination as! EditEmotionViewController
            editEmotionVC.emotionSelected = labelEmotionSelected.text
        }
    }
   
    
    @IBAction func submitPressed(_ sender: UIButton) {
        // if thought is empty, error label will appear to notify user
        if textViewThought.textColor == UIColor.lightGray{
            labelEmptyThought.isHidden = false
        }
        else{
            // add the new reocrd to the tableview in JournalRecordViewController
            let addedJournal = JournalRecord(emotion: labelEmotionSelected.text!,thought: textViewThought.text,date: labelDate.text!)
            
            let journalRecordVC = presentingViewController as! JournalRecordViewController
            journalRecordVC.journalRecords.append(addedJournal)
            journalRecordVC.noRecordView.isHidden = true
            journalRecordVC.journalTableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    // dismiss view without doing anything
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


