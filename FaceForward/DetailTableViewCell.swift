//
//  DetailTableViewCell.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-22.
//
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var bigTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    //MARK: Everything else
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
