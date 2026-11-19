//
//  InspectionTableCell.swift
//  Leaktronics
//
//  Created by ivaninfotech on 4/30/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import DLRadioButton
import SDWebImage


class HeaderTableCell: UITableViewCell {
    @IBOutlet weak var lblHeaderText: UILabel!
}

//MARK:- Image CollectionView
class ImageViewCell: UICollectionViewCell {
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var btnToDeleteOutlet: UIButton!
    
    var imageUrl: String = ""
    
    // MARK: - FUNCTIONS
    override func layoutSubviews() {
        let fileUrl = URL(string: imageUrl)
        print(fileUrl as Any)
        SDWebImageManager.shared().downloadImage(with: fileUrl as URL?, options: .continueInBackground, progress: {
            (receivedSize :Int, ExpectedSize :Int) in
        }, completed: {
            (image : UIImage?, error : Error?, cacheType : SDImageCacheType, finished : Bool, url : URL?) in
            self.imgV.image = image
            self.imgV.contentMode = .scaleAspectFill
        })
    }
}

protocol AddImgProtocol {
    func didTapImg(_indexPath: Int)
}
class AddImageViewCell: UICollectionViewCell {
    @IBOutlet weak var btnAddImgOutlet: UIButton!
    
    var delegate: AddImgProtocol?
    
    @IBAction func btnAddImage(_ sender: Any) {
        delegate?.didTapImg(_indexPath: (sender as AnyObject).tag)
    }
}

//MARK:- PoolDetection Module
protocol PhoneQuestionnaireProtocol {
    func didTapOnCommercialPool(_isCommercialPool: Bool)
    func didTapOnFountain(_isFountain: Bool)
}

class PhoneQuestionnaireCell: UITableViewCell {
    
    @IBOutlet weak var btnCPoolYes: UIButton!
    @IBOutlet weak var btnCPoolNo: UIButton!
    
    @IBOutlet weak var btnFountainYes: UIButton!
    @IBOutlet weak var btnFountainNo: UIButton!
    
    //TODO:: Variable Declaration
    var delegatePhoneQuestionnaire: PhoneQuestionnaireProtocol?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func btnCommercialPool(_ sender: Any) {
        let btn = sender as! UIButton
        print("Clicked Index : \(btn.tag)")
        if btn.tag == 10 {
            self.btnCPoolYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnCPoolNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnCPoolYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.btnCPoolNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.delegatePhoneQuestionnaire?.didTapOnCommercialPool(_isCommercialPool: true)
        } else if btn.tag == 11 {
            self.btnCPoolYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnCPoolNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnCPoolYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnCPoolNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.delegatePhoneQuestionnaire?.didTapOnCommercialPool(_isCommercialPool: false)
        }
    }
    @IBAction func btnFountain(_ sender: Any) {
        let btn = sender as! UIButton
        print("Clicked Index : \(btn.tag)")
        if btn.tag == 20 {
            self.btnFountainYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnFountainNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnFountainYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.btnFountainNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.delegatePhoneQuestionnaire?.didTapOnFountain(_isFountain: true)
        } else if btn.tag == 21 {
            self.btnFountainYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnFountainNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnFountainYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnFountainNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.delegatePhoneQuestionnaire?.didTapOnFountain(_isFountain: false)
        }
    }

}


//MARK:- QuestionnaireForm1VC
protocol FindUsCellProtocol {
    func didTapOnCellFindUs(_btnFindUsTag: Int)
}

class FindUsTableCell: UITableViewCell {
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnFindOptionOutlet: UIButton!
    
    @IBOutlet weak var imgFindUsOptn0: UIImageView!
    @IBOutlet weak var imgFindUsOptn1: UIImageView!
    @IBOutlet weak var imgFindUsOptn2: UIImageView!
    
    var imgFindUsOptn0Bool = false
    var imgFindUsOptn1Bool = false
    var imgFindUsOptn2Bool = false
    
    var delegateFindUs: FindUsCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if btnFindOptionOutlet.tag == 2 {
            if imgFindUsOptn2Bool == true{
                self.txtOther.isUserInteractionEnabled = true
            }
            else{
                self.txtOther.text = ""
                self.txtOther.isUserInteractionEnabled = false

            }
        }
//        else {
//            self.txtOther.text = ""
//            self.txtOther.isUserInteractionEnabled = false
//        }
        
