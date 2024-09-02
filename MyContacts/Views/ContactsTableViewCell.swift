//
//  ContactsTableViewCell.swift
//  MyContacts
//
//  Created by JiTHiN on 01/09/24.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nextButton.isUserInteractionEnabled = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
    }
    
    func configure(with contact : Contacts){
        nameLabel.text = contact.name
        if let image = contact.image{
            posterImageView.image = UIImage(data: image)
        }
    }
    
}
