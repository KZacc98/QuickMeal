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

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .onTapGesture {
                    coordinator.push(.details)
                }
            
            Button("Add Meal") {
                let newItem = FoodItem(context: viewContext)
                newItem.id = UUID()
                newItem.name = "Item \(Int.random(in: 0..<100))"
                newItem.image = "fish.fill"
                
                do {
                    try viewContext.save()
                } catch {
                    print("Error saving meal: \(error.localizedDescription)")
                }
            }
            .padding()

            List(foodItems) { foodItem in
                Text(foodItem.name ?? "Unknown item")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