        self.txtOther.isUserInteractionEnabled = false
        self.txtOther.layer.borderColor = UIColor.black.cgColor
        self.txtOther.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtOther.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtOther.layer.cornerRadius = 10
        }
    }
    
    @IBAction func findUsBtn(_ radioButton : UIButton) {
        print(radioButton.tag)
//        if radioButton.tag == 2 {
//            self.txtOther.isUserInteractionEnabled = true
//        } else {
//            self.txtOther.text = ""
//            self.txtOther.isUserInteractionEnabled = false
//        }
        
        
        /*if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }*/
        
        //Arun change - 27.07.2020


        
        if imgFindUsOptn0.tag == radioButton.tag {
            print("imgFindUsOptn0Bool:\(imgFindUsOptn0Bool)")

            if imgFindUsOptn0Bool == false{
                imgFindUsOptn0.image = UIImage(named: "checkmark")
                imgFindUsOptn0Bool = true
            }
            else if imgFindUsOptn0Bool == true{
                imgFindUsOptn0.image = UIImage(named: "unchecked")
                imgFindUsOptn0Bool = false
            }
           // imgFindUsOptn1.image = UIImage(named: "unchecked")
           // imgFindUsOptn2.image = UIImage(named: "unchecked")
        } //else
        if imgFindUsOptn1.tag == radioButton.tag {
            print("imgFindUsOptn1Bool:\(imgFindUsOptn1Bool)")

            if imgFindUsOptn1Bool == false{
                imgFindUsOptn1.image = UIImage(named: "checkmark")
                imgFindUsOptn1Bool = true
            }
            else if imgFindUsOptn1Bool == true{
                imgFindUsOptn1.image = UIImage(named: "unchecked")
                imgFindUsOptn1Bool = false
            }
            
           // imgFindUsOptn0.image = UIImage(named: "unchecked")
           // imgFindUsOptn2.image = UIImage(named: "unchecked")
        } //else
        if imgFindUsOptn2.tag == radioButton.tag {
            print("imgFindUsOptn2Bool:\(imgFindUsOptn2Bool)")
            if imgFindUsOptn2Bool == false{
                imgFindUsOptn2.image = UIImage(named: "checkmark")
                imgFindUsOptn2Bool = true
                self.txtOther.isUserInteractionEnabled = true

            }
           else if imgFindUsOptn2Bool == true{
                imgFindUsOptn2.image = UIImage(named: "unchecked")
                imgFindUsOptn2Bool = false
                self.txtOther.text = ""
                self.txtOther.isUserInteractionEnabled = false

            }
//            imgFindUsOptn0.image = UIImage(named: "unchecked")
//            imgFindUsOptn1.image = UIImage(named: "unchecked")
        }
        
        self.delegateFindUs?.didTapOnCellFindUs(_btnFindUsTag: radioButton.tag)
    }
}

protocol ReasonForCallProtocol {
    func didTapOnReasonForCall(_btnReasonForCallTag: Int)
}

class ReasonForCallTableCell: UITableViewCell {
    
    @IBOutlet weak var imgReasonForCallOptn0: UIImageView!
    @IBOutlet weak var imgReasonForCallOptn1: UIImageView!
    @IBOutlet weak var imgReasonForCallOptn2: UIImageView!
    @IBOutlet weak var imgReasonForCallOptn3: UIImageView!
    
    var delegateReasonForCall: ReasonForCallProtocol?
    
    @IBAction func reasonForCallBtn(_ radioButton: UIButton) {
        print(radioButton.tag)
        
        if imgReasonForCallOptn0.tag == radioButton.tag {
            imgReasonForCallOptn0.image = UIImage(named: "checkmark")
            imgReasonForCallOptn1.image = UIImage(named: "unchecked")
            imgReasonForCallOptn2.image = UIImage(named: "unchecked")
            imgReasonForCallOptn3.image = UIImage(named: "unchecked")
        } else if imgReasonForCallOptn1.tag == radioButton.tag {
            imgReasonForCallOptn0.image = UIImage(named: "unchecked")
            imgReasonForCallOptn1.image = UIImage(named: "checkmark")
            imgReasonForCallOptn2.image = UIImage(named: "unchecked")
            imgReasonForCallOptn3.image = UIImage(named: "unchecked")
        } else if imgReasonForCallOptn2.tag == radioButton.tag {
            imgReasonForCallOptn0.image = UIImage(named: "unchecked")
            imgReasonForCallOptn1.image = UIImage(named: "unchecked")
            imgReasonForCallOptn2.image = UIImage(named: "checkmark")
            imgReasonForCallOptn3.image = UIImage(named: "unchecked")
        } else if imgReasonForCallOptn3.tag == radioButton.tag {
            imgReasonForCallOptn0.image = UIImage(named: "unchecked")
            imgReasonForCallOptn1.image = UIImage(named: "unchecked")
            imgReasonForCallOptn2.image = UIImage(named: "unchecked")
            imgReasonForCallOptn3.image = UIImage(named: "checkmark")
        }
        
        self.delegateReasonForCall?.didTapOnReasonForCall(_btnReasonForCallTag: radioButton.tag)
    }
}


protocol PoolSizeProtocol {
    func didTapOnPoolSize(_btnPoolSizeTag: Int)
}

class PoolSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var imgPoolSizeOptn0: UIImageView!
    @IBOutlet weak var imgPoolSizeOptn1: UIImageView!
    @IBOutlet weak var imgPoolSizeOptn2: UIImageView!
    @IBOutlet weak var imgPoolSizeOptn3: UIImageView!
    
    var delegatePoolSize: PoolSizeProtocol?
    
    @IBAction func poolSizeBtn(_ radioButton: UIButton) {
        print(radioButton.tag)
        
        if imgPoolSizeOptn0.tag == radioButton.tag {
            imgPoolSizeOptn0.image = UIImage(named: "checkmark")
            imgPoolSizeOptn1.image = UIImage(named: "unchecked")
            imgPoolSizeOptn2.image = UIImage(named: "unchecked")
            imgPoolSizeOptn3.image = UIImage(named: "unchecked")
        } else if imgPoolSizeOptn1.tag == radioButton.tag {
            imgPoolSizeOptn0.image = UIImage(named: "unchecked")
            imgPoolSizeOptn1.image = UIImage(named: "checkmark")
            imgPoolSizeOptn2.image = UIImage(named: "unchecked")
            imgPoolSizeOptn3.image = UIImage(named: "unchecked")
        } else if imgPoolSizeOptn2.tag == radioButton.tag {
            imgPoolSizeOptn0.image = UIImage(named: "unchecked")
            imgPoolSizeOptn1.image = UIImage(named: "unchecked")
            imgPoolSizeOptn2.image = UIImage(named: "checkmark")
            imgPoolSizeOptn3.image = UIImage(named: "unchecked")
        } else if imgPoolSizeOptn3.tag == radioButton.tag {
            imgPoolSizeOptn0.image = UIImage(named: "unchecked")
            imgPoolSizeOptn1.image = UIImage(named: "unchecked")
            imgPoolSizeOptn2.image = UIImage(named: "unchecked")
            imgPoolSizeOptn3.image = UIImage(named: "checkmark")
        }
        
        self.delegatePoolSize?.didTapOnPoolSize(_btnPoolSizeTag: radioButton.tag)
    }
}

