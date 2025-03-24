//
//  Persistence.swift
//  A2_iOS_Fatima_101463256
//
//  Created by Fatemeh (Fatima) Arab on 2025-03-24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 1...10 {
            let product = Product(context: viewContext)
            product.productID = UUID().uuidString
            product.name = "Product \(i)"
            product.productDescription = " This is description for Product \(i)."
            product.price = Double(i) * 10.0
            product.provider = "Provider \(i)"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "A2_iOS_Fatima_101463256")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
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
        //container.viewContext.automaticallyMergesChangesFromParent = true
        insertSampleProductsIfNeeded(context: container.viewContext)
    }
    private func insertSampleProductsIfNeeded(context: NSManagedObjectContext){
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            let count = try context.count(for: fetchRequest)
            if count == 0{
                for i in 1...10{
                    let product = Product(context:context)
                    product.productID = UUID().uuidString
                    product.name = "Product \(i)"
                    product.productDescription = " This is description for Product \(i)"
                    product.price = Double(i) * 10.0
                    product.provider = "Provider \(i)"
                    
                }
                try context.save()
            }
        } catch {
            print(" Error inserting sample products: \(error.localizedDescription)")
        }
        
    }
}
