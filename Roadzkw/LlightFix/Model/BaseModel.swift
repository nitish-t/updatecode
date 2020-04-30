/*************************  *************************/
//
//  BaseModel.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//



import UIKit
import MagicalRecord

#if canImport(Alamofire)
import Alamofire

class BaseModel: NSObject {
    static let sharedInstance = BaseModel()
    
    func requestsHeadrs() -> [String: String] {
        var dic : [String: String] = [:]
        dic["Accept-Language"] = UserProfile.sharedInstance.isRTL() ? "ar" : "en"
        dic["Accept"] = "application/json"
        dic["Authorization"] = UserProfile.sharedInstance.currentUserToken
        return dic
    }
}
#elseif canImport(RestKit)
import RestKit


@objcMembers
class BaseModel: NSObject {
    static let sharedInstance = BaseModel()
    
    func updateHeadrs() -> Void {
        RKObjectManager.shared().httpClient.setDefaultHeader("lang", value: "ar")
        
        RKObjectManager.shared().httpClient.setDefaultHeader("Content-Type", value: "application/json")
    }
    
    func modelSetup (){
        let options = [NSSQLitePragmasOption:["journal_mode":"DELETE",
                                              NSInferMappingModelAutomaticallyOption:Int(true),
                                              NSMigratePersistentStoresAutomaticallyOption:Int(true)]]
        
        let storeUrl = URL(string:String(format: "\(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])/%@.sqlite", GlobalConstants.DataBaseName) )
        
        var modelURL = URL(fileURLWithPath: Bundle.main.path(forResource: GlobalConstants.DataBaseName, ofType: "momd")!)
        var managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        
        var managedObjectStore = RKManagedObjectStore(managedObjectModel:managedObjectModel)
        managedObjectStore?.createPersistentStoreCoordinator()
        do {
            try managedObjectStore?.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: options)
        } catch {
            do {
                try FileManager.default.removeItem(at: storeUrl!)
                if let bundleID = Bundle.main.bundleIdentifier {
                    UserDefaults.standard.removePersistentDomain(forName: bundleID)
                }
                modelURL = URL(fileURLWithPath: Bundle.main.path(forResource: GlobalConstants.DataBaseName, ofType: "momd")!)
                managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
                
                managedObjectStore = RKManagedObjectStore(managedObjectModel:managedObjectModel)
                managedObjectStore?.createPersistentStoreCoordinator()
                do {
                    try managedObjectStore?.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: options)
                } catch {
                    fatalError("Error migrating store: \(error)")
                }
            } catch {
                print("Could not delete file: \(error)")
            }
        }
        managedObjectStore?.createManagedObjectContexts()
        
        
        
        NSPersistentStoreCoordinator.mr_setDefaultStoreCoordinator(managedObjectStore?.persistentStoreCoordinator)
        NSManagedObjectContext.mr_setRootSaving(managedObjectStore?.persistentStoreManagedObjectContext)
        NSManagedObjectContext.mr_setDefaultContext(managedObjectStore?.mainQueueManagedObjectContext)
        
        let objectManager = RKObjectManager(baseURL: URL(string: GlobalConstants.APIUrl))
        RKObjectManager.setShared(objectManager)
        objectManager?.managedObjectStore = managedObjectStore
        //        objectManager?.requestSerializationMIMEType = RKMIMETypeJSON
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        dateFormatter2.timeZone   = NSTimeZone(name: "Asia/Riyadh")! as TimeZone
        dateFormatter2.locale     = Locale(identifier : "en_US_POSIX")
        RKObjectMapping.addDefaultDateFormatter(dateFormatter2)
        RKValueTransformer.defaultValueTransformer().insert(dateFormatter2, at: 0)
        
        self.updateHeadrs()
        
        let responseMapping = BaseResponse.prepareMapping()
        RKObjectManager.shared()?.addResponseDescriptors(from: [
            RKResponseDescriptor(mapping: responseMapping, method: RKRequestMethod.any, pathPattern: nil, keyPath: nil, statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClass.successful))
            ,RKResponseDescriptor(mapping: responseMapping, method: RKRequestMethod.any , pathPattern: nil, keyPath: nil, statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClass.serverError))
            ])
    }
}
#endif
