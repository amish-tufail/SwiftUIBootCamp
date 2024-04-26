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
    }
    
    
    // Business
    func getBusinessess() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching businesses: \(error)")
        }
    }
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        // add exisiting departments to the new business
//        newBusiness.departments = []
        // add exisiting employees to the new business
//        newBusiness.employees = []
        
        // add new business to the the existing departments
//        newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        // add new business to the the existing employee
//        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
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
        newDepartment.name = "Engineering"
        newDepartment.business = [businesses[0]]
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
        newEmployee.name = "Amish"
        newEmployee.age = 22
        newEmployee.dateJoined = Date()
        save()
    }
    
    // Save function
    func save() {
        businesses.removeAll()
        departments.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusinessess()
            self.getDepartments()
        }
    }
}
