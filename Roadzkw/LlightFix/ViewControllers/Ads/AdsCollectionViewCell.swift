/*************************  *************************/
//
//  AdsCollectionViewCell.swift
//  LlightFix
//
//  Created by  on 6/27/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class AdsCollectionViewCell : GeneralCollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func configerCell() {
        let obj = self.object.object as! TAdsObject
        self.img.sd_setImage_(urlString: obj.s_image ?? "")
    }
    override func didselect(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
