//
//  InspectionWaterFeatureTableCell.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 05/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton


protocol WaterFeatureCellProtocol {
    func didTapOnCellWaterFeature(_btnWaterPresentTag: Int)
}

class InspectWaterFeatureTableCell: UITableViewCell {
    
    @IBOutlet weak var btnYesOutlet: DLRadioButton!
    @IBOutlet weak var btnNoOutlet: DLRadioButton!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    @IBOutlet weak var txtInspectWaterFeature: UITextView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    
    
    var delegateWaterFeature: WaterFeatureCellProtocol?
    
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtInspectWaterFeature.layer.borderColor = UIColor.black.cgColor
        self.txtInspectWaterFeature.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtInspectWaterFeature.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtInspectWaterFeature.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnWaterFeaturePresentDidTap(_ radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        
        self.delegateWaterFeature?.didTapOnCellWaterFeature(_btnWaterPresentTag: radioButton.tag)
    }
}

protocol WaterOperateCellProtocol {
    func didTapOnCellWaterOperate(_btnWaterOperateTag: Int)
}


class WaterFeatureOperateTableCell: UITableViewCell {
    
    @IBOutlet weak var txtWaterOperate: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateWaterOperate: WaterOperateCellProtocol?
    
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         self.txtWaterOperate.layer.borderColor = UIColor.black.cgColor
         self.txtWaterOperate.layer.borderWidth = 0.68
         if UIDevice.current.userInterfaceIdiom == .phone {
             self.txtWaterOperate.layer.cornerRadius = 5
         } else if UIDevice.current.userInterfaceIdiom == .pad {
             self.txtWaterOperate.layer.cornerRadius = 10
         }
    }
    
    @IBAction func btnWaterOperateDidTap(_ radioButton : DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
           }
        } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        
        self.delegateWaterOperate?.didTapOnCellWaterOperate(_btnWaterOperateTag: radioButton.tag)
    }
}

protocol WaterHazardCellProtocol {
    func didTapOnCellWaterHazard(_btnWaterHazardTag: Int)
}

class WaterFeatureHazardTableCell: UITableViewCell {
    
    @IBOutlet weak var txtHazard: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateWaterHazard: WaterHazardCellProtocol?
    
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       self.txtHazard.layer.borderColor = UIColor.black.cgColor
       self.txtHazard.layer.borderWidth = 0.68
       if UIDevice.current.userInterfaceIdiom == .phone {
           self.txtHazard.layer.cornerRadius = 5
       } else if UIDevice.current.userInterfaceIdiom == .pad {
           self.txtHazard.layer.cornerRadius = 10
       }
    }
    
    @IBAction func btnHazardDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
          for button in radioButton.selectedButtons() {
                 print(String(format: "%@ is selected.\n", button));
          }
        } else {
             print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateWaterHazard?.didTapOnCellWaterHazard(_btnWaterHazardTag: radioButton.tag)
    }
}

protocol WaterSwimmerCellProtocol {
    func didTapOnCellWaterSwimmer(_btnWaterSwimmerTag: Int)
}

class WaterFeatureSwimmerAccessibleTableCell: UITableViewCell {
    
    @IBOutlet weak var txtSwimmer: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateWaterSwimmer: WaterSwimmerCellProtocol?
    
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtSwimmer.layer.borderColor = UIColor.black.cgColor
        self.txtSwimmer.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtSwimmer.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtSwimmer.layer.cornerRadius = 10
        }
    }
    
    
    @IBAction func btnSwimmerDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
         for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
         }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateWaterSwimmer?.didTapOnCellWaterSwimmer(_btnWaterSwimmerTag: radioButton.tag)
    }
}

protocol WaterBasinCrackCellProtocol {
    func didTapOnCellWaterBasinCrack(_btnWaterBasinCrackTag: Int)
}

class WaterFeatureBasinCrackTableCell: UITableViewCell {
    
    @IBOutlet weak var txtBasinCrack: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
     var delegateWaterBasinCrack: WaterBasinCrackCellProtocol?
    
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtBasinCrack.layer.borderColor = UIColor.black.cgColor
        self.txtBasinCrack.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtBasinCrack.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtBasinCrack.layer.cornerRadius = 10
        }
    }
    
    
    @IBAction func btnBasinFeatureDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
        for button in radioButton.selectedButtons() {
               print(String(format: "%@ is selected.\n", button));
            }
        } else {
           print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
         self.delegateWaterBasinCrack?.didTapOnCellWaterBasinCrack(_btnWaterBasinCrackTag: radioButton.tag)
    }
}


//MARK:- Diving Boards

protocol DivingBoardsCellProtocol {
    func didTapOnCellDivingBoards(_btnDivingBoardTag: Int)
}

class DivingBoardsTableCell: UITableViewCell{
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
 
    var delegateDivingBoards: DivingBoardsCellProtocol?
       
    //TODO:: View Lifecycle
    override func awakeFromNib() {
       super.awakeFromNib()
       // Initialization code
    }
    
