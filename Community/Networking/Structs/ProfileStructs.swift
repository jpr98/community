//
//  ProfileStructs.swift
//  Community
//
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

struct LoadProfileRequest: Encodable {
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
    enum CodingKeys : String, CodingKey {
        case id = "_id"
    }
}

struct LoadProfileResponse: Decodable {
    var success: Bool
    var report: ReportResponse
    
    struct user: Decodable {
        var id: String
        var address: String
        var DoB: String
        var phone: String
        var altPhone: String
        var isStudent: Bool
        var isActive: Bool
        var email: String
        var colony: String
        var createdAt: String
        var updatedAt: String
        var v: Int
        var emergencyC: String
        
        enum CodingKeys : String, CodingKey {
            case id = "_id", address = "sAddress", DoB = "dDateOfBirth", phone = "sPhone", altPhone = "sAltPhone", isStudent = "bIsStudent", isActive = "bActive", email = "sEmail", colony = "fkColony", createdAt = "createdAt", updatedAt = "updatedAt", v = "__v", emergencyC = "sEmergencyContactE"
        }
    }
}

struct ChangeProfileRequest: Encodable {
    
    var id: String
    var address: String
    var DoB: String
    var phone: String
    var altPhone: String
    var isStudent: Bool
    var isActive: Bool
    var email: String
    var colony: String
    var createdAt: String
    var updatedAt: String
    var v: Int
    var emergencyC: String
    
    init(id: String, address: String,DoB: String, phone: String, altPhone: String,isStudent: Bool, isActive: Bool, email: String,colony: String, createdAt: String,updatedAt: String,v: Int,  emergencyC: String) {
        self.id = id
        self.address = address
        self.DoB = DoB
        self.phone = phone
        self.altPhone = altPhone
        self.isStudent = isStudent
        self.isActive = isActive
        self.email = email
        self.colony = colony
        self.createdAt = createdAt
        self.updatedAt=updatedAt
        self.v = v
        self.emergencyC = emergencyC
    }
        
    enum CodingKeys : String, CodingKey {
        case id = "_id", address = "sAddress", DoB = "dDateOfBirth", phone = "sPhone", altPhone = "sAltPhone", isStudent = "bIsStudent", isActive = "bActive", email = "sEmail", colony = "fkColony", createdAt = "createdAt", updatedAt = "updatedAt", v = "__v", emergencyC = "sEmergencyContactE"
    }
    
    
}


struct ChangeProfileResponse: Decodable {
    var success: Bool
    var report: ReportResponse
    
}


