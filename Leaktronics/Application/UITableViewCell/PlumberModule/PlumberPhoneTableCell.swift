//
//  PlumberPhoneTableCell.swift
//  Leaktronics
//
//  Created by ivaninfotech on 6/8/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit

//MARK:- Protocol Declaration

protocol PropertyTypeProtocol {
    func didTapOnPropertyType(_btnPropertyTypeTag: Int)
}

protocol StoriesTypeProtocol {
    func didTapOnStoriesType(_btnStoriesTypeTag: Int)
}

protocol FindUsProtocol {
    func didTapOnFindUs(_btnFindUsTag: Int)
}

protocol CallReasonProtocol {
    func didTapOnCallReason(_btnCallReasonTag: Int)
}

protocol SwimmingOptionProtocol {
    func didTapOnSwimmingOption(_btnSwimmingTag: Int)
}

protocol ResidentOptionProtocol {
    func didTapOnResidentOption(_btnResidentTag: Int)
}

protocol FireSuppressionOptionProtocol {
    func didTapOnFireSuppressionOption (_btnFireSuppressionTag: Int)
}

protocol FloorHeatingOptionProtocol {
    func didTapOnFloorHeatingOption (_btnFloorHeatingTag: Int)
}

//MARK:- TableViewCell Methods
class PlumberPhoneQuestionTableCell: UITableViewCell {
    
    @IBOutlet weak var vwOtherText: UITextView!
    @IBOutlet weak var vwStoriesText: UITextView!
    @IBOutlet weak var vwFindText: UITextView!
    @IBOutlet weak var vwCallReasonText: UITextView!
    @IBOutlet weak var vwSwimmingText: UITextView!
    @IBOutlet weak var vwResidentText: UITextView!
    @IBOutlet weak var vwFireSuppressionText: UITextView!
    @IBOutlet weak var btnCommercialOutlet: UIButton!
    @IBOutlet weak var btnUploadOutlet: UIButton!
    @IBOutlet weak var collectionVw: UploadCollectionVw!
    @IBOutlet weak var btnNextOutlet: UIButton!
    @IBOutlet weak var txtNumberofBuilding: UITextField!
    
    
    @IBOutlet weak var imgProperty0: UIImageView!
    @IBOutlet weak var imgProperty1: UIImageView!
    @IBOutlet weak var imgProperty2: UIImageView!
    
    var delegatePropertyType: PropertyTypeProtocol?
    
    @IBOutlet weak var imgStoriesOptn0: UIImageView!
    @IBOutlet weak var imgStoriesOptn1: UIImageView!
    @IBOutlet weak var imgStoriesOptn2: UIImageView!
    @IBOutlet weak var imgStoriesOptn3: UIImageView!
    
    var delegateStoriesType: StoriesTypeProtocol?
    
    @IBOutlet weak var imgFindUsOptn0: UIImageView!
    @IBOutlet weak var imgFindUsOptn1: UIImageView!
    @IBOutlet weak var imgFindUsOptn2: UIImageView!
    
    var delegateFindUsType: FindUsProtocol?
    
    @IBOutlet weak var imgReasonOptn0: UIImageView!
    @IBOutlet weak var imgReasonOptn1: UIImageView!
    @IBOutlet weak var imgReasonOptn2: UIImageView!
    @IBOutlet weak var imgReasonOptn3: UIImageView!
    @IBOutlet weak var imgReasonOptn4: UIImageView!
    
    var delegateCallReasonType: CallReasonProtocol?
    
    @IBOutlet weak var imgSwimmingOptn0: UIImageView!
    @IBOutlet weak var imgSwimmingOptn1: UIImageView!
    
    var delegateSwimmingOptionType: SwimmingOptionProtocol?
    
    @IBOutlet weak var imgResidentOptn0: UIImageView!
    @IBOutlet weak var imgResidentOptn1: UIImageView!
    @IBOutlet weak var imgResidentOptn2: UIImageView!
    
    var delegateResidentOptionType: ResidentOptionProtocol?
    
    @IBOutlet weak var imgFireSuppressionOptn0: UIImageView!
    @IBOutlet weak var imgFireSuppressionOptn1: UIImageView!
    
    var delegateFireSuppressionOptionType: FireSuppressionOptionProtocol?
    
    @IBOutlet weak var imgFloorHeatingOptn0: UIImageView!
    @IBOutlet weak var imgFloorHeatingOptn1: UIImageView!
    
