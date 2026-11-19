//
//  InspectionTableCell.swift
//  Leaktronics
//
//  Created by ivaninfotech on 5/15/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton

//MARK:- Inspection

protocol WaterConditionCellProtocol {
    func didTapOnCellWaterCondition(_btnDescribeTag: Int)
}

class WaterConditionTableCell: UITableViewCell {
    
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
    
    var delegateWaterCondition: WaterConditionCellProtocol?
    
    
    @objc @IBAction private func waterConditionBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateWaterCondition?.didTapOnCellWaterCondition(_btnDescribeTag: radioButton.tag)
    }
}

protocol WaterLevelHtCellProtocol {
    func didTapOnCellWaterLevelHt(_btnDescribeTag: Int)
}

class WaterLevelHtTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateWaterLevelHt: WaterLevelHtCellProtocol?
    
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
    
    @objc @IBAction private func waterLevelHtBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateWaterLevelHt?.didTapOnCellWaterLevelHt(_btnDescribeTag: radioButton.tag)
    }
}

protocol DrainCellProtocol {
    func didTapOnCellDrain(_btnDescribeTag: Int)
}

class MainDrainTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateDrain: DrainCellProtocol?
    
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
    
    @objc @IBAction private func drainBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateDrain?.didTapOnCellDrain(_btnDescribeTag: radioButton.tag)
    }
}

protocol NearByCellProtocol {
    func didTapOnCellNearBy(_btnDescribeTag: Int)
}

class NearByTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateNearBy: NearByCellProtocol?
    
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
    
    @objc @IBAction private func nearByBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateNearBy?.didTapOnCellNearBy(_btnDescribeTag: radioButton.tag)
    }
}

protocol RiskCellProtocol {
    func didTapOnCellRisk(_btnDescribeTag: Int)
}

class RiskTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateRisk: RiskCellProtocol?
    
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
    
    @objc @IBAction private func riskBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateRisk?.didTapOnCellRisk(_btnDescribeTag: radioButton.tag)
    }
}

protocol PoolLevelCellProtocol {
    func didTapOnCellPoolLevel(_btnDescribeTag: Int)
}

class PoolLevelTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegatePoolLevel: PoolLevelCellProtocol?
    
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
    
    @objc @IBAction private func poolLevelBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegatePoolLevel?.didTapOnCellPoolLevel(_btnDescribeTag: radioButton.tag)
    }
}

protocol SpaLevelCellProtocol {
    func didTapOnCellSpaLevel(_btnDescribeTag: Int)
}

class SpaLevelTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSpaLevel: SpaLevelCellProtocol?
    
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
    
    @objc @IBAction private func spaLevelBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSpaLevel?.didTapOnCellSpaLevel(_btnDescribeTag: radioButton.tag)
    }
}


protocol ConstructedSPACellProtocol {
    func didTapOnCellConstructedSPA(_btnDescribeTag: Int)
}

class ConstructedSPATableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btn1: DLRadioButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var btn2: DLRadioButton!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var btn3: DLRadioButton!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var btn4: DLRadioButton!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var btn5: DLRadioButton!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var btn6: DLRadioButton!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var btn7: DLRadioButton!
    @IBOutlet weak var lbl7: UILabel!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    @IBOutlet weak var txtOther: UITextView!
    
    
    var delegateConstructedSPA: ConstructedSPACellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if btn7.tag == 6 {
            self.txtOther.isUserInteractionEnabled = true
        } else {
            self.txtOther.text = ""
            self.txtOther.isUserInteractionEnabled = false
        }
        
        self.txtOther.isUserInteractionEnabled = false
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
    
    @objc @IBAction private func constructedSPABtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if radioButton.tag == 6 {
            self.txtOther.isUserInteractionEnabled = true
        } else {
            self.txtOther.text = ""
            self.txtOther.isUserInteractionEnabled = false
        }
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateConstructedSPA?.didTapOnCellConstructedSPA(_btnDescribeTag: radioButton.tag)
    }
}

protocol SurfaceMaterialCellProtocol {
    func didTapOnCellSurfaceMaterial(_btnDescribeTag: Int)
}

class SurfaceMaterialTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btn1: DLRadioButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var btn2: DLRadioButton!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var btn3: DLRadioButton!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var btn4: DLRadioButton!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var btn5: DLRadioButton!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var btn6: DLRadioButton!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var btn7: DLRadioButton!
    @IBOutlet weak var lbl7: UILabel!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    @IBOutlet weak var txtOther: UITextView!
    
    
    var delegateSurfaceMaterial: SurfaceMaterialCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if btn7.tag == 6 {
            self.txtOther.isUserInteractionEnabled = true
        } else {
            self.txtOther.text = ""
            self.txtOther.isUserInteractionEnabled = false
        }
        
        self.txtOther.isUserInteractionEnabled = false
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
    
    @objc @IBAction private func surfaceMaterialBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if radioButton.tag == 6 {
            self.txtOther.isUserInteractionEnabled = true
        } else {
            self.txtOther.text = ""
            self.txtOther.isUserInteractionEnabled = false
        }
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSurfaceMaterial?.didTapOnCellSurfaceMaterial(_btnDescribeTag: radioButton.tag)
    }
}

protocol TouchCellProtocol {
    func didTapOnCellTouch(_btnDescribeTag: Int)
}

class TouchTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateTouch: TouchCellProtocol?
    
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
    
    @objc @IBAction private func touchBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateTouch?.didTapOnCellTouch(_btnDescribeTag: radioButton.tag)
    }
}

protocol SurfaceConditionCellProtocol {
    func didTapOnCellSurfaceCondition(_btnDescribeTag: Int)
}

class SurfaceConditionTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btn1: DLRadioButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var btn2: DLRadioButton!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var btn3: DLRadioButton!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var btn4: DLRadioButton!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var btn5: DLRadioButton!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var btn6: DLRadioButton!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var btn7: DLRadioButton!
    @IBOutlet weak var lbl7: UILabel!
    @IBOutlet weak var btn8: DLRadioButton!
    @IBOutlet weak var lbl8: UILabel!
    @IBOutlet weak var btn9: DLRadioButton!
    @IBOutlet weak var lbl9: UILabel!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    
    var delegateSurfaceCondition: SurfaceConditionCellProtocol?
    
    @objc @IBAction private func surfaceConditionBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSurfaceCondition?.didTapOnCellSurfaceCondition(_btnDescribeTag: radioButton.tag)
    }
}


protocol StructuralProtocol {
    func didTapOnCellStructural(_btnDescribeTag: Int)
}
class StructuralTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    //@IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    //@IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    @IBOutlet weak var lblNotes: UILabel!
    
    
    var delegateStructural: StructuralProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.txtOther.isUserInteractionEnabled = false
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
        delegateStructural?.didTapOnCellStructural(_btnDescribeTag: radioButton.tag)
    }
}

