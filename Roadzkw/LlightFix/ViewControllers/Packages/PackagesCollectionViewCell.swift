/*************************  *************************/
//
//  PackagesCollectionViewCell.swift
//  LlightFix
//
//  Created by  on 7/2/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class PackagesCollectionViewCell : GeneralCollectionViewCell {

    @IBOutlet weak var img: roundedImage!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func configerCell() {
        let obj = self.object.object as! TServiceObject
        self.img.sd_setImage_(urlString: obj.s_image ?? "")
        self.lblTitle.text = obj.s_title
        
        if self.parentVC is SelectServiceViewController {            
            self.selectionUI((self.parentVC as! SelectServiceViewController).selectedService?.pk_i_id?.intValue == obj.pk_i_id?.intValue)
        }else if self.parentVC is SelectCarViewController {
            self.selectionUI((self.parentVC as! SelectCarViewController).selectedService?.pk_i_id?.intValue == obj.pk_i_id?.intValue)
        }
    }
    func selectionUI(_ isSelected:Bool){
//        self.img.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        if isSelected == true {
//            self.img.imageTintColor = UIColor(named: "#009BA2")
            self.img.superview?.backgroundColor = UIColor(named: "#D3E1E3")
            self.img.superview?.layer.borderColor = UIColor(named: "#848384")?.cgColor
            //self.img.superview?.borderColor = UIColor(named: "#848384")
            self.img.superview?.layer.borderWidth = 1
        }else{
//            self.img.imageTintColor = nil
            self.img.superview?.backgroundColor = nil
            self.img.superview?.layer.borderColor = UIColor(named: "#848384")?.cgColor
            self.img.superview?.layer.borderWidth = 1
        }
    }
    override func didselect(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.object.object as! TServiceObject
        if self.parentVC is SelectServiceViewController {
            (self.parentVC as! SelectServiceViewController).selectedService = obj
            collectionView.reloadData()
        }else if self.parentVC is SelectCarViewController {
            (self.parentVC as! SelectCarViewController).selectedService = obj
            collectionView.reloadData()
        }
    }
}
