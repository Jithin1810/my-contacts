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
    
    var  contactManager = ContactsManager()

    var viewMode: ViewMode = .contacts

    var numberOfRows: Int {
        switch viewMode {
        case .favourites:
            return favouriteContacts.count
        case .contacts:
            return allContacts.count
        }
    }
    private func populateDefaults()-> [Contacts]{
        //guard viewMode == .favourites else { return []}
        let defaultContacts = [Contacts(id: UUID(), name: "favourite1", phoneNumber: "1111111111", emailId: "favourite1@gmail.com", fav: true),
                               Contacts(id: UUID(), name: "favourite2", phoneNumber: "2222222222", emailId: "favourite2@gmail.com", fav: false),
                               Contacts(id: UUID(), name: "favourite3", phoneNumber: "1111111333", emailId: "favourite3@gmail.com", fav: true),
                               Contacts(id: UUID(), name: "favourite4", phoneNumber: "2222222333", emailId: "favourite4@gmail.com", fav: false),
                               Contacts(id: UUID(), name: "favourite5", phoneNumber: "1111111444", emailId: "favourite5@gmail.com", fav: true),
                               Contacts(id: UUID(), name: "favourite6", phoneNumber: "2222222444", emailId: "favourite6@gmail.com", fav: true)]
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
        var fetchedContacts = contactManager.loadContacts()
        return fetchedContacts
    }
}
