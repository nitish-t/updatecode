//
//  PackagesViewController.swift
//  LlightFix
//
//  Created by  on 7/2/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class PackagesViewController: BaseViewController {

    var object :TCarObject?
    var package :TPackageObject?
    
    @IBOutlet weak var layoutConstraintCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: GeneralCollectionView!{
        didSet{
            self.collectionView.registerNib(NibName: "PackagesCollectionViewCell")
        }
    }
    @IBOutlet weak var lblCarName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.lblCarName.text = self.object?.s_name
        self.lblPrice.text = ""
        
        self.getDataFromServer()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.updateCollectionViewHeight()
    }
    func updateCollectionViewHeight(){
        let ratio = 80.0/115.0
        let cellWidth = self.collectionView.width / 3 - 15
        self.collectionView.cellSize(CGSize(width: cellWidth, height: (115.0 * CGFloat(ratio)) + 80))
        self.collectionView.reloadData()
        self.layoutConstraintCollectionViewHeight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
    }
    func getDataFromServer(){
        let request = GeneralRequest(.packages)
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            self.collectionView.clearData(true)
            self.package = responce.packagesArray.first
            self.lblPrice.text = "\(self.package?.s_price_ ?? UserProfile.sharedInstance.price) \("KD".localize_)"
            for obj in self.package?.services ?? [] {
                self.collectionView.objects.append(GeneralCollectionViewData(reuseIdentifier: "PackagesCollectionViewCell", object: obj))
            }
            self.updateCollectionViewHeight()
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toPaymentMethodVC" {
            let vc = segue.destination as! PaymentMethodViewController
            vc.carObject = self.object
            vc.packageObject = self.package
        }
    }
    
    @IBAction func btnSubsecribe(_ sender: Any) {
        self.performSegueWithCheck(withIdentifier: "toPaymentMethodVC", sender: self)
    }
    
}
