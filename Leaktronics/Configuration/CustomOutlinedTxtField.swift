//
//  CustomOutlinedTxtField.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 06/04/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import  MaterialComponents.MaterialTextFields
import  MaterialComponents.MaterialTextFields_ColorThemer

class CustomOutlinedTxtField: UIView {

    var textFieldControllerFloating: MDCTextInputControllerOutlined!
    var textField: MDCTextField!

    @IBInspectable var placeHolder: String!
    @IBInspectable var value: String!
    @IBInspectable var primaryColor: UIColor! = .purple

    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        textField.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    open     //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpProperty()
    }
    
    func setUpProperty() {
        //Change this properties to change the propperties of text
        textField = MDCTextField(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 128))
        textField.placeholder = placeHolder
        textField.text = value
        textField.autocapitalizationType = .sentences
        textField.clearButtonMode = .never
        
        //Change this properties to change the colors of border around text
        textFieldControllerFloating = MDCTextInputControllerOutlined(textInput: textField)

        textFieldControllerFloating.activeColor = UIColor.lightGray
        textFieldControllerFloating.floatingPlaceholderActiveColor = primaryColor
        textFieldControllerFloating.normalColor = primaryColor
        textFieldControllerFloating.inlinePlaceholderColor = UIColor (red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1.0)

        //Change this font to make borderRect bigger
        if UIDevice.current.userInterfaceIdiom == .phone {
            textFieldControllerFloating.inlinePlaceholderFont = UIFont.init(name: "Roboto-Regular", size: 13)
            textFieldControllerFloating.textInputFont = UIFont.init(name: "Roboto-Regular", size: 13)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            textFieldControllerFloating.inlinePlaceholderFont = UIFont.init(name: "Roboto-Regular", size: 35)
            textFieldControllerFloating.textInputFont = UIFont.init(name: "Roboto-Regular", size: 35)
        }
        
            textFieldControllerFloating.textInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))

        self.addSubview(textField)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
