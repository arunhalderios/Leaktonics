//
//  InspectionPoolPumpTableCell.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 07/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton

//MARK:- Pool Pump

protocol PoolFiltrationPumpCellProtocol {
    func didTapOnCellPoolPumpFiltration(_btnPoolPumpFiltrationTag: Int)
}


class InspectionPoolFiltrationPumpTableCell: UITableViewCell {
    
    @IBOutlet weak var btnYesPoolFiltration: DLRadioButton!
    @IBOutlet weak var txtPoolPump: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegatePoolFiltrationPump: PoolFiltrationPumpCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtPoolPump.layer.borderColor = UIColor.black.cgColor
        self.txtPoolPump.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPoolPump.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPoolPump.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPoolFiltrationDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                 print(String(format: "%@ is selected.\n", button));
            }
        } else {
                print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegatePoolFiltrationPump?.didTapOnCellPoolPumpFiltration(_btnPoolPumpFiltrationTag: radioButton.tag)
    }
}

protocol PoolMaintainancePumpCellProtocol {
    func didTapOnCellPoolMaintainance(_btnPoolPumpMaintainanceTag: Int)
}

class InspectionPoolPumpMaintainanceTableCell: UITableViewCell {
    
    @IBOutlet weak var btnYesOutlet: DLRadioButton!
    @IBOutlet weak var txtPoolPumpMaintainance: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegatePoolMaintainancePump: PoolMaintainancePumpCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtPoolPumpMaintainance.layer.borderColor = UIColor.black.cgColor
        self.txtPoolPumpMaintainance.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPoolPumpMaintainance.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPoolPumpMaintainance.layer.cornerRadius = 10
        }
    }
    
    
    @IBAction func btnPoolPumpMaintainanceDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegatePoolMaintainancePump?.didTapOnCellPoolMaintainance(_btnPoolPumpMaintainanceTag: radioButton.tag)
    }
}


protocol PoolPumpAdequateSizeCellProtocol {
    func didTapOnCellPoolAdequateSize(_btnPoolPumpAdequateSizeTag: Int)
}

class InspectionPoolPumpAdequateSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var txtPoolPumpAdequateSize: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegatePoolPumpAdequateSize: PoolPumpAdequateSizeCellProtocol?
    
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtPoolPumpAdequateSize.layer.borderColor = UIColor.black.cgColor
        self.txtPoolPumpAdequateSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPoolPumpAdequateSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPoolPumpAdequateSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPoolPumpAdequateSizeDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegatePoolPumpAdequateSize?.didTapOnCellPoolAdequateSize(_btnPoolPumpAdequateSizeTag: radioButton.tag)
    }
}

protocol PoolPumpMountedCellProtocol {
    func didTapOnCellPoolMounted(_btnPoolPumpMountedTag: Int)
}

class InspectionPoolPumpMountedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtPoolPumpMounted: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegatePoolPumpMounted: PoolPumpMountedCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       self.txtPoolPumpMounted.layer.borderColor = UIColor.black.cgColor
        self.txtPoolPumpMounted.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPoolPumpMounted.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPoolPumpMounted.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPoolPumpMountedDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegatePoolPumpMounted?.didTapOnCellPoolMounted(_btnPoolPumpMountedTag: radioButton.tag)
    }
}

protocol PoolPumpVisibleLeakCellProtocol {
    func didTapOnCellPoolVisibleLeak(_btnPoolPumpVisibleLeakTag: Int)
}

class InspectionPoolPumpVisibleLeakTableCell: UITableViewCell {
    @IBOutlet weak var txtPoolPumpVisibleLeak: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegatePoolPumpVisibleLeak: PoolPumpVisibleLeakCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtPoolPumpVisibleLeak.layer.borderColor = UIColor.black.cgColor
        self.txtPoolPumpVisibleLeak.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPoolPumpVisibleLeak.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPoolPumpVisibleLeak.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPoolPumpVisibleLeakDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegatePoolPumpVisibleLeak?.didTapOnCellPoolVisibleLeak(_btnPoolPumpVisibleLeakTag: radioButton.tag)
    }
}

protocol PoolPumpGasketsCellProtocol {
    func didTapOnCellPoolGaskets(_btnPoolPumpGasketsTag: Int)
}

