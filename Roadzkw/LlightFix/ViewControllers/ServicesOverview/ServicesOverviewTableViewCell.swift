/*************************  *************************/
//
//  ServicesOverviewTableViewCell.swift
//  LlightFix
//
//  Created by  on 9/5/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class ServicesOverviewTableViewCell : GeneralTableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func configerCell() {
        let obj = self.object.object as! ServicesOverviewCellType
        self.img.image = UIImage(named:obj.s_image)
        self.lblTitle.text = obj.s_title.localize_
        self.lblDetails.text = obj.s_details.localize_
        if UserProfile.sharedInstance.isSelectGest?.boolValue == true {
            self.lblTitle.isHidden = true
        }
    }
    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
