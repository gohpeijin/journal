//
//  EditEmotionViewController.swift
//  Journal
//
//  Created by gohpeijin on 28/07/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class EditEmotionViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchEmotion = [String]()
    var searching = false
    var emotionList = [String]()
    var emotionSelected: String = ""
    @IBOutlet weak var emotionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        
        emotionTableView.register(EmotionTableViewCell.nib(), forCellReuseIdentifier: EmotionTableViewCell.identifier)
        emotionTableView.delegate = self
        emotionTableView.dataSource = self
    }
    
    func retrieveData(){
        if let filePath = Bundle.main.path(forResource: "Emotions", ofType: "plist") {
            
            // get Data from the file
            if let plistData = FileManager.default.contents(atPath: filePath) {
                
                do {
                    // deserialize Data and return a property list
                    //  of type Any
                    let plistObject = try PropertyListSerialization.propertyList(
                        from: plistData,
                        options: PropertyListSerialization.ReadOptions(),
                        format: nil)
                    
                    // downcast the property list to an
                    // optional array of Strings
                    let emotions = plistObject as? [String]
                    
                    // print values of array
                    if let emotions = emotions {
                        emotionList = emotions
                        emotionList = emotionList.sorted()
                    }
                } catch {
                    print("Error serializing data from property list")
                }
            } else {
                print("Error reading data from property list file")
            }
        } else {
            print("Property list file does not exist")
        }
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension EditEmotionViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let resultList = (searching ? searchEmotion : emotionList)
        let selectedEmotion = resultList[indexPath.row]
        let addJournalVC = presentingViewController as! AddJournalViewController
        addJournalVC.labelEmotionSelected.text = selectedEmotion
        addJournalVC.imageEmotionSelected.image = UIImage(named: selectedEmotion)
        
        self.dismiss(animated: true, completion: nil)
    }
}


extension EditEmotionViewController: UITableViewDataSource{
    
    // tables comprised of sections and rows, a table can hv n num of sections
    // each section can have n num of row, defualt section is 1
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searching ? searchEmotion.count : emotionList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmotionTableViewCell.identifier, for: indexPath) as! EmotionTableViewCell
        
        let backgroundview = UIView()
        backgroundview.backgroundColor = UIColor.init(red: 81/255, green: 194/255, blue: 175/255, alpha: 0.2)
        cell.selectedBackgroundView = backgroundview
        
        let resultList = (searching ? searchEmotion : emotionList)

        
        let selectedEmotion = resultList[indexPath.row]
        cell.labelEmotionName.text = selectedEmotion
        cell.imageEmotion.image = UIImage(named: selectedEmotion)
        return cell
    }
}

extension EditEmotionViewController: UISearchBarDelegate{
    
    
    func searchBar(_ searchBar:UISearchBar, textDidChange searchText:String){
        searchEmotion = emotionList.filter({$0.lowercased().contains(searchText.lowercased())})
//        searchEmotion = emotionList.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        emotionTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        emotionTableView.reloadData()
    }
}



