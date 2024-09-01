//
//  ContactDetailsViewController.swift
//  MyContacts
//
//  Created by JiTHiN on 01/09/24.
//

import UIKit

struct ContactHeaderCellModel {
    let name: String
    let image: Data?
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
//    case call
//    case message
}

class ContactDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [Any]()
    var contact: Contacts!
    
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
        let contactheader = ContactHeaderCellModel(name: contact.name, image: contact.image)
        dataSource.append(contactheader)
        let contactmobile = ContactDetailCellModel(header: "Mobile", text: contact.phoneNumber)
        dataSource.append(contactmobile)
        if let mail = contact.emailId{
            let contactEmail = ContactDetailCellModel(header: "Email", text: mail)
            dataSource.append(contactEmail)
        }
        let contactfav = ContactActionCellModel(cta: "Add to Favourite", type: .addToFavourites)
        dataSource.append(contactfav)
        tableView.reloadData()
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
//            switch model.type {
//            case .addToFavourites:
//                //
//                
//            }
        }
    }

}
