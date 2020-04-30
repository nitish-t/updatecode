//
//  NotificationsListViewController.swift
//  LlightFix
//
//  Created by  on 6/30/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class NotificationsListViewController: BaseViewController {

    @IBOutlet weak var tableView: GeneralTableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupTableView()
    }
    func setupTableView(){
        let emptyTitle = NSMutableAttributedString(string: "NotificationsListVC.emptyTitle".localize_)
        let emptyDescription = NSMutableAttributedString(string: "NotificationsListVC.emptyDescription".localize_)
        let font = UIFont(name: AppFontName.bold, size: UIFont.getFontSize(15))!

        emptyTitle.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(named: "#009BA2") ?? UIColor.green, range:NSRange(location: 0, length: emptyTitle.length))
        emptyTitle.addAttribute(NSAttributedString.Key.font, value:font, range:NSRange(location: 0, length: emptyTitle.length))
        emptyDescription.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(named: "#848384") ?? UIColor.green, range:NSRange(location: 0, length: emptyDescription.length))
        emptyDescription.addAttribute(NSAttributedString.Key.font, value:font, range:NSRange(location: 0, length: emptyDescription.length))

        
        let request = UserRequest(.notifications)
        self.tableView.clearData(true)
        self.tableView.isPullToRefreshEnabled = true
        self.tableView.ofRequest(request)
            .reuseIdentifier("NotificationsListTableViewCell")
            .handleResponse { (BaseResponse) -> [Any]? in
                return BaseResponse.notificationsArray
            }
            .handlerTitleForEmptyDataSet(emptyTitle)
            .handlerDescriptionForEmptyDataSet(emptyDescription)
            .handlerImageForEmptyDataSet(UIImage(named: "ic_notification_nodata"))
            .start()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toNotificationsDetailsVC" {
            let vc = segue.destination as! NotificationsDetailsViewController
            vc.object = sender as! TNotificationsObject
        }
    }
    

}
