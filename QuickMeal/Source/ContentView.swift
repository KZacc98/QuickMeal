//
//  ContentView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/12/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FoodItem.name, ascending: true)],
        animation: .default
    )
    private var foodItems: FetchedResults<FoodItem>
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(foodItems) { item in
                    FoodItemView(name: item.name, imageName: item.image)
                }
            }
            .padding()
        }
    }
}

struct FoodItemView: View {
    var name: String?
    var imageName: String?
    
    var body: some View {
        VStack {
            if let imageName {
                Image(systemName: imageName)
                    .padding()
            }
            if let name {
                Text(name)
            }
        }
        .padding(20)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


#Preview {
    ContentView()
//    FoodItemView(name: "Cauliflower", imageName: "fish.fill")
}
