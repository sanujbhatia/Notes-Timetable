//
//  notesTableViewCell.swift
//  Notes Timetable
//
//  Created by Ishita Mediratta on 20/07/18.
//  Copyright © 2018 Sanuj Bhatia. All rights reserved.
//

import UIKit

class notesTableViewCell: UITableViewCell {
    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
