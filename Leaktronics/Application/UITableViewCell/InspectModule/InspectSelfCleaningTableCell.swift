//
//  InspectionSelfCleaningTableCell.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 07/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton

//MARK:- Self Cleaning

protocol SelfCleanPumpCellProtocol {
    func didTapOnCellSelfClean(_btnSelfCleanTag: Int)
}

class InspectionSelfCleaningTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSelfClean: UITextView!
    @IBOutlet weak var tblSelfCleanHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSelfCleanPump: SelfCleanPumpCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSelfClean.layer.borderColor = UIColor.black.cgColor
        self.txtSelfClean.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSelfClean.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSelfClean.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSelfCleaningDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSelfCleanPump?.didTapOnCellSelfClean(_btnSelfCleanTag: radioButton.tag)
    }
}

protocol SelfCleanOperateCellProtocol {
    func didTapOnCellSelfCleanOperate(_btnSelfCleanTag: Int)
}

class SelfCleanPumpOperatingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtPumpOperating: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSelfCleanOperate: SelfCleanOperateCellProtocol?
    
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
    
    @IBAction func btnPumpOperatingDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSelfCleanOperate?.didTapOnCellSelfCleanOperate(_btnSelfCleanTag: radioButton.tag)
    }
}

protocol SelfCleanMaintainCellProtocol {
    func didTapOnCellSelfCleanMaintain(_btnSelfCleanTag: Int)
}

class SelfCleanMaintaianceAccessTableCell: UITableViewCell {
    
    @IBOutlet weak var txtCleanMaintenance: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSelfCleanMaintain: SelfCleanMaintainCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtCleanMaintenance.layer.borderColor = UIColor.black.cgColor
        self.txtCleanMaintenance.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtCleanMaintenance.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtCleanMaintenance.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnCleanMaintenanceDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSelfCleanMaintain?.didTapOnCellSelfCleanMaintain(_btnSelfCleanTag: radioButton.tag)
    }
}

protocol SelfCleanAdequateSizeCellProtocol {
    func didTapOnCellSelfCleanAdequateSize(_btnSelfCleanTag: Int)
}

class SelfCleanAdequateSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var txtAdequateSize: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSelfCleanAdequateSize: SelfCleanAdequateSizeCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtAdequateSize.layer.borderColor = UIColor.black.cgColor
        self.txtAdequateSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtAdequateSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtAdequateSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnAdequateSizeDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSelfCleanAdequateSize?.didTapOnCellSelfCleanAdequateSize(_btnSelfCleanTag: radioButton.tag)
    }
}

protocol SelfCleanMountedCellProtocol {
    func didTapOnCellSelfCleanMounted(_btnSelfCleanTag: Int)
}

class SelfCleanMountedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtCleanMounted: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSelfCleanMounted: SelfCleanMountedCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtCleanMounted.layer.borderColor = UIColor.black.cgColor
        self.txtCleanMounted.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtCleanMounted.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtCleanMounted.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnCleanMountedDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSelfCleanMounted?.didTapOnCellSelfCleanMounted(_btnSelfCleanTag: radioButton.tag)
    }
}

protocol SelfCleanVisibleLeakCellProtocol {
    func didTapOnCellSelfCleanVisibleLeak(_btnSelfCleanTag: Int)
}

class SelfCleanVisibleLeakTableCell: UITableViewCell {
    
    @IBOutlet weak var txtCleanVisibleLeak: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSelfCleanVisibleLeak: SelfCleanVisibleLeakCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtCleanVisibleLeak.layer.borderColor = UIColor.black.cgColor
        self.txtCleanVisibleLeak.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtCleanVisibleLeak.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtCleanVisibleLeak.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnCleanVisibleLeakDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSelfCleanVisibleLeak?.didTapOnCellSelfCleanVisibleLeak(_btnSelfCleanTag: radioButton.tag)
    }
}

