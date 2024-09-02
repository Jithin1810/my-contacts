//
//  ContactDetailsViewController.swift
//  MyContacts
//
//  Created by JiTHiN on 01/09/24.
//

import UIKit

struct ContactHeaderCellModel {
    let name: String
    let image: UIImage?
}

struct ContactDetailCellModel {
    let header: String
    let text: String
}

struct ContactActionCellModel {
    let cta: String
    let type: ActionType
}

enum ActionType {
    case addToFavourites
    case removeFromFavourites
    //    case call
    //    case message
}

class ContactDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [Any]()
    var contact: Contacts!
    var contactManager = ContactsManager()
//    var onUpdateContact: ((Contacts) -> Void)?
    var uiimage : UIImage?
    func updateUI(with contact: Contacts) {
        self.contact = contact
        displayContact()
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        tableView.register(ContactDetailsTableViewCell.self, forCellReuseIdentifier: "contactcell")
        tableView.register(UINib(nibName: "ContactDetailsTableViewCell", bundle: .main) , forCellReuseIdentifier: "contactcell")
        tableView.register(ContactMobileTableViewCell.self, forCellReuseIdentifier: "mobileCell")
        tableView.register(UINib(nibName: "ContactMobileTableViewCell", bundle: .main), forCellReuseIdentifier: "mobileCell")
        tableView.register(ContactFavouriteTableViewCell.self, forCellReuseIdentifier: "favCell")
        tableView.register(UINib(nibName: "ContactFavouriteTableViewCell", bundle: .main), forCellReuseIdentifier: "favCell")
        displayContact()
        let rightButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
        navigationItem.largeTitleDisplayMode = .never
    }
    func displayContact(){
        dataSource.removeAll()
        if contact.image != nil{
            uiimage = contactManager.convertDataToImage(data: contact.image!)
        }
        let contactheader = ContactHeaderCellModel(name: contact.name, image: uiimage)
        dataSource.append(contactheader)
        let contactmobile = ContactDetailCellModel(header: "Mobile", text: contact.phoneNumber)
        dataSource.append(contactmobile)
        if let mail = contact.emailId{
            let contactEmail = ContactDetailCellModel(header: "Email", text: mail)
            dataSource.append(contactEmail)
        }
        var contactFav : ContactActionCellModel
        if contact.fav {
            contactFav = ContactActionCellModel(cta: "Remove from Favourite", type: .removeFromFavourites)
        }else{
            contactFav = ContactActionCellModel(cta: "Add to Favourite", type: .addToFavourites)
        }
        
        dataSource.append(contactFav)
        tableView.reloadData()
    }
    @objc func editButtonTapped(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let createContactDetailVC = storyBoard.instantiateViewController(identifier: "createVc") as? CreateContactViewController else{
            return
        }
        createContactDetailVC.contact = contact
        createContactDetailVC.onUpdateContact = {[weak self] updatedContact in
            self?.updateUI(with: updatedContact)}
        let navigationController = UINavigationController(rootViewController: createContactDetailVC)
        present(navigationController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = dataSource[indexPath.row]
        
        switch model {
        case let model as ContactHeaderCellModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "contactcell",for: indexPath) as! ContactDetailsTableViewCell
            cell.configure(model)
            return cell
            
        case let model as ContactDetailCellModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mobileCell", for: indexPath) as! ContactMobileTableViewCell
            cell.configure(model)
            return cell
            
        case let model as ContactActionCellModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! ContactFavouriteTableViewCell
            cell.configure(model)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        
        if let model = model as? ContactActionCellModel {
            switch model.type {
            case .addToFavourites:
                contact.fav = true
                contactManager.updateContact(contact)
                navigationController?.popViewController(animated: true)
                
                
            case .removeFromFavourites:
                contact.fav = false
                contactManager.updateContact(contact)
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
