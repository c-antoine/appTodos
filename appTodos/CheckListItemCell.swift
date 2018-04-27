//
//  CheckListItemCellTableViewCell.swift
//  appTodos
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 Antoine. All rights reserved.
//

import UIKit

class CheckListItemCell: UITableViewCell {

    
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
