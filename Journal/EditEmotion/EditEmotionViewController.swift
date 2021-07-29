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
     @IBOutlet weak var emotionTableView: UITableView!
    
    var searching = false           // for table view filter when true
    var searchEmotion = [String]()  // new array list to store the search result, so table view will updated to the new list
    var emotionList = [String]()    // list to store all the emotion of this app
    
    var emotionSelected: String! // use to pass the addJounalViewController's emotion to this view
   
    
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
                    
                    // assign values of array to a list
                    if let emotions = emotions {
                        emotionList = emotions
                        emotionList = emotionList.sorted() // so the emotions in alphabetically order
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
    
    // dismiss view without doing anything
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension EditEmotionViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // pass the selected index's emotion to the addJounalViewController
        let resultList = (searching ? searchEmotion : emotionList)
        let selectedEmotion = resultList[indexPath.row]
        
        let addJournalVC = presentingViewController as! AddJournalViewController
        addJournalVC.labelEmotionSelected.text = selectedEmotion
        addJournalVC.imageEmotionSelected.image = UIImage(named: selectedEmotion.lowercased())
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // let the previous default or selected emotion to be shown as selected in tableview
        let resultList = (searching ? searchEmotion : emotionList)
        let index = resultList.firstIndex(of: emotionSelected)
        if(index == indexPath.row){
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
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
        
        // change the selected background color to light green
        let backgroundview = UIView()
        backgroundview.backgroundColor = UIColor.init(red: 81/255, green: 194/255, blue: 175/255, alpha: 0.2)
        cell.selectedBackgroundView = backgroundview
        
        // set the cell's objects
        let resultList = (searching ? searchEmotion : emotionList)
        let selectedEmotion = resultList[indexPath.row]

        cell.labelEmotionName.text = selectedEmotion
        cell.imageEmotion.image = UIImage(named: selectedEmotion.lowercased())
        return cell
    }
}

extension EditEmotionViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar:UISearchBar, textDidChange searchText:String){
        // if no text it will set to default view
        if (searchText == ""){
            searching = false
        }
        else{
            // match the search string with the emotion array
            searchEmotion = emotionList.filter({$0.lowercased().contains(searchText.lowercased())})
//        searchEmotion = emotionList.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()}) // this will only math with same index
            searching = true
        }

        emotionTableView.reloadData()
    }
    
    // reset the searchbar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        emotionTableView.reloadData()
    }
}



