//
//  InspectionAutofillTableCell.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 06/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton

//MARK:- AutoFill
protocol AutofillCellProtocol {
    func didTapOnCellAutofill(_btnAutofillTag: Int)
}

class InspectionAutofillTableCell: UITableViewCell {
    
    @IBOutlet weak var btnYesAutofill: DLRadioButton!
    
    @IBOutlet weak var tblAutofillHeightConstraint: NSLayoutConstraint!
    
    var delegateAutofill: AutofillCellProtocol?
    
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func btnInspectionAutofillDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateAutofill?.didTapOnCellAutofill(_btnAutofillTag: radioButton.tag)
    }
}


protocol AutoModeCellProtocol {
    func didTapOnCellAutoMode(_btnAutofillTag: Int)
}

class AutofillModeTableCell: UITableViewCell {
    
    var delegateAutoMode: AutoModeCellProtocol?
    
    @IBAction func btnAutofillModeDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateAutoMode?.didTapOnCellAutoMode(_btnAutofillTag: radioButton.tag)
    }
}

protocol AutoWaterCellProtocol {
    func didTapOnCellAutoWater(_btnAutofillTag: Int)
}

class AutofillAboveWaterlineTableCell: UITableViewCell {
    
    @IBOutlet weak var txtAutofillWaterline: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateAutoWater: AutoWaterCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtAutofillWaterline.layer.borderColor = UIColor.black.cgColor
        self.txtAutofillWaterline.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtAutofillWaterline.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtAutofillWaterline.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnAutofillWaterlineDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateAutoWater?.didTapOnCellAutoWater(_btnAutofillTag: radioButton.tag)
    }
}

protocol AutoLeakCellProtocol {
    func didTapOnCellAutoLeak(_btnAutofillTag: Int)
}

class AutofillLeakFreeTableCell: UITableViewCell {
    
    @IBOutlet weak var txtAutofillLeakFree: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateAutoLeak: AutoLeakCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtAutofillLeakFree.layer.borderColor = UIColor.black.cgColor
        self.txtAutofillLeakFree.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtAutofillLeakFree.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtAutofillLeakFree.layer.cornerRadius = 10
        }
    }

    @IBAction func btnAutofillLeakFreeDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateAutoLeak?.didTapOnCellAutoLeak(_btnAutofillTag: radioButton.tag)
    }
}

protocol AutoShutOutCellProtocol {
    func didTapOnCellAutoShutOut(_btnAutofillTag: Int)
}

class AutofillProperShutoutTableCell: UITableViewCell {
    
    @IBOutlet weak var txtAutofillShutout: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateAutoShutOut: AutoShutOutCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtAutofillShutout.layer.borderColor = UIColor.black.cgColor
        self.txtAutofillShutout.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtAutofillShutout.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtAutofillShutout.layer.cornerRadius = 10
        }
    }

    @IBAction func btnAutofillShutoutDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateAutoShutOut?.didTapOnCellAutoShutOut(_btnAutofillTag: radioButton.tag)
    }
}

protocol AutoBackCellProtocol {
    func didTapOnCellAutoBack(_btnAutofillTag: Int)
}

class AutofillBackflowTableCell: UITableViewCell {
    
    @IBOutlet weak var txtAutofillBackflow: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateAutoBack: AutoBackCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtAutofillBackflow.layer.borderColor = UIColor.black.cgColor
        self.txtAutofillBackflow.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtAutofillBackflow.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtAutofillBackflow.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnAutofillBackflowDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateAutoBack?.didTapOnCellAutoBack(_btnAutofillTag: radioButton.tag)
    }
}

protocol AutoMainAccessCellProtocol {
    func didTapOnCellAutoMainAccess(_btnAutofillTag: Int)
}

class AutofillMaintainanceAccessibleTableCell: UITableViewCell {
    
    @IBOutlet weak var txtAutofillMaintenance: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateAutoMainAccess: AutoMainAccessCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtAutofillMaintenance.layer.borderColor = UIColor.black.cgColor
        self.txtAutofillMaintenance.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtAutofillMaintenance.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtAutofillMaintenance.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnAutofillMaintenanceDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateAutoMainAccess?.didTapOnCellAutoMainAccess(_btnAutofillTag: radioButton.tag)
    }
}

