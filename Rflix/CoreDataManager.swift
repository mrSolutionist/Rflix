//
//  CoreDataManager.swift
//  Rflix
//
//  Created by  Robin George  on 15/11/21.
//

import Foundation
import CoreData

// MARK: - Core Data stack

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Rflix")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveObjectForOfflineLoading(jsonData: GenreTypeModel){
        //FIXME: DATA NOT SAVED COZ NO CONVERTION DONE. NEEDS TO FIND  A WAY TO SAVE DATA
        
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let data = ApiResponseData(context: context)
        data.backdrop_path = jsonData.backdrop_path
        guard let imageUrl = jsonData.backdrop_path else { return  }
        data.adult = jsonData.adult ?? false
        data.belongs_to_collection = jsonData.belongs_to_collection
        
        getImageData(imageUrl: imageUrl) { imageData in
            data.imageData = imageData
        }
        
        try! context.save()
        
        
        
    }
}


func getImageData(imageUrl : String , complition: (_ imageData : Data?) -> ()){
    let baseImageUrl = ApiManager.shared.imageUrl
    let url = URL(string: "\(baseImageUrl)\(imageUrl)")
    let imageData = try! Data(contentsOf: url!)
}
