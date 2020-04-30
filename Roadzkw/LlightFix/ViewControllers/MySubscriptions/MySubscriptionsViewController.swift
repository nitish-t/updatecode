//
//  MySubscriptionsViewController.swift
//  LlightFix
//
//  Created by  on 7/1/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class MySubscriptionsViewController: BaseViewController {

    @IBOutlet weak var tableView: GeneralTableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.setupTableView()
    }
    func setupTableView(){
        let request = SubscriptionsRequest(.list)
        self.tableView.clearData(true)
        self.tableView.isPullToRefreshEnabled = true
        self.tableView.ofRequest(request)
            .reuseIdentifier("MySubscriptionsTableViewCell")
            .handleResponse { (BaseResponse) -> [Any]? in
                return BaseResponse.subscriptionsArray
            }.start()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