protocol AutoExposedCellProtocol {
    func didTapOnCellAutoExposed(_btnAutofillTag: Int)
}

class AutofillExposedPlumbingLeakTableCell: UITableViewCell {
    
    @IBOutlet weak var txtAutofillExposedLeak: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateAutoExposed: AutoExposedCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtAutofillExposedLeak.layer.borderColor = UIColor.black.cgColor
        self.txtAutofillExposedLeak.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtAutofillExposedLeak.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtAutofillExposedLeak.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnAutofillExposedLeakDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateAutoExposed?.didTapOnCellAutoExposed(_btnAutofillTag: radioButton.tag)
    }
}

protocol AutoMountedCellProtocol {
    func didTapOnCellAutoMounted(_btnAutofillTag: Int)
}

class AutofillOverflowMountedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtAutofillMounted: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateAutoMounted: AutoMountedCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtAutofillMounted.layer.borderColor = UIColor.black.cgColor
        self.txtAutofillMounted.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtAutofillMounted.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtAutofillMounted.layer.cornerRadius = 10
        }
    }

    @IBAction func btnAutofillMountedDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateAutoMounted?.didTapOnCellAutoMounted(_btnAutofillTag: radioButton.tag)
    }
}

protocol AutoValveCellProtocol {
    func didTapOnCellAutoValve(_btnAutofillTag: Int)
}

class AutofillValveAdjustmentTableCell: UITableViewCell {
    
    @IBOutlet weak var txtAutofillValveAdjust: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateAutoValve: AutoValveCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtAutofillValveAdjust.layer.borderColor = UIColor.black.cgColor
        self.txtAutofillValveAdjust.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtAutofillValveAdjust.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtAutofillValveAdjust.layer.cornerRadius = 10
        }
    }

    @IBAction func btnAutofillValveAdjustDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateAutoValve?.didTapOnCellAutoValve(_btnAutofillTag: radioButton.tag)
    }
}


//MARK:- Overflow
protocol OverflowCellProtocol {
    func didTapOnCellOverflow(_btnOverflowTag: Int)
}

class InspectionOverflowTableCell: UITableViewCell {
    
    @IBOutlet weak var btnYesOverflow: DLRadioButton!
    @IBOutlet weak var txtOverflow: UITextView!
    @IBOutlet weak var tblOverflowHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOverflow: OverflowCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOverflow.layer.borderColor = UIColor.black.cgColor
        self.txtOverflow.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOverflow.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOverflow.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnOverflowOptionDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                   print(String(format: "%@ is selected.\n", button));
            }
        } else {
               print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOverflow?.didTapOnCellOverflow(_btnOverflowTag: radioButton.tag)
    }
}

protocol OverflowPlumbedCellProtocol {
    func didTapOnCellOverflowPlumbed(_btnOverflowTag: Int)
}

class OverflowPlumbedProperlyTableCell: UITableViewCell {
    
    @IBOutlet weak var txtOverflowPlumbed: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOverflowPlumbed: OverflowPlumbedCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOverflowPlumbed.layer.borderColor = UIColor.black.cgColor
        self.txtOverflowPlumbed.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOverflowPlumbed.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOverflowPlumbed.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnOverflowPlumbedDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOverflowPlumbed?.didTapOnCellOverflowPlumbed(_btnOverflowTag: radioButton.tag)
    }
}

protocol OverflowHeightCellProtocol {
    func didTapOnCellOverflowHeight(_btnOverflowTag: Int)
}

class OverflowMountedHeightTableCell: UITableViewCell {
    
    @IBOutlet weak var txtOverflowMountedHeight: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOverflowHeight: OverflowHeightCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOverflowMountedHeight.layer.borderColor = UIColor.black.cgColor
        self.txtOverflowMountedHeight.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOverflowMountedHeight.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOverflowMountedHeight.layer.cornerRadius = 10
        }
    }

    @IBAction func btnOverflowMountedHeightDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOverflowHeight?.didTapOnCellOverflowHeight(_btnOverflowTag: radioButton.tag)
    }
}
