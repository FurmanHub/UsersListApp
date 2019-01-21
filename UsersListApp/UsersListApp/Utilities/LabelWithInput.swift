//
//  LabelWithInput.swift
//  UsersListApp
//
//  Created by Fedya on 1/20/19.
//  Copyright © 2019 Fedya. All rights reserved.
//

import Foundation
import UIKit

final class LabelWithInput: UIView, UITextFieldDelegate {
    private var labelText: String
    private var inputTextPlaceholder: String
    private let label = UILabel()
    private let inputField = UITextField()
    private let rowView = UIView()
    private let separator = UIView()
    var inputText: String {
        return inputField.text ?? ""
    }
    
    init(labelText: String, inputTextPlaceholder: String) {
        self.labelText = labelText
        self.inputTextPlaceholder = inputTextPlaceholder
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func enablePhoneFormatting() {
        inputField.delegate = self
        inputField.keyboardType = .phonePad
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.install(rowView) { _ in
            rowView.pinTop(to: self)
            rowView.pinLeading(to: self)
            rowView.pinTrailing(to: self)
            rowView.pinBottom(to: self)
        }
        
        self.install(label) { _ in
            label.pinCenterY(to: rowView)
            label.pinLeading(to: rowView, constant: 10)
            label.pinTrailing(to: rowView, .centerX, constant: -30)
            label.text = labelText
            label.textAlignment = .left
        }
        
        self.install(inputField) { _ in
            inputField.pinLeading(to: rowView, .centerX, constant: -30)
            inputField.pinTrailing(to: rowView, constant: -10)
            inputField.pinCenterY(to: rowView)
            inputField.placeholder = inputTextPlaceholder
            inputField.textAlignment = .right
        }
        
        self.install(separator) { _ in
            separator.pinTop(to: rowView, .bottom, constant: -0.3)
            separator.pinLeading(to: rowView)
            separator.pinTrailing(to: rowView)
            separator.constraintHeight(to: 0.3)
            separator.backgroundColor = .gray
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let length = Int(getLength(mobileNumber: textField.text!))
        if length == 15 {
            if range.length == 0 {
                return false
            }
        }
        
        if length == 3 {
            let num = self.formatNumber(mobileNumber: textField.text!)
            textField.text = NSString(format:"(%@)",num) as String
            
            if range.length > 0 {
                let index: String.Index = num.index(num.startIndex, offsetBy: 3)
                textField.text = NSString(format:"%@",num.substring(to: index)) as String
            }
        
        } else if length == 6 {
            let num = self.formatNumber(mobileNumber: textField.text!)
            let index: String.Index = num.index(num.startIndex, offsetBy: 3)
            
            textField.text = NSString(format:"(%@) %@-",num.substring(to: index), num.substring(from: index)) as String
            if range.length > 0{
                textField.text = NSString(format:"(%@) %@",num.substring(to: index), num.substring(from: index)) as String
            }
        }
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    private func formatNumber(mobileNumber: String) -> String {
        var number = mobileNumber
        number = number.replacingOccurrences(of: "(", with: "")
        number = number.replacingOccurrences(of: ")", with: "")
        number = number.replacingOccurrences(of: " ", with: "")
        number = number.replacingOccurrences(of: "-", with: "")
        number = number.replacingOccurrences(of: "+", with: "")
        
        let length = Int(number.characters.count)
        
        if length > 15 {
            let index = number.index(number.startIndex, offsetBy: 15)
            number = number.substring(to: index)
        }
        return number
    }
    
    private func getLength(mobileNumber: String) -> Int {
        var number = mobileNumber
        number = number.replacingOccurrences(of: "(", with: "")
        number = number.replacingOccurrences(of: ")", with: "")
        number = number.replacingOccurrences(of: " ", with: "")
        number = number.replacingOccurrences(of: "-", with: "")
        number = number.replacingOccurrences(of: "+", with: "")
        let length = Int(number.characters.count)
        return length
    }
}
