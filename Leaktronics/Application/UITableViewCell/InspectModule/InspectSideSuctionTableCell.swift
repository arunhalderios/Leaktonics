//
//  InspectionSideSuctionTableCell.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 06/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton

//MARK:- Side Suction

protocol SideSuctionPresentCellProtocol {
    func didTapOnCellSideSuctionPresent(_btnSideSuctionPresentTag: Int)
}

class InspectSideSuctionTableCell: UITableViewCell {
    
    @IBOutlet weak var btnYesSideSuction: DLRadioButton!
    @IBOutlet weak var txtSideSuction: UITextView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    
    var delegateSideSuctionPresent: SideSuctionPresentCellProtocol?
    
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSideSuction.layer.borderColor = UIColor.black.cgColor
        self.txtSideSuction.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSideSuction.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSideSuction.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSideSuctionPresentDidTap(radioButton : DLRadioButton) {
            print(radioButton.tag)
           if (radioButton.isMultipleSelectionEnabled) {
               for button in radioButton.selectedButtons() {
                      print(String(format: "%@ is selected.\n", button));
               }
           } else {
                  print(String(format: "%@ is selected.\n", radioButton.selected()!));
           }
           
           self.delegateSideSuctionPresent?.didTapOnCellSideSuctionPresent(_btnSideSuctionPresentTag: radioButton.tag)
       }
        
}

protocol Suction0Protocol {
    func didTapOnCellSuction0(_btnDescribeTag: Int)
}

class SideSuctionInchesTableCell: UITableViewCell {
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    @IBOutlet weak var txtSuctionInches: UITextView!
    
    var delegateSuction0: Suction0Protocol?
        
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSuctionInches.layer.borderColor = UIColor.black.cgColor
        self.txtSuctionInches.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSuctionInches.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSuctionInches.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSuctionInchesDidTap(radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSuction0?.didTapOnCellSuction0(_btnDescribeTag: radioButton.tag)
    }
}

protocol Suction1Protocol {
    func didTapOnCellSuction1(_btnDescribeTag: Int)
}

class SideSuctionVGBComplaintTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSuctionVGBComplaint: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSuction1: Suction1Protocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSuctionVGBComplaint.layer.borderColor = UIColor.black.cgColor
        self.txtSuctionVGBComplaint.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSuctionVGBComplaint.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSuctionVGBComplaint.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSuctionVGBComplaintDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSuction1?.didTapOnCellSuction1(_btnDescribeTag: radioButton.tag)
    }
}

protocol Suction2Protocol {
    func didTapOnCellSuction2(_btnDescribeTag: Int)
}

class SideSuctionMountedProperlyTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSuctionMounted: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSuction2: Suction2Protocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSuctionMounted.layer.borderColor = UIColor.black.cgColor
        self.txtSuctionMounted.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSuctionMounted.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSuctionMounted.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSuctionMountedDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSuction2?.didTapOnCellSuction2(_btnDescribeTag: radioButton.tag)
    }
}


//MARK:- Skimmer

protocol SkimmerPresentCellProtocol {
    func didTapOnCellSkimmerPresent(_btnSkimmerPresentTag: Int)
}

class InspectSkimmerTableCell: UITableViewCell {
    
    @IBOutlet weak var btnYesSkimmer: DLRadioButton!
    @IBOutlet weak var txtSkimmer: UITextView!
    @IBOutlet weak var tblSkimmerHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerPresent: SkimmerPresentCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtSkimmer.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmer.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmer.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmer.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSkimmerOptionDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                   print(String(format: "%@ is selected.\n", button));
            }
        } else {
               print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        
        self.delegateSkimmerPresent?.didTapOnCellSkimmerPresent(_btnSkimmerPresentTag: radioButton.tag)
    }
}

protocol SkimmerOperatingCellProtocol {
    func didTapOnCellSkimmerOperating(_btnSkimmerOperatingTag: Int)
}

class SkimmerOperatingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerOperating: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerOperating: SkimmerOperatingCellProtocol?
       
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerOperating.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerOperating.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerOperating.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerOperating.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSkimmerOperatingDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerOperating?.didTapOnCellSkimmerOperating(_btnSkimmerOperatingTag: radioButton.tag)
    }
}

protocol SkimmerRepairCellProtocol {
    func didTapOnCellSkimmerRepair(_btnSkimmerOperatingTag: Int)
}

class SkimmerPreviousRepairTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerRepair: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerRepair: SkimmerRepairCellProtocol?
    
       
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerRepair.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerRepair.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerRepair.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerRepair.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSkimmerRepairDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerRepair?.didTapOnCellSkimmerRepair(_btnSkimmerOperatingTag: radioButton.tag)
    }
}

protocol SkimmerHeightCellProtocol {
    func didTapOnCellSkimmerHeight(_btnSkimmerOperatingTag: Int)
}

class SkimmerProperHeightTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerHeight: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerHeight: SkimmerHeightCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerHeight.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerHeight.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerHeight.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerHeight.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSkimmerHeightDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerHeight?.didTapOnCellSkimmerHeight(_btnSkimmerOperatingTag: radioButton.tag)
    }
}

protocol SkimmerDoorCellProtocol {
    func didTapOnCellSkimmerDoor(_btnSkimmerOperatingTag: Int)
}

class SkimmerWeirDoorTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerWeirDoor: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerDoor: SkimmerDoorCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerWeirDoor.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerWeirDoor.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerWeirDoor.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerWeirDoor.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSkimmerWeirDoorDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerDoor?.didTapOnCellSkimmerDoor(_btnSkimmerOperatingTag: radioButton.tag)
    }
}

protocol SkimmerWeirCellProtocol {
    func didTapOnCellSkimmerWeir(_btnSkimmerOperatingTag: Int)
}

class SkimmerWeirDoorWorkingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerDoorWorking: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerWeir: SkimmerWeirCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerDoorWorking.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerDoorWorking.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerDoorWorking.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerDoorWorking.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSkimmerWeirDoorWorkingDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerWeir?.didTapOnCellSkimmerWeir(_btnSkimmerOperatingTag: radioButton.tag)
    }
}

protocol SkimmerBaseCellProtocol {
    func didTapOnCellSkimmerBase(_btnSkimmerOperatingTag: Int)
}

class SkimmerBasementTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerBasement: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerBase: SkimmerBaseCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerBasement.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerBasement.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerBasement.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerBasement.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSkimmerBasementDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerBase?.didTapOnCellSkimmerBase(_btnSkimmerOperatingTag: radioButton.tag)
    }
}

protocol SkimmerCondiCellProtocol {
    func didTapOnCellSkimmerCondi(_btnSkimmerOperatingTag: Int)
}

class SkimmerBasementConditionTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerBasementCondition: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerCondi: SkimmerCondiCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerBasementCondition.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerBasementCondition.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerBasementCondition.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerBasementCondition.layer.cornerRadius = 10
        }
    }
        
    @IBAction func btnSkimmerBasementConditionDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerCondi?.didTapOnCellSkimmerCondi(_btnSkimmerOperatingTag: radioButton.tag)
    }
}

protocol SkimmerDiverCellProtocol {
    func didTapOnCellSkimmerDiver(_btnSkimmerOperatingTag: Int)
}

class SkimmerProperDiverterTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerProperDiverter: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerDiver: SkimmerDiverCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerProperDiverter.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerProperDiverter.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerProperDiverter.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerProperDiverter.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSkimmerProperDiverterDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerDiver?.didTapOnCellSkimmerDiver(_btnSkimmerOperatingTag: radioButton.tag)
    }
}

protocol SkimmerSeamCellProtocol {
    func didTapOnCellSkimmerSeam(_btnSkimmerOperatingTag: Int)
}

class SkimmerSeamConditionTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerCondition: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerSeam: SkimmerSeamCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerCondition.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerCondition.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerCondition.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerCondition.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSkimmerConditionDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerSeam?.didTapOnCellSkimmerSeam(_btnSkimmerOperatingTag: radioButton.tag)
    }
}

protocol SkimmerCreakCellProtocol {
    func didTapOnCellSkimmerCreak(_btnSkimmerOperatingTag: Int)
}

class SkimmerCrackTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerCrack: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerCreak: SkimmerCreakCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerCrack.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerCrack.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerCrack.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerCrack.layer.cornerRadius = 10
        }
    }

    @IBAction func btnSkimmerCrackDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerCreak?.didTapOnCellSkimmerCreak(_btnSkimmerOperatingTag: radioButton.tag)
    }
}

protocol SkimmerSuctCellProtocol {
    func didTapOnCellSkimmerSuct(_btnSkimmerOperatingTag: Int)
}

class SkimmerSuctionWorkingTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerSuctionWorking: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerCreak: SkimmerSuctCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerSuctionWorking.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerSuctionWorking.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerSuctionWorking.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerSuctionWorking.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSkimmerSuctionWorkingDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerCreak?.didTapOnCellSkimmerSuct(_btnSkimmerOperatingTag: radioButton.tag)
    }
}

protocol SkimmerEquiCellProtocol {
    func didTapOnCellSkimmerEqui(_btnSkimmerOperatingTag: Int)
}

class SkimmerEqualizerTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerEqualizer: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerEqui: SkimmerEquiCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerEqualizer.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerEqualizer.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerEqualizer.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerEqualizer.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSkimmerEqualizerDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerEqui?.didTapOnCellSkimmerEqui(_btnSkimmerOperatingTag: radioButton.tag)
    }
}

protocol SkimmerVGBCellProtocol {
    func didTapOnCellSkimmerVGB(_btnSkimmerOperatingTag: Int)
}

class SkimmerEqualizerVGBTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerEqualizerVGB: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerVGB: SkimmerVGBCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerEqualizerVGB.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerEqualizerVGB.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerEqualizerVGB.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerEqualizerVGB.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSkimmerEqualizerVGBDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerVGB?.didTapOnCellSkimmerVGB(_btnSkimmerOperatingTag: radioButton.tag)
    }
}

protocol SkimmerDrainCellProtocol {
    func didTapOnCellSkimmerDrain(_btnSkimmerOperatingTag: Int)
}

class SkimmerMainDrainTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSkimmerMainDrain: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSkimmerDrain: SkimmerDrainCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
        self.txtSkimmerMainDrain.layer.borderColor = UIColor.black.cgColor
        self.txtSkimmerMainDrain.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSkimmerMainDrain.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSkimmerMainDrain.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnSkimmerMainDrainDidTap(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
       }
        self.delegateSkimmerDrain?.didTapOnCellSkimmerDrain(_btnSkimmerOperatingTag: radioButton.tag)
    }
}
