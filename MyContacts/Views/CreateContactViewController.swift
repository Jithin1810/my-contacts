//
//  CreateContactViewController.swift
//  MyContacts
//
//  Created by JiTHiN on 01/09/24.
//

import UIKit

class CreateContactViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var contactPosterImageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var emailID: UITextField!
    
    let contactManager = ContactsManager()
    var contact : Contacts?
    var onUpdateContact: ((Contacts) -> Void)?
    let imagePicker = UIImagePickerController()
    var imageData : Data?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarButtons()
        imagePicker.delegate = self
        if contact != nil{
            nameText.text = contact?.name
            mobileNumber.text = contact?.phoneNumber
            emailID.text = contact?.emailId
            if let imgData = contact?.image {
                contactPosterImageView.image = contactManager.convertDataToImage(data: imgData)
                self.imageData = imgData
            }
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // Ensures that the tap does not interfere with touches in the table view
        self.view.addGestureRecognizer(tapGesture)
        
        //keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3
            let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            
            UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
                self.view.frame.origin.y = -keyboardHeight
            }, completion: nil)
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3
        let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
            self.view.frame.origin.y = 0
        }, completion: nil)
    }
    private func setupNavigationBarButtons() {
        // Left bar button
        let leftButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(previousButtonTapped))
        self.navigationItem.leftBarButtonItem = leftButton
        
        // Right bar button
        var title = "Save"
        if contact != nil{
            title = "Update"
        }
        let rightButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    @objc func dismissKeyboard() {
        // Resign the first responder from the active text field or text view
        self.view.endEditing(true)
    }
    
    @objc private func previousButtonTapped() {
        // Handle the action for the Previous button
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        if validateInput(){
            let name = nameText.text ?? ""
            let mobile = mobileNumber.text ?? ""
            let email = emailID.text
            let contactNew = Contacts(id: UUID(), name: name, phoneNumber: mobile,emailId: email, fav: false, image: imageData)
            if contact != nil{
                let contactUpdate = Contacts(id : contact!.id, name: name, phoneNumber: mobile,emailId: email, fav: false, image: imageData)
                contactManager.updateContact(contactUpdate)
                onUpdateContact?(contactNew)
            }
            else{
                let save = contactManager.saveContact(contactNew)
                if !save{
                    showAlert(title: "Error", message: "Contact already exist")
                }
            }
            navigationController?.dismiss(animated: true)
        }
        
    }
    @IBAction func addPhotoButton(_ sender: Any) {
        let alert = UIAlertController(title: "Select Photo", message: nil, preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                    self.openCamera()
                }))
                
                alert.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
                    self.openPhotoLibrary()
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(alert, animated: true, completion: nil)
    }
    func openCamera() {
         if UIImagePickerController.isSourceTypeAvailable(.camera) {
             imagePicker.sourceType = .camera
             present(imagePicker, animated: true, completion: nil)
         } else {
             // Handle the case where the camera is not available
             print("Camera not available")
         }
     }
     
     func openPhotoLibrary() {
         imagePicker.sourceType = .photoLibrary
         present(imagePicker, animated: true, completion: nil)
     }
     
     // UIImagePickerControllerDelegate methods
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let selectedImage = info[.originalImage] as? UIImage {
             contactPosterImageView.image = selectedImage
             imageData = contactManager.convertImageToData(image: selectedImage)
         }
         picker.dismiss(animated: true, completion: nil)
     }
     
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true, completion: nil)
     }
    private func validateInput() -> Bool{
        guard let name = nameText.text, !name.isEmpty,
              let phoneNumber = mobileNumber.text, !phoneNumber.isEmpty else {
            showAlert(title: "Invalid Input", message: "Name and phone number are required.")
            return false
        }
        let phoneNumberdigits = phoneNumber.filter({$0.isNumber})
        if phoneNumberdigits.count != 10{
            showAlert(title: "Invalid Input ", message: "Phone number must contain exactly 10 digits.")
        }
        if let email = emailID.text, !email.isEmpty {
            if !isValidEmail(email) {
                showAlert(title: "Invalid Input", message: "Please enter a valid email address.")
                return false
            }
        }
        return true
    }
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    private func isValidEmail(_ email: String) -> Bool {
        // Basic regex for email validation
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
}
