//
//  SelectCarViewController.swift
//  LlightFix
//
//  Created by  on 7/2/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

var IsSelected_CAr:Bool = false

class SelectCarViewController: BaseViewController {
    
    @IBOutlet weak var ChooseCar: UILabel!

    @IBOutlet weak var tableView: GeneralTableView!
    @IBOutlet weak var collectionView: GeneralCollectionView!
        {
        didSet{
            self.collectionView.registerNib(NibName: "PackagesCollectionViewCell")
        }
    }
    @IBOutlet weak var layoutConstraintCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var lblProceed: UILabel!
    
    var selectedCar:TCarObject?{
        didSet{
            if UserProfile.sharedInstance.isSelectGest?.boolValue == false {
                self.collectionView.isUserInteractionEnabled = self.selectedCar?.subscription == nil ? false : true
            }
            if self.selectedCar?.subscription == nil || self.selectedCar?.subscription?.b_payed == 0{
                self.lblProceed.localized = "OurServicesVC.btnSubscribe.text"
            }else if self.selectedCar?.subscription?.b_active.boolValue == true {
                self.lblProceed.localized = "SelectCarVC.btnProceed.title"
            }
            else if self.selectedCar?.subscription?.b_active.boolValue == false {
                self.lblProceed.localized = "SelectCarVC.btnProceed.title"
            }
        }
    }
    var package :TPackageObject?
    var selectedService : TServiceObject?
    var order_id : String?
    var subscriptionObject : TSubscriptionObject?
    var paymentURL : String?
    var isForCallLocal: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IsSelected_CAr = false
        collectionView.isHidden = true
        ChooseCar.isHidden = true
        