protocol SpaSizeProtocol {
    func didTapOnSpaSize(_btnSpaSizeTag: Bool)
}

class SpaSizeTableCell: UITableViewCell {
    
    @IBOutlet weak var imgSpaSize: UIImageView!
    @IBOutlet weak var txtDimension: UITextField!
    @IBOutlet weak var btnSpaSizeOutlet: UIButton!
    var delegateSpaSize: SpaSizeProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        print(self.btnSpaSizeOutlet.isSelected)
        self.txtDimension.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor//UIColor.black.cgColor //
        self.txtDimension.layer.borderWidth = 0.68
        self.txtDimension.layer.cornerRadius = 5
    }
    
    @IBAction func spaSizeButton(_ sender: Any) {
        self.btnSpaSizeOutlet.isSelected = !self.btnSpaSizeOutlet.isSelected
        if (self.btnSpaSizeOutlet.isSelected) {
             print(String(format: "is selected.\n"))
             self.imgSpaSize.image = UIImage(named: "checkmark")
             self.delegateSpaSize?.didTapOnSpaSize(_btnSpaSizeTag: true)
        } else {
            print(String(format: "is not selected.\n"))
            self.imgSpaSize.image = UIImage(named: "unchecked")
            //self.imgSpaSize.setImage(UIImage(named: "unchecked"), for: .normal)
            self.delegateSpaSize?.didTapOnSpaSize(_btnSpaSizeTag: false)
        }
    }
}


class SpaSizeDescriptionTableCell: UITableViewCell {
    @IBOutlet weak var txtDescription: UITextView!
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
        
        self.txtDescription.layer.borderColor = UIColor.black.cgColor
        self.txtDescription.layer.borderWidth = 0.68
        self.txtDescription.layer.cornerRadius = 5
    }
}


//MARK:- QuestionnaireForm2VC
protocol PoolSurfaceProtocol {
    func didTapOnPoolSurfacee(_btnPoolSurfaceTag: Int)
}

class PoolSurfaceTableCell: UITableViewCell {
    
    @IBOutlet weak var imgPoolSurfaceOptn0: UIImageView!
    @IBOutlet weak var imgPoolSurfaceOptn1: UIImageView!
    @IBOutlet weak var imgPoolSurfaceOptn2: UIImageView!
    @IBOutlet weak var imgPoolSurfaceOptn3: UIImageView!
    @IBOutlet weak var imgPoolSurfaceOptn4: UIImageView!
    
    var delegatePoolSurface: PoolSurfaceProtocol?
    
    @IBAction func poolSurfaceBtn(_ radioButton: UIButton) {
        print(radioButton.tag)
        
        if imgPoolSurfaceOptn0.tag == radioButton.tag {
            imgPoolSurfaceOptn0.image = UIImage(named: "checkmark")
            imgPoolSurfaceOptn1.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn2.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn3.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn4.image = UIImage(named: "unchecked")
        } else if imgPoolSurfaceOptn1.tag == radioButton.tag {
            imgPoolSurfaceOptn0.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn1.image = UIImage(named: "checkmark")
            imgPoolSurfaceOptn2.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn3.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn4.image = UIImage(named: "unchecked")
        } else if imgPoolSurfaceOptn2.tag == radioButton.tag {
            imgPoolSurfaceOptn0.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn1.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn2.image = UIImage(named: "checkmark")
            imgPoolSurfaceOptn3.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn4.image = UIImage(named: "unchecked")
        } else if imgPoolSurfaceOptn3.tag == radioButton.tag {
            imgPoolSurfaceOptn0.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn1.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn2.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn3.image = UIImage(named: "checkmark")
            imgPoolSurfaceOptn4.image = UIImage(named: "unchecked")
        } else if imgPoolSurfaceOptn4.tag == radioButton.tag {
            imgPoolSurfaceOptn0.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn1.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn2.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn3.image = UIImage(named: "unchecked")
            imgPoolSurfaceOptn4.image = UIImage(named: "checkmark")
        }
        
        self.delegatePoolSurface?.didTapOnPoolSurfacee(_btnPoolSurfaceTag: radioButton.tag)
    }
}

protocol BoolProtocol {
    func didTapOnPumpRunningStatus(_btnPumpRunning: Int)
    func didTapOnWaterVisible(_isWaterVisible: Bool)
    func didTapOnRecentWorkAroundPool(_isRecentWorkAroundPool: Bool)
    func didTapOnPoolCleaning(_isPoolCleaning: Bool)
    func didTapOnFloorSystem(_isFloorSystem: Bool)
}

