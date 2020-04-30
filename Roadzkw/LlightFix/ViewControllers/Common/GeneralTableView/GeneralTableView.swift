/*************************  *************************/
//
//  GeneralTableView.swift
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

enum GeneralTableViewType {
    case list
    case sections
}

class GeneralTableView: UITableView {
    
    var tableViewType : GeneralTableViewType = .list
    
    var rowHeightGlobal : NSNumber?
    var parentVC : UIViewController!
    var objects = [GeneralTableViewData]()
    var objectsOfSections = [(key: Any, value: Array<GeneralTableViewData>)]()
    
    var isPullToRefreshEnabled = false
    var isLoadMoreEnabled = false
    var showLodaerWhileReuqest = false
    
    var emptyDataSetTitle = "No Data To Show".localize_
    var emptyDataSetTitleColor = UIColor.darkGray
    var emptyDataIsVisible = false {
        didSet{
            self.reloadEmptyDataSet()
        }
    }
    
    private var lastPaginition: Pagination?
    private var currentPage = 1
    private var lastDataCount: NSNumber = NSNumber(value:0)
    
    @IBInspectable var dummyActive: Bool = false
    @IBInspectable var dummyCellID: String = ""
    @IBInspectable var dummyObjectsCount: Int = 0
    
    #if canImport(Alamofire)
    var lastOperation:DataRequest?
    #elseif canImport(RestKit)
    var lastOperation:RKObjectRequestOperation?
    #endif
    
    private var responseHandler: ((_ response: BaseResponse) -> [Any]?)?
    func handleResponse(_ responseHandler: @escaping ((_ response: BaseResponse) -> [Any]?)) -> GeneralTableView {
        self.responseHandler = responseHandler
        return self
    }
    private var willResponseHandler: (() -> Void)?
    func willHandleResponseFunc(_ willResponseHandler: @escaping (() -> Void)) -> GeneralTableView {
        self.willResponseHandler = willResponseHandler
        return self
    }
    private var didResponseHandler: (() -> Void)?
    func didHandleResponseFunc(_ didResponseHandler: @escaping (() -> Void)) -> GeneralTableView {
        self.didResponseHandler = didResponseHandler
        return self
    }
    private var didFinishRequest: (() -> Void)?
    func didFinishRequestFunc(_ didFinishRequest: @escaping (() -> Void)) -> GeneralTableView {
        self.didFinishRequest = didFinishRequest
        return self
    }
    private var willAddObject: ((_ object:Any) -> GeneralTableViewData)?
    func handlerWillAddObject(_ willAddObject: @escaping  ((_ object:Any) -> GeneralTableViewData)) -> GeneralTableView {
        self.willAddObject = willAddObject
        return self
    }
    private var reuseIdentifier: String = ""
    func reuseIdentifier(_ reuseIdentifier: String) -> GeneralTableView {
        self.reuseIdentifier = reuseIdentifier
        return self
    }
    
    private var request: BaseRequest?
    public func ofRequest(_ request: BaseRequest) -> GeneralTableView {
        self.request = request
        return self
    }
    
    
    private var titleForEmptyDataSet: NSAttributedString?
    func handlerTitleForEmptyDataSet(_ titleForEmptyDataSet: NSAttributedString?) -> GeneralTableView {
        self.titleForEmptyDataSet = titleForEmptyDataSet
        return self
    }
    private var descriptionForEmptyDataSet: NSAttributedString?
    func handlerDescriptionForEmptyDataSet(_ descriptionForEmptyDataSet: NSAttributedString?) -> GeneralTableView {
        self.descriptionForEmptyDataSet = descriptionForEmptyDataSet
        return self
    }
    private var imageForEmptyDataSet: UIImage?
    func handlerImageForEmptyDataSet(_ imageForEmptyDataSet: UIImage?) -> GeneralTableView {
        self.imageForEmptyDataSet = imageForEmptyDataSet
        return self
    }
    
    private var heightForSections: ((_ section:Int) -> CGFloat)?
    func heightForSectionsFunc(_ heightForSections: @escaping ((_ section:Int) -> CGFloat)) -> GeneralTableView {
        self.heightForSections = heightForSections
        return self
    }
    
