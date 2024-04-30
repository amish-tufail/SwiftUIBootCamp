//
//  CoreDataRelationshipViewModel.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 26/04/2024.
//

import Foundation
import CoreData

class CoreDataRelationshipViewModel: ObservableObject {
    let manager = CoreDataRelationshipManager.shared
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    
    init() {
        getBusinessess()
        getDepartments()
        getEmployees()
    }
    
    
    // Business
    func getBusinessess() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        // Sorting
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
        // Filtering
        let filter = NSPredicate(format: "name == %@", "Apple")
        request.predicate = filter
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching businesses: \(error)")
        }
    }
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Google"
        // add exisiting departments to the new business
        newBusiness.departments = [departments[0], departments[1]]
//        // add exisiting employees to the new business
//        newBusiness.employees = [employees[0], employees[1]]
        
        // add new business to the the existing departments
//        newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        // add new business to the the existing employee
//        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        save()
    }
    func updateBusiness() {
        let exisitingBusiness = businesses[1]
        exisitingBusiness.departments = [departments[0], departments[1]]
        save()
    }
    // Department
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching businesses: \(error)")
        }
    }
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Marketing"
        newDepartment.business = [businesses[0]]
        newDepartment.employees = [employees[1]]
//        newDepartment.addToEmployees(employees[1]) // same as above
        save()
    }
    
    // Employee
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching businesses: \(error)")
        }
    }
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Mohsin"
        newEmployee.age = 20
        newEmployee.dateJoined = Date()
        newEmployee.business = businesses[0]
        newEmployee.department = departments[0]
        save()
    }
    func getEmployees(forBusiness business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching businesses: \(error)")
        }
    }
    
    // Delete
    func deleteDepartment() {
        let department = departments[0]
        manager.context.delete(department)
        save()
    } // Department entity -> inside it relatioship in which we add delete rule, so if delete rule is deny, then if we delete a department then a relartionship which has that rule will prevent it from happening

    
    // Save function
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusinessess()
            self.getDepartments()
            self.getEmployees()
        }
    }
}


