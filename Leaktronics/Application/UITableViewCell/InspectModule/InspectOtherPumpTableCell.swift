//
//  InspectionOtherPumpTableCell.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 07/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton

//MARK:- Other Pump
protocol OtherPumpCellProtocol {
    func didTapOnCellOtherPump(_btnOtherPumpTag: Int)
}

class InspectionOtherPumpTableCell: UITableViewCell{
    
    @IBOutlet weak var txtOtherPumps: UITextView!
    @IBOutlet weak var tblOtherPumpHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPump: OtherPumpCellProtocol?
       
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOtherPumps.layer.borderColor = UIColor.black.cgColor
        self.txtOtherPumps.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOtherPumps.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOtherPumps.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnOtherPumpDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
               print(String(format: "%@ is selected.\n", button));
           }
        } else {
               print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPump?.didTapOnCellOtherPump(_btnOtherPumpTag: radioButton.tag)
    }
}

class InspectionOtherPumpTypesTableCell: UITableViewCell {
    
    @IBOutlet weak var txtOtherPumpTypes: UITextView!
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOtherPumpTypes.layer.borderColor = UIColor.black.cgColor
        self.txtOtherPumpTypes.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOtherPumpTypes.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOtherPumpTypes.layer.cornerRadius = 10
        }
    }
}

protocol OtherPumpOperateCellProtocol {
    func didTapOnCellOtherPumpOperate(_btnOtherPumpTag: Int)
}

class InspectionOtherPumpOperatingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtPumpOperating: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherOperatePump: OtherPumpOperateCellProtocol?
       
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtPumpOperating.layer.borderColor = UIColor.black.cgColor
        self.txtPumpOperating.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPumpOperating.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPumpOperating.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPumpOperatingDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherOperatePump?.didTapOnCellOtherPumpOperate(_btnOtherPumpTag: radioButton.tag)
    }
}

protocol OtherPumpMaintainCellProtocol {
    func didTapOnCellOtherPumpMaintain(_btnOtherPumpTag: Int)
}

class InspectionOtherPumpMaintainanceAccessTableCell: UITableViewCell {
    
    @IBOutlet weak var txtPumpMaintenance: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpMaintain: OtherPumpMaintainCellProtocol?
       
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtPumpMaintenance.layer.borderColor = UIColor.black.cgColor
        self.txtPumpMaintenance.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPumpMaintenance.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPumpMaintenance.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPumpMaintenanceDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpMaintain?.didTapOnCellOtherPumpMaintain(_btnOtherPumpTag: radioButton.tag)
    }
}

protocol OtherPumpRightSizeCellProtocol {
    func didTapOnCellOtherPumpRightSize(_btnOtherPumpTag: Int)
}

class InspectionOtherPumpRightSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var txtPumpRightSize: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpRightSize: OtherPumpRightSizeCellProtocol?
       
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtPumpRightSize.layer.borderColor = UIColor.black.cgColor
        self.txtPumpRightSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPumpRightSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPumpRightSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPumpRightSizeDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpRightSize?.didTapOnCellOtherPumpRightSize(_btnOtherPumpTag: radioButton.tag)
    }
}

protocol OtherPumpMountedCellProtocol {
    func didTapOnCellOtherPumpMounted(_btnOtherPumpTag: Int)
}

class InspectionOtherPumpMountedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtPumpMounted: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpMounted: OtherPumpMountedCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtPumpMounted.layer.borderColor = UIColor.black.cgColor
        self.txtPumpMounted.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPumpMounted.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPumpMounted.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPumpMountedDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpMounted?.didTapOnCellOtherPumpMounted(_btnOtherPumpTag: radioButton.tag)
    }
}

protocol OtherPumpVisibleLeakCellProtocol {
    func didTapOnCellOtherPumpVisibleLeak(_btnOtherPumpTag: Int)
}

class InspectionOtherPumpVisibleLeakTableCell: UITableViewCell {
    
