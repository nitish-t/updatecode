//
//  BeforeLoginViewController.swift
//  LlightFix
//
//  Created by  on 9/1/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class BeforeLoginViewController: BaseViewController {

    @IBOutlet weak var bgview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

            if UserProfile.sharedInstance.isRTL() == true {
                bgview.isHidden = true
                let flippedImage = UIImage(named: "bg_views_")?.imageFlippedForRightToLeftLayoutDirection()
                let addImageView = UIImageView(image: flippedImage)
            addImageView.frame = CGRect(x: 0, y: self.view.frame.height - bgview.frame.height+150, width: bgview.frame.width - 320, height: bgview.frame.height - 150)
                addImageView.image = flippedImage
                self.view.addSubview(addImageView)
               
            }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnGest(_ sender: Any) {
        UserProfile.sharedInstance.isSelectGest = NSNumber(value:true)
        self.navigationController?.setViewControllers([HomeViewController.initiateInstance()], animated: true)
    }
    
}
