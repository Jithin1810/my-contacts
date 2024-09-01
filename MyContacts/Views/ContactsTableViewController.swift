//
//  ContactsTableViewController.swift
//  MyContacts
//
//  Created by JiTHiN on 01/09/24.
//

import UIKit


class ContactsTableViewController: UITableViewController {
    var viewModel : ContactsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "ContactsTableViewCell", bundle: .main), forCellReuseIdentifier: "cell")
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactsTableViewCell
        let contact = viewModel.contact(at: indexPath.row)
        cell.configure(with: contact)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = viewModel.contact(at: indexPath.row)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsVc = storyBoard.instantiateViewController(withIdentifier: "contactDetails") as? ContactDetailsViewController else {
            return
        }
        detailsVc.contact = contact
        self.navigationController?.pushViewController(detailsVc, animated: true)
        
    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
