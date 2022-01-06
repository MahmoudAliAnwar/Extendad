//
//  CoreDataManager.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//




import Foundation
import CoreData
import os

public class CoreDataManager {
    private static let identifier: String  = "MahmoudALi.Extendad"
    private static let model: String       = "Extendad"

    /**
     **Presistent Container for the CoreDataManager**.
     ````
     Core data
     ````
     */
    static let persistentContainer: NSPersistentContainer = {
        let messageKitBundle = Bundle(identifier: CoreDataManager.identifier)
        let modelURL = messageKitBundle!.url(forResource: CoreDataManager.model, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)

        let container = NSPersistentContainer(name: CoreDataManager.model, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { (_, error) in
            if let err = error {
                os_log("❌ Loading of store failed: %{PUBLIC}@", log: OSLog.default, type: .error, err.localizedDescription)
                fatalError("❌ Loading of store failed:\(err)")
            }
        }
        os_log("✅ Got Presistent Container succesfully", type: .debug)
        return container
    }()

    // MARK: repositories

    /**
     **add  repositories**.
     ````
     Core data
     ````
     - Parameter Repositories: the arry to be saved
     */
    static func addNew(Repositories repositories:[RepositoryModel]) {
        let context = CoreDataManager.persistentContainer.viewContext
        
      
        
        
        for repo in repositories{
            let repository = NSEntityDescription.insertNewObject(forEntityName: "RepositoryEntity", into: context) as! RepositoryEntity
            
            repository.date = repo.date ?? ""
            repository.id = Int64(repo.id ?? 0)
            repository.image = repo.owner?.avatarURL ?? ""
            repository.name = repo.name ?? ""
            repository.ownerName = repo.owner?.login ?? ""
            repository.repoDescription = repo.repoDescription ?? ""
            repository.pageNumber = Int64(repositories.count / 10)
        }

        
        
        do {
            try context.save()
            os_log("✅ Product saved succesfuly", type: .debug)
        } catch let error {
            os_log("❌ Failed to create Product", log: OSLog.default, type: .error, error.localizedDescription)

        }
    }

  
    /**
     **Get saved local repositories **.
     ````
     Core data
     ````
     - Parameter repositories: array of returned Repositories
     - Parameter error: error object if found
     */
    public static func fetchRepository(callback: @escaping (_ repositories: [RepositoryEntity]?, _ error: Error?) -> Void) {

        let context = CoreDataManager.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<RepositoryEntity>(entityName: "RepositoryEntity")

        do {
 
            let retrievedData = try context.fetch(fetchRequest)
            
            
            var items: [RepositoryEntity] = []
            for item in retrievedData {
               
                items.append(RepositoryEntity(name: item.name, id: item.id, ownerName: item.ownerName, repoDescription: item.repoDescription, image: item.image, date: item.date))
               
            }
            callback(items, nil)
            os_log("✅ repositories retrieved succesfully", type: .debug)
        } catch let fetchErr {
            callback(nil, fetchErr)
            os_log("❌ Failed to fetch repositories", log: OSLog.default, type: .error, fetchErr.localizedDescription)
        }
    }

    
   
   
   
  
   

}