    var delegateFloorHeatingOptionType: FloorHeatingOptionProtocol?
    
    
    //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.vwOtherText.isUserInteractionEnabled = false
//        self.vwFindText.isUserInteractionEnabled = false
//        self.vwStoriesText.isUserInteractionEnabled = false
//        self.vwResidentText.isUserInteractionEnabled = false
//        self.vwSwimmingText.isUserInteractionEnabled = false
//        self.vwCallReasonText.isUserInteractionEnabled = false
//        self.vwFireSuppressionText.isUserInteractionEnabled = false
        
        self.vwOtherText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor//UIColor.black.cgColor //
        self.vwOtherText.layer.borderWidth = 0.68
        self.vwOtherText.layer.cornerRadius = 5
        
        self.vwStoriesText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor//UIColor.black.cgColor //
        self.vwStoriesText.layer.borderWidth = 0.68
        self.vwStoriesText.layer.cornerRadius = 5
        self.vwFindText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor//UIColor.black.cgColor //
        self.vwFindText.layer.borderWidth = 0.68
        self.vwFindText.layer.cornerRadius = 5
        self.vwCallReasonText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor//UIColor.black.cgColor //
        self.vwCallReasonText.layer.borderWidth = 0.68
        self.vwCallReasonText.layer.cornerRadius = 5
        self.vwSwimmingText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor//UIColor.black.cgColor //
        self.vwSwimmingText.layer.borderWidth = 0.68
        self.vwSwimmingText.layer.cornerRadius = 5
        self.vwResidentText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor//UIColor.black.cgColor //
        self.vwResidentText.layer.borderWidth = 0.68
        self.vwResidentText.layer.cornerRadius = 5
        self.vwFireSuppressionText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor//UIColor.black.cgColor //
        self.vwFireSuppressionText.layer.borderWidth = 0.68
        self.vwFireSuppressionText.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Property Option Button
    @objc @IBAction private func propertyOptionButton(radioButton : UIButton) {
        print(radioButton.tag)
        if radioButton.tag == 2 {
           self.vwOtherText.isUserInteractionEnabled = true
        } else {
           self.vwOtherText.text = ""
           self.vwOtherText.isUserInteractionEnabled = false
        }
        
        if imgProperty0.tag == radioButton.tag {
            imgProperty0.image = UIImage(named: "checkmark")
            imgProperty1.image = UIImage(named: "unchecked")
            imgProperty2.image = UIImage(named: "unchecked")
        } else if imgProperty1.tag == radioButton.tag {
            imgProperty0.image = UIImage(named: "unchecked")
            imgProperty1.image = UIImage(named: "checkmark")
            imgProperty2.image = UIImage(named: "unchecked")
        } else if imgProperty2.tag == radioButton.tag {
            imgProperty0.image = UIImage(named: "unchecked")
            imgProperty1.image = UIImage(named: "unchecked")
            imgProperty2.image = UIImage(named: "checkmark")
        }
        
        self.delegatePropertyType?.didTapOnPropertyType(_btnPropertyTypeTag: radioButton.tag)
    }
    
    // MARK:- Stories Button
    @objc @IBAction private func storiesOptionButton(radioButton : UIButton) {
        print(radioButton.tag)
//        if radioButton.tag == 3 {
//            self.vwStoriesText.isUserInteractionEnabled = true
//        } else {
//            self.vwStoriesText.text = ""
//            self.vwStoriesText.isUserInteractionEnabled = false
//        }
        
        if imgStoriesOptn0.tag == radioButton.tag {
            imgStoriesOptn0.image = UIImage(named: "checkmark")
            imgStoriesOptn1.image = UIImage(named: "unchecked")
            imgStoriesOptn2.image = UIImage(named: "unchecked")
            imgStoriesOptn3.image = UIImage(named: "unchecked")
        } else if imgStoriesOptn1.tag == radioButton.tag {
            imgStoriesOptn0.image = UIImage(named: "unchecked")
            imgStoriesOptn1.image = UIImage(named: "checkmark")
            imgStoriesOptn2.image = UIImage(named: "unchecked")
            imgStoriesOptn3.image = UIImage(named: "unchecked")
        } else if imgStoriesOptn2.tag == radioButton.tag {
            imgStoriesOptn0.image = UIImage(named: "unchecked")
            imgStoriesOptn1.image = UIImage(named: "unchecked")
            imgStoriesOptn2.image = UIImage(named: "checkmark")
            imgStoriesOptn3.image = UIImage(named: "unchecked")
        } else if imgStoriesOptn3.tag == radioButton.tag {
            imgStoriesOptn0.image = UIImage(named: "unchecked")
            imgStoriesOptn1.image = UIImage(named: "unchecked")
            imgStoriesOptn2.image = UIImage(named: "unchecked")
            imgStoriesOptn3.image = UIImage(named: "checkmark")
        }
        
        self.delegateStoriesType?.didTapOnStoriesType(_btnStoriesTypeTag: radioButton.tag)
    }
    
