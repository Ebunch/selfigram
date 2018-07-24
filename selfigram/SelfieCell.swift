//
//  SelfieCell.swift
//  selfigram
//
//  Created by Inderpal Lehal on 2018-07-23.
//  Copyright © 2018 Inderpal Lehal. All rights reserved.
//

import UIKit

class SelfieCell: UITableViewCell {

    @IBOutlet weak var selfiecellLabel: UILabel!
    
    @IBOutlet weak var selfiecellComment: UILabel!
    @IBOutlet weak var selfieImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
