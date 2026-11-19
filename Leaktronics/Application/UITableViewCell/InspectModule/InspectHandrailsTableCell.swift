//
//  InspectHandrailsTableCell.swift
//  Leaktronics
//
//  Created by ivaninfotech on 5/6/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton

//MARK:- Handrails

protocol HandEntranceCellProtocol {
    func didTapOnCellHandEntrance(_btnDescribeTag: Int)
}

class HandEntranceTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateHandEntrance: HandEntranceCellProtocol?
    
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
    
    @objc @IBAction private func optionsBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateHandEntrance?.didTapOnCellHandEntrance(_btnDescribeTag: radioButton.tag)
    }
}

protocol HandDeepEndCellProtocol {
    func didTapOnCellHandDeepEnd(_btnDescribeTag: Int)
}

class HandDeepEndTableCell: UITableViewCell {
    
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
    
    var delegateHandDeepEnd: HandDeepEndCellProtocol?
    
    
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
        
    @objc @IBAction private func optionsBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateHandDeepEnd?.didTapOnCellHandDeepEnd(_btnDescribeTag: radioButton.tag)
    }
}


protocol HandGrabRailsCellProtocol {
    func didTapOnCellHandGrabRails(_btnDescribeTag: Int)
}

class HandGrabRailsTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateHandGrabRails: HandGrabRailsCellProtocol?
    
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
        
    @objc @IBAction private func optionsBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateHandGrabRails?.didTapOnCellHandGrabRails(_btnDescribeTag: radioButton.tag)
    }
}

protocol HandrailsCellProtocol {
    func didTapOnCellHandrails(_btnDescribeTag: Int)
}

class HandrailsTableCell: UITableViewCell {
    
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
    
    var delegateHandrails: HandrailsCellProtocol?
    
    
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
        
    @objc @IBAction private func optionsBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateHandrails?.didTapOnCellHandrails(_btnDescribeTag: radioButton.tag)
    }
}

protocol SubRaisedWallCellProtocol {
    func didTapOnCellSubRaisedWall(_btnDescribeTag: Int)
}

class SubRaisedWallTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSubRaisedWall: SubRaisedWallCellProtocol?
    
    
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
        
    @objc @IBAction private func optionsBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSubRaisedWall?.didTapOnCellSubRaisedWall(_btnDescribeTag: radioButton.tag)
    }
}

protocol HandGrabEdgeCellProtocol {
    func didTapOnCellHandGrabEdge(_btnDescribeTag: Int)
}

class HandGrabEdgeTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateHandGrabEdge: HandGrabEdgeCellProtocol?
    
    
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
        
    @objc @IBAction private func optionsBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateHandGrabEdge?.didTapOnCellHandGrabEdge(_btnDescribeTag: radioButton.tag)
    }
}
