/*************************  *************************/
//
//  GeneralTableViewCell.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

protocol GeneralTableViewCellDelegate : NSObjectProtocol {
    func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
}

class GeneralTableViewCell: UITableViewCell,GeneralTableViewCellDelegate {

    weak open var tableView : GeneralTableView!
    open var indexPath : IndexPath!
    weak open var parentVC : UIViewController!
    weak open var object : GeneralTableViewData!

    weak open var delegate: GeneralTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configerCell() {
        
    }
    func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}