    //MARK:- FindUS Button
    @IBAction func findUsButton(_ radioButton: UIButton) {
        print(radioButton.tag)
//        if radioButton.tag == 2 {
//            self.vwFindText.isUserInteractionEnabled = true
//        } else {
//            self.vwFindText.text = ""
//            self.vwFindText.isUserInteractionEnabled = false
//        }
        
        if imgFindUsOptn0.tag == radioButton.tag {
            imgFindUsOptn0.image = UIImage(named: "checkmark")
            imgFindUsOptn1.image = UIImage(named: "unchecked")
            imgFindUsOptn2.image = UIImage(named: "unchecked")
        } else if imgFindUsOptn1.tag == radioButton.tag {
            imgFindUsOptn0.image = UIImage(named: "unchecked")
            imgFindUsOptn1.image = UIImage(named: "checkmark")
            imgFindUsOptn2.image = UIImage(named: "unchecked")
        } else if imgFindUsOptn2.tag == radioButton.tag {
            imgFindUsOptn0.image = UIImage(named: "unchecked")
            imgFindUsOptn1.image = UIImage(named: "unchecked")
            imgFindUsOptn2.image = UIImage(named: "checkmark")
        }
        
        self.delegateFindUsType?.didTapOnFindUs(_btnFindUsTag: radioButton.tag)
    }
    
    //MARK:- ReasonForCall Button
    @IBAction func callReasonButton(_ radioButton: UIButton) {
        print(radioButton.tag)
//        if radioButton.tag == 4 {
//            self.vwCallReasonText.isUserInteractionEnabled = true
//        } else {
//            self.vwCallReasonText.text = ""
//            self.vwCallReasonText.isUserInteractionEnabled = false
//        }
        
        if imgReasonOptn0.tag == radioButton.tag {
            imgReasonOptn0.image = UIImage(named: "checkmark")
            imgReasonOptn1.image = UIImage(named: "unchecked")
            imgReasonOptn2.image = UIImage(named: "unchecked")
            imgReasonOptn3.image = UIImage(named: "unchecked")
            imgReasonOptn4.image = UIImage(named: "unchecked")
        } else if imgReasonOptn1.tag == radioButton.tag {
            imgReasonOptn0.image = UIImage(named: "unchecked")
            imgReasonOptn1.image = UIImage(named: "checkmark")
            imgReasonOptn2.image = UIImage(named: "unchecked")
            imgReasonOptn3.image = UIImage(named: "unchecked")
            imgReasonOptn4.image = UIImage(named: "unchecked")
        } else if imgReasonOptn2.tag == radioButton.tag {
            imgReasonOptn0.image = UIImage(named: "unchecked")
            imgReasonOptn1.image = UIImage(named: "unchecked")
            imgReasonOptn2.image = UIImage(named: "checkmark")
            imgReasonOptn3.image = UIImage(named: "unchecked")
            imgReasonOptn4.image = UIImage(named: "unchecked")
        } else if imgReasonOptn3.tag == radioButton.tag {
            imgReasonOptn0.image = UIImage(named: "unchecked")
            imgReasonOptn1.image = UIImage(named: "unchecked")
            imgReasonOptn2.image = UIImage(named: "unchecked")
            imgReasonOptn3.image = UIImage(named: "checkmark")
            imgReasonOptn4.image = UIImage(named: "unchecked")
        } else if imgReasonOptn4.tag == radioButton.tag {
            imgReasonOptn0.image = UIImage(named: "unchecked")
            imgReasonOptn1.image = UIImage(named: "unchecked")
            imgReasonOptn2.image = UIImage(named: "unchecked")
            imgReasonOptn3.image = UIImage(named: "unchecked")
            imgReasonOptn4.image = UIImage(named: "checkmark")
        }
        
        self.delegateCallReasonType?.didTapOnCallReason(_btnCallReasonTag: radioButton.tag)
    }
    
