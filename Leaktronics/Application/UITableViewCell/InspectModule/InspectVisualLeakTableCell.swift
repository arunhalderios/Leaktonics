//
//  InspectVisualLeakTableCell.swift
//  Leaktronics
//
//  Created by ivaninfotech on 5/27/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton



protocol InspectEquipmentAreaCellProtocol {
    func didTapOnCellInspectEquipmentArea(_btnEquipmentAreaTag: Int)
}

class InspectEquipmentAreaCell: UITableViewCell {
    @IBOutlet weak var vwWhereDescription: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    
    //TODO:: Variable Declaration
    var delegateEquiArea: InspectEquipmentAreaCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code

        self.vwWhereDescription.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.vwWhereDescription.layer.borderWidth = 0.68
            self.vwWhereDescription.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.vwWhereDescription.layer.borderWidth = 0.85
            self.vwWhereDescription.layer.cornerRadius = 10
        }
    }
    
    @objc @IBAction private func equipmentAreaBtn(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        
        self.delegateEquiArea?.didTapOnCellInspectEquipmentArea(_btnEquipmentAreaTag: radioButton.tag)
    }
}

protocol BackWashCellProtocol {
    func didTapOnCellBackWash(_btnBackWashTag: Int)
}

class BackWashImgTableCell: UITableViewCell{
    @IBOutlet weak var lblOptionalImg: UILabel!
    @IBOutlet weak var vwBtn: UIView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var btnOptionImg1: DLRadioButton!
    @IBOutlet weak var btnOptionImg2: DLRadioButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    
    //TODO:: Variable Declaration
    var delegateBackWash: BackWashCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
    }
    
    @objc @IBAction private func optionalCheckBtn(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        
        self.delegateBackWash?.didTapOnCellBackWash(_btnBackWashTag: radioButton.tag)
    }
}

protocol AroundWaterCellProtocol {
    func didTapOnCellAroundWater(_btnAroundWaterTag: Int)
}

class AroundWaterImgTableCell: UITableViewCell{
    @IBOutlet weak var lblOptionalImg: UILabel!
    @IBOutlet weak var vwBtn: UIView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var btnOptionImg1: DLRadioButton!
    @IBOutlet weak var btnOptionImg2: DLRadioButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    
    //TODO:: Variable Declaration
    var delegateAroundWater: AroundWaterCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
    }
    
    @objc @IBAction private func optionalCheckBtn(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        
        self.delegateAroundWater?.didTapOnCellAroundWater(_btnAroundWaterTag: radioButton.tag)
    }
}

protocol SolarSystemCellProtocol {
    func didTapOnCellSolarSystem(_btnSolarSystemTag: Int)
}

class SolarSystemImgTableCell: UITableViewCell{
    @IBOutlet weak var lblOptionalImg: UILabel!
    @IBOutlet weak var vwBtn: UIView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var btnOptionImg1: DLRadioButton!
    @IBOutlet weak var btnOptionImg2: DLRadioButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    
    //TODO:: Variable Declaration
    var delegateSolarSystem: SolarSystemCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
    }
    
    @objc @IBAction private func optionalCheckBtn(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        
        self.delegateSolarSystem?.didTapOnCellSolarSystem(_btnSolarSystemTag: radioButton.tag)
    }
}

protocol CatchBasinCellProtocol {
    func didTapOnCellCatchBasin(_btnCatchBasinTag: Int)
}

class CatchBasinImgTableCell: UITableViewCell{
    @IBOutlet weak var lblOptionalImg: UILabel!
    @IBOutlet weak var vwBtn: UIView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var btnOptionImg1: DLRadioButton!
    @IBOutlet weak var btnOptionImg2: DLRadioButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    
    //TODO:: Variable Declaration
    var delegateCatchBasin: CatchBasinCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
    }
    
    @objc @IBAction private func optionalCheckBtn(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        
        self.delegateCatchBasin?.didTapOnCellCatchBasin(_btnCatchBasinTag: radioButton.tag)
    }
}

protocol SlotDrainsCellProtocol {
    func didTapOnCellSlotDrains(_btnSlotDrainsTag: Int)
}

class SlotDrainsImgTableCell: UITableViewCell{
    @IBOutlet weak var lblOptionalImg: UILabel!
    @IBOutlet weak var vwBtn: UIView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var btnOptionImg1: DLRadioButton!
    @IBOutlet weak var btnOptionImg2: DLRadioButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    
    //TODO:: Variable Declaration
    var delegateSlotDrains: SlotDrainsCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
    }
    
    @objc @IBAction private func optionalCheckBtn(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        
        self.delegateSlotDrains?.didTapOnCellSlotDrains(_btnSlotDrainsTag: radioButton.tag)
    }
}

protocol VinylCellProtocol {
    func didTapOnCellVinyl(_btnVinylTag: Int)
}

class VinylImgTableCell: UITableViewCell{
    @IBOutlet weak var lblOptionalImg: UILabel!
    @IBOutlet weak var vwBtn: UIView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var btnOptionImg1: DLRadioButton!
    @IBOutlet weak var lblOptional1: UILabel!
    @IBOutlet weak var btnOptionImg2: DLRadioButton!
    @IBOutlet weak var lblOptional2: UILabel!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    
    //TODO:: Variable Declaration
    var delegateVinyl: VinylCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
    }
    
    @objc @IBAction private func optionalCheckBtn(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        
        self.delegateVinyl?.didTapOnCellVinyl(_btnVinylTag: radioButton.tag)
    }
}

