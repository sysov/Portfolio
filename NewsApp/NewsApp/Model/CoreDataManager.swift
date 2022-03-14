//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Valera Sysov on 11.03.22.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    private func deleteNews () {
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        if let news = try? context.fetch(fetchRequest) {
            news.forEach {
                context.delete($0)
            }
        }
        saveContext()
    }
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataManager: PersistenceProtocol {
    func readFavorites() -> [Article] {
        let fetchRequest = NSFetchRequest<News>(entityName: "News")
        if let result = try? context.fetch(fetchRequest) {
            return result.map{
                Article(author: $0.author,
                        title: $0.title!,
                        description: $0.descriptionText!,
                        url: $0.url!,
                        urlToImage: $0.urlToImage,
                        publishedAt: $0.publishedAt!,
                        content: $0.content!)
            }
        }
        return []
    }
    
    func saveFavorites(_ favorites: [Article]) {
        deleteNews()
        favorites.forEach {
            let entity = News(context: context)
            entity.author = $0.author
            entity.title = $0.title
            entity.descriptionText = $0.description
            entity.url = $0.url
            entity.urlToImage = $0.urlToImage
            entity.publishedAt = $0.publishedAt
            entity.content = $0.content
            saveContext()
        }
    }
}



