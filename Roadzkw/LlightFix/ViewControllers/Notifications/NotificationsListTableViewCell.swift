/*************************  *************************/
//
//  NotificationsListTableViewCell.swift
//  LlightFix
//
//  Created by  on 6/30/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
import DateTools

class NotificationsListTableViewCell : GeneralTableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var viewContaner: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func configerCell() {
        let obj = self.object.object as! TNotificationsObject
        self.lblTitle.text = obj.s_title
        self.lblDetails.text = obj.s_body
        self.lblDate.text = obj.dt_created?.timeAgoSinceNow()
        self.viewContaner.backgroundColor = obj.b_read?.boolValue == true ? UIColor.white : UIColor(named: "#76C2CE 30%")
    }
    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.object.object as! TNotificationsObject
        let request = UserRequest(.notifications_read)
        request.notification_id = obj.pk_i_id
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            obj.b_read = NSNumber(value:true)
            tableView.reloadData()
            self.parentVC.performSegueWithCheck(withIdentifier: "toNotificationsDetailsVC", sender: obj)
        }
    }
}
