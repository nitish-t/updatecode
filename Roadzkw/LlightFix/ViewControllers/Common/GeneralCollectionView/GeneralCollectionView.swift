/*************************  *************************/
//
//  GeneralCollectionView.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
import SwiftPullToRefresh
import DZNEmptyDataSet

#if canImport(Alamofire)
import Alamofire
#elseif canImport(RestKit)
import RestKit
#endif

enum GeneralCollectionViewType {
    case list
    case sections
}

class CustomCellSizeCollectionView:GeneralCollectionView,UICollectionViewDelegateFlowLayout{
    override func awakeFromNib() {
        super.awakeFromNib()
        (self.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let obj = objects[indexPath.row]
        return obj.cellSize!
    }
}

class GeneralCollectionView: UICollectionView {
    
    var collectionViewType : GeneralTableViewType = .list
    
    var parentVC : UIViewController!
    var objects : [GeneralCollectionViewData] = []
    var objectsOfSections = [(key: String, value: Array<GeneralCollectionViewData>)]()
    
    var isPullToRefreshEnabled = false
    var isLoadMoreEnabled = false
    var showLodaerWhileReuqest = false
    
    var emptyDataSetTitle = "No Data To Show".localize_
    var emptyDataSetTitleColor = UIColor.darkGray
    private var emptyDataIsVisible = false {
        didSet{
            self.reloadEmptyDataSet()
        }
    }
    
    var refreshFromBottom = false
    
    private var lastPaginition: Pagination?
    private var currentPage = 1
    private var lastDataCount: NSNumber = NSNumber(value:0)
    
    @IBInspectable var dummyActive: Bool = false
    @IBInspectable var dummyCellID: String = ""
    @IBInspectable var dummyObjectsCount: Int = 0
    @IBInspectable var dummyCellSize: CGSize = CGSize(width: 50, height: 50)
    
    #if canImport(Alamofire)
    var lastOperation:DataRequest?
    #elseif canImport(RestKit)
    var lastOperation:RKObjectRequestOperation?
    #endif
    
    
    var collectionViewDidDisplayCell: ((_ indexPath: IndexPath) -> Void)?
    func willDisplayCell(_ collectionViewWillDisplay: @escaping ((_ indexPath: IndexPath) -> Void)) -> Void {
        self.collectionViewDidDisplayCell = collectionViewWillDisplay
    }
    var collectionViewDidEndDisplaying: ((_ indexPath: IndexPath) -> Void)?
    func didEndDisplayingCell(_ collectionViewDidEndDisplaying: @escaping ((_ indexPath: IndexPath) -> Void)) -> Void {
        self.collectionViewDidEndDisplaying = collectionViewDidEndDisplaying
    }
    private var responseHandler: ((_ response: BaseResponse) -> [Any]?)?
    func handleResponse(_ responseHandler: @escaping ((_ response: BaseResponse) -> [Any]?)) -> GeneralCollectionView {
        self.responseHandler = responseHandler
        return self
    }
    private var reuseIdentifier: String = ""
    func reuseIdentifier(_ reuseIdentifier: String) -> GeneralCollectionView {
        self.reuseIdentifier = reuseIdentifier
        return self
    }
    private var willResponseHandler: (() -> Void)?
    func willHandleResponseFunc(_ willResponseHandler: @escaping (() -> Void)) -> GeneralCollectionView {
        self.willResponseHandler = willResponseHandler
        return self
    }
    private var didResponseHandler: (() -> Void)?
    func didHandleResponseFunc(_ didResponseHandler: @escaping (() -> Void)) -> GeneralCollectionView {
        self.didResponseHandler = didResponseHandler
        return self
    }
    private var didFinishRequest: (() -> Void)?
    func didFinishRequestFunc(_ didFinishRequest: @escaping (() -> Void)) -> GeneralCollectionView {
        self.didFinishRequest = didFinishRequest
        return self
    }
    private var willAddObject: ((_ object:Any) -> GeneralCollectionViewData)?
    func handlerWillAddObject(_ willAddObject: @escaping  ((_ object:Any) -> GeneralCollectionViewData)) -> GeneralCollectionView {
        self.willAddObject = willAddObject
        return self
    }
    