class BoolTableCell: UITableViewCell {
    
    @IBOutlet weak var btnPumpRunningYes: UIButton!
    @IBOutlet weak var btnPumpRunningNo: UIButton!
    @IBOutlet weak var btnPumpRunningUnSure: UIButton!
    
    @IBOutlet weak var txtPumpRunning: UITextView!
    
    @IBOutlet weak var btnWaterVisibleYes: UIButton!
    @IBOutlet weak var btnWaterVisibleNo: UIButton!
    
    @IBOutlet weak var btnRecentWorkYes: UIButton!
    @IBOutlet weak var btnRecentWorkNo: UIButton!
    
    @IBOutlet weak var btnPoolCleanYes: UIButton!
    @IBOutlet weak var btnPoolCleanNo: UIButton!
    
    @IBOutlet weak var btnFloorSystemYes: UIButton!
    @IBOutlet weak var btnFloorSystemNo: UIButton!
    
    
    var delegateBool: BoolProtocol?

    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtPumpRunning.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPumpRunning.layer.borderWidth = 0.68
            self.txtPumpRunning.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPumpRunning.layer.borderWidth = 0.85
            self.txtPumpRunning.layer.cornerRadius = 10
        }
    }
    
    @IBAction func btnPumpRunningDidTap(_ sender: Any) {
        let btn = sender as! UIButton
        print("Clicked Index : \(btn.tag)")
        if btn.tag == 0 {
            self.btnPumpRunningYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnPumpRunningYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.btnPumpRunningNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnPumpRunningNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnPumpRunningUnSure.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnPumpRunningUnSure.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.delegateBool?.didTapOnPumpRunningStatus(_btnPumpRunning: btn.tag)
        } else if btn.tag == 1 {
            self.btnPumpRunningYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnPumpRunningYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnPumpRunningNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnPumpRunningNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.btnPumpRunningUnSure.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnPumpRunningUnSure.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.delegateBool?.didTapOnPumpRunningStatus(_btnPumpRunning: btn.tag)
        } else if btn.tag == 2 {
            self.btnPumpRunningYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnPumpRunningYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnPumpRunningNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnPumpRunningNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnPumpRunningUnSure.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnPumpRunningUnSure.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.delegateBool?.didTapOnPumpRunningStatus(_btnPumpRunning: btn.tag)
        }
    }
    @IBAction func btnWaterVisibleDidTap(_ sender: Any) {
        let btn = sender as! UIButton
        print("Clicked Index : \(btn.tag)")
        if btn.tag == 20 {
            self.btnWaterVisibleYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnWaterVisibleYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.btnWaterVisibleNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnWaterVisibleNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.delegateBool?.didTapOnWaterVisible(_isWaterVisible: true)
        } else if btn.tag == 21 {
            self.btnWaterVisibleYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnWaterVisibleYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnWaterVisibleNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnWaterVisibleNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.delegateBool?.didTapOnWaterVisible(_isWaterVisible: false)
        }
    }
    @IBAction func btnRecentWorkDidTap(_ sender: Any) {
        let btn = sender as! UIButton
        print("Clicked Index : \(btn.tag)")
        if btn.tag == 30 {
            self.btnRecentWorkYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnRecentWorkYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.btnRecentWorkNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnRecentWorkNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.delegateBool?.didTapOnRecentWorkAroundPool(_isRecentWorkAroundPool: true)
        } else if btn.tag == 31 {
            self.btnRecentWorkYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnRecentWorkYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnRecentWorkNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnRecentWorkNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.delegateBool?.didTapOnRecentWorkAroundPool(_isRecentWorkAroundPool: false)
        }
    }
    @IBAction func btnPoolCleaningDidTap(_ sender: Any) {
        let btn = sender as! UIButton
        print("Clicked Index : \(btn.tag)")
        if btn.tag == 40 {
            self.btnPoolCleanYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnPoolCleanYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.btnPoolCleanNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnPoolCleanNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.delegateBool?.didTapOnPoolCleaning(_isPoolCleaning: true)
        } else if btn.tag == 41 {
            self.btnPoolCleanYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnPoolCleanYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnPoolCleanNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnPoolCleanNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.delegateBool?.didTapOnPoolCleaning(_isPoolCleaning: false)
        }
    }
    @IBAction func btnFloorSystemDidTap(_ sender: Any) {
        let btn = sender as! UIButton
        print("Clicked Index : \(btn.tag)")
        if btn.tag == 50 {
            self.btnFloorSystemYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnFloorSystemYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.btnFloorSystemNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnFloorSystemNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.delegateBool?.didTapOnFloorSystem(_isFloorSystem: true)
        } else if btn.tag == 51 {
            self.btnFloorSystemYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnFloorSystemYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnFloorSystemNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnFloorSystemNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.delegateBool?.didTapOnFloorSystem(_isFloorSystem: false)
        }
    }
}

protocol WaterFeatureProtocol {
    func didTapOnPoolWaterFeature(_isPoolWaterFeature: Bool)
    func didTapOnPoolWaterFeatureOption(_btnPoolWaterFeatureTag: Int)
    func didTapOnSolarSystem(_isSolarSystem: Bool)
}
class WaterFeatureTableCell: UITableViewCell {
    @IBOutlet weak var btnPoolWaterFeatureYes: UIButton!
    @IBOutlet weak var btnPoolWaterFeatureNo: UIButton!
    
