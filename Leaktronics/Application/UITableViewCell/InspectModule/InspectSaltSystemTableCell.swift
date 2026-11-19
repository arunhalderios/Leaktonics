//
//  InspectionSaltSystemTableCell.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 07/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton


//MARK:- Salt System

protocol SaltSystemCellProtocol {
    func didTapOnCellSaltSystem(_btnSaltSystemTag: Int)
}

class InspectionSaltSystemTableCell: UITableViewCell {
  
    @IBOutlet weak var txtSaltSystem: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    @IBOutlet weak var tblSaltHtConstraint: NSLayoutConstraint!
     
    var delegateSaltSystem: SaltSystemCellProtocol?
   
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSaltSystem.layer.borderColor = UIColor.black.cgColor
        self.txtSaltSystem.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSaltSystem.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSaltSystem.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSaltSystemDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSaltSystem?.didTapOnCellSaltSystem(_btnSaltSystemTag: radioButton.tag)
    }
}

protocol SaltSystemMaintainCellProtocol {
    func didTapOnCellSaltSystemMaintain(_btnSaltSystemTag: Int)
}

class InspectionSaltSystemMaintainTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSaltSystemMaintain: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!

    var delegateSaltSystemMaintain: SaltSystemMaintainCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSaltSystemMaintain.layer.borderColor = UIColor.black.cgColor
        self.txtSaltSystemMaintain.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSaltSystemMaintain.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSaltSystemMaintain.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSaltSystemMaintainDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSaltSystemMaintain?.didTapOnCellSaltSystemMaintain(_btnSaltSystemTag: radioButton.tag)
    }
}

protocol SaltSystemPowerCellProtocol {
    func didTapOnCellSaltSystemPower(_btnSaltSystemTag: Int)
}

class InspectionSaltSystemPowerButtonTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSaltPower: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSaltSystemPower: SaltSystemPowerCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSaltPower.layer.borderColor = UIColor.black.cgColor
        self.txtSaltPower.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSaltPower.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSaltPower.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSystemPowerDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSaltSystemPower?.didTapOnCellSaltSystemPower(_btnSaltSystemTag: radioButton.tag)
    }
}

protocol SaltSystemWorkingCellProtocol {
    func didTapOnCellSaltSystemWorking(_btnSaltSystemTag: Int)
}

class InspectionSaltSystemWorkingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSaltSystemWorking: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSaltSystemWorking: SaltSystemWorkingCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSaltSystemWorking.layer.borderColor = UIColor.black.cgColor
        self.txtSaltSystemWorking.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSaltSystemWorking.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSaltSystemWorking.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSystemWorkingDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSaltSystemWorking?.didTapOnCellSaltSystemWorking(_btnSaltSystemTag: radioButton.tag)
    }
}

protocol SaltSystemLeakCellProtocol {
    func didTapOnCellSaltSystemLeak(_btnSaltSystemTag: Int)
}

class InspectionSaltSystemVisibleLeakTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSaltVisibleLeak: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSaltSystemLeak: SaltSystemLeakCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSaltVisibleLeak.layer.borderColor = UIColor.black.cgColor
        self.txtSaltVisibleLeak.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSaltVisibleLeak.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSaltVisibleLeak.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSaltVisibleLeakDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSaltSystemLeak?.didTapOnCellSaltSystemLeak(_btnSaltSystemTag: radioButton.tag)
    }
}

protocol SaltSystemCalcificationCellProtocol {
    func didTapOnCellSaltSystemCalcification(_btnSaltSystemTag: Int)
}

class InspectionSaltSystemCalcificationTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSaltCalcification: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSaltSystemCalcification: SaltSystemCalcificationCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSaltCalcification.layer.borderColor = UIColor.black.cgColor
        self.txtSaltCalcification.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSaltCalcification.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSaltCalcification.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSaltCalcificationDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSaltSystemCalcification?.didTapOnCellSaltSystemCalcification(_btnSaltSystemTag: radioButton.tag)
    }
}

//MARK:- Water Purification

protocol WaterPurificationCellProtocol {
    func didTapOnCellWaterPurification(_btnWaterPurificationTag: Int)
}

class InspectionWaterPurificationTableCell: UITableViewCell {
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    @IBOutlet weak var txtWaterPurification: UITextView!
    