protocol SelfCleanGasketsCellProtocol {
    func didTapOnCellSelfCleanGaskets(_btnSelfCleanTag: Int)
}

class SelfCleanGasketsTableCell: UITableViewCell {
    
    @IBOutlet weak var txtCleanGaskets: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSelfCleanGaskets: SelfCleanGasketsCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtCleanGaskets.layer.borderColor = UIColor.black.cgColor
        self.txtCleanGaskets.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtCleanGaskets.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtCleanGaskets.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnCleanGasketsDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSelfCleanGaskets?.didTapOnCellSelfCleanGaskets(_btnSelfCleanTag: radioButton.tag)
    }
}

protocol SelfCleanVisibleAdequateSizeCellProtocol {
    func didTapOnCellSelfCleanVisibleAdequateSize(_btnSelfCleanTag: Int)
}

class SelfCleanVisibleAdequateSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var txtCleanVisibleAdequateSize: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSelfCleanVisibleAdequateSize: SelfCleanVisibleAdequateSizeCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtCleanVisibleAdequateSize.layer.borderColor = UIColor.black.cgColor
        self.txtCleanVisibleAdequateSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtCleanVisibleAdequateSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtCleanVisibleAdequateSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnCleanVisibleAdequateSizeDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSelfCleanVisibleAdequateSize?.didTapOnCellSelfCleanVisibleAdequateSize(_btnSelfCleanTag: radioButton.tag)
    }
}

protocol SelfCleanRunQuietlyCellProtocol {
    func didTapOnCellSelfCleanRunQuietly(_btnSelfCleanTag: Int)
}

class SelfCleanRunQuietlyTableCell: UITableViewCell {
    
    @IBOutlet weak var txtCleanRunQuietly: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSelfCleanRunQuietly: SelfCleanRunQuietlyCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtCleanRunQuietly.layer.borderColor = UIColor.black.cgColor
        self.txtCleanRunQuietly.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtCleanRunQuietly.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtCleanRunQuietly.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnCleanRunQuietlyDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSelfCleanRunQuietly?.didTapOnCellSelfCleanRunQuietly(_btnSelfCleanTag: radioButton.tag)
    }
}


//MARK:- BOOSTER PUMP FOR PRESSURE SIDE CLEANER

protocol BoosterPumpCellProtocol {
    func didTapOnCellBoosterPump(_btnBoosterPumpTag: Int)
}

class InspectionBoosterPumpTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBoosterPump: UITextView!
    @IBOutlet weak var tblBoosterPumpHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateBoosterPump: BoosterPumpCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBoosterPump.layer.borderColor = UIColor.black.cgColor
        self.txtBoosterPump.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBoosterPump.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBoosterPump.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBoostPumpDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateBoosterPump?.didTapOnCellBoosterPump(_btnBoosterPumpTag: radioButton.tag)
    }
}

protocol BoosterOperateCellProtocol {
    func didTapOnCellBoosterOperate(_btnBoosterPumpTag: Int)
}

class BoosterPumpOperatingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBoosterPumpOperation: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateBoosterOperate: BoosterOperateCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBoosterPumpOperation.layer.borderColor = UIColor.black.cgColor
        self.txtBoosterPumpOperation.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBoosterPumpOperation.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBoosterPumpOperation.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBoosterPumpOperationDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateBoosterOperate?.didTapOnCellBoosterOperate(_btnBoosterPumpTag: radioButton.tag)
    }
}

protocol BoosterMaintainCellProtocol {
    func didTapOnCellBoosterMaintain(_btnBoosterPumpTag: Int)
}

class BoosterPumpMaintaianceAccessTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBoosterMaintenance: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateBoosterMaintain: BoosterMaintainCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBoosterMaintenance.layer.borderColor = UIColor.black.cgColor
        self.txtBoosterMaintenance.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBoosterMaintenance.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBoosterMaintenance.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBoosterMaintenanceDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateBoosterMaintain?.didTapOnCellBoosterMaintain(_btnBoosterPumpTag: radioButton.tag)
    }
}