    @IBAction func btnDivingBoardsDidTap(_ radioButton: DLRadioButton) {
           print(radioButton.tag)
           if (radioButton.isMultipleSelectionEnabled) {
           for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button));
               }
           } else {
              print(String(format: "%@ is selected.\n", radioButton.selected()!));
           }
            self.delegateDivingBoards?.didTapOnCellDivingBoards(_btnDivingBoardTag: radioButton.tag)
       }
    
}

//MARK:- Slides

protocol SlidesCellProtocol {
    func didTapOnCellSlides(_btnSlidesTag: Int)
}

class SlidesTableCell: UITableViewCell{
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionvw: UploadCollectionVw!
    
    var delegateSlides: SlidesCellProtocol?
          
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btnSlidesDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
        for button in radioButton.selectedButtons() {
               print(String(format: "%@ is selected.\n", button));
            }
        } else {
           print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
         self.delegateSlides?.didTapOnCellSlides(_btnSlidesTag: radioButton.tag)
    }
    
}

//MARK:- MAIN DRAINS

protocol PoolSubOptionCellProtocol {
    func didTapOnCellPoolSubOption(_btnPoolSubOptionTag: Int)
}

protocol SpaSubOptionCellProtocol {
    func didTapOnCellSpaSubOption(_btnSpaSubOptionTag: Int)
}

protocol MainDrainOptionCellProtocol {
    func didTapOnCellMainDrainOption(_btnMainDrainOptionTag: Int)
}

class MainDrainsHeaderTableCell: UITableViewCell{
    
    @IBOutlet weak var btnMainDrainUpload: UIButton!
    @IBOutlet weak var mainDrainCollectionvw: UploadCollectionVw!
    
    @IBOutlet weak var btnBasinUpload: UIButton!
    @IBOutlet weak var basinCollectionvw: UploadCollectionVw!
    
    @IBOutlet weak var btnPoolUpload: UIButton!
    @IBOutlet weak var poolCollectionvw: UploadCollectionVw!
    
    @IBOutlet weak var btnSpaUpload: UIButton!
    @IBOutlet weak var spaCollectionvw: UploadCollectionVw!
    
    @IBOutlet weak var btnFeatureUpload: UIButton!
    @IBOutlet weak var featureCollectionvw: UploadCollectionVw!
    
    @IBOutlet weak var btnDrainUpload: UIButton!
    @IBOutlet weak var drainCollectionvw: UploadCollectionVw!
    
    @IBOutlet weak var option1SubHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var option1SubView: UIView!
    @IBOutlet weak var option2SubView: UIView!
    @IBOutlet weak var option2SubHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var txtMainDrain: UITextView!
    
    var delegatePoolSubOption: PoolSubOptionCellProtocol?
    var delegateSpaSubOption: SpaSubOptionCellProtocol?
    var delegateMainDrainOption: MainDrainOptionCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtMainDrain.layer.borderColor = UIColor.black.cgColor
        self.txtMainDrain.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtMainDrain.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtMainDrain.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPoolSubOptionsDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
        for button in radioButton.selectedButtons() {
               print(String(format: "%@ is selected.\n", button));
            }
        } else {
           print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
         self.delegatePoolSubOption?.didTapOnCellPoolSubOption(_btnPoolSubOptionTag: radioButton.tag)
    }
    
    @IBAction func btnSpaSubOptionDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
        for button in radioButton.selectedButtons() {
               print(String(format: "%@ is selected.\n", button));
            }
        } else {
           print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateSpaSubOption?.didTapOnCellSpaSubOption(_btnSpaSubOptionTag: radioButton.tag)
    }
    
    @IBAction func btnMainDrainOptionDidTap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
        if (radioButton.isMultipleSelectionEnabled) {
        for button in radioButton.selectedButtons() {
               print(String(format: "%@ is selected.\n", button));
            }
        } else {
           print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateMainDrainOption?.didTapOnCellMainDrainOption(_btnMainDrainOptionTag: radioButton.tag)
    }
}


protocol SplitDrainProtocol {
    func didTapOnCellSplitDrain(_btnDescribeTag: Int)
}

class SplitDrainTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btn1: DLRadioButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var btn2: DLRadioButton!
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSplitDrain: SplitDrainProtocol?
    
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
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateSplitDrain?.didTapOnCellSplitDrain(_btnDescribeTag: radioButton.tag)
    }
}

protocol VGBCoverProtocol {
    func didTapOnCellVGBCover(_btnDescribeTag: Int)
}

class VGBCoverTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btn1: DLRadioButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var btn2: DLRadioButton!
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateVGBCover: VGBCoverProtocol?
    
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
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateVGBCover?.didTapOnCellVGBCover(_btnDescribeTag: radioButton.tag)
    }
}

protocol CoverMountedProtocol {
    func didTapOnCellCoverMounted(_btnDescribeTag: Int)
}

class CoverMountedTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btn1: DLRadioButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var btn2: DLRadioButton!
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateCoverMounted: CoverMountedProtocol?
    
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
        
    @objc @IBAction private func describeYesBtn(radioButton : DLRadioButton) {
        print(radioButton.tag)
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        delegateCoverMounted?.didTapOnCellCoverMounted(_btnDescribeTag: radioButton.tag)
    }
}