    @IBOutlet weak var btnSolarSystemYes: UIButton!
    @IBOutlet weak var btnSolarSystemNo: UIButton!
    
    @IBOutlet weak var imgWaterFeatureOptn0: UIImageView!
    @IBOutlet weak var imgWaterFeatureOptn1: UIImageView!
    @IBOutlet weak var imgWaterFeatureOptn2: UIImageView!
    @IBOutlet weak var imgWaterFeatureOptn3: UIImageView!
    @IBOutlet weak var imgWaterFeatureOptn4: UIImageView!
    
    var delegateWaterFeature: WaterFeatureProtocol?
    
    
    @IBAction func btnPoolWaterFeature(_ sender: Any) {
        let btn = sender as! UIButton
        print("Clicked Index : \(btn.tag)")
        if btn.tag == 60 {
            self.btnPoolWaterFeatureYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnPoolWaterFeatureNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnPoolWaterFeatureYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.btnPoolWaterFeatureNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.delegateWaterFeature?.didTapOnPoolWaterFeature(_isPoolWaterFeature: true)
        } else if btn.tag == 61 {
            self.btnPoolWaterFeatureYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnPoolWaterFeatureNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnPoolWaterFeatureYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnPoolWaterFeatureNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.delegateWaterFeature?.didTapOnPoolWaterFeature(_isPoolWaterFeature: false)
        }
    }
    @IBAction func btnPoolWaterFeatureOption(_ radioButton: UIButton) {
        print(radioButton.tag)
        
        if imgWaterFeatureOptn0.tag == radioButton.tag {
            imgWaterFeatureOptn0.image = UIImage(named: "checkmark")
//            imgWaterFeatureOptn1.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn2.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn3.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn4.image = UIImage(named: "unchecked")
        } else if imgWaterFeatureOptn1.tag == radioButton.tag {
            imgWaterFeatureOptn0.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn1.image = UIImage(named: "checkmark")
//            imgWaterFeatureOptn2.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn3.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn4.image = UIImage(named: "unchecked")
        } else if imgWaterFeatureOptn2.tag == radioButton.tag {
            imgWaterFeatureOptn0.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn1.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn2.image = UIImage(named: "checkmark")
//            imgWaterFeatureOptn3.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn4.image = UIImage(named: "unchecked")
        } else if imgWaterFeatureOptn3.tag == radioButton.tag {
            imgWaterFeatureOptn0.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn1.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn2.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn3.image = UIImage(named: "checkmark")
//            imgWaterFeatureOptn4.image = UIImage(named: "unchecked")
        } else if imgWaterFeatureOptn4.tag == radioButton.tag {
            imgWaterFeatureOptn0.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn1.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn2.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn3.image = UIImage(named: "unchecked")
//            imgWaterFeatureOptn4.image = UIImage(named: "checkmark")
        }
        
        self.delegateWaterFeature?.didTapOnPoolWaterFeatureOption(_btnPoolWaterFeatureTag: radioButton.tag)
    }
    @IBAction func btnSolarSystem(_ sender: Any) {
        let btn = sender as! UIButton
        print("Clicked Index : \(btn.tag)")
        if btn.tag == 70 {
            self.btnSolarSystemYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnSolarSystemYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.btnSolarSystemNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnSolarSystemNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.delegateWaterFeature?.didTapOnSolarSystem(_isSolarSystem: true)
        } else if btn.tag == 71 {
            self.btnSolarSystemYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnSolarSystemYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnSolarSystemNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnSolarSystemNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.delegateWaterFeature?.didTapOnSolarSystem(_isSolarSystem: false)
        }
    }
}

//MARK:- VisualLeakVC
protocol EquipmentAreaCellProtocol {
    func didTapOnCellEquipmentArea(_btnEquipmentAreaTag: Int)
}

class EquipmentAreaCell: UITableViewCell {
    @IBOutlet weak var vwWhereDescription: UITextView!
    
    @IBOutlet weak var imgEquipmentArea0: UIImageView!
    @IBOutlet weak var imgEquipmentArea1: UIImageView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    
    //TODO:: Variable Declaration
    var delegateEquiArea: EquipmentAreaCellProtocol?
    
    
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
    
    @IBAction func equipmentAreaBtn(_ radioButton: UIButton) {
        if imgEquipmentArea0.tag == radioButton.tag {
            imgEquipmentArea0.image = UIImage(named: "checkmark")
            imgEquipmentArea1.image = UIImage(named: "unchecked")
        } else if imgEquipmentArea1.tag == radioButton.tag {
            imgEquipmentArea0.image = UIImage(named: "unchecked")
            imgEquipmentArea1.image = UIImage(named: "checkmark")
        }
        self.delegateEquiArea?.didTapOnCellEquipmentArea(_btnEquipmentAreaTag: radioButton.tag)
    }
    
    /*func setCollectionViewDataSourceDelegate <D: UICollectionViewDataSource & UICollectionViewDelegate> (dataSourceDelegate: D, forRow row: Int) {
    
    collectionVw.delegate = dataSourceDelegate
    collectionVw.dataSource = dataSourceDelegate
    collectionVw.tag = row
    collectionVw.reloadData()
    }*/
}

protocol BackWashImageCellProtocol {
    func didTapOnCellBackWash(_btnBackWashTag: Int)
}

