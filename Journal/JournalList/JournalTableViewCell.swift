//
//  JournalTableViewCell.swift
//  Journal
//
//  Created by gohpeijin on 29/07/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class JournalTableViewCell: UITableViewCell {

    
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var labelThought: UILabel!
    @IBOutlet weak var labelEmotion: UILabel!
    @IBOutlet weak var imageEmotion: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    
    static let identifier = "JournalTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setColor()
    }

    
    func setColor(){
        backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCardView.layer.shadowOpacity = 0.8
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // fore register the cell
    static func nib() -> UINib {
        return UINib(nibName: "JournalTableViewCell", bundle: nil)
    }
    
}
