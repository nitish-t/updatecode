//
//  SelectServiceViewController.swift
//  LlightFix
//
//  Created by  on 7/3/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
//import AlertsPickers
import RLBAlertsPickers
import MapKit

class SelectServiceViewController: BaseViewController {

    var package_id : NSNumber?
    var selectedService : TServiceObject?
    var selectedCar : TCarObject?
    
    @IBOutlet weak var collectionView: GeneralCollectionView!{
        didSet{
            self.collectionView.registerNib(NibName: "PackagesCollectionViewCell")
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getDataFromServer()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.updateCollectionViewHeight()
    }
    
    func updateCollectionViewHeight(){
        let ratio = 80.0/115.0
        let cellWidth = self.collectionView.width / 2 - 40
        self.collectionView.cellSize(CGSize(width: cellWidth, height: (115.0 * CGFloat(ratio)) + 100))
        self.collectionView.reloadData()
    }
    
    func getDataFromServer(){
        let request = GeneralRequest(.services)
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            self.collectionView.clearData(true)
            for obj in responce.servicesArray{
                self.collectionView.objects.append(GeneralCollectionViewData(reuseIdentifier: "PackagesCollectionViewCell", object: obj))
            }
            self.updateCollectionViewHeight()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toServiceStatusVC"{
            let vc = segue.destination as! ServiceStatusViewController
            vc.resultOfService = (sender as? Bool) ?? true
        }
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        if self.selectedService == nil {
            self.showPopAlert(title: "Error".localize_, message: "SelectServiceToContinue".localize_)
            return
        }
        
        let alert = UIAlertController(style: .actionSheet)
        alert.addLocationPicker { location in
            // action with location
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2, execute: {
                let alertController = UIAlertController(title: "Attention".localize_, message:"AreYouSureSelectThisLocation".localize_, preferredStyle:.alert)
                alertController.addAction(title: "OK".localize_, color: UIColor(named: "#009BA2"), style: .default, isEnabled: true) { (alert) in
                    self.makeRequest(location: location?.coordinate)
                }
                alertController.addAction(UIAlertAction(title: "Cancel".localize_, style:.cancel, handler: { (action) in
                    
                }))
                self.present(alertController, animated: true, completion: nil)
            })
        }
        alert.addAction(title: "Cancel".localize_, style: .cancel)
        alert.show()
    }
    
    func makeRequest(location:CLLocationCoordinate2D?)
    {
        let request = SubscriptionsRequest(.make)
        request.car_id = self.selectedCar?.pk_i_id
        request.package_id = self.package_id
        request.latitude = NSNumber(value:location?.latitude ?? 0.0)
        request.longitude = NSNumber(value:location?.longitude ?? 0.0)
        request.service_id = self.selectedService?.pk_i_id
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            self.performSegueWithCheck(withIdentifier: "toServiceStatusVC", sender: responce.status?.success)
        }
    }
}
