//
//  ContactMobileTableViewCell.swift
//  MyContacts
//
//  Created by JiTHiN on 01/09/24.
//

import UIKit

class ContactMobileTableViewCell: UITableViewCell {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(_ model : ContactDetailCellModel){
        headingLabel.text = model.header
        detailLabel.text = model.text
    }
    
}