    var delegateWaterPurification: WaterPurificationCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtWaterPurification.layer.borderColor = UIColor.black.cgColor
        self.txtWaterPurification.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtWaterPurification.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtWaterPurification.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnWaterPurificationDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateWaterPurification?.didTapOnCellWaterPurification(_btnWaterPurificationTag: radioButton.tag)
    }
}

//MARK:- Self Cleaning Salt System

protocol SaltSelfCleanCellProtocol {
    func didTapOnCellSaltSelfCleaning(_btnSaltSelfCleaningTag: Int)
}

class InspectionSaltSelfCleaningTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSaltSelfClean: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    @IBOutlet weak var tblSelfCleanHeightConstraint: NSLayoutConstraint!
    
    var delegateSaltSelfClean: SaltSelfCleanCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSaltSelfClean.layer.borderColor = UIColor.black.cgColor
        self.txtSaltSelfClean.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSaltSelfClean.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSaltSelfClean.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSaltSelfCleaningDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSaltSelfClean?.didTapOnCellSaltSelfCleaning(_btnSaltSelfCleaningTag: radioButton.tag)
    }
}

protocol SaltSelfFloorHeadCellProtocol {
    func didTapOnCellSaltSelfFloorHead(_btnSaltSelfCleaningTag: Int)
}

class InspectionSelfCleanFloorHeadTableCell: UITableViewCell {
    
    @IBOutlet weak var txtCleanFloorHead: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSaltSelfFloorHead: SaltSelfFloorHeadCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtCleanFloorHead.layer.borderColor = UIColor.black.cgColor
        self.txtCleanFloorHead.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtCleanFloorHead.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtCleanFloorHead.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnCleanFloorHeadDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSaltSelfFloorHead?.didTapOnCellSaltSelfFloorHead(_btnSaltSelfCleaningTag: radioButton.tag)
    }
}

protocol SaltSelfConditionCellProtocol {
    func didTapOnCellSaltSelfCondition(_btnSaltSelfCleaningTag: Int)
}

class InspectionSelfCleanHeadConditionTableCell: UITableViewCell {
    
    @IBOutlet weak var txtCleanHeadCondition: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSaltSelfCondition: SaltSelfConditionCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtCleanHeadCondition.layer.borderColor = UIColor.black.cgColor
        self.txtCleanHeadCondition.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtCleanHeadCondition.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtCleanHeadCondition.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnCleanHeadConditionDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSaltSelfCondition?.didTapOnCellSaltSelfCondition(_btnSaltSelfCleaningTag: radioButton.tag)
    }
}

protocol SaltSelfHeadSyncCellProtocol {
    func didTapOnCellSaltSelfHeadSync(_btnSaltSelfCleaningTag: Int)
}

class InspectionSelfCleanHeadSyncTableCell: UITableViewCell {
    
    @IBOutlet weak var txtCleanHeadSync: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSaltSelfHeadSync: SaltSelfHeadSyncCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtCleanHeadSync.layer.borderColor = UIColor.black.cgColor
        self.txtCleanHeadSync.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtCleanHeadSync.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtCleanHeadSync.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnCleanHeadSyncDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSaltSelfHeadSync?.didTapOnCellSaltSelfHeadSync(_btnSaltSelfCleaningTag: radioButton.tag)
    }
}

protocol SaltSelfLatchingCellProtocol {
    func didTapOnCellSaltSelfLatching(_btnSaltSelfCleaningTag: Int)
}

class InspectionSelfCleanLatchingSafetyTableCell: UITableViewCell {
    
    @IBOutlet weak var txtCleanLatching: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSaltSelfLatching: SaltSelfLatchingCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtCleanLatching.layer.borderColor = UIColor.black.cgColor
        self.txtCleanLatching.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtCleanLatching.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtCleanLatching.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnCleanLatchingDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSaltSelfLatching?.didTapOnCellSaltSelfLatching(_btnSaltSelfCleaningTag: radioButton.tag)
    }
}

protocol SaltSelfLeakCellProtocol {
    func didTapOnCellSaltSelfLeak(_btnSaltSelfCleaningTag: Int)
}

class InspectionSelfCleanControllerLeakTableCell: UITableViewCell {
    
    @IBOutlet weak var txtCleanController: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSaltSelfLeak: SaltSelfLeakCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtCleanController.layer.borderColor = UIColor.black.cgColor
        self.txtCleanController.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtCleanController.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtCleanController.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnCleanControllerDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSaltSelfLeak?.didTapOnCellSaltSelfLeak(_btnSaltSelfCleaningTag: radioButton.tag)
    }
}
