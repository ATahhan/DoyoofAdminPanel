//
//  SideMenuTableViewCell.swift
//  NathemAdminPanel
//
//  Created by Ammar AlTahhan on 01/08/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backAlphaView: UIView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var arrow: UILabel!
    @IBOutlet weak var icon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        sideView.isHidden = !selected
        backAlphaView.isHidden = !selected
        title.textColor = selected ? .white : UIColor(rgb: 0xB9C0BA)
        arrow.textColor = selected ? .white : UIColor(rgb: 0xB9C0BA)
        arrow.isHidden = !selected
    }

}
