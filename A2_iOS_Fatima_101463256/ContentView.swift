//
//  ContentView.swift
//  A2_iOS_Fatima_101463256
//
//  Created by Fatemeh (Fatima) Arab on 2025-03-24.
//

import SwiftUI
import CoreData

let dateFormatter : DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.createdAt, ascending:true)]
        
    )private var allProducts: FetchedResults<Product>
    
    @State private var currentIndex = 0
    @State private var searchText = ""

    // Filtered product list
    var filteredProducts: [Product]{
        if searchText.isEmpty {
            return Array(allProducts)
        }else{
            return allProducts.filter{product in 
               ( product.name?.localizedCaseInsensitiveContains(searchText) ?? false) ||
               ( product.productDescription?.localizedCaseInsensitiveContains(searchText) ?? false)
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
                
                
                // filtered list
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
                    if let created = product.createdAt{
                        Text("Created At: \(dateFormatter.string(from: created))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    
                    
                    // previous /next buttons
                    HStack(spacing:16){
                        Button(action:{
                            if currentIndex > 0{
                                currentIndex -= 1
                            }
                        }){
                            Text("Previous")
                                .frame(width: 120,height:44)
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
                                .frame(width: 120, height:44)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        .disabled(currentIndex >= filteredProducts.count - 1)
                    }
                }
                
                // Add New Product button
                NavigationLink(destination: AddProductView()){
                    Text(" Add New Product")
                    //.padding()
                        .frame(width:256, height:44)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            
            
                 // view All products button
                 NavigationLink(destination: ProductListView()){
                     Text("View All Products")
                         .padding()
                         .frame(width: 256, height:44)
                         .background(Color.green)
                         .foregroundColor(.white)
                         .cornerRadius(8)
                 }
            }
           
                    .padding()
                    .navigationTitle("Product Viewer")
                    .onChange(of: searchText){_ in
                        currentIndex = 0
                    }
                }
            }
}
