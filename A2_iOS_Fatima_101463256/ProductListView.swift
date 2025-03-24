//
//  ProductListView.swift
//  A2_iOS_Fatima_101463256
//
//  Created by Fatemeh (Fatima) Arab on 2025-03-24.
//

import SwiftUI
import CoreData

struct ProductListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Product.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending:true)]
    ) private var allProducts: FetchedResults<Product>
    
  

