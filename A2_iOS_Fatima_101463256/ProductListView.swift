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
            ScrollView{
                LazyVStack(alignment: .leading, spacing: 12){
                    ForEach(allProducts, id: \.self){
                        product in
                        VStack(alignment: .leading, spacing: 6){
                            Text("Name: \(product.name ?? "N/A")")
                                .font(.headline)
                            Text("Description: \(product.productDescription ?? "N/A")")
                                .font(.subheadline)
                            Text(String(format: " Price: $%.2f", product.price))
                            Text("Provider: \(product.provider ?? "N/A")")
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                    }
                }
                .padding(.top)
               
            }
                .navigationTitle("All Products")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
}

