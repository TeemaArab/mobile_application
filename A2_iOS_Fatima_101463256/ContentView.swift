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
                    
                    Text("Product Name: \(product.name?? "N/A")")
                        .font(.subheadline)
                }
                               
    
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
