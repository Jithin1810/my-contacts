//
//  Contacts.swift
//  MyContacts
//
//  Created by JiTHiN on 01/09/24.
//

import Foundation
import UIKit

struct Contacts : Codable{
    var id : UUID
    var name : String
    var phoneNumber : String
    var emailId :  String?
    var fav : Bool
    var image : Data?
}

extension UIImage {
    func toData() -> Data? {
        return self.pngData()
    }
    
    static func fromData(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
