//
//  MyCarsViewController.swift
//  LlightFix
//
//  Created by  on 7/1/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class MyCarsViewController: BaseViewController {
    
    
    @objc func checkController(notification: NSNotification) {
           
            if let dataInfo = notification.userInfo?["dataInfo"] as? TCarObject {
               debugPrint(dataInfo.s_plate_number)
                self.performSegue(withIdentifier: "paymentMethod", sender: dataInfo)
            }
       }
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                   if segue.identifier == "paymentMethod" {
               if let paymentScreen = segue.destination as? PaymentMethodViewController {
                   paymentScreen.carObject = sender as! TCarObject
               }
           }
       }
    
    
    
    @IBOutlet weak var tableView: GeneralTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      debugPrint("hello")
        
        // Do any additional setup after loading the view.
        self.setupTableView()
        
         NotificationCenter.default.addObserver(self, selector: #selector(checkController(notification:)), name: NSNotification.Name(rawValue: "goToPaymentScreen"), object: nil)
    }
    
    
    
    func setupTableView(){
        self.tableView.clearData(true)
        let request = CarsRequest(.list)
        self.tableView.isPullToRefreshEnabled = true
        self.tableView.ofRequest(request)
            .reuseIdentifier("MyCarsTableViewCell")
            .handleResponse { (BaseResponse) -> [Any]? in
              
                return BaseResponse.carsArray
              
                
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
    @IBAction func unwindToMyCarsVC(_ segue:UIStoryboardSegue){
        if segue.source is AddCarViewController {
            self.setupTableView()
        }
    }
}