class InspectionPoolPumpGasketsTableCell: UITableViewCell {
    @IBOutlet weak var txtPoolPumpGaskets: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegatePoolPumpGaskets: PoolPumpGasketsCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtPoolPumpGaskets.layer.borderColor = UIColor.black.cgColor
        self.txtPoolPumpGaskets.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPoolPumpGaskets.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPoolPumpGaskets.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPoolPumpGasketsDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegatePoolPumpGaskets?.didTapOnCellPoolGaskets(_btnPoolPumpGasketsTag: radioButton.tag)
    }
}

protocol PoolPumpVisibleAdequateSizeCellProtocol {
    func didTapOnCellPoolVisibleAdequateSize(_btnPoolPumpVisibleAdequateSizeTag: Int)
}

class InspectionPoolPumpVisibleAdequateSizeTableCell: UITableViewCell {
    @IBOutlet weak var txtPoolPumpVisibleAdequateSize: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegatePoolPumpVisibleAdequateSize: PoolPumpVisibleAdequateSizeCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtPoolPumpVisibleAdequateSize.layer.borderColor = UIColor.black.cgColor
        self.txtPoolPumpVisibleAdequateSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPoolPumpVisibleAdequateSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPoolPumpVisibleAdequateSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPoolPumpVisibleAdequateSizeDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegatePoolPumpVisibleAdequateSize?.didTapOnCellPoolVisibleAdequateSize(_btnPoolPumpVisibleAdequateSizeTag: radioButton.tag)
    }
}

protocol PoolPumpEquipmentRunCellProtocol {
    func didTapOnCellPoolEquipmentRun(_btnPoolPumpEquipmentRunTag: Int)
}

class InspectionPoolPumpEquipmentRunTableCell: UITableViewCell {
    @IBOutlet weak var txtPoolPumpEquipmentRun: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegatePoolPumpEquipmentRun: PoolPumpEquipmentRunCellProtocol?
    
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtPoolPumpEquipmentRun.layer.borderColor = UIColor.black.cgColor
        self.txtPoolPumpEquipmentRun.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPoolPumpEquipmentRun.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPoolPumpEquipmentRun.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPoolPumpEquipmentRunDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegatePoolPumpEquipmentRun?.didTapOnCellPoolEquipmentRun(_btnPoolPumpEquipmentRunTag: radioButton.tag)
    }
}

//MARK:- SPA Jets Pump
protocol SpaJetsCellProtocol {
    func didTapOnCellSpaJets(_btnSpaJetsTag: Int)
}

class InspectionSpaJetsPumpTableCell: UITableViewCell {
    @IBOutlet weak var txtSpaJets: UITextView!
    @IBOutlet weak var tblSpaJetsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSpaJets: SpaJetsCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
       super.awakeFromNib()
       // Initialization code
        self.txtSpaJets.layer.borderColor = UIColor.black.cgColor
        self.txtSpaJets.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSpaJets.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSpaJets.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSpaJetPump(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSpaJets?.didTapOnCellSpaJets(_btnSpaJetsTag: radioButton.tag)
    }
}

protocol SpaJetsPumpCellProtocol {
    func didTapOnCellSpaJetsPump(_btnSpaJetsTag: Int)
}

class SpaJetPumpOperatingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSpaPumpOperating: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSpaJetsPump: SpaJetsPumpCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
       super.awakeFromNib()
       // Initialization code
        self.txtSpaPumpOperating.layer.borderColor = UIColor.black.cgColor
        self.txtSpaPumpOperating.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSpaPumpOperating.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSpaPumpOperating.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSpaPumpOperatingDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSpaJetsPump?.didTapOnCellSpaJetsPump(_btnSpaJetsTag: radioButton.tag)
    }
}

protocol SpaJetsMainAccessCellProtocol {
    func didTapOnCellSpaJetsMainAccess(_btnSpaJetsTag: Int)
}

class SpaJetMaintaianceAccessTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSpaJetMaintenance: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateMainAccess: SpaJetsMainAccessCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
       super.awakeFromNib()
       // Initialization code
        self.txtSpaJetMaintenance.layer.borderColor = UIColor.black.cgColor
        self.txtSpaJetMaintenance.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSpaJetMaintenance.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSpaJetMaintenance.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSpaJetMaintenanceDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateMainAccess?.didTapOnCellSpaJetsMainAccess(_btnSpaJetsTag: radioButton.tag)
    }
}

