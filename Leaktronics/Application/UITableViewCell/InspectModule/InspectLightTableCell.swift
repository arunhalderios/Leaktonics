//
//  InspectionLightTableCell.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 08/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton

//MARK:- Light
protocol LightWorkingProtocol {
    func didTapOnCellLightWorking(_btnLightTag: Int)
}

class InspectionPoolLightWorkingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtLightWork: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateLightWorking: LightWorkingProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtLightWork.layer.borderColor = UIColor.black.cgColor
        self.txtLightWork.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtLightWork.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtLightWork.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnLightWorkDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateLightWorking?.didTapOnCellLightWorking(_btnLightTag: radioButton.tag)
    }
}

protocol LightLowVoltageProtocol {
    func didTapOnCellLightLowVoltage(_btnLightTag: Int)
}

class InspectionLowVoltageTableCell: UITableViewCell {
    
    @IBOutlet weak var txtLowVoltage: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateLightLowVoltage: LightLowVoltageProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtLowVoltage.layer.borderColor = UIColor.black.cgColor
        self.txtLowVoltage.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtLowVoltage.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtLowVoltage.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnLowVoltageDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateLightLowVoltage?.didTapOnCellLightLowVoltage(_btnLightTag: radioButton.tag)
    }
}

protocol LightFiberOpticProtocol {
    func didTapOnCellLightFiberOptic(_btnLightTag: Int)
}

class InspectionFiberOpticLightingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtFiberLightning: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateLightFiberOptic: LightFiberOpticProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtFiberLightning.layer.borderColor = UIColor.black.cgColor
        self.txtFiberLightning.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtFiberLightning.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtFiberLightning.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnFiberLightningDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateLightFiberOptic?.didTapOnCellLightFiberOptic(_btnLightTag: radioButton.tag)
    }
    
}

protocol LightFiberOpticWorkingProtocol {
    func didTapOnCellLightFiberOpticWorking(_btnLightTag: Int)
}

class InspectionFiberOpticWorkingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtFiberWorking: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateLightFiberOpticWorking: LightFiberOpticWorkingProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtFiberWorking.layer.borderColor = UIColor.black.cgColor
        self.txtFiberWorking.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtFiberWorking.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtFiberWorking.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnFiberWorkingDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateLightFiberOpticWorking?.didTapOnCellLightFiberOpticWorking(_btnLightTag: radioButton.tag)
    }
}

protocol MultiLightSynchProtocol {
    func didTapOnCellMultiLightSynch(_btnLightTag: Int)
}

class InspectionMultiLightSynchTableCell: UITableViewCell {
    
    @IBOutlet weak var txtMultiSynch: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateMultiLightSynch: MultiLightSynchProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtMultiSynch.layer.borderColor = UIColor.black.cgColor
        self.txtMultiSynch.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtMultiSynch.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtMultiSynch.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnMultiLightSynchDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateMultiLightSynch?.didTapOnCellMultiLightSynch(_btnLightTag: radioButton.tag)
    }
}

protocol SpaLightWorkingProtocol {
    func didTapOnCellSpaLightWorking(_btnLightTag: Int)
}

class InspectionSpaLightWorkingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSpaLight: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSpaLightWorking: SpaLightWorkingProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSpaLight.layer.borderColor = UIColor.black.cgColor
        self.txtSpaLight.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSpaLight.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSpaLight.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSpaLightDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSpaLightWorking?.didTapOnCellSpaLightWorking(_btnLightTag: radioButton.tag)
    }
}

protocol BasinLightProtocol {
    func didTapOnCellBasinLight(_btnLightTag: Int)
}

class InspectionBasinLightWorkingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBasinLight: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateBasinLight: BasinLightProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBasinLight.layer.borderColor = UIColor.black.cgColor
        self.txtBasinLight.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBasinLight.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBasinLight.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBasinLightDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateBasinLight?.didTapOnCellBasinLight(_btnLightTag: radioButton.tag)
    }
}

protocol LightFreeWaterProtocol {
    func didTapOnCellLightFreeWater(_btnLightTag: Int)
}

class InspectionLightFreeWaterTableCell: UITableViewCell {
    
    @IBOutlet weak var txtFreeWater: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateLightFreeWater: LightFreeWaterProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtFreeWater.layer.borderColor = UIColor.black.cgColor
        self.txtFreeWater.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtFreeWater.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtFreeWater.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnFreeWaterDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateLightFreeWater?.didTapOnCellLightFreeWater(_btnLightTag: radioButton.tag)
    }
}

protocol LightMountedProtocol {
    func didTapOnCellLightMounted(_btnLightTag: Int)
}

class InspectionAllLightMountedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtLightMounted: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateLightMounted: LightMountedProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtLightMounted.layer.borderColor = UIColor.black.cgColor
        self.txtLightMounted.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtLightMounted.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtLightMounted.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnLightMountedDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateLightMounted?.didTapOnCellLightMounted(_btnLightTag: radioButton.tag)
    }
}

protocol ProperGFIProtocol {
    func didTapOnCellProperGFI(_btnLightTag: Int)
}

class InspectionProperGFITableCell: UITableViewCell {
    
    @IBOutlet weak var txtProperGFI: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateProperGFI: ProperGFIProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtProperGFI.layer.borderColor = UIColor.black.cgColor
        self.txtProperGFI.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtProperGFI.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtProperGFI.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnProperGFIDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateProperGFI?.didTapOnCellProperGFI(_btnLightTag: radioButton.tag)
    }
}

