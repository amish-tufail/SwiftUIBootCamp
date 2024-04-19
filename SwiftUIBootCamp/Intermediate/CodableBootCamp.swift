//
//  CodableBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 19/04/2024.
//

import SwiftUI

struct CustomerModel: Identifiable, Encodable, Decodable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    // Start
    init(id: String, name: String, points: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case points
        case isPremium
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.points = try container.decode(Int.self, forKey: .points)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
    }
    
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.points, forKey: .points)
        try container.encode(self.isPremium, forKey: .isPremium)
    }
    // End
    
    // From Start - End, we do this when we use Encodable, Decodable, but when we use Codable, it is auto done in the back so, we dont have to do write this
}

class CodableViewModel: ObservableObject {
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJSONData() else { return } // This is how we get JSON data from internet
        print(data) // Raw Form
        let jsonData = String(data: data, encoding: .utf8) // Presenting it in string form, still unable to use it
        print(jsonData)
        
        // Decoding data, getting back that dictionary we converted into the data
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data), // Get Any
//            let dictionary = localData as? [String : Any], // Get back that inital dictionary
//            let id =  dictionary["id"] as? String,
//            let name =  dictionary["name"] as? String,
//            let points =  dictionary["points"] as? Int,
//            let isPremium =  dictionary["isPremium"] as? Bool {
//            // Now putting the values in our Model and append
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//            customer = newCustomer
//        }
        
        // but this is under the hood thing, and we dont really need to do it
        // We can use Codable or Decodable
        
        let decodedData = try? JSONDecoder().decode(CustomerModel.self, from: data)
        customer = decodedData
        
    }
    
    func getJSONData() -> Data? {
        // Creating a JSON
//        let dictionary: [String : Any] = [
//            "id": "12345",
//            "name": "Amish",
//            "points": 5,
//            "isPremium": true
//        ]
//        // Converts into JsonObject / DataObject
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
//        return jsonData
        
        // We dont need to do that above Serialization thing we can use Encodable / Codable
        let customer = CustomerModel(id: "201333", name: "Amish", points: 100, isPremium: true)
        let encodedData = try? JSONEncoder().encode(customer)
        return encodedData
    }
}

struct CodableBootCamp: View {
    @StateObject var vm = CodableViewModel()
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text("\(customer.isPremium)")
            }
        }
    }
}

#Preview {
    CodableBootCamp()
}
