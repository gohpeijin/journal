//
//  EmotionTableViewCell.swift
//  Journal
//
//  Created by gohpeijin on 28/07/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class EmotionTableViewCell: UITableViewCell {

    @IBOutlet weak var imageEmotion: UIImageView!
    @IBOutlet weak var labelEmotionName: UILabel!
    
    static let identifier = "EmotionTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // fore register the cell
    static func nib() -> UINib {
        return UINib(nibName: "EmotionTableViewCell", bundle: nil)
    }
}