        // Do any additional setup after loading the view.
        if UserProfile.sharedInstance.isSelectGest?.boolValue == true {
            self.addDemoData()
            self.getDataFromServer()
        }else{
            self.scrollView.spr_setIndicatorHeader {
                self.setupTableView()
            }
            self.setupTableView()
            self.collectionView.isUserInteractionEnabled = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationUpdate), name: NSNotification.Name(rawValue: "updateTableForCars"), object: nil)

    }
    

    
   @objc func notificationUpdate() {
        if IsSelected_CAr == true
        {
            if self.selectedCar?.subscription?.b_active.boolValue == true {
                ChooseCar.isHidden = false
                collectionView.isHidden = false
                
                if isForCallLocal == true {
                      collectionView.isHidden = true
                    ChooseCar.isHidden = true
                    tableView.reloadData()
                  }
            }
            else {
                
//                if self.selectedCar?.subscription == nil || self.selectedCar?.subscription?.b_payed == 0 {
                    ChooseCar.isHidden = true
                    collectionView.isHidden = true
  
//                }
//                else {
//                    ChooseCar.isHidden = false
//                    collectionView.isHidden = false
//                }
            }
            


            
    }
    }
    
    func setupTableView(){
        self.tableView.clearData(true)
        let request = CarsRequest(.list)
        NLRequestWrapper.sharedInstance.makeRequest(request: request).didComplete({ (res, error) in
            self.getDataFromServer()
            self.scrollView.spr_endRefreshing()
        }).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            for obj in responce.carsArray {
                self.tableView.objects.append(GeneralTableViewData(reuseIdentifier: "SelectCarTableViewCell", object: obj, rowHeight: nil))
            }
            self.tableView.reloadData()
            
            self.updateCollectionViewHeight()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = self.localized
        
        IsSelected_CAr = false
        collectionView.isHidden = true
        ChooseCar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationUpdate), name: NSNotification.Name(rawValue: "updateTableForCars"), object: nil)
           tableView.reloadData()
          
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
         self.updateCollectionViewHeight()
        
        if IsSelected_CAr == true
        {
            if self.selectedCar?.subscription?.b_active.boolValue == true {
                collectionView.isHidden = false
                ChooseCar.isHidden = false
                if isForCallLocal == true {
                      collectionView.isHidden = true
                    ChooseCar.isHidden = true
                  }
            }
            else {
  //               if self.selectedCar?.subscription == nil || self.selectedCar?.subscription?.b_payed == 0 {
                    ChooseCar.isHidden = true
                    collectionView.isHidden = true
  
//                 }
//                 else {
//                    ChooseCar.isHidden = false
//                    collectionView.isHidden = false
//                 }
            }
        }
    }
    
    func updateCollectionViewHeight(){
        let ratio = 80.0/115.0
        let cellWidth = self.collectionView.width / 3 - 15
        self.collectionView.cellSize(CGSize(width: cellWidth, height: (115.0 * CGFloat(ratio)) + 80))
        self.collectionView.layoutIfNeeded()
        self.collectionView.reloadData()
        self.layoutConstraintCollectionViewHeight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        self.layoutConstraintTableViewHeight.constant = self.tableView.contentSize.height
    }
    func getDataFromServer(){
        let request = GeneralRequest(.packages)
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            self.collectionView.clearData(true)
            self.package = responce.packagesArray.first
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
            vc.carObject = self.selectedCar
            vc.packageObject = self.package
        }else if segue.identifier == "toMapVC" {
            let vc = segue.destination as! MapViewController
            vc.package_id = sender as? NSNumber
            vc.selectedCar = self.selectedCar
            vc.selectedService = self.selectedService
        }else if segue.identifier == "toPaymentResultVC"{
            let vc = segue.destination as! PaymentResultViewController
            vc.object = self.subscriptionObject
            vc.resultOfPayment = (sender as? Bool) ?? true
            vc.orderID = self.order_id
        }else if segue.identifier == "toPaymentWebVC" {
            let vc = segue.destination as! PaymentWebViewController
            vc.link = (sender as? String)
        }
    }
    
    @IBAction func btnProcced(_ sender: Any) {
        self.checkSubscription()
    }
    func checkSubscription(isForCall:Bool = false){
        
        
        if isForCall == true {
            isForCallLocal = true
        }
        if self.selectedCar == nil {
            self.showPopAlert(title: "Error".localize_, message: "SelectCarToContinue".localize_)
            return
        }
            //        else if isForCall == false && self.selectedCar != nil && self.selectedCar?.subscription != nil && self.selectedService == nil
            //
            //        {
            
        else if isForCall == false && self.selectedCar != nil && self.selectedCar?.subscription?.b_active.boolValue == true && self.selectedService == nil
            
        {
            
            self.showPopAlert(title: "Error".localize_, message: "SelectServiceToContinue".localize_)
            return
        }
        
//        if self.selectedCar?.subscription?.b_active.boolValue == false{
//            self.showPopAlert(title: "Error".localize_, message: "SelectServiceToContinue".localize_)
//            return
//        }
        
        
        
        
        if UserProfile.sharedInstance.isSelectGest?.boolValue == true {
            self.performSegueWithCheck(withIdentifier: "toMapVC", sender: NSNumber(value:1))
            return
        }
        let request = SubscriptionsRequest(.check_subscription)
        request.car_id = self.selectedCar?.pk_i_id
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            if responce.status?.codeNumber?.intValue == 200 {
                if isForCall == true {
                    
                    
                    var arabicString = "";
                    if UserProfile.sharedInstance.isRTL() == true {
                        arabicString = "تم إرسال طلبك للمتابعة ، يرجى الاتصال";
                    }
                    else {
                        arabicString = "Your request has been submitted to follow up please call";
                    }
                    let alertController = UIAlertController(title: "CallUS".localize_, message: arabicString, preferredStyle:.alert)
                    alertController.addAction(UIAlertAction(title: "CallUS".localize_, style:.default, handler: { (action) in
                        self.isForCallLocal = false
                        if let url = URL(string: "tel://\((TempClass.sharedInstance.settingsObject?.s_mobile ?? "").removeWhiteSpaceAndArabicNumbers)") {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }))
                    alertController.addAction(UIAlertAction(title: "Cancel".localize_, style:.cancel, handler: { (action) in
                        self.isForCallLocal = false
                        
                    }))
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                if self.selectedService == nil  {
                self.showPopAlert(title: "Error".localize_, message: "SelectServiceToContinue".localize_)
                } else {
                    self.performSegueWithCheck(withIdentifier: "toMapVC", sender: responce.package_id)
                   
                }
                
            }else if responce.status?.codeNumber?.intValue == 201 {
                self.performSegueWithCheck(withIdentifier: "toPaymentMethodVC", sender: self)
            }else if responce.status?.codeNumber?.intValue == 202 {
                let alertController = UIAlertController(title: "Error".localize_, message: responce.status?.message ?? "An error occurred".localize_, preferredStyle:.alert)
                alertController.addAction(UIAlertAction(title: "Renew".localize_, style:.default, handler: { (action) in
                    self.performSegueWithCheck(withIdentifier: "toPaymentMethodVC", sender: self)
                }))
                alertController.addAction(UIAlertAction(title: "Cancel".localize_, style:.cancel, handler: { (action) in
                    
                }))
                self.present(alertController, animated: true, completion: nil)
            }else if responce.status?.codeNumber?.intValue == 203 {
                
                
                var arabicString = "";
                if UserProfile.sharedInstance.isRTL() == true {
                    arabicString = "تم إرسال طلبك للمتابعة ، يرجى الاتصال";
                }
                else {
                    arabicString = responce.status?.message ?? "An error occurred".localize_;
                }
                
                let alertController = UIAlertController(title: "CallUS".localize_, message: arabicString, preferredStyle:.alert)
                alertController.addAction(UIAlertAction(title: "CallUS".localize_, style:.default, handler: { (action) in
                    self.isForCallLocal = false
                    
                    if let url = URL(string: "tel://\((TempClass.sharedInstance.settingsObject?.s_mobile ?? "").removeWhiteSpaceAndArabicNumbers)") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }))
                alertController.addAction(UIAlertAction(title: "Cancel".localize_, style:.cancel, handler: { (action) in
                    self.isForCallLocal = false
                    
                }))
                self.present(alertController, animated: true, completion: nil)
            }else if responce.status?.codeNumber?.intValue == 205 {
                let alertController = UIAlertController(title: "Info".localize_, message: responce.status?.message ?? "An error occurred".localize_, preferredStyle:.alert)
                alertController.addAction(UIAlertAction(title: "OK".localize_, style:.cancel, handler: { (action) in
                }))
                self.present(alertController, animated: true, completion: nil)
            }else if responce.status?.codeNumber?.intValue == 207 {
                let alertController = UIAlertController(title: "Info".localize_, message: responce.status?.message ?? "An error occurred".localize_, preferredStyle:.alert)
                alertController.addAction(UIAlertAction(title: "OK".localize_, style:.default, handler: { (action) in
                    self.order_id = responce.order_id
                    self.subscriptionObject = responce.subscriptionsObject
                    self.paymentURL = responce.paymentlink
                    self.performSegueWithCheck(withIdentifier: "toPaymentMethodVC", sender: self.paymentURL)
                }))
                alertController.addAction(UIAlertAction(title: "Cancel".localize_, style:.cancel, handler: { (action) in
                    
                }))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func unwindToMyCarsVC(_ segue:UIStoryboardSegue){
        if segue.source is AddCarViewController {
            self.setupTableView()
        }
    }
    @IBAction func unwindToPaymentMethodVC(_ segue:UIStoryboardSegue){
        if segue.source is PaymentWebViewController {
            let request = SubscriptionsRequest(.check_payment)
            request.order_id = self.order_id
            NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
                self.performSegueWithCheck(withIdentifier: "toPaymentResultVC", sender: responce.status?.success)
            }
        }else if segue.source is PaymentResultViewController {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                self.performSegueWithCheck(withIdentifier: "toPaymentWebVC", sender: self.paymentURL)
            }
        }
    }
}


extension SelectCarViewController{
    func addDemoData(){
        do {
            let carStr = """
{
            "id": 120,
            "customer_id": "73",
            "car_maker_id": "1",
            "car_model_id": "1",
            "car_year_id": "81",
            "plate_number": null,
            "color": "1221",
            "has_open_request": false,
            "car_maker": {
                "id": 1,
                "title": "Toyoto land"
            },
            "car_model": {
                "id": 1,
                "car_maker_id": "1",
                "title": "Cruiser"
            },
            "car_year": {
                "id": 81,
                "car_model_id": "1",
                "title": "2020"
            },
            "subscription": {
                "id": 95,
                "ref_id": "#10095",
                "customer_id": "73",
                "car_id": "120",
                "package_id": "1",
                "price": "15",
                "coupon": null,
                "coupon_discount_percentage": "0",
                "final_total": "15",
                "status": "active",
                "subscription_start": "2019-09-04",
                "subscription_end": "2020-09-04",
                "b_payed": 0,
                "RedirectUrl": "https://kw.MyFatoorah.com/ie/050736677208547863",
                "order_id": "2085478"
            }
        }
""".toDictionary()
            let car1 = TCarObject(fromDictionary: carStr)
            self.tableView.objects.append(GeneralTableViewData(reuseIdentifier: "SelectCarTableViewCell", object: car1, rowHeight: nil))
        }
        do {
            let carStr = """
{
            "id": 122,
            "customer_id": "73",
            "car_maker_id": "3",
            "car_model_id": "3",
            "car_year_id": "83",
            "plate_number": null,
            "color": "1222",
            "has_open_request": false,
            "car_maker": {
                "id": 3,
                "title": "Nissan"
            },
            "car_model": {
                "id": 3,
                "car_maker_id": "3",
                "title": "Petrol"
            },
            "car_year": {
                "id": 83,
                "car_model_id": "3",
                "title": "2020"
            },
            "subscription": {
                "id": 97,
                "ref_id": "#10097",
                "customer_id": "73",
                "car_id": "122",
                "package_id": "1",
                "price": "15",
                "coupon": null,
                "coupon_discount_percentage": "0",
                "final_total": "15",
                "status": "active",
                "subscription_start": "2019-09-04",
                "subscription_end": "2020-09-04",
                "b_payed": 0,
                "RedirectUrl": "https://kw.MyFatoorah.com/ie/050736677208547863",
                "order_id": "2085478"
            }
        }
""".toDictionary()
            let car1 = TCarObject(fromDictionary: carStr)
            self.tableView.objects.append(GeneralTableViewData(reuseIdentifier: "SelectCarTableViewCell", object: car1, rowHeight: nil))
        }
                do {
                    let carStr = """
        {
                    "id": 121,
                    "customer_id": "73",
                    "car_maker_id": "2",
                    "car_model_id": "2",
                    "car_year_id": "82",
                    "plate_number": null,
                    "color": "222",
                    "has_open_request": false,
                    "car_maker": {
                        "id": 2,
                        "title": "Chevrolet"
                    },
                    "car_model": {
                        "id": 2,
                        "car_maker_id": "3",
                        "title": "Tahoe"
                    },
                    "car_year": {
                        "id": 82,
                        "car_model_id": "2",
                        "title": "2020"
                    },
                    "subscription": {
                        "id": 96,
                        "ref_id": "#10096",
                        "customer_id": "73",
                        "car_id": "121",
                        "package_id": "1",
                        "price": "15",
                        "coupon": null,
                        "coupon_discount_percentage": "0",
                        "final_total": "15",
                        "status": "active",
                        "subscription_start": "2019-09-04",
                        "subscription_end": "2020-09-04",
                        "b_payed": 0,
                        "RedirectUrl": "https://kw.MyFatoorah.com/ie/050736677208547863",
                        "order_id": "2085478"
                    }
                }
        """.toDictionary()
                    let car2 = TCarObject(fromDictionary: carStr)
                    self.tableView.objects.append(GeneralTableViewData(reuseIdentifier: "SelectCarTableViewCell", object: car2, rowHeight: nil))
                }
        
        self.tableView.reloadData()
        
//        do {
//            let objEn = """
//{
//            "id": 1,
//            "type": "emergency",
//            "price": "15",
//            "created_at": "19-06-2019",
//            "services": [
//                {
//                    "id": 1,
//                    "package_id": "1",
//                    "image": "http://light-fix.linekwdemo2.com/uploads/images/services/VqlLWICAt79SnxIhGkBioWgTyYcOt7ZNd7osyOU4.png",
//                    "title": "Towing"
//                },
//                {
//                    "id": 2,
//                    "package_id": "1",
//                    "image": "http://light-fix.linekwdemo2.com/uploads/images/services/XORCn4OUb8Xo9s6UXSBlUV1zGkEwnDV8mNT13hrH.png",
//                    "title": "Jump Start"
//                },
//                {
//                    "id": 3,
//                    "package_id": "1",
//                    "image": "http://light-fix.linekwdemo2.com/uploads/images/services/jLwJHRLblcxYSaB2he4mra6VplnMwi62egklhwH3.png",
//                    "title": "Refuel"
//                },
//                {
//                    "id": 4,
//                    "package_id": "1",
//                    "image": "http://light-fix.linekwdemo2.com/uploads/images/services/IHmMrtrpPTJDRoUOEAK9sgzJdJbBKrmFyG88yajX.png",
//                    "title": "Tire"
//                },
//                {
//                    "id": 5,
//                    "package_id": "1",
//                    "image": "http://light-fix.linekwdemo2.com/uploads/images/services/I7cyU1HLKxZ8g5zpyP5esVX6hwvVqf9b14OWP1yx.png",
//                    "title": "Breakdown"
//                },
//                {
//                    "id": 6,
//                    "package_id": "1",
//                    "image": "http://light-fix.linekwdemo2.com/uploads/images/services/HB8Qh3vW9bA1RLw04gu6qSQWdakqHZpu8SNiY01M.png",
//                    "title": "Open Locked Car"
//                }
//            ]
//        }
//""".toDictionary()
//            let objAr = """
//{
//            "id": 1,
//            "type": "emergency",
//            "price": "15",
//            "created_at": "19-06-2019",
//            "services": [
//                {
//                    "id": 1,
//                    "package_id": "1",
//                    "image": "http://light-fix.linekwdemo2.com/uploads/images/services/VqlLWICAt79SnxIhGkBioWgTyYcOt7ZNd7osyOU4.png",
//                    "title": "ونش"
//                },
//                {
//                    "id": 2,
//                    "package_id": "1",
//                    "image": "http://light-fix.linekwdemo2.com/uploads/images/services/XORCn4OUb8Xo9s6UXSBlUV1zGkEwnDV8mNT13hrH.png",
//                    "title": "اشتراك بطارية"
//                },
//                {
//                    "id": 3,
//                    "package_id": "1",
//                    "image": "http://light-fix.linekwdemo2.com/uploads/images/services/jLwJHRLblcxYSaB2he4mra6VplnMwi62egklhwH3.png",
//                    "title": "وقود"
//                },
//                {
//                    "id": 4,
//                    "package_id": "1",
//                    "image": "http://light-fix.linekwdemo2.com/uploads/images/services/IHmMrtrpPTJDRoUOEAK9sgzJdJbBKrmFyG88yajX.png",
//                    "title": "عطل الاطار"
//                },
//                {
//                    "id": 5,
//                    "package_id": "1",
//                    "image": "http://light-fix.linekwdemo2.com/uploads/images/services/I7cyU1HLKxZ8g5zpyP5esVX6hwvVqf9b14OWP1yx.png",
//                    "title": "عطل"
//                },
//                {
//                    "id": 6,
//                    "package_id": "1",
//                    "image": "http://light-fix.linekwdemo2.com/uploads/images/services/HB8Qh3vW9bA1RLw04gu6qSQWdakqHZpu8SNiY01M.png",
//                    "title": "فتح السيارة"
//                }
//            ]
//        }
//""".toDictionary()
//            self.package = TPackageObject(fromDictionary: UserProfile.sharedInstance.isRTL() == true ? objAr : objEn)
//            for serv in self.package?.services ?? [] {
//                self.collectionView.objects.append(GeneralCollectionViewData(reuseIdentifier: "PackagesCollectionViewCell", object: serv))
//            }
//            self.updateCollectionViewHeight()
//        }
//        self.collectionView.reloadData()

    }
}


extension String {

    var numberValue:NSNumber? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self)
    }
}
