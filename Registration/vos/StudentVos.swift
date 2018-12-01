//
//  StudentVos.swift
//  Registration
//
//  Created by MIT App Dev on 11/30/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit

class StudentVos: NSObject {
    var id : String = UUID.init().uuidString
    
    var name : String? = nil
    
    var nrc : String? = nil
    
    var dob : String? = nil
    
    var gender : String? = nil
    
    var major : String? = nil
    
    var university : String? = nil
    
    var address : String? = nil
    
    var email : String? = nil
    
    var phone : String? = nil
    
    var password : String? = nil
    
    var confirmPassword : String? = nil
    
    var image : String? = nil
    
    public static func parseToStuVO(json : [String : Any]) -> StudentVos {
        
        let user = StudentVos()
        user.id = json["id"] as! String
        user.name = json["name"] as? String
        user.phone = json["phone"] as? String
        user.email = json["email"] as? String
        user.password = json["password"] as? String
        return user
        
    }
    
    public static func parseToDictionary(student : StudentVos) -> [String : Any] {
        
      /*  let student1 = [
            "id" : student.id,
            "name" : student.name ?? "",
            "nrc" : student.nrc ?? "",
            "dob" : student.dob ?? "",
            "gender" : student.gender ?? "",
            "major" : student.major ?? "",
            "university" : student.university ?? "",
            "address" : student.address ?? "",
            "email" : student.email ?? "",
            "phone" : student.phone ?? "",
            "password" : student.password ?? "",
            "confirmPassword" : student.confirmPassword ?? "",
            "image" : student.image ?? ""
        ]*/
        
        let student = [
            "id" : student.id,
            "name" : student.name ?? "",
            "nrc" : student.nrc ?? "",
            "dob" : student.dob ?? "",
            "gender" : student.gender ?? "",
            "major" : student.major ?? "",
            "university" : student.university ?? "",
            "address" : student.address ?? "",
            "email" : student.email ?? ""
           ]
        
        return student
        
    }
   

}