protocol GFITrippedProtocol {
    func didTapOnCellGFITripped(_btnLightTag: Int)
}

class InspectionGFITrippedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtGFITripped: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateGFITripped: GFITrippedProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtGFITripped.layer.borderColor = UIColor.black.cgColor
        self.txtGFITripped.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtGFITripped.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtGFITripped.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnGFITrippedDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateGFITripped?.didTapOnCellGFITripped(_btnLightTag: radioButton.tag)
    }
}

//MARK:- Electrical Safety

protocol ElectricalSafetyProtocol {
    func didTapOnCellElectricalSafety(_btnLightTag: Int)
}

class InspectionElectricalSafetyAroundPoolTableCell: UITableViewCell {
    
    @IBOutlet weak var txtPoolSafety: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateElectricalSafety: ElectricalSafetyProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtPoolSafety.layer.borderColor = UIColor.black.cgColor
        self.txtPoolSafety.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPoolSafety.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPoolSafety.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPoolSafetyDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateElectricalSafety?.didTapOnCellElectricalSafety(_btnLightTag: radioButton.tag)
    }
}

protocol ElectricalExposedProtocol {
    func didTapOnCellElectricalExposed(_btnLightTag: Int)
}

class InspectionElectricalExposedWiringTableCell: UITableViewCell {
    
    @IBOutlet weak var txtExposeWiring: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateElectricalExposed: ElectricalExposedProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtExposeWiring.layer.borderColor = UIColor.black.cgColor
        self.txtExposeWiring.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtExposeWiring.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtExposeWiring.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnExposeWiringDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateElectricalExposed?.didTapOnCellElectricalExposed(_btnLightTag: radioButton.tag)
    }
}

protocol DisconnectedAccessoriesProtocol {
    func didTapOnCellDisconnectedAccessories(_btnLightTag: Int)
}

class InspectionDisconnectedAccessoriesTableCell: UITableViewCell {
    
    @IBOutlet weak var txtDisconnectedAccessories: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateDisconnectedAccessories: DisconnectedAccessoriesProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtDisconnectedAccessories.layer.borderColor = UIColor.black.cgColor
        self.txtDisconnectedAccessories.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtDisconnectedAccessories.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtDisconnectedAccessories.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnDisconnectedAccessoriesDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateDisconnectedAccessories?.didTapOnCellDisconnectedAccessories(_btnLightTag: radioButton.tag)
    }
}

protocol ElectricalEquipmentProtocol {
    func didTapOnCellElectricalEquipment(_btnLightTag: Int)
}

class InspectionElectricalEquipmentBondTableCell: UITableViewCell {
    
    @IBOutlet weak var txtEquipmentBond: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateElectricalEquipment: ElectricalEquipmentProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtEquipmentBond.layer.borderColor = UIColor.black.cgColor
        self.txtEquipmentBond.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtEquipmentBond.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtEquipmentBond.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnEquipmentBondDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateElectricalEquipment?.didTapOnCellElectricalEquipment(_btnLightTag: radioButton.tag)
    }
}

protocol ElectricalProperGFIProtocol {
    func didTapOnCellElectricalProperGFI(_btnLightTag: Int)
}

class InspectionElectricalProperGFITableCell: UITableViewCell {
    
    @IBOutlet weak var txtProperGFI: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateElectricalProperGFI: ElectricalProperGFIProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtProperGFI.layer.borderColor = UIColor.black.cgColor
        self.txtProperGFI.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtProperGFI.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtProperGFI.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnProperGFIDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateElectricalProperGFI?.didTapOnCellElectricalProperGFI(_btnLightTag: radioButton.tag)
    }
}

protocol ElectricalGFITrippedProtocol {
    func didTapOnCellElectricalGFITripped(_btnLightTag: Int)
}

class InspectionElectricalGFITrippedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtGFITripped: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateElectricalGFITripped: ElectricalGFITrippedProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtGFITripped.layer.borderColor = UIColor.black.cgColor
        self.txtGFITripped.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtGFITripped.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtGFITripped.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnGFITrippedDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateElectricalGFITripped?.didTapOnCellElectricalGFITripped(_btnLightTag: radioButton.tag)
    }
}

protocol ElectricalWireHangingProtocol {
    func didTapOnCellElectricalWireHanging(_btnLightTag: Int)
}

class InspectionElectricalWireHangingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtWireHiring: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateElectricalWireHanging: ElectricalWireHangingProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtWireHiring.layer.borderColor = UIColor.black.cgColor
        self.txtWireHiring.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtWireHiring.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtWireHiring.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnWireHiringDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateElectricalWireHanging?.didTapOnCellElectricalWireHanging(_btnLightTag: radioButton.tag)
    }
}

protocol ElectricalBoxesMountedProtocol {
    func didTapOnCellElectricalBoxesMounted(_btnLightTag: Int)
}

class InspectionElectricalBoxesMountedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBoxMounted: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateElectricalBoxesMounted: ElectricalBoxesMountedProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBoxMounted.layer.borderColor = UIColor.black.cgColor
        self.txtBoxMounted.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBoxMounted.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBoxMounted.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBoxMountedDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateElectricalBoxesMounted?.didTapOnCellElectricalBoxesMounted(_btnLightTag: radioButton.tag)
    }
}