    @IBOutlet weak var txtPumpVisibleLeak: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpVisibleLeak: OtherPumpVisibleLeakCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtPumpVisibleLeak.layer.borderColor = UIColor.black.cgColor
        self.txtPumpVisibleLeak.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPumpVisibleLeak.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPumpVisibleLeak.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPumpVisibleLeakDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpVisibleLeak?.didTapOnCellOtherPumpVisibleLeak(_btnOtherPumpTag: radioButton.tag)
    }
}

protocol OtherPumpGasketsCellProtocol {
    func didTapOnCellOtherPumpGaskets(_btnOtherPumpTag: Int)
}

class InspectionOtherPumpGasketsTableCell: UITableViewCell {
    
    @IBOutlet weak var txtPumpGaskets: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpGaskets: OtherPumpGasketsCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtPumpGaskets.layer.borderColor = UIColor.black.cgColor
        self.txtPumpGaskets.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPumpGaskets.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPumpGaskets.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPumpGasketsDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpGaskets?.didTapOnCellOtherPumpGaskets(_btnOtherPumpTag: radioButton.tag)
    }
}

protocol OtherPumpPlumbingCellProtocol {
    func didTapOnCellOtherPumpPlumbing(_btnOtherPumpTag: Int)
}

class InspectionOtherPumpPlumbingPresentTableCell: UITableViewCell {
    
    @IBOutlet weak var txtPlumbingPresent: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpPlumbing: OtherPumpPlumbingCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtPlumbingPresent.layer.borderColor = UIColor.black.cgColor
        self.txtPlumbingPresent.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPlumbingPresent.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPlumbingPresent.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPlumbingPresentDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpPlumbing?.didTapOnCellOtherPumpPlumbing(_btnOtherPumpTag: radioButton.tag)
    }
}

protocol OtherPumpEquipmentRunCellProtocol {
    func didTapOnCellOtherPumpEquipmentRun(_btnOtherPumpTag: Int)
}

class InspectionOtherPumpEquipmentRunTableCell: UITableViewCell {
    
    @IBOutlet weak var txtEquipmentRun: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpEquipmentRun: OtherPumpEquipmentRunCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtEquipmentRun.layer.borderColor = UIColor.black.cgColor
        self.txtEquipmentRun.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtEquipmentRun.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtEquipmentRun.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnEquipmentRunDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpEquipmentRun?.didTapOnCellOtherPumpEquipmentRun(_btnOtherPumpTag: radioButton.tag)
    }
}


//MARK:- Blower

protocol OtherPumpBlowerCellProtocol {
    func didTapOnCellOtherPumpBlower(_btnOtherPumpBlowerTag: Int)
}

class InspectionOtherPumpBlowerTableCell: UITableViewCell {
    
    @IBOutlet weak var txtOtherPumpsBlower: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    @IBOutlet weak var tblOtherPumpBlowerHeightConstraint: NSLayoutConstraint!
     
    var delegateOtherPumpBlower: OtherPumpBlowerCellProtocol?
      
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtOtherPumpsBlower.layer.borderColor = UIColor.black.cgColor
        self.txtOtherPumpsBlower.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOtherPumpsBlower.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOtherPumpsBlower.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnOtherPumpBlowerDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
               print(String(format: "%@ is selected.\n", button));
           }
        } else {
               print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpBlower?.didTapOnCellOtherPumpBlower(_btnOtherPumpBlowerTag: radioButton.tag)
    }
}

protocol OtherPumpBlowerRepairCellProtocol {
    func didTapOnCellOtherPumpBlowerRepair(_btnOtherPumpBlowerTag: Int)
}

class InspectionOtherPumpBlowerRepairTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBlowerRepair: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpBlowerRepair: OtherPumpBlowerRepairCellProtocol?
      
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBlowerRepair.layer.borderColor = UIColor.black.cgColor
        self.txtBlowerRepair.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBlowerRepair.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBlowerRepair.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBlowerRepairDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpBlowerRepair?.didTapOnCellOtherPumpBlowerRepair(_btnOtherPumpBlowerTag: radioButton.tag)
    }
}

