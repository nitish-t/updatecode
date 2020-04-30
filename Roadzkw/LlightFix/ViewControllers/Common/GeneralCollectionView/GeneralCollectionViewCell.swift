/*************************  *************************/
//
//  GeneralCollectionViewCell.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//


import UIKit

protocol GeneralCollectionViewCellDelegate : NSObjectProtocol {
    func didselect(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

class GeneralCollectionViewCell: UICollectionViewCell,GeneralCollectionViewCellDelegate {
    
    weak open var collectionView : GeneralCollectionView!
    open var indexPath : IndexPath!
    weak open var parentVC : UIViewController!
    weak open var object : GeneralCollectionViewData!

    weak open var delegate: GeneralCollectionViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.delegate = self
    }
    
    func configerCell() {
        
    }
    func didselect(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

}
