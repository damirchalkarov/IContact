//
//  ContactTableViewCell.swift
//  IContact
//
//  Created by Damir Chalkarov on 25.11.2024.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contactTextLabel: UILabel!
    
    static let identifier: String = "ContactTableViewCellIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contactTextLabel.text = nil
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contactTextLabel.text = nil
    }
    
}