protocol NoticeableCellProtocol {
    func didTapOnCellNoticeable(_btnNoticeableTag: Int)
}

class NoticeableImgTableCell: UITableViewCell{
    @IBOutlet weak var lblOptionalImg: UILabel!
    @IBOutlet weak var vwBtn: UIView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var btnOptionImg1: DLRadioButton!
    @IBOutlet weak var lblOptional1: UILabel!
    @IBOutlet weak var btnOptionImg2: DLRadioButton!
    @IBOutlet weak var lblOptional2: UILabel!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    
    //TODO:: Variable Declaration
    var delegateNoticeable: NoticeableCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
    }
    
    @objc @IBAction private func optionalCheckBtn(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        
        self.delegateNoticeable?.didTapOnCellNoticeable(_btnNoticeableTag: radioButton.tag)
    }
}

protocol StructuralCracksCellProtocol {
    func didTapOnCellStructuralCracks(_btnStructuralCracksTag: Int)
}

class StructuralCracksTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var lblNote: UILabel!
    
    @IBOutlet weak var lblOptional1: UILabel!
    @IBOutlet weak var lblOptional2: UILabel!
    
    @IBOutlet weak var vwWhereDescription: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    
    //TODO:: Variable Declaration
    var delegateStructuralCracks: StructuralCracksCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code

        self.vwWhereDescription.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.vwWhereDescription.layer.borderWidth = 0.68
            self.vwWhereDescription.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.vwWhereDescription.layer.borderWidth = 0.85
            self.vwWhereDescription.layer.cornerRadius = 10
        }
    }
    
    @objc @IBAction private func equipmentAreaBtn(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        
        self.delegateStructuralCracks?.didTapOnCellStructuralCracks(_btnStructuralCracksTag: radioButton.tag)
    }
}

protocol BondBeamCellProtocol {
    func didTapOnCellBondBeam(_btnBondBeamTag: Int)
}

class BondBeamTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var lblNote: UILabel!
    
    @IBOutlet weak var lblOptional1: UILabel!
    @IBOutlet weak var lblOptional2: UILabel!
    
    @IBOutlet weak var vwWhereDescription: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    
    //TODO:: Variable Declaration
    var delegateBondBeam: BondBeamCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code

        self.vwWhereDescription.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.vwWhereDescription.layer.borderWidth = 0.68
            self.vwWhereDescription.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.vwWhereDescription.layer.borderWidth = 0.85
            self.vwWhereDescription.layer.cornerRadius = 10
        }
    }
    
    @objc @IBAction private func equipmentAreaBtn(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        
        self.delegateBondBeam?.didTapOnCellBondBeam(_btnBondBeamTag: radioButton.tag)
    }
}

protocol SurgeTankPoolProtocol {
    func didTapOnCellSurgeTankPool(_btnDescribeTag: Int)
}

class SurgeTankPoolTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateSurgeTankPool: SurgeTankPoolProtocol?
    
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
        delegateSurgeTankPool?.didTapOnCellSurgeTankPool(_btnDescribeTag: radioButton.tag)
    }
}

protocol ScumGuttersProtocol {
    func didTapOnCellScumGutters(_btnDescribeTag: Int)
}

class ScumGuttersTableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateScumGutters: ScumGuttersProtocol?
    
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
        delegateScumGutters?.didTapOnCellScumGutters(_btnDescribeTag: radioButton.tag)
    }
}

protocol CommercialBondBeanProtocol {
    func didTapOnCellBondBeam(_btnDescribeTag: Int)
}

protocol CommercialInnerBondBeamProtocol {
    func didTapOnCellInnerBondBeam(_btnDescribeTag: Int)
}

class CommercialBondBeamTableCell: UITableViewCell {
    
     @IBOutlet weak var lblTag: UILabel!
    
     var delegateBondBeam: CommercialBondBeanProtocol?
    var delegateInnerBondBeam: CommercialInnerBondBeamProtocol?
        
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
           delegateBondBeam?.didTapOnCellBondBeam(_btnDescribeTag: radioButton.tag)
       }
    
    @IBAction func btnInnerOptionDidTsap(_ radioButton: DLRadioButton) {
        print(radioButton.tag)
                  
                  if (radioButton.isMultipleSelectionEnabled) {
                      for button in radioButton.selectedButtons() {
                          print(String(format: "%@ is selected.\n", button));
                      }
                  } else {
                      print(String(format: "%@ is selected.\n", radioButton.selected()!));
                  }
                  delegateInnerBondBeam?.didTapOnCellInnerBondBeam(_btnDescribeTag: radioButton.tag)
    }
    
    
}

class ReturnsValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class SkimmerValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class SkimmerSeamValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class MainDrainValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class NichesValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class SideSuctionValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class CleanerLinesValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class SkimmerPortsValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class EqualizerValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class StructuralCracksValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class ExplainValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class SpaJetsValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class SpaFillValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class SuctionsValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class SurgeTankValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class ScumGuttersValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class AutofillValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class ArroundFitValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


class NotedCracksValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class DescribeValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
