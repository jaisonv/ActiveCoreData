//
//  ActiveCoreData.swift
//  ActiveCoreData
//
//  Created by Jaison Vieira on 7/21/16.
//  Copyright © 2016 jaisonv. All rights reserved.
//

import CoreData

extension NSManagedObject {
    
    /// Finds all the stored objects.
    ///
    /// - Returns: Returns an array of NSManagedObject (needs to be converted to your type). If no object is found it will return an empty array.
    public class func findAll() -> [NSManagedObject] {
        
        let entityName = NSStringFromClass(self).components(separatedBy: ".").last!
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: ActiveCoreData.sharedController.managedObjectContext!)
    
        fetchRequest.entity = entity
        
        var fetchedObjects = [NSManagedObject]()
        
        do {
         
            fetchedObjects = try ActiveCoreData.sharedController.managedObjectContext!.fetch(fetchRequest) as! [NSManagedObject]
        }
        catch let error as NSError {
            
            print(error.localizedDescription)
        }
        
        return fetchedObjects
    }
    
    /// Finds all the stored objects maching attribute and value parameters.
    ///
    /// - Parameters:
    ///   - attribute: The key parameter to search for. Eg.: "Name"
    ///   - value: The value parameter to search for. Eg.: "John"
    /// - Returns: Returns an array of NSManagedObject (needs to be converted to your type). If no object is found it will return an empty array.
    public class func findAllByAttribute(_ attribute: String, value: String) -> [NSManagedObject] {
        
        if attribute == "" || value == "" {
            
            return []
        }
        
        let predicate = NSPredicate(format: "%K = %@", attribute, value)
        let entityName = NSStringFromClass(self).components(separatedBy: ".").last!
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: ActiveCoreData.sharedController.managedObjectContext!)
        
        fetchRequest.entity = entity
        fetchRequest.predicate = predicate
        
        var fetchedObjects = [NSManagedObject]()
        
        do {
            
            fetchedObjects = try ActiveCoreData.sharedController.managedObjectContext!.fetch(fetchRequest) as! [NSManagedObject]
        }
        catch let error as NSError {
            
            print(error.localizedDescription)
        }
        
        return fetchedObjects
    }
    
    public class func findFirst() -> Self? {
        
        return findFirstHelper()
    }
    
    fileprivate class func findFirstHelper<T>() -> T? {
        
        let entityName = NSStringFromClass(self).components(separatedBy: ".").last!
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: ActiveCoreData.sharedController.managedObjectContext!)
        
        fetchRequest.entity = entity
        
        var fetchedObjects = [NSManagedObject]()
        
        do {
            
            fetchedObjects = try ActiveCoreData.sharedController.managedObjectContext!.fetch(fetchRequest) as! [NSManagedObject]
        }
        catch let error as NSError {
            
            print(error.localizedDescription)
        }
        
        if fetchedObjects.count > 0 {
            
            return fetchedObjects.first as? T
        }
        
        return nil
    }
    
    /// Finds first stored object maching attribute and value parameters.
    ///
    /// - Parameters:
    ///   - attribute: The key parameter to search for. Eg.: "Name"
    ///   - value: The value parameter to search for. Eg.: "John"
    /// - Returns: Returns an object. If no object is found it will return nil.
    public class func findFirstByAttribute(_ attribute: String, value: String) -> Self? {
        
        return findFirstByAttributeHelper(attribute, value: value)
    }
    
    fileprivate class func findFirstByAttributeHelper<T>(_ attribute: String, value: String) -> T? {
        
        if attribute == "" || value == "" {
            
            return nil
        }
        
        let predicate = NSPredicate(format: "%K = %@", attribute, value)
        let entityName = NSStringFromClass(self).components(separatedBy: ".").last!
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: ActiveCoreData.sharedController.managedObjectContext!)
        
        fetchRequest.entity = entity
        fetchRequest.predicate = predicate
        
        var fetchedObjects = [NSManagedObject]()
        
        do {
            
            fetchedObjects = try ActiveCoreData.sharedController.managedObjectContext!.fetch(fetchRequest) as! [NSManagedObject]
        }
        catch let error as NSError {
            
            print(error.localizedDescription)
        }
        
        if fetchedObjects.count > 0 {
            
            return fetchedObjects.first as? T
        }
        
        return nil
    }

    /// Creates a new object and stores it in the database.
    /// 
    /// - Returns: Returns created object.
    public class func create() -> Self {
        
        return createHelper()
    }
    
    fileprivate class func createHelper<T>() -> T {
        
        let entityName = NSStringFromClass(self).components(separatedBy: ".").last!
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: ActiveCoreData.sharedController.managedObjectContext!) as! T
    }
    
    /// Delete object from database.
    public func delete() {
        
        ActiveCoreData.sharedController.managedObjectContext?.delete(self)
        save()
    }
    
    /// Save object on database.
    public func save() {
        
        do {
            try ActiveCoreData.sharedController.managedObjectContext?.save()
        }
        catch let error as NSError {
            
            print(error.localizedDescription)
        }
    }
}

open class ActiveCoreData: NSObject {

    static let sharedController = ActiveCoreData()
    
    var managedObjectModel: NSManagedObjectModel?
    var persistentStoreCoordinator: NSPersistentStoreCoordinator?
    var managedObjectContext: NSManagedObjectContext?
    
    override init() {
        
        super.init()
        
        let bundle = Bundle.main
        let bundleName = Bundle.main.infoDictionary!["CFBundleName"] as! String
        
        // consider the 'xcdatamodeld' file has the same name as the project
        let modelUrl = bundle.url(forResource: bundleName, withExtension: "momd")
        
        if let result = modelUrl {
            
            self.managedObjectModel = NSManagedObjectModel.init(contentsOf: result)!
        }
        
        // init persistentStoreCoordinator
        if let manageObject = self.managedObjectModel {
            
            self.persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: manageObject)
            let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
            let storeUrl = self.applicationDirectoryPath.appendingPathComponent("\(bundleName).sqlite")
            
            do {
                
                try self.persistentStoreCoordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: options)
            }
            catch let error as NSError {
                
                print(error.localizedDescription)
                persistentStoreCoordinator = nil
            }
        }
        
        // init managedObjectContex
        if let coordinator = self.persistentStoreCoordinator {
            
            self.managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            self.managedObjectContext?.persistentStoreCoordinator = coordinator
        }
    }
    
    var applicationDirectoryPath: URL {
        
        let bundleId = Bundle.main.bundleIdentifier
        
        let libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).last
        let path = (libraryPath! as NSString).appendingPathComponent(bundleId!)
        
        var isDirectory: ObjCBool = false
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: path, isDirectory: &isDirectory) {
            
            do {
                
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                
            } catch let error as NSError {
                
                print("Can't create directory \(path) [\(error.localizedDescription)]")
            }
            
        } else if !isDirectory.boolValue {
            
            print("Path \(path) exists but is not a directory")
        }
        
        return URL(fileURLWithPath: path)
    }
    
    func saveContext() {
        
        if let context = self.managedObjectContext {
            
            do {
                if context.hasChanges {
                    
                    try context.save()
                }
            }
            catch let error as NSError {
                
                print(error.localizedDescription)
            }
        }
    }
}
