/*************************  *************************/
//
//  MySubscriptionsTableViewCell.swift
//  LlightFix
//
//  Created by  on 7/1/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class MySubscriptionsTableViewCell : GeneralTableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var stackViewContaner: UIStackView!
    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var lblCarModel: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func configerCell() {
        let obj = self.object.object as! TSubscriptionObject
        self.lblTitle.text     = obj.package?.s_type
        self.lblOrderID.text   = obj.s_ref_id
        self.lblCarModel.text  = obj.car?.carModel?.s_title
        self.lblStartDate.text = obj.s_dt_subscription_start
        self.lblEndDate.text   = obj.s_dt_subscription_end
        self.lblAmount.text    = "\(obj.s_final_total ?? "0") \("KD".localize_)"
        
        self.stackViewContaner.isHidden = !obj.isCellShowAllInfo
        self.imgArrow.image = UIImage(named: obj.isCellShowAllInfo ? "ic_drop_down_arrow_up" : "ic_drop_down_arrow")
    }
    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.object.object as! TSubscriptionObject
        obj.isCellShowAllInfo = !obj.isCellShowAllInfo
        tableView.reloadRows(at: [self.indexPath], with: .automatic)
    }
}