    private var viewForHeaderInSection: ((_ section:Int) -> UIView)?
    func viewForHeaderInSectionFunc(_ viewForHeaderInSection: @escaping ((_ section:Int) -> UIView)) -> GeneralTableView {
        self.viewForHeaderInSection = viewForHeaderInSection
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
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if dummyActive == true && dummyCellID.count > 0 && dummyObjectsCount > 0 {
            self.clearData(true)
            for _ in 0...dummyObjectsCount {
                self.objects.append(GeneralTableViewData(reuseIdentifier: dummyCellID, object: nil, rowHeight: nil))
            }
            self.reloadData()
        }
    }
    func registerNib(NibName: String) {
        self.register(UINib(nibName: NibName, bundle: nil), forCellReuseIdentifier: NibName)
    }
}

//MARK: - DataHelper
extension GeneralTableView {
    func clearData(_ reloadData: Bool = false){
        if self.tableViewType == .sections {
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

//MARK: - TableViewDelegate
extension GeneralTableView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.tableViewType == .sections ? self.heightForSections?(section) ?? 44 : 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.tableViewType == .sections ? self.viewForHeaderInSection?(section) ?? UIView() : nil
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        let value = self.tableViewType == .sections ? self.objectsOfSections[indexPath.section].value[indexPath.row].rowHeight : objects[indexPath.row].rowHeight
        return (value != nil) ? CGFloat((value?.floatValue)!) : UITableView.automaticDimension
    }
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let value = self.tableViewType == .sections ? self.objectsOfSections[indexPath.section].value[indexPath.row].rowHeight : objects[indexPath.row].rowHeight
        return (value != nil) ? CGFloat((value?.floatValue)!) : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GeneralTableViewCell
        cell.delegate?.didselect(tableView, didSelectRowAt: indexPath)

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateTableForCars"), object: nil, userInfo: nil)

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! GeneralTableViewCell
        cell.delegate?.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
    }
}

//MARK: - TableViewDataSource
extension GeneralTableView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewType == .sections ? self.objectsOfSections.count : 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.tableViewType == .sections ? self.objectsOfSections[section].value.count : objects.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let obj = self.tableViewType == .sections ? self.objectsOfSections[indexPath.section].value[indexPath.row] : objects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: obj.reuseIdentifier, for: indexPath) as! GeneralTableViewCell
        cell.tableView = self
        cell.indexPath = indexPath
        cell.parentVC = self.parentVC
        cell.object = obj
        cell.configerCell()
        return cell
    }
}

//MARK: - EmptyDataSet
extension GeneralTableView : DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString {
        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: UIFont.init(name: AppFontName.regular, size: CGFloat(18.0))!, NSAttributedString.Key.foregroundColor: emptyDataSetTitleColor]
        return self.titleForEmptyDataSet ?? NSAttributedString(string: emptyDataSetTitle, attributes: attributes as? [NSAttributedString.Key : Any])
    }
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return self.descriptionForEmptyDataSet ?? NSAttributedString(string: "")
    }
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return self.imageForEmptyDataSet ?? UIImage()
    }
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return self.emptyDataIsVisible
    }
}

//MARK: - Networking
extension GeneralTableView {
    func start() {
        self.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        self.alwaysBounceVertical = true
        bindPullToRefresh()
        refresh(trigerREfresh: true)
    }
    
    private func stopLoading() {
        if(isPullToRefreshEnabled) {
            self.spr_endRefreshing()
            self.contentInset.top = 0
        }
        self.emptyDataIsVisible = true
    }
    
    private func bindPullToRefresh() {
        if(isPullToRefreshEnabled) {
            self.spr_setIndicatorHeader { [weak self] in
                self?.clearData(true)
                self?.refresh(trigerREfresh: false)
            }
        }
        if(isLoadMoreEnabled) {
            self.spr_setIndicatorFooter { [weak self] in
                self?.loadMore()
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
                self.objects.append(self.willAddObject?(item) ?? GeneralTableViewData(reuseIdentifier: self.reuseIdentifier , object: item, rowHeight: self.rowHeightGlobal))
            }
        }
        self.reloadData()
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
