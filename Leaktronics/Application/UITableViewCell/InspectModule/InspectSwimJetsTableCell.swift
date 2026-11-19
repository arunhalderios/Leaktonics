//
//  InspectionSwimJetsTableCell.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 07/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton

//MARK:- Swim Jets Pump
protocol SwimJetsPumpCellProtocol {
    func didTapOnCellSwimJets(_btnSwimJetsTag: Int)
}

class InspectionSwimJetsPumpTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimJets: UITextView!
    @IBOutlet weak var tblSwimJetsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsPump: SwimJetsPumpCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimJets.layer.borderColor = UIColor.black.cgColor
        self.txtSwimJets.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimJets.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimJets.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimJetsDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsPump?.didTapOnCellSwimJets(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsOperatingCellProtocol {
    func didTapOnCellSwimJetsOperating(_btnSwimJetsTag: Int)
}

class SwimJetsPumpOperatingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimJetOperating: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsOperate: SwimJetsOperatingCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimJetOperating.layer.borderColor = UIColor.black.cgColor
        self.txtSwimJetOperating.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimJetOperating.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimJetOperating.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimJetPumOperatingDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsOperate?.didTapOnCellSwimJetsOperating(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsMaintaianceCellProtocol {
    func didTapOnCellSwimJetsMaintaiance(_btnSwimJetsTag: Int)
}

class SwimJetsMaintaianceAccessTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimJetMaintenance: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsMaintaiance: SwimJetsMaintaianceCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimJetMaintenance.layer.borderColor = UIColor.black.cgColor
        self.txtSwimJetMaintenance.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimJetMaintenance.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimJetMaintenance.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimJetMaintenanceDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsMaintaiance?.didTapOnCellSwimJetsMaintaiance(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsAdequateCellProtocol {
    func didTapOnCellSwimJetsAdequate(_btnSwimJetsTag: Int)
}

class SwimJetsAdequateSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimAdequateSize: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsAdequate: SwimJetsAdequateCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimAdequateSize.layer.borderColor = UIColor.black.cgColor
        self.txtSwimAdequateSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimAdequateSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimAdequateSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimAdequateSizeDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsAdequate?.didTapOnCellSwimJetsAdequate(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsMountedCellProtocol {
    func didTapOnCellSwimJetsMounted(_btnSwimJetsTag: Int)
}

class SwimJetsMountedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimMounted: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsMounted: SwimJetsMountedCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimMounted.layer.borderColor = UIColor.black.cgColor
        self.txtSwimMounted.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimMounted.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimMounted.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimMountedDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsMounted?.didTapOnCellSwimJetsMounted(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsLeakCellProtocol {
    func didTapOnCellSwimJetsLeak(_btnSwimJetsTag: Int)
}

class SwimJetsVisibleLeakTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimVisibleLeak: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsLeak: SwimJetsLeakCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimVisibleLeak.layer.borderColor = UIColor.black.cgColor
        self.txtSwimVisibleLeak.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimVisibleLeak.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimVisibleLeak.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimVisibleLeakDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsLeak?.didTapOnCellSwimJetsLeak(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsGasketsCellProtocol {
    func didTapOnCellSwimJetsGaskets(_btnSwimJetsTag: Int)
}

class SwimJetsGasketsTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimGaskets: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsGaskets: SwimJetsGasketsCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimGaskets.layer.borderColor = UIColor.black.cgColor
        self.txtSwimGaskets.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimGaskets.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimGaskets.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimGasketsDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsGaskets?.didTapOnCellSwimJetsGaskets(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsVisibleAdequateCellProtocol {
    func didTapOnCellSwimJetsVisibleAdequate(_btnSwimJetsTag: Int)
}

class SwimJetsVisibleAdequateSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimVisibleAdequateSize: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsVisibleAdequate: SwimJetsVisibleAdequateCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimVisibleAdequateSize.layer.borderColor = UIColor.black.cgColor
        self.txtSwimVisibleAdequateSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimVisibleAdequateSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimVisibleAdequateSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimVisibleAdequateSizeDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsVisibleAdequate?.didTapOnCellSwimJetsVisibleAdequate(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsRunQuietlyCellProtocol {
    func didTapOnCellSwimJetsRunQuietly(_btnSwimJetsTag: Int)
}

class SwimJetsRunQuietlyTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimRunQuietly: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsRunQuietly: SwimJetsRunQuietlyCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimRunQuietly.layer.borderColor = UIColor.black.cgColor
        self.txtSwimRunQuietly.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimRunQuietly.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimRunQuietly.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimRunQuietlyDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsRunQuietly?.didTapOnCellSwimJetsRunQuietly(_btnSwimJetsTag: radioButton.tag)
    }
}

//MARK:- Water Feature Pump

protocol SwimJetsWaterFeatureCellProtocol {
    func didTapOnCellSwimJetsWaterFeature(_btnSwimJetsWaterFeatureTag: Int)
}

class InspectionJetsWaterFeaturePumpTableCell: UITableViewCell {
    @IBOutlet weak var txtJetsWaterFeature: UITextView!
    @IBOutlet weak var tblJetsWaterFeatureHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateJetsWaterFeature: SwimJetsWaterFeatureCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtJetsWaterFeature.layer.borderColor = UIColor.black.cgColor
        self.txtJetsWaterFeature.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtJetsWaterFeature.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtJetsWaterFeature.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnJetsWaterFeatureDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateJetsWaterFeature?.didTapOnCellSwimJetsWaterFeature(_btnSwimJetsWaterFeatureTag: radioButton.tag)
    }
}

protocol SwimJetsWaterFeatureOperateCellProtocol {
    func didTapOnCellSwimJetsWaterFeatureOperate(_btnSwimJetsTag: Int)
}

class SwimJetsWaterFeatureOperatingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimWaterOperating: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsWaterFeatureOperate: SwimJetsWaterFeatureOperateCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimWaterOperating.layer.borderColor = UIColor.black.cgColor
        self.txtSwimWaterOperating.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimWaterOperating.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimWaterOperating.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimWaterOperating(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsWaterFeatureOperate?.didTapOnCellSwimJetsWaterFeatureOperate(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsWaterFeatureMaintaianceCellProtocol {
    func didTapOnCellSwimJetsWaterFeatureMaintaiance(_btnSwimJetsTag: Int)
}

class SwimJetsWaterFeatureMaintaianceAccessTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimWaterMaintenance: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsWaterFeatureMaintain: SwimJetsWaterFeatureMaintaianceCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimWaterMaintenance.layer.borderColor = UIColor.black.cgColor
        self.txtSwimWaterMaintenance.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimWaterMaintenance.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimWaterMaintenance.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimWaterMaintenanceDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsWaterFeatureMaintain?.didTapOnCellSwimJetsWaterFeatureMaintaiance(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsWaterFeatureAdequateSizeCellProtocol {
    func didTapOnCellSwimJetsWaterFeatureAdequateSize(_btnSwimJetsTag: Int)
}

class SwimJetsWaterFeatureAdequateSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimAdequateSize: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsAdequateSize: SwimJetsWaterFeatureAdequateSizeCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimAdequateSize.layer.borderColor = UIColor.black.cgColor
        self.txtSwimAdequateSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimAdequateSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimAdequateSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimAdequateSizeDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsAdequateSize?.didTapOnCellSwimJetsWaterFeatureAdequateSize(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsWaterFeatureMountedCellProtocol {
    func didTapOnCellSwimJetsWaterFeatureMounted(_btnSwimJetsTag: Int)
}

class SwimJetsWaterFeatureMountedTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimMounted: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsMounted: SwimJetsWaterFeatureMountedCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimMounted.layer.borderColor = UIColor.black.cgColor
        self.txtSwimMounted.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimMounted.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimMounted.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimMountedDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsMounted?.didTapOnCellSwimJetsWaterFeatureMounted(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsWaterFeatureLeakCellProtocol {
    func didTapOnCellSwimJetsWaterFeatureLeak(_btnSwimJetsTag: Int)
}

class SwimJetsWaterFeatureVisibleLeakTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimWaterVisibleLeak: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsLeak: SwimJetsWaterFeatureLeakCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSwimWaterVisibleLeak.layer.borderColor = UIColor.black.cgColor
        self.txtSwimWaterVisibleLeak.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimWaterVisibleLeak.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimWaterVisibleLeak.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimWaterVisibleLeakDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsLeak?.didTapOnCellSwimJetsWaterFeatureLeak(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsWaterGasketsCellProtocol {
    func didTapOnCellSwimJetsWaterGaskets(_btnSwimJetsTag: Int)
}

class SwimJetsWaterFeatureGasketsTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimGaskets: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsGaskets: SwimJetsWaterGasketsCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtSwimGaskets.layer.borderColor = UIColor.black.cgColor
        self.txtSwimGaskets.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimGaskets.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimGaskets.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimWaterGasketsDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsGaskets?.didTapOnCellSwimJetsWaterGaskets(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsWaterVisibleAdequateSizeCellProtocol {
    func didTapOnCellSwimJetsWaterVisibleAdequateSize(_btnSwimJetsTag: Int)
}

class SwimJetsWaterFeatureVisibleAdequateSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimVisibleAdequateSize: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsVisibleAdequateSize: SwimJetsWaterVisibleAdequateSizeCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtSwimVisibleAdequateSize.layer.borderColor = UIColor.black.cgColor
        self.txtSwimVisibleAdequateSize.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimVisibleAdequateSize.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimVisibleAdequateSize.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimVisibleAdequateSizeDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsVisibleAdequateSize?.didTapOnCellSwimJetsWaterVisibleAdequateSize(_btnSwimJetsTag: radioButton.tag)
    }
}

protocol SwimJetsWaterRunQuietlyCellProtocol {
    func didTapOnCellSwimJetsWaterRunQuietly(_btnSwimJetsTag: Int)
}

class SwimJetsWaterFeatureRunQuietlyTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimFeatureRun: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSwimJetsRunQuietly: SwimJetsWaterRunQuietlyCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtSwimFeatureRun.layer.borderColor = UIColor.black.cgColor
        self.txtSwimFeatureRun.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimFeatureRun.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimFeatureRun.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSwimFeatureRunDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSwimJetsRunQuietly?.didTapOnCellSwimJetsWaterRunQuietly(_btnSwimJetsTag: radioButton.tag)
    }
}
