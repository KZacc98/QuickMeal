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
    @StateObject var viewModel: HomeViewModel
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FoodItem.name, ascending: true)],
        animation: .default
    ) var foodItems: FetchedResults<FoodItem>
    
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
        .overlay {
            if viewModel.hideButton == false {
                GeometryReader { geometry in
                    VStack{
                        Spacer()
                        MakeRecipeButton(requiredCount: 3, currentCount: viewModel.foodItems.count) {
                            print("make recipe with:")
                            viewModel.foodItems.forEach { item in
                                print(item.name ?? "")
                            }
                        }
                        .frame(height: geometry.size.height * 0.08)
                        .padding()
                    }
                }
            }
        }
    }
}