    public func cellSize(_ size: CGSize?) {
        if size == nil {
            if #available(iOS 12.0, *) {
                (self.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }else{
                (self.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: 1, height: 1)
            }
        }else{
            (self.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize.zero
            (self.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = size!
        }
        self.collectionViewLayout.invalidateLayout()
    }
    
    private var request: BaseRequest?
    public func ofRequest(_ request: BaseRequest) -> GeneralCollectionView {
        self.request = request
        return self
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        self.parentVC = self.getParentViewController()
        self.delegate = self
        self.dataSource = self
        self.emptyDataSetDelegate = self
        self.emptyDataSetSource = self
        if self.collectionViewLayout is UICollectionViewFlowLayout{
            if #available(iOS 12.0, *) {
                (self.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }else{
                (self.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: 1, height: 1)
            }
        }
    }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if dummyActive == true && dummyCellID.count > 0 && dummyObjectsCount > 0 && self.dummyCellSize.width > 0 && self.dummyCellSize.height > 0 {
            self.clearData(true)
            for _ in 0...dummyObjectsCount {
                self.objects.append(GeneralCollectionViewData(reuseIdentifier: dummyCellID, object: nil))
            }
            self.reloadData()
            self.cellSize(self.dummyCellSize)
        }
    }
    func registerNib(NibName: String) {
        self.register(UINib(nibName: NibName, bundle: nil), forCellWithReuseIdentifier: NibName)
    }
}

//MARK: - DataHelper
extension GeneralCollectionView {
    func clearData(_ reloadData: Bool = false){
        if self.collectionViewType == .sections {
            self.objectsOfSections.removeAll()
        }else{
            self.objects.removeAll()
        }
        lastPaginition = nil
        currentPage = 1
        if reloadData == true {
            self.reloadData()
        }
    }
}

//MARK: - CollectionViewDelegate
extension GeneralCollectionView : UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.cellForItem(at: indexPath) as! GeneralCollectionViewCell
        cell.delegate?.didselect(collectionView, didSelectItemAt: indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.collectionViewDidEndDisplaying != nil{
            self.collectionViewDidEndDisplaying!(indexPath)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollDidFinishScrolling(scrollView)
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollDidFinishScrolling(scrollView)
    }
    func scrollDidFinishScrolling(_ scrollView: UIScrollView){
        var visibleRect = CGRect()
        
        visibleRect.origin = self.contentOffset
        visibleRect.size = self.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        let visibleIndexPath = self.indexPathForItem(at: visiblePoint)
        
        if visibleIndexPath != nil && (visibleIndexPath?.item)! < self.objects.count && (visibleIndexPath?.item)! >= 0 {
            if self.collectionViewDidDisplayCell != nil{
                self.collectionViewDidDisplayCell!(visibleIndexPath!)
            }
        }
    }
}


//MARK: - CollectionViewDataSource
extension GeneralCollectionView : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collectionViewType == .sections ? self.objectsOfSections.count : 1
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionViewType == .sections ? self.objectsOfSections[section].value.count : objects.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let obj = self.collectionViewType == .sections ? self.objectsOfSections[indexPath.section].value[indexPath.row] : objects[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: obj.reuseIdentifier, for: indexPath) as! GeneralCollectionViewCell
        cell.collectionView = self
        cell.indexPath = indexPath
        cell.parentVC = self.parentVC
        cell.object = obj
        cell.configerCell()
        return cell
    }
}

//MARK: - EmptyDataSet
extension GeneralCollectionView : DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString {
        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: UIFont.init(name: AppFontName.regular, size: CGFloat(18.0))!, NSAttributedString.Key.foregroundColor: emptyDataSetTitleColor]
        return NSAttributedString(string: emptyDataSetTitle, attributes: attributes as? [NSAttributedString.Key : Any])
    }
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return self.emptyDataIsVisible
    }
}


//MARK: - Networking
extension GeneralCollectionView {
    func start() {
        self.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        self.alwaysBounceVertical = true
        bindPullToRefresh()
        refresh(trigerREfresh: true)
    }
    
    private func stopLoading() {
        if(isPullToRefreshEnabled) {
            self.spr_endRefreshing()
        }
        self.emptyDataIsVisible = true
    }
    
    private func bindPullToRefresh() {
        if(isPullToRefreshEnabled) {
            self.spr_setIndicatorHeader { [weak self] in
                if self?.refreshFromBottom == false {
                    self?.clearData(true)
                    self?.refresh(trigerREfresh: false)
                }else{
                    self?.loadMore()
                }
            }
        }
        if(isLoadMoreEnabled) {
            self.spr_setIndicatorFooter { [weak self] in
                if self?.refreshFromBottom == false {
                    self?.loadMore()
                }else{
                    self?.clearData(true)
                    self?.refresh(trigerREfresh: false)
                }
            }
        }
    }
    
