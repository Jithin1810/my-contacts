//
//  ContactsViewModel.swift
//  MyContacts
//
//  Created by JiTHiN on 01/09/24.
//

import Foundation

enum ViewMode{
    case favourites
    case contacts
}

class ContactsViewModel{
    private var allContacts: [Contacts] = []
    
    private var favouriteContacts: [Contacts] = []

    var viewMode: ViewMode = .contacts

    var numberOfRows: Int {
        switch viewMode {
        case .favourites:
            return favouriteContacts.count
        case .contacts:
            return allContacts.count
        }
    }
    func populateDefaultsifrequired(){
        //check user defaults if user entered contacts exists and if not populate default contacts
        
        //populateDefaults()
    }
    private func populateDefaults()-> [Contacts]{
        //guard viewMode == .favourites else { return []}
        let defaultContacts = [Contacts(name: "favourite1", phoneNumber: "1111111111", emailId: "favourite1@gmail.com", fav: true),
        Contacts(name: "favourite2", phoneNumber: "2222222222", emailId: "favourite2@gmail.com", fav: false),
        Contacts(name: "favourite3", phoneNumber: "1111111333", emailId: "favourite3@gmail.com", fav: true),
        Contacts(name: "favourite4", phoneNumber: "2222222333", emailId: "favourite4@gmail.com", fav: false),
        Contacts(name: "favourite5", phoneNumber: "1111111444", emailId: "favourite5@gmail.com", fav: true),
        Contacts(name: "favourite6", phoneNumber: "2222222444", emailId: "favourite6@gmail.com", fav: true)]
         return defaultContacts
    }


    func fetchData() {
        // Replace with actual data fetching logic
        allContacts = fetchContacts()
        //favouriteContacts = fetchFavourites()
        favouriteContacts = allContacts.filter({$0.fav})
    }

    func contact(at index: Int) -> Contacts {
        switch viewMode {
        case .favourites:
            return favouriteContacts[index]
        case .contacts:
            return allContacts[index]
        }
    }

    private func fetchContacts() -> [Contacts] {
        // Fetch and return all contacts
        
        return populateDefaults()
    }

    private func fetchFavourites() -> [Contacts] {
        // Fetch and return favourite contacts
        return []
    }
    
}
