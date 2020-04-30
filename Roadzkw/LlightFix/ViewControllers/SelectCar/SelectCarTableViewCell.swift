/*************************  *************************/
//
//  SelectCarTableViewCell.swift
//  LlightFix
//
//  Created by  on 7/2/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
import BEMCheckBox



class SelectCarTableViewCell : GeneralTableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewCheckBox: BEMCheckBox!
    @IBOutlet weak var imgCall: UIImageView!
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
        let obj = self.object.object as! TCarObject
        self.lblTitle.text = obj.s_name
        self.viewCheckBox.boxType = .square

        self.viewCheckBox.isHidden = true
        
//        self.viewCheckBox.setOn((self.parentVC as! SelectCarViewController).selectedCar?.pk_i_id?.intValue == obj.pk_i_id?.intValue, animated: true)
        
//        self.viewCheckBox.isHidden = obj.b_open_request?.boolValue == true
        self.imgCall.isHidden = obj.b_open_request?.boolValue == false
        self.checkSelection()
    }
    func checkSelection(){
        let obj = self.object.object as! TCarObject
        if (self.parentVC as! SelectCarViewController).selectedCar?.pk_i_id?.intValue == obj.pk_i_id?.intValue {
            self.viewContaner.backgroundColor = UIColor(named: "#009BA2")
            self.viewContaner.layer.borderColor = nil
            self.viewContaner.layer.borderWidth = 0
             
            
        }else{
            self.viewContaner.backgroundColor = .clear
            self.viewContaner.layer.borderColor = UIColor(named: "#B1B0B1")?.cgColor
            self.viewContaner.layer.borderWidth = 1
        }
    }
    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
         IsSelected_CAr = true

        
        let obj = self.object.object as! TCarObject
        (self.parentVC as! SelectCarViewController).selectedCar = obj
        if obj.b_open_request?.boolValue == true {
            (self.parentVC as! SelectCarViewController).checkSubscription(isForCall:true)
        }else{
            tableView.reloadData()
        }
    }
}
