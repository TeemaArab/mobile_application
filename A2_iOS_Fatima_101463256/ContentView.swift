//
//  ContentView.swift
//  A2_iOS_Fatima_101463256
//
//  Created by Fatemeh (Fatima) Arab on 2025-03-24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending:true)]
        
    )private var allProducts: FetchedResults<Product>
    
    @State private var currentIndex = 0
    @State private var searchText = ""
    
    // Filtered product list
    var filteredProducts: [Product]{
        if searchText.isEmpty {
            return Array(allProducts)
        }else{
            return allProducts.filter{product in (product.name?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                                        (product.productDescription?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }
}
                                    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                
                
                
                // Search bar
                TextField("Search by name or description", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                if filteredProducts.isEmpty{
                    Text("No matching products.")
                        .foregroundColor(.gray)
                }else{
                    let product = filteredProducts[currentIndex]
                    
                    
                    Text("Product Name: \(product.name ?? "N/A")")
                        .font(.subheadline)
                    Text("Description: \(product.productDescription ?? "N/A")")
                        .font(.subheadline)
                    Text("Price: $\(product.price, specifier: "%.2f")")
                    Text("Provider: \(product.provider ?? "N/A")")
                    
                    HStack(spacing:20){
                        Button(action: {
                            if currentIndex > 0{
                                currentIndex -= 1
                            }
                        }){
                            Text("Previous")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .disabled(currentIndex == 0)
                        
                        Button(action: {
                            if currentIndex < filteredProducts.count - 1{
                                currentIndex += 1
                            }
                        }){
                            Text("Next")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        .disabled(currentIndex >= filteredProducts.count - 1)
                    }
                    
                    // Add product Button
                    NavigationLink(destination: AddProductView()){
                        Text(" Add New Product")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
                    .padding()
                    .navigationTitle("Product Viewer")
                    .onChange(of:searchText){ _ in
                currentIndex = 0
                }
                
            }
        }
}
    
    
