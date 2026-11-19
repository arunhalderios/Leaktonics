//
//  InspectPortableSpaTableCell.swift
//  Leaktronics
//
//  Created by ivaninfotech on 5/6/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton

//MARK:-PortableSpa
protocol PortableSpaProtocol {
    func didTapOnCellPortableSpa(_btnDescribeTag: Int)
}

class PortableSpaTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    @IBOutlet weak var tblSubVw: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    
    var delegateSpa: PortableSpaProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSpa?.didTapOnCellPortableSpa(_btnDescribeTag: radioButton.tag)
    }
}

protocol Spa0Protocol {
    func didTapOnCellSpa0(_btnDescribeTag: Int)
}

class Spa0TableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSpa0: Spa0Protocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSpa0?.didTapOnCellSpa0(_btnDescribeTag: radioButton.tag)
    }
}

protocol Spa1Protocol {
    func didTapOnCellSpa1(_btnDescribeTag: Int)
}

class Spa1TableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSpa1: Spa1Protocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSpa1?.didTapOnCellSpa1(_btnDescribeTag: radioButton.tag)
    }
}

protocol Spa2Protocol {
    func didTapOnCellSpa2(_btnDescribeTag: Int)
}

class Spa2TableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSpa2: Spa2Protocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSpa2?.didTapOnCellSpa2(_btnDescribeTag: radioButton.tag)
    }
}

protocol Spa3Protocol {
    func didTapOnCellSpa3(_btnDescribeTag: Int)
}

class Spa3TableCell: UITableViewCell {
    
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btn1: DLRadioButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var btn2: DLRadioButton!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var btn3: DLRadioButton!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var btn4: DLRadioButton!
    @IBOutlet weak var lbl4: UILabel!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSpa3: Spa3Protocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSpa3?.didTapOnCellSpa3(_btnDescribeTag: radioButton.tag)
    }
}

protocol Spa4Protocol {
    func didTapOnCellSpa4(_btnDescribeTag: Int)
}

class Spa4TableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btn1: DLRadioButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var btn2: DLRadioButton!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var btn3: DLRadioButton!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var btn4: DLRadioButton!
    @IBOutlet weak var lbl4: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSpa4: Spa4Protocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
              self.txtOther.layer.borderWidth = 0.68
              if UIDevice.current.userInterfaceIdiom == .phone {
                  self.txtOther.layer.cornerRadius = 5
              } else if UIDevice.current.userInterfaceIdiom == .pad {
                  self.txtOther.layer.cornerRadius = 10
              }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSpa4?.didTapOnCellSpa4(_btnDescribeTag: radioButton.tag)
    }
}

protocol Spa5Protocol {
    func didTapOnCellSpa5(_btnDescribeTag: Int)
}

class Spa5TableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSpa5: Spa5Protocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSpa5?.didTapOnCellSpa5(_btnDescribeTag: radioButton.tag)
    }
}

protocol Spa6Protocol {
    func didTapOnCellSpa6(_btnDescribeTag: Int)
}

class Spa6TableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btn1: DLRadioButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var btn2: DLRadioButton!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var btn3: DLRadioButton!
    @IBOutlet weak var lbl3: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSpa6: Spa6Protocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSpa6?.didTapOnCellSpa6(_btnDescribeTag: radioButton.tag)
    }
}

protocol Spa7Protocol {
    func didTapOnCellSpa7(_btnDescribeTag: Int)
}

class Spa7TableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSpa7: Spa7Protocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSpa7?.didTapOnCellSpa7(_btnDescribeTag: radioButton.tag)
    }
}

protocol Spa8Protocol {
    func didTapOnCellSpa8(_btnDescribeTag: Int)
}

class Spa8TableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSpa8: Spa8Protocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSpa8?.didTapOnCellSpa8(_btnDescribeTag: radioButton.tag)
    }
}

protocol Spa9Protocol {
    func didTapOnCellSpa9(_btnDescribeTag: Int)
}

class Spa9TableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSpa9: Spa9Protocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSpa9?.didTapOnCellSpa9(_btnDescribeTag: radioButton.tag)
    }
}

//MARK:- Equipment Area
protocol EquipRoomProtocol {
    func didTapOnCellEquipRoom(_btnDescribeTag: Int)
}

class EquipRoomTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateEquipRoom: EquipRoomProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateEquipRoom?.didTapOnCellEquipRoom(_btnDescribeTag: radioButton.tag)
    }
}

protocol EquipClearProtocol {
    func didTapOnCellEquipClear(_btnDescribeTag: Int)
}

class EquipClearTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateEquipClear: EquipClearProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateEquipClear?.didTapOnCellEquipClear(_btnDescribeTag: radioButton.tag)
    }
}

protocol EquipElementProtocol {
    func didTapOnCellEquipElement(_btnDescribeTag: Int)
}

class EquipElementTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateEquipElement: EquipElementProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateEquipElement?.didTapOnCellEquipElement(_btnDescribeTag: radioButton.tag)
    }
}

protocol EquipUvProtocol {
    func didTapOnCellEquipUv(_btnDescribeTag: Int)
}

class EquipUvTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateEquipUv: EquipUvProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateEquipUv?.didTapOnCellEquipUv(_btnDescribeTag: radioButton.tag)
    }
}
