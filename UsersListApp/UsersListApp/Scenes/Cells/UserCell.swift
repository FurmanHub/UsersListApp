//
//  UserCell.swift
//  UsersListApp
//
//  Created by Fedya on 1/16/19.
//  Copyright © 2019 Fedya. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

final class UserCell: UITableViewCell {
    private var firstNameLabel = UILabel()
    private var lastNameLabel = UILabel()
    private var phoneNumberLabel = UILabel()
    private var userAvatar = RoundedImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        selectionStyle = .none
        setupAvatar()
        setupFirstNameLabel()
        setupLastNameLabel()
        setupPhoneNumber()
    }
    
    func configure(with user: UsersList.FetchUsers.ViewModel.DisplayedUser) {
        self.accessoryType = .disclosureIndicator
        firstNameLabel.text = user.firstName
        lastNameLabel.text = user.lastName
        phoneNumberLabel.text = user.phoneNumber
        if let avatarUrl = URL(string: user.avatarUrl) {
            userAvatar.kf.setImage(with: avatarUrl)
        } else {
            let url = URL(fileURLWithPath: user.avatarUrl)
            userAvatar.kf.setImage(with: url)
        }
    }
    
    func configure(with user: SavedUsersList.fetchSavedUsers.ViewModel.DisplayedUser) {
        self.accessoryType = .disclosureIndicator
        firstNameLabel.text = user.firstName
        lastNameLabel.text = user.lastName
        phoneNumberLabel.text = user.phoneNumber
        if let avatarUrl = URL(string: user.avatarUrl) {
            userAvatar.kf.setImage(with: avatarUrl)
        } else {
            let url = URL(fileURLWithPath: user.avatarUrl)
            userAvatar.kf.setImage(with: url)
        }
    }
    
    private func setupAvatar() {
        contentView.install(userAvatar) { _ in
            userAvatar.pinCenterY(to: contentView)
            userAvatar.pinLeading(to: contentView, constant: 10)
            userAvatar.constraintWidth(to: 40)
            userAvatar.constraintHeight(to: 40)
        }
        userAvatar.contentMode = .scaleAspectFill
    }
    
    private func setupFirstNameLabel() {
        firstNameLabel.textColor = .black
        contentView.install(firstNameLabel) { _ in
            firstNameLabel.pinCenterY(to: userAvatar, constant: -10)
            firstNameLabel.pinLeading(to: userAvatar, .trailing, constant: 10)
        }
    }
    
    private func setupLastNameLabel() {
        lastNameLabel.textColor = .black
        contentView.install(lastNameLabel) { _ in
            lastNameLabel.pinLeading(to: firstNameLabel, .trailing, constant: 5)
            lastNameLabel.pinCenterY(to: firstNameLabel)
        }
    }
    
    private func setupPhoneNumber() {
        contentView.install(phoneNumberLabel) { _ in
            phoneNumberLabel.pinTop(to: firstNameLabel, .bottom, constant: 5)
            phoneNumberLabel.pinLeading(to: firstNameLabel)
        }
        phoneNumberLabel.textColor = .lightGray
    }
}
