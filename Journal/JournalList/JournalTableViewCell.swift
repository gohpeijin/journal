//
//  JournalTableViewCell.swift
//  Journal
//
//  Created by gohpeijin on 29/07/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class JournalTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelThought: UILabel!
    @IBOutlet weak var labelEmotion: UILabel!
    @IBOutlet weak var imageEmotion: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    
    static let identifier = "JournalTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
