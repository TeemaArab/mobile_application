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
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(allProducts){
                    product in
                    VStack(alignment: .leading, spacing: 8){
                        Text(product.name ?? "No Name")
                            .font(.headline)
                        Text(product.productDescription ?? "No Description")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("All Products")
        }
    }
}