class BackWashImageTableCell: UITableViewCell {
    @IBOutlet weak var lblOptionalImg: UILabel!
    @IBOutlet weak var vwBtn: UIView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    @IBOutlet weak var imgBackWash0: UIImageView!
    @IBOutlet weak var imgBackWash1: UIImageView!
    
    //TODO:: Variable Declaration
    var delegateBackWash: BackWashImageCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
    }
    
    @IBAction func backWashBtn(_ radioButton : UIButton) {
        if imgBackWash0.tag == radioButton.tag {
            imgBackWash0.image = UIImage(named: "checkmark")
            imgBackWash1.image = UIImage(named: "unchecked")
        } else if imgBackWash1.tag == radioButton.tag {
            imgBackWash0.image = UIImage(named: "unchecked")
            imgBackWash1.image = UIImage(named: "checkmark")
        }
        self.delegateBackWash?.didTapOnCellBackWash(_btnBackWashTag: radioButton.tag)
    }
}

protocol AroundWaterImageCellProtocol {
    func didTapOnCellAroundWater(_btnAroundWaterTag: Int)
}

class AroundWaterImageTableCell: UITableViewCell {
    @IBOutlet weak var lblOptionalImg: UILabel!
    @IBOutlet weak var vwBtn: UIView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    @IBOutlet weak var imgAroundWater0: UIImageView!
    @IBOutlet weak var imgAroundWater1: UIImageView!
    
    //TODO:: Variable Declaration
    var delegateAroundWater: AroundWaterImageCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
    }
    
    @IBAction func aroundWaterBtn(_ radioButton : UIButton) {
        if imgAroundWater0.tag == radioButton.tag {
            imgAroundWater0.image = UIImage(named: "checkmark")
            imgAroundWater1.image = UIImage(named: "unchecked")
        } else if imgAroundWater1.tag == radioButton.tag {
            imgAroundWater0.image = UIImage(named: "unchecked")
            imgAroundWater1.image = UIImage(named: "checkmark")
        }
        self.delegateAroundWater?.didTapOnCellAroundWater(_btnAroundWaterTag: radioButton.tag)
    }
}

protocol SolarSystemImageCellProtocol {
    func didTapOnCellSolarSystem(_btnSolarSystemTag: Int)
}

class SolarSystemImageTableCell: UITableViewCell {
    @IBOutlet weak var lblOptionalImg: UILabel!
    @IBOutlet weak var vwBtn: UIView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    @IBOutlet weak var imgSolarSystem0: UIImageView!
    @IBOutlet weak var imgSolarSystem1: UIImageView!
    
    //TODO:: Variable Declaration
    var delegateSolarSystem: SolarSystemImageCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
    }
    
    @IBAction func solarSystemBtn(_ radioButton: UIButton) {
        if imgSolarSystem0.tag == radioButton.tag {
            imgSolarSystem0.image = UIImage(named: "checkmark")
            imgSolarSystem1.image = UIImage(named: "unchecked")
        } else if imgSolarSystem1.tag == radioButton.tag {
            imgSolarSystem0.image = UIImage(named: "unchecked")
            imgSolarSystem1.image = UIImage(named: "checkmark")
        }
        self.delegateSolarSystem?.didTapOnCellSolarSystem(_btnSolarSystemTag: radioButton.tag)
    }
}

protocol CatchBasinImageCellProtocol {
    func didTapOnCellCatchBasin(_btnCatchBasinTag: Int)
}

class CatchBasinImageTableCell: UITableViewCell {
    @IBOutlet weak var lblOptionalImg: UILabel!
    @IBOutlet weak var vwBtn: UIView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    @IBOutlet weak var imgCatchBasin0: UIImageView!
    @IBOutlet weak var imgCatchBasin1: UIImageView!
    
    //TODO:: Variable Declaration
    var delegateCatchBasin: CatchBasinImageCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
    }
    
    @IBAction func solarSystemBtn(_ radioButton: UIButton) {
        if imgCatchBasin0.tag == radioButton.tag {
            imgCatchBasin0.image = UIImage(named: "checkmark")
            imgCatchBasin1.image = UIImage(named: "unchecked")
        } else if imgCatchBasin1.tag == radioButton.tag {
            imgCatchBasin0.image = UIImage(named: "unchecked")
            imgCatchBasin1.image = UIImage(named: "checkmark")
        }
        self.delegateCatchBasin?.didTapOnCellCatchBasin(_btnCatchBasinTag: radioButton.tag)
    }
}

protocol SlotDrainImageCellProtocol {
    func didTapOnCellSlotDrain(_btnSlotDrainTag: Int)
}

class SlotDrainImageTableCell: UITableViewCell {
    @IBOutlet weak var lblOptionalImg: UILabel!
    @IBOutlet weak var vwBtn: UIView!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    @IBOutlet weak var imgSlotDrain0: UIImageView!
    @IBOutlet weak var imgSlotDrain1: UIImageView!
    
    //TODO:: Variable Declaration
    var delegateSlotDrain: SlotDrainImageCellProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
    }
    
    @IBAction func slotDrainBtn(_ radioButton: UIButton) {
        if imgSlotDrain0.tag == radioButton.tag {
            imgSlotDrain0.image = UIImage(named: "checkmark")
            imgSlotDrain1.image = UIImage(named: "unchecked")
        } else if imgSlotDrain1.tag == radioButton.tag {
            imgSlotDrain0.image = UIImage(named: "unchecked")
            imgSlotDrain1.image = UIImage(named: "checkmark")
        }
        self.delegateSlotDrain?.didTapOnCellSlotDrain(_btnSlotDrainTag: radioButton.tag)
    }
}