protocol BoosterAdequateSizeCellProtocol {
    func didTapOnCellBoosterAdequateSize(_btnBoosterPumpTag: Int)
}

class BoosterPumpAdequateSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBoosterAdequateSize: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateBoosterAdequateSize: BoosterAdequateSizeCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBoosterAdequateSize.layer.borderColor = UIColor.black.cgColor
        self.txtBoosterAdequateSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBoosterAdequateSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBoosterAdequateSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBoosterAdequateSizeDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateBoosterAdequateSize?.didTapOnCellBoosterAdequateSize(_btnBoosterPumpTag: radioButton.tag)
    }
}

protocol BoosterMountedCellProtocol {
    func didTapOnCellBoosterMounted(_btnBoosterPumpTag: Int)
}

class BoosterPumpMountedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBoosterMounted: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateBoosterMounted: BoosterMountedCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBoosterMounted.layer.borderColor = UIColor.black.cgColor
        self.txtBoosterMounted.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBoosterMounted.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBoosterMounted.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBoosterMountedDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateBoosterMounted?.didTapOnCellBoosterMounted(_btnBoosterPumpTag: radioButton.tag)
    }
}

protocol BoosterVisibleLeakCellProtocol {
    func didTapOnCellBoosterVisibleLeak(_btnBoosterPumpTag: Int)
}

class BoosterPumpVisibleLeakTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBoosterVisibleLeak: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateBoosterVisibleLeak: BoosterVisibleLeakCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBoosterVisibleLeak.layer.borderColor = UIColor.black.cgColor
        self.txtBoosterVisibleLeak.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBoosterVisibleLeak.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBoosterVisibleLeak.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBoosterVisibleLeakDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateBoosterVisibleLeak?.didTapOnCellBoosterVisibleLeak(_btnBoosterPumpTag: radioButton.tag)
    }
}

protocol BoosterGasketsCellProtocol {
    func didTapOnCellBoosterGaskets(_btnBoosterPumpTag: Int)
}

class BoosterPumpGasketsTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBoosterGaskets: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateBoosterGaskets: BoosterGasketsCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBoosterGaskets.layer.borderColor = UIColor.black.cgColor
        self.txtBoosterGaskets.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBoosterGaskets.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBoosterGaskets.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBoosterGasketsDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateBoosterGaskets?.didTapOnCellBoosterGaskets(_btnBoosterPumpTag: radioButton.tag)
    }
}

protocol BoosterVisibleAdequateSizeCellProtocol {
    func didTapOnCellBoosterVisibleAdequateSize(_btnBoosterPumpTag: Int)
}

class BoosterPumpVisibleAdequateSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBoosterVisibleAdequateSize: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateBoosterVisibleAdequateSize: BoosterVisibleAdequateSizeCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBoosterVisibleAdequateSize.layer.borderColor = UIColor.black.cgColor
        self.txtBoosterVisibleAdequateSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBoosterVisibleAdequateSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBoosterVisibleAdequateSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBoosterVisibleAdequateSizeDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateBoosterVisibleAdequateSize?.didTapOnCellBoosterVisibleAdequateSize(_btnBoosterPumpTag: radioButton.tag)
    }
}

protocol BoosterRunQuietlyCellProtocol {
    func didTapOnCellBoosterRunQuietly(_btnBoosterPumpTag: Int)
}

class BoosterPumpRunQuietlyTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBoosterPumpRun: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateBoosterRunQuietly: BoosterRunQuietlyCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBoosterPumpRun.layer.borderColor = UIColor.black.cgColor
        self.txtBoosterPumpRun.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBoosterPumpRun.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBoosterPumpRun.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnBoosterPumpRun(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateBoosterRunQuietly?.didTapOnCellBoosterRunQuietly(_btnBoosterPumpTag: radioButton.tag)
    }
}