    //MARK:- Swimming Button
    @IBAction func swimmingButton(_ radioButton: UIButton) {
        print(radioButton.tag)
//        if radioButton.tag == 0 {
//            self.vwSwimmingText.isUserInteractionEnabled = true
//        } else {
//            self.vwSwimmingText.text = ""
//            self.vwSwimmingText.isUserInteractionEnabled = false
//        }
        
        if imgSwimmingOptn0.tag == radioButton.tag {
            imgSwimmingOptn0.image = UIImage(named: "checkmark")
            imgSwimmingOptn1.image = UIImage(named: "unchecked")
        } else if imgSwimmingOptn1.tag == radioButton.tag {
            imgSwimmingOptn0.image = UIImage(named: "unchecked")
            imgSwimmingOptn1.image = UIImage(named: "checkmark")
        }
        self.delegateSwimmingOptionType?.didTapOnSwimmingOption(_btnSwimmingTag: radioButton.tag)
    }
    
    //MARK:- ResidentialOption Button
    @IBAction func btnResidentialOption(_ radioButton: UIButton) {
        print(radioButton.tag)
//        if radioButton.tag == 2 {
//            self.vwResidentText.isUserInteractionEnabled = true
//        } else {
//            self.vwResidentText.text = ""
//            self.vwResidentText.isUserInteractionEnabled = false
//        }
        
        if imgResidentOptn0.tag == radioButton.tag {
            imgResidentOptn0.image = UIImage(named: "checkmark")
            imgResidentOptn1.image = UIImage(named: "unchecked")
            imgResidentOptn2.image = UIImage(named: "unchecked")
        } else if imgResidentOptn1.tag == radioButton.tag {
            imgResidentOptn0.image = UIImage(named: "unchecked")
            imgResidentOptn1.image = UIImage(named: "checkmark")
            imgResidentOptn2.image = UIImage(named: "unchecked")
        } else if imgResidentOptn2.tag == radioButton.tag {
            imgResidentOptn0.image = UIImage(named: "unchecked")
            imgResidentOptn1.image = UIImage(named: "unchecked")
            imgResidentOptn2.image = UIImage(named: "checkmark")
        }
        
        self.delegateResidentOptionType?.didTapOnResidentOption(_btnResidentTag: radioButton.tag)
    }
    
    //MARK:- FireSuppression Button
    @IBAction func fireSuppressionButton(_ radioButton: UIButton) {
        print(radioButton.tag)
//        if radioButton.tag == 0 {
//            self.vwFireSuppressionText.isUserInteractionEnabled = true
//        } else {
//            self.vwFireSuppressionText.text = ""
//            self.vwFireSuppressionText.isUserInteractionEnabled = false
//        }
        
        if imgFireSuppressionOptn0.tag == radioButton.tag {
            imgFireSuppressionOptn0.image = UIImage(named: "checkmark")
            imgFireSuppressionOptn1.image = UIImage(named: "unchecked")
        } else if imgFireSuppressionOptn1.tag == radioButton.tag {
            imgFireSuppressionOptn0.image = UIImage(named: "unchecked")
            imgFireSuppressionOptn1.image = UIImage(named: "checkmark")
        }
        
        self.delegateFireSuppressionOptionType?.didTapOnFireSuppressionOption(_btnFireSuppressionTag: radioButton.tag)
    }
    
    //MARK:- FloorHeating Button
    @IBAction func floorHeatingButton(_ radioButton: UIButton) {
        print(radioButton.tag)
        
        if imgFloorHeatingOptn0.tag == radioButton.tag {
            imgFloorHeatingOptn0.image = UIImage(named: "checkmark")
            imgFloorHeatingOptn1.image = UIImage(named: "unchecked")
        } else if imgFloorHeatingOptn1.tag == radioButton.tag {
            imgFloorHeatingOptn0.image = UIImage(named: "unchecked")
            imgFloorHeatingOptn1.image = UIImage(named: "checkmark")
        }
        
       self.delegateFloorHeatingOptionType?.didTapOnFloorHeatingOption(_btnFloorHeatingTag: radioButton.tag)
    }
}

