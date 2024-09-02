//
//  ContactFavouriteTableViewCell.swift
//  MyContacts
//
//  Created by JiTHiN on 01/09/24.
//

import UIKit

class ContactFavouriteTableViewCell: UITableViewCell {
    @IBOutlet weak var favButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favButton.isUserInteractionEnabled = false
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(_ model : ContactActionCellModel){
        favButton.setTitle(model.cta, for: .normal)
    
    }
    
}
