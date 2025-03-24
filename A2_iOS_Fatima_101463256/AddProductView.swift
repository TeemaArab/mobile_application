//
//  AddProductView.swift
//  A2_iOS_Fatima_101463256
//
//  Created by Fatemeh (Fatima) Arab on 2025-03-24.
//

import SwiftUI

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var productID = UUID().uuidString
    @State private var name = ""
    @State private var productDescription = ""
    @State private var price = ""
    @State private var provider = ""
    
    
    
    
    var body: some View {
        NavigationView{
            Form {
                Section (header: Text ("Product information")){
                    TextField( "Product ID", text : $productID)
                        .disabled(true)
                    TextField("Name", text: $name)
                    TextField("Description", text: $productDescription)
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                    TextField("Provider", text: $provider)
                }
                Button ("Save Product"){
                    addNewProduct()
                }
                .disabled(name.isEmpty || price.isEmpty)
            }
            .navigationTitle("Add New Product")
        }
    }
    
    func addNewProduct(){
        let newProduct = Product(context: viewContext)
        newProduct.productID = productID
        newProduct.name = name
        newProduct.productDescription = productDescription
        newProduct.price = Double(price) ?? 0.0
        newProduct.provider = provider
        
        
        do {
            try viewContext.save()
            dismiss()
            
        }catch {
            print ("Error saving product: \(error)")
        }
    }
}