//MARK:- PlumbingStatisticVC
protocol EQLineCellProtocol {
    func didTapOnCellEQLine(_btnLeakingTag: Int)
}

class EQLineTableCell: UITableViewCell {
    
    @IBOutlet weak var imgEQLine0: UIImageView!
    @IBOutlet weak var imgEQLine1: UIImageView!
    
    var delegateEQLine: EQLineCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func EQLineBtn(_ radioButton : UIButton) {
        print(radioButton.tag)
        
        if imgEQLine0.tag == radioButton.tag {
            imgEQLine0.image = UIImage(named: "checkmark")
            imgEQLine1.image = UIImage(named: "unchecked")
        } else if imgEQLine1.tag == radioButton.tag {
            imgEQLine0.image = UIImage(named: "unchecked")
            imgEQLine1.image = UIImage(named: "checkmark")
        }
        self.delegateEQLine?.didTapOnCellEQLine(_btnLeakingTag: radioButton.tag)
    }
}

protocol LeakLocatorCellProtocol {
    func didTapOnCellPinHolesLeak(_btnPinHolesLeakTag: Int)
}

class LeakLocatorTableCell: UITableViewCell {
    
    //TODO:: Variable Declaration
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    
    var delegateLeakLocator: LeakLocatorCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnPinHolesLeak(_ sender: Any) {
        let btn = sender as! UIButton
        print("Clicked Index : \(btn.tag)")
        if btn.tag == 10 {
            print("10")
            self.btnYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.btnNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        } else if btn.tag == 20 {
            print("20")
            self.btnYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
        }
        self.delegateLeakLocator?.didTapOnCellPinHolesLeak(_btnPinHolesLeakTag: btn.tag)
    }
}

//MARK:- PlumbingStatistic2VC
protocol SuctionLineAirCellProtocol {
    func didTapOnCellSuctionLineAir(_btnSuctionLineAirTag: Int)
}

class SuctionLineAirTableCell: UITableViewCell {
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var imgSuctionLineAirOptn0: UIImageView!
    @IBOutlet weak var imgSuctionLineAirOptn1: UIImageView!
    @IBOutlet weak var imgSuctionLineAirOptn2: UIImageView!
    @IBOutlet weak var imgSuctionLineAirOptn3: UIImageView!
    @IBOutlet weak var imgSuctionLineAirOptn4: UIImageView!
    @IBOutlet weak var imgSuctionLineAirOptn5: UIImageView!

    
    var delegateSuctionLineAir: SuctionLineAirCellProtocol?
    
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
    
    @IBAction func btnSuctionLineAir(_ radioButton : UIButton) {
        print(radioButton.tag)
        if radioButton.tag == 5 {
            self.txtOther.isUserInteractionEnabled = true
        } else {
            self.txtOther.text = ""
            self.txtOther.isUserInteractionEnabled = false
        }
        
        if imgSuctionLineAirOptn0.tag == radioButton.tag {
            imgSuctionLineAirOptn0.image = UIImage(named: "checkmark")
            imgSuctionLineAirOptn1.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn2.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn3.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn4.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn5.image = UIImage(named: "unchecked")
        } else if imgSuctionLineAirOptn1.tag == radioButton.tag {
            imgSuctionLineAirOptn0.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn1.image = UIImage(named: "checkmark")
            imgSuctionLineAirOptn2.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn3.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn4.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn5.image = UIImage(named: "unchecked")
        } else if imgSuctionLineAirOptn2.tag == radioButton.tag {
            imgSuctionLineAirOptn0.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn1.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn2.image = UIImage(named: "checkmark")
            imgSuctionLineAirOptn3.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn4.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn5.image = UIImage(named: "unchecked")
        } else if imgSuctionLineAirOptn3.tag == radioButton.tag {
            imgSuctionLineAirOptn0.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn1.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn2.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn3.image = UIImage(named: "checkmark")
            imgSuctionLineAirOptn4.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn5.image = UIImage(named: "unchecked")
        } else if imgSuctionLineAirOptn4.tag == radioButton.tag {
            imgSuctionLineAirOptn0.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn1.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn2.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn3.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn4.image = UIImage(named: "checkmark")
            imgSuctionLineAirOptn5.image = UIImage(named: "unchecked")
        } else if imgSuctionLineAirOptn5.tag == radioButton.tag {
            imgSuctionLineAirOptn0.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn1.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn2.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn3.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn4.image = UIImage(named: "unchecked")
            imgSuctionLineAirOptn5.image = UIImage(named: "checkmark")
        }
        
        self.delegateSuctionLineAir?.didTapOnCellSuctionLineAir(_btnSuctionLineAirTag: radioButton.tag)
    }
}

class SurgeTankTableCell: UITableViewCell {
    @IBOutlet weak var txtPressure: UITextView!
    
    @IBOutlet weak var imgSuctionLineSurgeTankNA: UIImageView!

    var SurgeTankcheckStatus = false

    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtPressure.layer.borderColor = UIColor.black.cgColor
        self.txtPressure.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtPressure.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtPressure.layer.cornerRadius = 10
        }
    }
    
    @IBAction func SurgeTankIsApplicable(_ radioButton : UIButton) {
        print(radioButton.tag)
        
        if SurgeTankcheckStatus == false{
            SurgeTankcheckStatus = true
            imgSuctionLineSurgeTankNA.image = UIImage(named: "checkmark")
        }
        else{
            SurgeTankcheckStatus = false
            imgSuctionLineSurgeTankNA.image = UIImage(named: "unchecked")
        }

    }

}

