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
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CoreDataBootCamp()
}


class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer // Setup container
    
    init() {
        // All logic to load up core data - START
        container = NSPersistentContainer(name: "") // setup container
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data: \(error)")
            }
        } // this loads all the data from container
        //  - END
    }
}
