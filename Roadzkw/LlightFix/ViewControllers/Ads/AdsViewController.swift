//
//  AdsViewController.swift
//  LlightFix
//
//  Created by  on 6/27/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class AdsViewController: UIViewController {

    @IBOutlet weak var collectionView: GeneralCollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.btnNext.setTitle("AdsVC_btnNext_Title".localize_, for: .normal)
        self.btnBack.setTitle("AdsVC_btnBack_Title".localize_, for: .normal)

        self.pageControl.numberOfPages = 0
        self.collectionView.contentInsetAdjustmentBehavior = .never

        self.getDataFromServer()
        
        self.updatePageControl()
        self.collectionView.willDisplayCell { (indexPath) in
            self.currentIndex = indexPath.item
            self.updatePageControl()
        }
    }
    func updatePageControl() -> Void {
        self.pageControl.currentPage = self.currentIndex
        self.pageControl.updateCurrentPageSize()
        
        self.btnNext.setTitle("AdsVC_btnNext_Title".localize_, for: .normal)
        if self.currentIndex == 0 {
            self.setButton(button: self.btnBack, isEnabled: false)
            self.setButton(button: self.btnNext, isEnabled: true)
        }else if self.currentIndex == self.collectionView.objects.count-1{
            self.setButton(button: self.btnBack, isEnabled: true)
            self.btnNext.setTitle("AdsVC_btnNext_Title_Done".localize_, for: .normal)
            self.setButton(button: self.btnNext, isEnabled: true)
        }else{
            self.setButton(button: self.btnBack, isEnabled: true)
            self.setButton(button: self.btnNext, isEnabled: true)
        }
    }
    
    func setButton(button:UIButton,isEnabled:Bool) -> Void {
        button.isEnabled = isEnabled
    }
    
    func getDataFromServer(){
        for obj in TempClass.sharedInstance.adsArray ?? [] {
            self.collectionView.objects.append(GeneralCollectionViewData(reuseIdentifier: "AdsCollectionViewCell", object: obj))
        }
        self.pageControl.numberOfPages = self.collectionView.objects.count
        self.collectionView.reloadData()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.pageControl.updateCurrentPageSize()
        self.collectionView.cellSize(self.collectionView.frame.size)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnNext(_ sender: UIButton)
    {
        //-1
        if self.currentIndex == self.collectionView.objects.count{
            if (UserProfile.sharedInstance.isLoginBefore?.boolValue ?? false) == false {
                self.navigationController?.setViewControllers([self.storyboard?.instantiateViewController(withIdentifier: "BeforeLoginViewController") ?? BeforeLoginViewController()], animated: true)
            }else{
                self.navigationController?.setViewControllers([self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") ?? HomeViewController()], animated: true)
            }
            return
        }
        self.currentIndex = self.currentIndex + 1
        self.updatePageControl()
        self.scrollToCurrentIndex()
    }
    @IBAction func btnBack(_ sender: UIButton) {
        self.currentIndex = self.currentIndex - 1
        self.updatePageControl()
        self.scrollToCurrentIndex()
    }
    func scrollToCurrentIndex() -> Void {
        if self.collectionView.objects.count == 0 {
            return
        }
        self.collectionView.scrollToItem(at: IndexPath(item: self.currentIndex, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }

}


extension UIPageControl {
    func updateCurrentPageSize() {
        var index = 0
        self.subviews.forEach {
            if index == self.currentPage {
                $0.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }else{
                $0.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
            index += 1
        }
    }
}
