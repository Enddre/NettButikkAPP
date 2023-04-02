//
//  Produkter.swift
//  NettButikkAPP
//
//  Created by Endre Jørstad Kvisgaard on 31/03/2023.
//

import SwiftUI

struct Products: Decodable {
    var products: [Product]
}
struct Product: Identifiable, Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
}



struct ProductRow: View {
    var product: Product
    
    var body: some View {
        HStack {
    
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                    .foregroundColor(.blue)
                Text("$\(product.price, specifier: "%.2f")")
                    .foregroundColor(.green)
            }
        }
    }
}


struct ProductDetail: View {
    var product: Product
    
    var body: some View {
        VStack {
        
            Text(product.title)
                .font(.largeTitle)
                .padding()
            Text(product.description)
                .padding()
            Text("$\(product.price, specifier: "%.2f")")
                .font(.title)
                .foregroundColor(.green)
                .padding()
            
            Spacer()
        }
    }
}


struct Produkter: View {
    
    @State var products: [Product] = []
    
    var body: some View {
        NavigationView {
            List(products) { products in
        
                NavigationLink(destination: ProductDetail(product: products)) {
                    ProductRow(product: products)
                }
            }
            .navigationTitle("Produkter")
        }
        .onAppear {
            
            fetchProducts()
        }
    }
    

    func fetchProducts() {

        guard let url = URL(string: "https://dummyjson.com/products") else { return }
        
      
        let request = URLRequest(url: url)
        
    
        URLSession.shared.dataTask(with: request) { data, response, error in
          
            if let error = error {
                print(error.localizedDescription)
                return
            }
            

            if let data = data {
                
                do {
                    let decodedProducts = try JSONDecoder().decode(Products.self, from: data)
          
                    DispatchQueue.main.async {
                        self.products = decodedProducts.products
                    }
                } catch {
              
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