    func loadMore() {
        #if canImport(Alamofire)
//        if(lastPaginition?.i_items_on_page?.intValue == lastDataCount.intValue && lastDataCount.intValue != 0) {
            currentPage = currentPage + 1
//        } else if(lastPaginition != nil) {
//            self.currentPage = (lastPaginition?.i_current_page?.intValue ?? 1)
//        }
        #elseif canImport(RestKit)
        if(lastPaginition?.i_items_on_page == lastDataCount && lastDataCount != 0) {
            currentPage = currentPage + 1
        } else if(lastPaginition != nil) {
            self.currentPage = lastPaginition?.i_current_page as! Int
        }
        #endif
        load(page: currentPage)
    }
    func refresh(trigerREfresh: Bool,refreshAfterClear:Bool = false) {
        if(trigerREfresh && isPullToRefreshEnabled) {
            self.clearData(refreshAfterClear)
            self.spr_beginRefreshing()
        }else{
            load(page: 1)
        }
    }
    func cancelThenRestart(){
        if(lastOperation != nil ){
            #if canImport(RestKit)
            lastOperation?.setCompletionBlockWithSuccess(nil,failure: nil)
            #endif
            lastOperation?.cancel()
        }
        self.clearData(true)
        stopLoading()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() +  .milliseconds(350), execute: {
            self.refresh(trigerREfresh: true,refreshAfterClear:true)
        })
    }
    func load(page: Int){
        self.emptyDataIsVisible = false
        if isLoadMoreEnabled {
            #if canImport(Alamofire)
            let request = NLRequestWrapper.sharedInstance.pagnationRequest(request: self.request!, page: page).didComplete { (op, er) in
                self.stopLoading()
            }
            #elseif canImport(RestKit)
            let request = NLRequestWrapper.sharedInstance.pagnationRequest(request: self.request!, page: page).didComplete { (op, mp, er) in
                self.stopLoading()
            }
            #endif
            lastOperation = request.executeWithCheckResponse(showLodaer: showLodaerWhileReuqest, showMsg: false, { (response) in
                self.afterResponce(response)
                self.didFinishRequest?()
            })
        }else{
            #if canImport(Alamofire)
            let request = NLRequestWrapper.sharedInstance.makeRequest(request: self.request!).didComplete { (op, er) in
                self.stopLoading()
            }
            #elseif canImport(RestKit)
            let request = NLRequestWrapper.sharedInstance.makeRequest(request: self.request!).didComplete { (op, mp, er) in
                self.stopLoading()
            }
            #endif
            lastOperation = request.executeWithCheckResponse(showLodaer: showLodaerWhileReuqest, showMsg: false, { (response) in
                self.afterResponce(response)
                self.didFinishRequest?()
            })
        }
    }
    func afterResponce(_ response:BaseResponse){
        self.lastPaginition = response.pagination
        guard let data = self.responseHandler?(response) else {
            return
        }
        self.lastDataCount = NSNumber(value: data.count)
        for item in data {
            if self.checkIfObjectExist(item) == false {
                if self.refreshFromBottom == false {
                    self.objects.append(self.willAddObject?(item) ?? GeneralCollectionViewData(reuseIdentifier: self.reuseIdentifier, object: item))
                }else{
                    self.objects.insert(self.willAddObject?(item) ?? GeneralCollectionViewData(reuseIdentifier: self.reuseIdentifier, object: item), at: 0)
                }
            }
        }
        self.reloadData()
        if self.refreshFromBottom == true && self.currentPage == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.scrollToItem(at: IndexPath(item: self.objects.count-1, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true)
            }
        }
        self.didResponseHandler?()
    }
    func checkIfObjectExist(_ object:Any) -> Bool {
        var found = false
        for obj in self.objects {
            let hasClassMember = (obj.object as AnyObject).responds(to: Selector(("pk_i_id")))
            if hasClassMember == true {
                if ((obj.object as AnyObject).value(forKey: "pk_i_id") != nil &&
                    (object as AnyObject).value(forKey: "pk_i_id") != nil &&
                    ((obj.object as AnyObject).value(forKey: "pk_i_id") as! NSNumber).isEqual(to: (object as AnyObject).value(forKey: "pk_i_id") as! NSNumber)) {
                    found = true
                }else if (obj.object as AnyObject).value(forKey: "pk_i_id") == nil || (object as AnyObject).value(forKey: "pk_i_id") == nil {
                    found = false
                }
            }
            
        }
        return found
    }
}