protocol MarkLocationCellProtocol {
    func didTapOnCellMarkLocation(_isMarkLocation: Bool)
}

class MarkLocationTableCell: UITableViewCell {
    
    @IBOutlet weak var lblMarkLoc: UILabel!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    //TODO:: Variable Declaration
    var delegateMarkLocation: MarkLocationCellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnMarkLocationDidTap(_ sender: Any) {
        let btn = sender as! UIButton
        print("Clicked Index : \(btn.tag)")
        if btn.tag == 11 {
            print("11")
            self.btnYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.btnNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.delegateMarkLocation?.didTapOnCellMarkLocation(_isMarkLocation: true)
        } else if btn.tag == 21 {
            print("21")
            self.btnYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.delegateMarkLocation?.didTapOnCellMarkLocation(_isMarkLocation: false)
        }
    }
}

protocol EstimateCellProtocol {
    func didTapOnCellEstimate(_isEstimate: Bool)
}

class EstimateTableCell: UITableViewCell {
       
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    //TODO:: Variable Declaration
    var delegateEstimate: EstimateCellProtocol?
       
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
       
    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)

       // Configure the view for the selected state
    }
    
    @IBAction func btnEstimateDidTap(_ sender: Any) {
        let btn = sender as! UIButton
        print("Clicked Index : \(btn.tag)")
        if btn.tag == 11 {
            print("10")
            self.btnYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.btnNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.delegateEstimate?.didTapOnCellEstimate(_isEstimate: true)
        } else if btn.tag == 21 {
            print("11")
            self.btnYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.btnYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.btnNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
            self.btnNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
            self.delegateEstimate?.didTapOnCellEstimate(_isEstimate: false)
        }
    }
}

class DataTextViewTableCell: UITableViewCell {
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var txtData: UITextView!

    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtData.layer.borderColor = UIColor.black.cgColor
        self.txtData.layer.borderWidth = 0.68
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.cornerRadius = 10
        }
    }
}

class SubmitFormTableCell: UITableViewCell {
    @IBOutlet weak var btnSubmit: UIButton!
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.btnSubmit.tintColor = #colorLiteral(red: 0.9474589229, green: 0.2073712945, blue: 0.1776620746, alpha: 1)
        self.btnSubmit.layer.borderColor = #colorLiteral(red: 0.9474589229, green: 0.2073712945, blue: 0.1776620746, alpha: 1)
        self.btnSubmit.clipsToBounds = true
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.btnSubmit.clipsToBounds = true
            self.btnSubmit.layer.borderWidth = 0.68
            self.btnSubmit.layer.cornerRadius = 25
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.btnSubmit.layer.borderWidth = 0.85
            self.btnSubmit.layer.cornerRadius = 50
        }
    }
}


//MARK:- Inspection Module
class InspectionTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol RealEstateDealProtocol {
    func didTapOnCellRealEstateDeal(_btnDescribeTag: Int)
}

class RealEstateDealTableCell: UITableViewCell {
    
    var delegateRealEstateDeal: RealEstateDealProtocol?
    
    @objc @IBAction private func realEstateDealBtn(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateRealEstateDeal?.didTapOnCellRealEstateDeal(_btnDescribeTag: radioButton.tag)
    }
}

protocol InsuranceClaimProtocol {
    func didTapOnCellInsuranceClaim(_btnDescribeTag: Int)
}

class InsuranceClaimTableCell: UITableViewCell {
    
    var delegateInsuranceClaim: InsuranceClaimProtocol?
    
    @objc @IBAction private func insuranceClaimBtn(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!));
        }
        self.delegateInsuranceClaim?.didTapOnCellInsuranceClaim(_btnDescribeTag: radioButton.tag)
    }
}

class CameraTableCell: UITableViewCell {
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var collectionVw: UploadCollectionVw!
}

protocol Optional3CellProtocol {
    func didTapOnCellOptional3(_btnDescribeTag: Int)
}

class Optional3TableCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnYes: DLRadioButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: DLRadioButton!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var btnDescribe: DLRadioButton!
    @IBOutlet weak var lblDescribe: UILabel!
    
    @IBOutlet weak var txtOther: UITextView!
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    
    var delegateOptional3: Optional3CellProtocol?
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        if btnDescribe.tag == 2 {
//            self.txtOther.isUserInteractionEnabled = true
//        } else if btnDescribe.tag == 0 {
//            //Declare the outlet in our custom class
////            let mapSatelliteOfc = mapLocationCell.viewWithTag(25) as! GMSMapView
////            let lblSatelliteOfc = mapLocationCell.viewWithTag(20) as! UILabel
//        } else {
//            self.txtOther.text = ""
//            self.txtOther.isUserInteractionEnabled = false
//        }
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
        if radioButton.tag == 2 {
            self.txtOther.isUserInteractionEnabled = true
        } else if btnDescribe.tag == 0 {
            //Declare the outlet in our custom class
//            let lblSatelliteOfc = mapLocationCell.viewWithTag(20) as! UILabel
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
        self.delegateOptional3?.didTapOnCellOptional3(_btnDescribeTag: radioButton.tag)
    }
}
