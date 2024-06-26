//
//  CoreDataRelationshipBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 26/04/2024.
//

import SwiftUI

struct CoreDataRelationshipBootCamp: View {
    @StateObject private var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20.0) {
                    Button {
                        vm.deleteDepartment()
                    } label: {
                        Text("Perform Action")
                            .foregroundStyle(.white)
                            .frame(height: 55.0)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .clipShape(.rect(cornerRadius: 12.0))
                    }
                 
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Core Data Business 🏢")
        }
    }
}

#Preview {
    CoreDataRelationshipBootCamp()
}

struct BusinessView: View {
    let entity: BusinessEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("Name: \(entity.name ?? "")")
                .font(.title3)
                .bold()
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                        .font(.caption)
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                        .font(.caption)
                }
            }
        }
        .padding()
        .frame(maxWidth: 300.0, alignment: .leading)
        .background(.gray.opacity(0.5))
        .clipShape(.rect(cornerRadius: 10.0))
        .shadow(radius: 10.0)
    }
}

struct DepartmentView: View {
    let entity: DepartmentEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("Name: \(entity.name ?? "")")
                .font(.title3)
                .bold()
            if let businesses = entity.business?.allObjects as? [DepartmentEntity] {
                Text("Businesses:")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                        .font(.caption)
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                        .font(.caption)
                }
            }
        }
        .padding()
        .frame(maxWidth: 300.0, alignment: .leading)
        .background(.green.opacity(0.5))
        .clipShape(.rect(cornerRadius: 10.0))
        .shadow(radius: 10.0)
    }
}

struct EmployeeView: View {
    let entity: EmployeeEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("Name: \(entity.name ?? "")")
                .font(.title3)
                .bold()
            Text("Age: \(entity.age)")
                .font(.title3)
                .bold()
            Text("Date Joined: \(entity.dateJoined ?? Date())")
                .font(.title3)
                .bold()
            if let business = entity.business {
                Text("Business:")
                    .bold()
                Text(business.name ?? "")
                    .font(.caption)
            }
            
            if let department = entity.department {
                Text("Department:")
                    .bold()
                Text(department.name ?? "")
                    .font(.caption)
            }
        }
        .padding()
        .frame(maxWidth: 300.0, alignment: .leading)
        .background(.blue.opacity(0.5))
        .clipShape(.rect(cornerRadius: 10.0))
        .shadow(radius: 10.0)
    }
}