protocol SpaJetsAdequateCellProtocol {
    func didTapOnCellSpaJetsAdequate(_btnSpaJetsTag: Int)
}

class SpaJetAdequateSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSpaAdequateSize: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateAdequate: SpaJetsAdequateCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
       super.awakeFromNib()
       // Initialization code
        self.txtSpaAdequateSize.layer.borderColor = UIColor.black.cgColor
        self.txtSpaAdequateSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSpaAdequateSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSpaAdequateSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSpaAdequateSizeDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateAdequate?.didTapOnCellSpaJetsAdequate(_btnSpaJetsTag: radioButton.tag)
    }
}

protocol SpaJetsMountedCellProtocol {
    func didTapOnCellSpaJetsMounted(_btnSpaJetsTag: Int)
}

class SpaJetMountedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSpaMounted: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateMounted: SpaJetsMountedCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
       super.awakeFromNib()
       // Initialization code
        self.txtSpaMounted.layer.borderColor = UIColor.black.cgColor
        self.txtSpaMounted.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSpaMounted.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSpaMounted.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSpaMountedDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateMounted?.didTapOnCellSpaJetsMounted(_btnSpaJetsTag: radioButton.tag)
    }
}

protocol SpaJetsLeakCellProtocol {
    func didTapOnCellSpaJetsLeak(_btnSpaJetsTag: Int)
}

class SpaJetVisibleLeakTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSpaVisibleLeak: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateLeak: SpaJetsLeakCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
       super.awakeFromNib()
       // Initialization code
        self.txtSpaVisibleLeak.layer.borderColor = UIColor.black.cgColor
        self.txtSpaVisibleLeak.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSpaVisibleLeak.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSpaVisibleLeak.layer.cornerRadius = 10
        }
    }
    @IBAction func btnSpaVisibleLeakDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateLeak?.didTapOnCellSpaJetsLeak(_btnSpaJetsTag: radioButton.tag)
    }
}

protocol SpaJetsGasketsCellProtocol {
    func didTapOnCellSpaJetsGaskets(_btnSpaJetsTag: Int)
}

class SpaJetGasketsTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSpaGaskets: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateGaskets: SpaJetsGasketsCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
       super.awakeFromNib()
       // Initialization code
        self.txtSpaGaskets.layer.borderColor = UIColor.black.cgColor
        self.txtSpaGaskets.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSpaGaskets.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSpaGaskets.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSpaGasketsDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateGaskets?.didTapOnCellSpaJetsGaskets(_btnSpaJetsTag: radioButton.tag)
    }
}

protocol SpaJetsSizeCellProtocol {
    func didTapOnCellSpaJetsSize(_btnSpaJetsTag: Int)
}

class SpaJetVisibleAdequateSizeTableCell: UITableViewCell {
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    @IBOutlet weak var txtVisibleAdequateSize: UITextView!
    
    var delegateSize: SpaJetsSizeCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
       super.awakeFromNib()
       // Initialization code
        self.txtVisibleAdequateSize.layer.borderColor = UIColor.black.cgColor
        self.txtVisibleAdequateSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtVisibleAdequateSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtVisibleAdequateSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnVisibleAdequateSizeDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSize?.didTapOnCellSpaJetsSize(_btnSpaJetsTag: radioButton.tag)
    }
    
}

protocol SpaJetsRunQuietlyCellProtocol {
    func didTapOnCellSpaJetsRunQuietly(_btnSpaJetsTag: Int)
}

class SpaJetRunQuietlyTableCell: UITableViewCell {
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateRunQuietly: SpaJetsRunQuietlyCellProtocol?
    
    @IBOutlet weak var txtSpaRunQuietly: UITextView!
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
       super.awakeFromNib()
       // Initialization code
        self.txtSpaRunQuietly.layer.borderColor = UIColor.black.cgColor
        self.txtSpaRunQuietly.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSpaRunQuietly.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSpaRunQuietly.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSpaRunQuietlyDidTap(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateRunQuietly?.didTapOnCellSpaJetsRunQuietly(_btnSpaJetsTag: radioButton.tag)
    }
    
}
