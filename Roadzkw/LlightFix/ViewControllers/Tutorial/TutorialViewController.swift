//
//  TutorialViewController.swift
//  LlightFix
//
//  Created by  on 6/27/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
import FSPagerView

class TutorialViewController: UIViewController {

    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var pagerControl: FSPageControl!
    var sliderArray = [TSliderObject]()
    var adsaray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupSlider()
        
        
        let request = GeneralRequest(.home)
               NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
                   TempClass.sharedInstance.sliderArray    = responce.sliderArray
                   TempClass.sharedInstance.adsArray       = responce.adsArray
                   TempClass.sharedInstance.carMakersArray = responce.carMakersArray
                   TempClass.sharedInstance.settingsObject = responce.settingsObject
                
                
                self.adsaray = responce.adsArray as NSArray
                //self.sliderrr = responce.sliderArray as NSArray
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.pagerView.itemSize = CGSize(width: self.pagerView.width - 80, height: self.pagerView.height)

    }
    @IBAction func btnStart(_ sender: Any) {
        if adsaray.count == 0 {
        if (UserProfile.sharedInstance.isLoginBefore?.boolValue ?? false) == false {
            self.navigationController?.setViewControllers([self.storyboard?.instantiateViewController(withIdentifier: "BeforeLoginViewController") ?? BeforeLoginViewController()], animated: true)
        }else{
            self.navigationController?.setViewControllers([self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") ?? HomeViewController()], animated: true)
        }
        
        } else {
            self.navigationController?.setViewControllers([self.storyboard?.instantiateViewController(withIdentifier: "AdsViewController") ?? AdsViewController()], animated: true)
        }
    
}
}


extension TutorialViewController:FSPagerViewDelegate,FSPagerViewDataSource {
    func setupSlider() {
        self.sliderArray = TempClass.sharedInstance.sliderArray ?? []
        
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
        self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
        self.pagerView.isInfinite = true
        self.pagerView.automaticSlidingInterval = CGFloat(TempClass.sharedInstance.settingsObject?.i_skip_ads_timer?.floatValue ?? 0.0)
        self.pagerView.interitemSpacing = 10
        self.pagerView.itemSize = CGSize(width: self.pagerView.width - 80, height: self.pagerView.height)
        
        self.pagerControl.numberOfPages = self.sliderArray.count
        self.pagerControl.contentHorizontalAlignment = .center
        self.pagerControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.pagerControl.setFillColor(.black, for: .normal)
        self.pagerControl.setFillColor(.black, for: .selected)
        self.pagerControl.setImage(UIImage(named: "ic_slider_big_dot"), for: .selected)
        self.pagerControl.setImage(UIImage(named: "ic_slider_small_dot"), for: .normal)
    }
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pagerControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pagerControl.currentPage = pagerView.currentIndex
    }
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        self.pagerControl.numberOfPages = self.sliderArray.count
        return self.sliderArray.count
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        
    }
    
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let obj = self.sliderArray[index]
        cell.imageView?.sd_setImage_(urlString: obj.s_image ?? "")
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        return cell
    }
}
