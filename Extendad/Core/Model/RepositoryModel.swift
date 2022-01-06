//
//  RepositoryModel.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//

import Foundation
import CoreData

// MARK: - RepositoryModel
struct RepositoryModel: Codable {
    let id: Int?
    let name: String?
    let repoDescription: String?
    let owner: Owner?
    let date: String?
   
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case date
        case repoDescription = "description"
       
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String?
    let id: Int?
    let avatarURL: String?
   
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
       
    }
}




public class RepositoryEntity: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var id: Int64
    @NSManaged var ownerName: String
    @NSManaged var repoDescription: String
    @NSManaged var image: String
    @NSManaged var date: String
    @NSManaged var page: Int64
    @NSManaged var pageNumber: Int64
    @NSManaged var totalPage: Int64
    
    convenience init(name: String, id: Int64, ownerName: String,repoDescription: String, image: String, date: String) {
        let context = CoreDataManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "RepositoryEntity", in: context)!
        self.init(entity: entity, insertInto: context)
        self.name = name
        self.id = id
        self.ownerName = ownerName
        self.repoDescription = repoDescription
        self.image = image
        self.date = date
    }
}
