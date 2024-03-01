//
//  MyTableViewCell.swift
//  AddPin
//
//  Created by Droadmin on 10/10/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
