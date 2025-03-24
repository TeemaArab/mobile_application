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
        
    )private var products: FetchedResults<Product>
    
    @State private var currentIndex = 0
    
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                if products.isEmpty{
                    Text ("No products available.")
                        .foregroundColor(.gray)
                }else{
                    let product = products[currentIndex]
                    
                    Text("Product Name: \(product.name ?? "N/A")")
                        .font(.subheadline)
                    Text("Description: \(product.productDescription ?? "N/A")")
                        .font(.subheadline)
                    Text("Price: $\(product.price, specifier: "%.2f")")
                    Text("Provider: \(product.provider ?? "N/A")")
                    
                    HStack{
                        Button ("Previous"){
                            if currentIndex > 0{
                                currentIndex -= 1
                            }
                        }
                        .disabled(currentIndex == 0)
                        
                        Button("Next"){
                            if currentIndex < products.count - 1{
                                currentIndex += 1
                            }
                        }
                        .disabled(currentIndex >= products.count - 1)
                    }
                    .padding()
                    .navigationTitle("Product Viewer")
                }
                
            }
        }
    }
}
    
