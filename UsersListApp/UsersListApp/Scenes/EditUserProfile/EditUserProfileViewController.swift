//
//  EditUserProfileViewController.swift
//  UsersListApp
//
//  Created by Fedya on 1/20/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

final class EditUserProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var interactor: EditUserProfileBusinessLogic?
    var router: (NSObjectProtocol & EditUserProfileDataPassing)?
    private let userAvatar = RoundedImageView()
    private let changeAvatarBtn = UIButton()
    private var firstNameField: LabelWithInput?
    private var lastNameField: LabelWithInput?
    private var emailField: LabelWithInput?
    private var phoneField: LabelWithInput?
    private let imagePicker = UIImagePickerController()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = EditUserProfileInteractor()
        let router = EditUserProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
        imagePicker.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        tabBarController?.tabBar.isHidden = true
        self.title = NSLocalizedString("Edit user profile", comment: "")
        let rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveUserProfile))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        setupUserAvatar()
        setupChangeAvatarBtn()
        setupFirstNameField()
        setupLastNameField()
        setupEmailField()
        setupPhoneField()
    }
    
    private func setupUserAvatar() {
        view.install(userAvatar) { _ in
            userAvatar.pinTop(to: view, constant: 110)
            userAvatar.pinCenterX(to: view)
            userAvatar.constraintHeight(to: 100)
            userAvatar.constraintWidth(to: 100)
        }
        userAvatar.contentMode = .scaleAspectFill
    }
    
    private func setupChangeAvatarBtn() {
        view.install(changeAvatarBtn) { _ in
            changeAvatarBtn.pinTop(to: userAvatar, .bottom, constant: 5)
            changeAvatarBtn.pinCenterX(to: userAvatar)
            changeAvatarBtn.constraintWidth(to: 100)
            changeAvatarBtn.constraintHeight(to: 20)
        }
        changeAvatarBtn.setTitle(NSLocalizedString("Change photo", comment: ""), for: .normal)
        changeAvatarBtn.addTarget(self, action: #selector(changeAvatar), for: .touchUpInside)
        changeAvatarBtn.setTitleColor(UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
        changeAvatarBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    private func setupFirstNameField() {
        view.install(firstNameField!) { _ in
            firstNameField?.pinTop(to: changeAvatarBtn, .bottom, constant: 50)
            firstNameField?.pinLeading(to: view)
            firstNameField?.pinTrailing(to: view)
            firstNameField?.constraintHeight(to: 40)
        }
    }
    
    private func setupLastNameField() {
        view.install(lastNameField!) { _ in
            lastNameField?.pinTop(to: firstNameField!, .bottom)
            lastNameField?.pinLeading(to: view)
            lastNameField?.pinTrailing(to: view)
            lastNameField?.constraintHeight(to: 40)
        }
    }
    
    private func setupEmailField() {
        view.install(emailField!) { _ in
            emailField?.pinTop(to: lastNameField!, .bottom)
            emailField?.pinLeading(to: view)
            emailField?.pinTrailing(to: view)
            emailField?.constraintHeight(to: 40)
        }
    }
    
    private func setupPhoneField() {
        view.install(phoneField!) { _ in
            phoneField?.pinTop(to: emailField!, .bottom)
            phoneField?.pinLeading(to: view)
            phoneField?.pinTrailing(to: view)
            phoneField?.constraintHeight(to: 40)
        }
    }
    
    private func configure(with user: User) {
        firstNameField = LabelWithInput(labelText: "First name", inputTextPlaceholder: user.name.first)
        lastNameField = LabelWithInput(labelText: "Last name", inputTextPlaceholder: user.name.last)
        emailField = LabelWithInput(labelText: "Email", inputTextPlaceholder: user.email)
        phoneField = LabelWithInput(labelText: "Phone", inputTextPlaceholder: user.phoneNumber)
        phoneField?.enablePhoneFormatting()
        if let avatarUrl = URL(string: user.avatar.medium) {
            userAvatar.kf.setImage(with: avatarUrl)
        } else {
            let url = URL(fileURLWithPath: user.avatar.medium)
            userAvatar.kf.setImage(with: url)
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = router?.dataStore?.user else { return }
        configure(with: user)
        setupUI()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Save user profile
    
    // Input placeholder can be used instead inputText for update only some "rows"
    @objc private func saveUserProfile() {
        let firstName = firstNameField?.inputText
        let lastName = lastNameField?.inputText
        let name = User.UserName.init(first: firstName ?? "", last: lastName ?? "")
        let avatarUrl = saveImage(image: userAvatar.image!)
        let avatar = User.UserAvatar.init(medium: avatarUrl)
        let phoneNumber = phoneField?.inputText
        let email = emailField?.inputText
        let id = router?.dataStore?.user?.userID
        let updatedUser = User(name: name, avatar: avatar, phoneNumber: phoneNumber!, email: email!, id: id!)
        do {
            try interactor?.updateUserInLocalDB(user: updatedUser)
        } catch {
            print("Unsuccessful user update")
            return
        }
        tabBarController?.selectedIndex = 1
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Change avatar
    
    @objc private func changeAvatar() {
        let alert = UIAlertController(title: "Choose photo picker", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openPhotoLibrary() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func saveImage(image: UIImage) -> String {
        let userName = firstNameField?.inputText
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(userName).png")
        let data = image.pngData()
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        return imagePath
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        userAvatar.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
