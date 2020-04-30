//
//  ServicesOverviewViewController.swift
//  LlightFix
//
//  Created by  on 9/5/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

enum ServicesOverviewCellType {
    case battery
    case tow_truck
    case refull
    case puncture
    case car_lock
    
    var s_image:String{
        switch self {
        case .battery:
            return "ic_demo_battery"
        case .tow_truck:
            return "ic_demo_tow_truck"
        case .refull:
            return "ic_demo_refull"
        case .puncture:
            return "ic_demo_puncture"
        case .car_lock:
            return "ic_demo_car_lock"
        }
    }
    var s_title:String{
        switch self {
        case .battery:
            return "ServicesOverviewVC.lblCell.title.text.1"
        case .tow_truck:
            return "ServicesOverviewVC.lblCell.title.text.2"
        case .refull:
            return "ServicesOverviewVC.lblCell.title.text.3"
        case .puncture:
            return "ServicesOverviewVC.lblCell.title.text.4"
        case .car_lock:
            return "ServicesOverviewVC.lblCell.title.text.5"
        }
    }
    var s_details:String{
        switch self {
        case .battery:
            return "ServicesOverviewVC.lblCell.value.text.1"
        case .tow_truck:
            return "ServicesOverviewVC.lblCell.value.text.2"
        case .refull:
            return "ServicesOverviewVC.lblCell.value.text.3"
        case .puncture:
            return "ServicesOverviewVC.lblCell.value.text.4"
        case .car_lock:
            return "ServicesOverviewVC.lblCell.value.text.5"
        }
    }
}

class ServicesOverviewViewController: BaseViewController {

    @IBOutlet weak var tableView: GeneralTableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.appenData(.battery)
        self.appenData(.tow_truck)
        self.appenData(.refull)
        self.appenData(.puncture)
        self.appenData(.car_lock)
        self.tableView.reloadData()
    }
    func appenData(_ type:ServicesOverviewCellType){
        self.tableView.objects.append(GeneralTableViewData(reuseIdentifier: "ServicesOverviewTableViewCell", object: type, rowHeight: nil))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnNext(_ sender: Any) {
        self.navigationController?.pushViewController(SelectCarViewController.initiateInstance(), animated: true)
    }
    
}
