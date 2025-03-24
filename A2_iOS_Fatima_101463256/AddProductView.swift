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
    @State private var productDescriptin = ""
    
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AddProductView()
}