protocol OtherPumpBlowerBondingCellProtocol {
    func didTapOnCellOtherPumpBlowerBonding(_btnOtherPumpBlowerTag: Int)
}

class InspectionOtherPumpBlowerBondingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBlowerBonding: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpBlowerBonding: OtherPumpBlowerBondingCellProtocol?
      
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBlowerBonding.layer.borderColor = UIColor.black.cgColor
        self.txtBlowerBonding.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBlowerBonding.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBlowerBonding.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBlowerBondingDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpBlowerBonding?.didTapOnCellOtherPumpBlowerBonding(_btnOtherPumpBlowerTag: radioButton.tag)
    }
}

protocol OtherPumpBlowerAdequateCellProtocol {
    func didTapOnCellOtherPumpBlowerAdequate(_btnOtherPumpBlowerTag: Int)
}

class InspectionOtherPumpBlowerAdequateSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBlowerAdequateSize: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpBlowerAdequate: OtherPumpBlowerAdequateCellProtocol?
      
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBlowerAdequateSize.layer.borderColor = UIColor.black.cgColor
        self.txtBlowerAdequateSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBlowerAdequateSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBlowerAdequateSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBlowerAdequateSizeDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpBlowerAdequate?.didTapOnCellOtherPumpBlowerAdequate(_btnOtherPumpBlowerTag: radioButton.tag)
    }
}

protocol OtherPumpBlowerMountedCellProtocol {
    func didTapOnCellOtherPumpBlowerMounted(_btnOtherPumpBlowerTag: Int)
}

class InspectionOtherPumpBlowerMountedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBlowerMounted: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpBlowerMounted: OtherPumpBlowerMountedCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBlowerMounted.layer.borderColor = UIColor.black.cgColor
        self.txtBlowerMounted.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBlowerMounted.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBlowerMounted.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBlowerMountedDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpBlowerMounted?.didTapOnCellOtherPumpBlowerMounted(_btnOtherPumpBlowerTag: radioButton.tag)
    }
}

protocol OtherPumpBlowerStrappedCellProtocol {
    func didTapOnCellOtherPumpBlowerStrapped(_btnOtherPumpBlowerTag: Int)
}

class InspectionOtherPumpBlowerStrappedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBlowerStrapped: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpBlowerStrapped: OtherPumpBlowerStrappedCellProtocol?
      
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBlowerStrapped.layer.borderColor = UIColor.black.cgColor
        self.txtBlowerStrapped.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBlowerStrapped.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBlowerStrapped.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBlowerStrappedDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpBlowerStrapped?.didTapOnCellOtherPumpBlowerStrapped(_btnOtherPumpBlowerTag: radioButton.tag)
    }
}

protocol OtherPumpBlowerValveCellProtocol {
    func didTapOnCellOtherPumpBlowerValve(_btnOtherPumpBlowerTag: Int)
}

class InspectionOtherPumpBlowerValveTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBlowerValve: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpBlowerValve: OtherPumpBlowerValveCellProtocol?
      
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBlowerValve.layer.borderColor = UIColor.black.cgColor
        self.txtBlowerValve.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBlowerValve.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBlowerValve.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBlowerValveDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpBlowerValve?.didTapOnCellOtherPumpBlowerValve(_btnOtherPumpBlowerTag: radioButton.tag)
    }
}

protocol OtherPumpBlowerQuietCellProtocol {
    func didTapOnCellOtherPumpBlowerQuiet(_btnOtherPumpBlowerTag: Int)
}

class InspectionOtherPumpBlowerQuietTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBlowerQuiet: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateOtherPumpBlowerQuiet: OtherPumpBlowerQuietCellProtocol?
      
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBlowerQuiet.layer.borderColor = UIColor.black.cgColor
        self.txtBlowerQuiet.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBlowerQuiet.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBlowerQuiet.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBlowerQuietDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateOtherPumpBlowerQuiet?.didTapOnCellOtherPumpBlowerQuiet (_btnOtherPumpBlowerTag: radioButton.tag)
    }
}


