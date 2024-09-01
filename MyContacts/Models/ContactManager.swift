//
//  ContactManager.swift
//  MyContacts
//
//  Created by JiTHiN on 01/09/24.
//

import Foundation

class ContactsManager {

    private let defaults = UserDefaults.standard
    private let contactsKey = "contactsKey"

    func saveContacts(_ contacts: [Contacts]) {
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
}

