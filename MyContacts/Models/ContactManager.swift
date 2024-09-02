//
//  ContactManager.swift
//  MyContacts
//
//  Created by JiTHiN on 01/09/24.
//

import Foundation
import UIKit


class ContactsManager {
    
    private let defaults = UserDefaults.standard
    private let contactsKey = "contactsKey"
    
    func saveContact(_ contact: Contacts) -> Bool {
        var allContacts = loadContacts()
        if allContacts.contains(where: {$0.name == contact.name}){return false}
        allContacts.append(contact)
        saveContactsArray(allContacts)
        return true
    }
    func saveContactsArray(_ contacts : [Contacts]){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(contacts)
            defaults.set(data, forKey: contactsKey)
        } catch {
            print("Failed to save contacts: \(error)")
        }
    }
    
    func loadContacts() -> [Contacts] {
        guard let data = defaults.data(forKey: contactsKey) else { return [] }
        do {
            let decoder = JSONDecoder()
            let contacts = try decoder.decode([Contacts].self, from: data)
            return contacts
        } catch {
            print("Failed to load contacts: \(error)")
            return []
        }
    }
    func updateContact(_ contact : Contacts) {
        var oldContacts = loadContacts()
        if let index = oldContacts.firstIndex(where: {$0.id == contact.id}){
            oldContacts[index] = contact
        }
        saveContactsArray(oldContacts)
    }
    func convertImageToData(image: UIImage) -> Data? {
        return image.jpegData(compressionQuality: 0.8) // Adjust compression quality as needed
    }
    func convertDataToImage(data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    func deleteContact(_ contact : Contacts){
        var oldContacts = loadContacts()
        if let index = oldContacts.firstIndex(where: {$0.id == contact.id}){
            oldContacts.remove(at: index)
        }
        saveContactsArray(oldContacts)
    }
}

