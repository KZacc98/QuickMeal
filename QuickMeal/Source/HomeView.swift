//
//  HomeView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/12/2024.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FoodItem.name, ascending: true)],
        animation: .default
    ) var foodItems: FetchedResults<FoodItem>
    
    @StateObject var viewModel: HomeViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(foodItems) { item in
                    FoodItemView(name: item.name, imageName: item.image) {
                        viewModel.manageFoodItems(item)
                    }
                }
            }
            .padding()
            
        }
    }
}
