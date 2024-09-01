//
//  ContactDetailsTableViewCell.swift
//  MyContacts
//
//  Created by JiTHiN on 01/09/24.
//

import UIKit

class ContactDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var contactPosterView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(_ model : ContactHeaderCellModel){
        
        //contactPosterView.image = model.image ?? UIImage(named: "contacticon")
        nameLabel.text = model.name
    }
    
}
