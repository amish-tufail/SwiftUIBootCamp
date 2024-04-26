//
//  CoreDataBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 26/04/2024.
//

import SwiftUI
import CoreData

struct CoreDataBootCamp: View {
    @StateObject var vm = CoreDataViewModel()
    @State private var text: String = ""
    var body: some View {
        NavigationStack {
            VStack(spacing: 20.0) {
                TextField("Add fruit...", text: $text)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55.0)
                    .background(.orange.opacity(0.25))
                    .clipShape(.rect(cornerRadius: 12.0))
                    .padding(.horizontal)
                Button {
                    guard !text.isEmpty else { return }
                    vm.addFruits(name: text)
                    text = ""
                } label: {
                    Text("Add fruit")
                }
                .frame(maxWidth: .infinity)
                .buttonBorderShape(.capsule)
                .buttonStyle(BorderedButtonStyle())
            }
            List {
                ForEach(vm.savedEntities) { fruit in
                    Text(fruit.name ?? "")
                        .font(.headline)
                        .onTapGesture {
                            vm.updateFruit(fruit: fruit)
                        }
                }
                .onDelete(perform: vm.deleteFruit)
            }
            .listStyle(.plain)
            .navigationTitle("Fruit Core Data 🍓")
            
        }
    }
}

#Preview {
    CoreDataBootCamp()
}


class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer // Setup container
    
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        // All logic to load up core data - START
        container = NSPersistentContainer(name: "FruitsContainer") // setup container
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data: \(error)")
            } else {
                print("Successfully loaded core data.")
            }
        } // this loads all the data from container
        //  - END
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity") // Earlier we used @FetchRequest but here we do like this
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching: \(error)")
        }
    }
    
    func addFruits(name: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = name
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet ) {
        guard let index = indexSet.first else { return }
        let currentFruit = savedEntities[index]
        container.viewContext.delete(currentFruit)
        saveData()
    }
    
    func updateFruit(fruit: FruitEntity) {
        let currentFruitName = fruit.name ?? ""
        let updatedFruitName = currentFruitName + "!"
        fruit.name = updatedFruitName
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save() // Now earlier we user @FetchedRequest so, when we did this, it auto saved and updated the view, but now the view is linked to the @Published savedEnitites, so we need to update it and the easiest way is to call fetchFruits() here
            fetchFruits()
        } catch let error {
            print("Error saving: \(error)")
        }
    }
}
