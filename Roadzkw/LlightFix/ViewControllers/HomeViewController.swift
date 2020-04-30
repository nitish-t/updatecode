//
//  HomeViewController.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
import XCDYouTubeKit
import Sheriff
import YoutubeKit
class HomeViewController: BaseViewController {
    @IBOutlet weak var bottomImage: UIImageView!

    @IBOutlet weak var btnNotifications: UIButton!
    @IBOutlet weak var btnOrderRegistration: roundedButton!
    @IBOutlet weak var btnOpenYoutubeMaintenance: UIButton!
    @IBOutlet weak var btnOpenYoutubeEmergency: UIButton!
    var settingsObject : TSettingObject?
    var badgeView : GIBadgeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserProfile.sharedInstance.isRTL() == true {
            bottomImage.isHidden = true
            let flippedImage = UIImage(named: "bg_views_")?.imageFlippedForRightToLeftLayoutDirection()
            let addImageView = UIImageView(image: flippedImage)

            addImageView.frame = CGRect(x: 0, y: self.view.frame.height - bottomImage.frame.height+145, width: bottomImage.frame.width - 320, height: bottomImage.frame.height - 150)
            addImageView.image = flippedImage
            self.view.addSubview(addImageView)
           
        }

       UserProfile.sharedInstance.isLoginBefore = true
        // Do any additional setup after loading the view.
        self.settingsObject = TempClass.sharedInstance.settingsObject
        
//        self.btnOpenYoutubeMaintenance.isHidden = (self.settingsObject?.s_youtube_maintenance ?? "").isEmptyOrWhiteSpace() == true
        self.btnOpenYoutubeEmergency.isHidden = (self.settingsObject?.s_youtube_emergency ?? "").isEmptyOrWhiteSpace() == true || UserProfile.sharedInstance.currentUserID != nil
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateButton), name: NSNotification.Name("userStatusChanged"), object: nil)
        self.updateButton()
        
        self.badgeView = GIBadgeView()
        if let badgeVew = self.badgeView{
            self.btnNotifications.addSubview(badgeVew)
        }
        self.checkNotificationCount()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateButton()
    }
    func checkNotificationCount(){
        if UserProfile.sharedInstance.currentUserID != nil {
            let request = UserRequest(.notifications_unread_count)
            NLRequestWrapper.sharedInstance.makeRequest(request: request).execute(showLodaer: false, { (result) in
                switch result {
                case .responseSuccess(let response):
                    self.badgeView?.badgeValue = response.not_read_notification_count?.intValue ?? 0
                    break
                case .responseError(let response): break
                case .failure(let opareation,let error): break
                case .emptyResponse(): break
                }
            })
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+10) {
                self.checkNotificationCount()
            }
        }else{
            self.badgeView?.badgeValue = 0
        }
    }
    @objc func updateButton(){
        if UserProfile.sharedInstance.isSelectGest?.boolValue == true {
            self.btnOrderRegistration.localized = "HomeVC.btnOrder.title.Demo"
        }else{
            self.btnOrderRegistration.localized = UserProfile.sharedInstance.currentUserID == nil ? "Registration" : "HomeVC.btnOrder.title"
            if UserProfile.sharedInstance.currentUserID == nil{
                self.badgeView?.badgeValue = 0
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

    }
    
    @IBAction func btnProfile(_ sender: Any) {
        if UserProfile.sharedInstance.checkIfUserLogin(alert: true) == false {
           return
        }
        self.navigationController?.performSegueWithCheck(withIdentifier: "toProfileVC", sender: self)
    }
    @IBAction func btnNotification(_ sender: Any) {
        if UserProfile.sharedInstance.checkIfUserLogin(alert: true) == false {
            return
        }
        self.performSegueWithCheck(withIdentifier: "toNotificationsListVC", sender: self)
    }
    @IBAction func btnOpenMenu(_ sender: Any) {
        UserProfile.sharedInstance.openMenuBaseedOnLang()
    }
    @IBAction func btnEmergency(_ sender: Any) {
        if UserProfile.sharedInstance.isSelectGest?.boolValue == true {
            self.navigationController?.pushViewController(ServicesOverviewViewController.initiateInstance(), animated: true)
        }else if UserProfile.sharedInstance.checkIfUserLogin(alert: false) == false {
            self.navigationController?.pushViewController(RegestrationViewController.initiateInstance(), animated: true)
        }else{
            self.performSegueWithCheck(withIdentifier: "toSelectCarVC", sender: self)
        }
    }
    @IBAction func btnOpenYoutubeMaintenance(_ sender: Any) {
        self.openVideo(self.settingsObject?.s_youtube_maintenance ?? "")
    }
    @IBAction func btnOpenYoutubeEmergency(_ sender: Any) {
       self.openVideo(self.settingsObject?.s_youtube_emergency ?? "")
    }
    func openVideo(_ url:String){
        let videoID = url.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "")
        let videoPlayerViewController =  self.storyboard?.instantiateViewController(withIdentifier:"youtplayviewcontroller") as! youtplayviewcontroller
    
        videoPlayerViewController.video_ID = videoID
       // videoPlayerViewController.modalPresentationStyle = .fullScreen
        //XCDYouTubeVideoPlayerViewController(videoIdentifier: videoID)
        self.present(videoPlayerViewController, animated: true, completion: {() -> Void in
           //  videoPlayerViewController.moviePlayer.play()
        })
    }
    
    @IBAction func unwindToHomeVC(_ segue:UIStoryboardSegue){
        
    }
}
