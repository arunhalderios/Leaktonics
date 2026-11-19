//
//  CommercialTableCell.swift
//  Leaktronics
//
//  Created by ivaninfotech on 6/8/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit

protocol MonitorFiveMinuteProtocol {
    func didTapOnMonitorFiveMinute(_btnfFiveMinuteTag: Int)
}

protocol ShutdownBuildingFromMeterProtocol {
    func didTapOnShutdownBuildingFromMeter(_btnShutdownBuildingFromMeter: Int)
}

protocol ShutdownHotWaterToBuildingProtocol {
    func didTapOnShutdownHotWaterToBuilding(_btnDidTapOnShutdownHotWaterToBuilding: Int)
}

protocol MeterShutdownProtocol {
    func didTapOnMeterShutdown(_btnMeterShutdown: Int)
}

protocol OtherStructureMeterShutdownProtocol {
    func didTapOnOtherStructureMeterShutdown(_btnOtherStructureMeterShutdown: Int)
}

class CommercialLeakTableCell: UITableViewCell {
    
    @IBOutlet weak var imgMonitorOptn0: UIImageView!
    @IBOutlet weak var imgMonitorOptn1: UIImageView!
    @IBOutlet weak var imgMonitorOptn2: UIImageView!
    @IBOutlet weak var imgMonitorOptn3: UIImageView!
    
    var delegateMonitorFiveMinute: MonitorFiveMinuteProtocol?
    
    @IBOutlet weak var imgMeterOptn0: UIImageView!
    @IBOutlet weak var imgMeterOptn1: UIImageView!
    @IBOutlet weak var imgMeterOptn2: UIImageView!
    
    var delegateShutdownBuildingFromMeter: ShutdownBuildingFromMeterProtocol?
    
    @IBOutlet weak var imgHotWaterOptn0: UIImageView!
    @IBOutlet weak var imgHotWaterOptn1: UIImageView!
    @IBOutlet weak var imgHotWaterOptn2: UIImageView!
    
    var delegateShutdownHotWaterToBuilding: ShutdownHotWaterToBuildingProtocol?
    
    @IBOutlet weak var imgShutdownOptn0: UIImageView!
    @IBOutlet weak var imgShutdownOptn1: UIImageView!
    @IBOutlet weak var imgShutdownOptn2: UIImageView!
    
    var delegateMeterShutdown: MeterShutdownProtocol?
    
    @IBOutlet weak var imgStructureOptn0: UIImageView!
    @IBOutlet weak var imgStructureOptn1: UIImageView!
    
    var delegateOtherStructureMeterShutdown: OtherStructureMeterShutdownProtocol?
    
        //TODO:: View Lifecycle
    override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
        
    }
    
    //MARK:- MonitorFiveMinute Button
    @IBAction func monitorFiveMinuteButton(_ radioButton : UIButton) {
        print(radioButton.tag)
        
        if imgMonitorOptn0.tag == radioButton.tag {
            imgMonitorOptn0.image = UIImage(named: "checkmark")
            imgMonitorOptn1.image = UIImage(named: "unchecked")
            imgMonitorOptn2.image = UIImage(named: "unchecked")
            imgMonitorOptn3.image = UIImage(named: "unchecked")
        } else if imgMonitorOptn1.tag == radioButton.tag {
            imgMonitorOptn0.image = UIImage(named: "unchecked")
            imgMonitorOptn1.image = UIImage(named: "checkmark")
            imgMonitorOptn2.image = UIImage(named: "unchecked")
            imgMonitorOptn3.image = UIImage(named: "unchecked")
        } else if imgMonitorOptn2.tag == radioButton.tag {
            imgMonitorOptn0.image = UIImage(named: "unchecked")
            imgMonitorOptn1.image = UIImage(named: "unchecked")
            imgMonitorOptn2.image = UIImage(named: "checkmark")
            imgMonitorOptn3.image = UIImage(named: "unchecked")
        } else if imgMonitorOptn3.tag == radioButton.tag {
            imgMonitorOptn0.image = UIImage(named: "unchecked")
            imgMonitorOptn1.image = UIImage(named: "unchecked")
            imgMonitorOptn2.image = UIImage(named: "unchecked")
            imgMonitorOptn3.image = UIImage(named: "checkmark")
        }
        
        self.delegateMonitorFiveMinute?.didTapOnMonitorFiveMinute(_btnfFiveMinuteTag: radioButton.tag)
    }
    
    //MARK:- ShutdownBuildingFromMeter Button
    @IBAction func shutdownBuildingFromMeterButton(_ radioButton: UIButton) {
        print(radioButton.tag)
        
        if imgMeterOptn0.tag == radioButton.tag {
            imgMeterOptn0.image = UIImage(named: "checkmark")
            imgMeterOptn1.image = UIImage(named: "unchecked")
            imgMeterOptn2.image = UIImage(named: "unchecked")
        } else if imgMeterOptn1.tag == radioButton.tag {
            imgMeterOptn0.image = UIImage(named: "unchecked")
            imgMeterOptn1.image = UIImage(named: "checkmark")
            imgMeterOptn2.image = UIImage(named: "unchecked")
        } else if imgMeterOptn2.tag == radioButton.tag {
            imgMeterOptn0.image = UIImage(named: "unchecked")
            imgMeterOptn1.image = UIImage(named: "unchecked")
            imgMeterOptn2.image = UIImage(named: "checkmark")
        }
        
        self.delegateShutdownBuildingFromMeter?.didTapOnShutdownBuildingFromMeter(_btnShutdownBuildingFromMeter: radioButton.tag)
    }
    
    //MARK:- ShutdownHotWaterToBuilding Button
    @IBAction func shutdownHotWaterToBuildingButton(_ radioButton: UIButton) {
        print(radioButton.tag)
        
        if imgHotWaterOptn0.tag == radioButton.tag {
            imgHotWaterOptn0.image = UIImage(named: "checkmark")
            imgHotWaterOptn1.image = UIImage(named: "unchecked")
            imgHotWaterOptn2.image = UIImage(named: "unchecked")
        } else if imgHotWaterOptn1.tag == radioButton.tag {
            imgHotWaterOptn0.image = UIImage(named: "unchecked")
            imgHotWaterOptn1.image = UIImage(named: "checkmark")
            imgHotWaterOptn2.image = UIImage(named: "unchecked")
        } else if imgHotWaterOptn2.tag == radioButton.tag {
            imgHotWaterOptn0.image = UIImage(named: "unchecked")
            imgHotWaterOptn1.image = UIImage(named: "unchecked")
            imgHotWaterOptn2.image = UIImage(named: "checkmark")
        }
        
        self.delegateShutdownHotWaterToBuilding?.didTapOnShutdownHotWaterToBuilding(_btnDidTapOnShutdownHotWaterToBuilding: radioButton.tag)
    }
    
    //MARK:- MeterShutdown Button
    @IBAction func meterShutdownButton(_ radioButton : UIButton) {
        print(radioButton.tag)
        
        if imgShutdownOptn0.tag == radioButton.tag {
            imgShutdownOptn0.image = UIImage(named: "checkmark")
            imgShutdownOptn1.image = UIImage(named: "unchecked")
            imgShutdownOptn2.image = UIImage(named: "unchecked")
        } else if imgShutdownOptn1.tag == radioButton.tag {
            imgShutdownOptn0.image = UIImage(named: "unchecked")
            imgShutdownOptn1.image = UIImage(named: "checkmark")
            imgShutdownOptn2.image = UIImage(named: "unchecked")
        } else if imgShutdownOptn2.tag == radioButton.tag {
            imgShutdownOptn0.image = UIImage(named: "unchecked")
            imgShutdownOptn1.image = UIImage(named: "unchecked")
            imgShutdownOptn2.image = UIImage(named: "checkmark")
        }
        
        self.delegateMeterShutdown?.didTapOnMeterShutdown(_btnMeterShutdown: radioButton.tag)
    }
    
    //MARK:- OtherStructureMeterShutdown Button
    @IBAction func otherStructureMeterShutdownButton(_ radioButton: UIButton) {
        print(radioButton.tag)
        
        if imgStructureOptn0.tag == radioButton.tag {
            imgStructureOptn0.image = UIImage(named: "checkmark")
            imgStructureOptn1.image = UIImage(named: "unchecked")
        } else if imgStructureOptn1.tag == radioButton.tag {
            imgStructureOptn0.image = UIImage(named: "unchecked")
            imgStructureOptn1.image = UIImage(named: "checkmark")
        }
        
        self.delegateOtherStructureMeterShutdown?.didTapOnOtherStructureMeterShutdown(_btnOtherStructureMeterShutdown: radioButton.tag)
    }
}


protocol VisualWalkOutsideProtocol {
    func didTapOnVisualWalkOutside(_btnVisualWalkOutside: Int)
}

protocol LeakHeardStubProtocol {
    func didTapOnLeakHeardStub(_btnLeakHeardStub: Int)
}

protocol WalkedInsideParameterProtocol {
    func didTapOnwalkedInsideParameter(_btnwalkedInsideParameter: Int)
}

protocol LeakHeardatTouchStubProtocol {
    func didTapOnLeakHeardatTouchStub(_btnLeakHeardatTouchStub: Int)
}

class CommercialLeakOutsideCell: UITableViewCell {
    
    @IBOutlet weak var vwVisualWalkOutsideText: UITextView!
    @IBOutlet weak var vwLeakHeaderStubs: UITextView!
    @IBOutlet weak var vwWalkedInsideParameter: UITextView!
    @IBOutlet weak var vwLeakHeardTouchStub: UITextView!
    
    
    @IBOutlet weak var btnImgUpload10: UIButton!
    @IBOutlet weak var btnImgUpload20: UIButton!
    @IBOutlet weak var btnImgUpload30: UIButton!
    @IBOutlet weak var btnImgUpload40: UIButton!
    
    
    @IBOutlet weak var collect10Vw: UploadCollectionVw!
    @IBOutlet weak var collect20Vw: UploadCollectionVw!
    @IBOutlet weak var collect30Vw: UploadCollectionVw!
    @IBOutlet weak var collect40Vw: UploadCollectionVw!
    
    
    @IBOutlet weak var imgVisualWalkOptn0: UIImageView!
    @IBOutlet weak var imgVisualWalkOptn1: UIImageView!
    @IBOutlet weak var imgVisualWalkOptn2: UIImageView!
    
    var delegateVisualWalkOutside: VisualWalkOutsideProtocol?
    
    
    @IBOutlet weak var imgLeakHeardOptn0: UIImageView!
    @IBOutlet weak var imgLeakHeardOptn1: UIImageView!
    
    var delegateLeakHeardStub: LeakHeardStubProtocol?
    
    
    @IBOutlet weak var imgWalkedInsideOptn0: UIImageView!
    @IBOutlet weak var imgWalkedInsideOptn1: UIImageView!
    @IBOutlet weak var imgWalkedInsideOptn2: UIImageView!
    
    var delegateWalkedInsideParameter: WalkedInsideParameterProtocol?
    
    
    @IBOutlet weak var imgTouchStubOptn0: UIImageView!
    @IBOutlet weak var imgTouchStubOptn1: UIImageView!
    
    var delegateLeakHeardatTouchStub: LeakHeardatTouchStubProtocol?
    
        //TODO:: View Lifecycle
    override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
        
        self.vwVisualWalkOutsideText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        self.vwVisualWalkOutsideText.layer.borderWidth = 0.68
        self.vwVisualWalkOutsideText.layer.cornerRadius = 5
        
        self.vwLeakHeaderStubs.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        self.vwLeakHeaderStubs.layer.borderWidth = 0.68
        self.vwLeakHeaderStubs.layer.cornerRadius = 5
        
        self.vwWalkedInsideParameter.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        self.vwWalkedInsideParameter.layer.borderWidth = 0.68
        self.vwWalkedInsideParameter.layer.cornerRadius = 5
        
        self.vwLeakHeardTouchStub.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        self.vwLeakHeardTouchStub.layer.borderWidth = 0.68
        self.vwLeakHeardTouchStub.layer.cornerRadius = 5

        
        self.vwVisualWalkOutsideText.isUserInteractionEnabled = false
        self.vwLeakHeaderStubs.isUserInteractionEnabled = false
        self.vwWalkedInsideParameter.isUserInteractionEnabled = false
        self.vwLeakHeardTouchStub.isUserInteractionEnabled = false
        
    }
    
    //MARK:- VisualWalkOutside Button
    @IBAction func visualWalkOutsideButton(_ radioButton: UIButton) {
        print(radioButton.tag)
        if radioButton.tag == 2 {
            self.vwVisualWalkOutsideText.isUserInteractionEnabled = true
        } else {
            self.vwVisualWalkOutsideText.text = ""
            self.vwVisualWalkOutsideText.isUserInteractionEnabled = false
        }
        
        if imgVisualWalkOptn0.tag == radioButton.tag {
            imgVisualWalkOptn0.image = UIImage(named: "checkmark")
            imgVisualWalkOptn1.image = UIImage(named: "unchecked")
            imgVisualWalkOptn2.image = UIImage(named: "unchecked")
        } else if imgVisualWalkOptn1.tag == radioButton.tag {
            imgVisualWalkOptn0.image = UIImage(named: "unchecked")
            imgVisualWalkOptn1.image = UIImage(named: "checkmark")
            imgVisualWalkOptn2.image = UIImage(named: "unchecked")
        } else if imgVisualWalkOptn2.tag == radioButton.tag {
            imgVisualWalkOptn0.image = UIImage(named: "unchecked")
            imgVisualWalkOptn1.image = UIImage(named: "unchecked")
            imgVisualWalkOptn2.image = UIImage(named: "checkmark")
        }
        
        self.delegateVisualWalkOutside?.didTapOnVisualWalkOutside(_btnVisualWalkOutside: radioButton.tag)
    }
    
    //MARK:- LeakHeardStub Button
    @IBAction func leakHeardStubButton(_ radioButton: UIButton) {
        print(radioButton.tag)
        if radioButton.tag == 1 {
            self.vwLeakHeaderStubs.isUserInteractionEnabled = true
        } else {
            self.vwLeakHeaderStubs.text = ""
            self.vwLeakHeaderStubs.isUserInteractionEnabled = false
        }
        
        if imgLeakHeardOptn0.tag == radioButton.tag {
            imgLeakHeardOptn0.image = UIImage(named: "checkmark")
            imgLeakHeardOptn1.image = UIImage(named: "unchecked")
        } else if imgLeakHeardOptn1.tag == radioButton.tag {
            imgLeakHeardOptn0.image = UIImage(named: "unchecked")
            imgLeakHeardOptn1.image = UIImage(named: "checkmark")
        }
        
        self.delegateLeakHeardStub?.didTapOnLeakHeardStub(_btnLeakHeardStub: radioButton.tag)
    }
    
    //MARK:- WalkedInsideParameter Button
    @IBAction func walkedInsideParameterButton(_ radioButton: UIButton) {
        print(radioButton.tag)
        if radioButton.tag == 2 {
            self.vwWalkedInsideParameter.isUserInteractionEnabled = true
        } else {
            self.vwWalkedInsideParameter.text = ""
            self.vwWalkedInsideParameter.isUserInteractionEnabled = false
        }
        
        if imgWalkedInsideOptn0.tag == radioButton.tag {
            imgWalkedInsideOptn0.image = UIImage(named: "checkmark")
            imgWalkedInsideOptn1.image = UIImage(named: "unchecked")
            imgWalkedInsideOptn2.image = UIImage(named: "unchecked")
        } else if imgWalkedInsideOptn1.tag == radioButton.tag {
            imgWalkedInsideOptn0.image = UIImage(named: "unchecked")
            imgWalkedInsideOptn1.image = UIImage(named: "checkmark")
            imgWalkedInsideOptn2.image = UIImage(named: "unchecked")
        } else if imgWalkedInsideOptn2.tag == radioButton.tag {
            imgWalkedInsideOptn0.image = UIImage(named: "unchecked")
            imgWalkedInsideOptn1.image = UIImage(named: "unchecked")
            imgWalkedInsideOptn2.image = UIImage(named: "checkmark")
        }
        
        self.delegateWalkedInsideParameter?.didTapOnwalkedInsideParameter(_btnwalkedInsideParameter: radioButton.tag)
    }
    
    //MARK:- LeakHeardatTouchStub Button
    @IBAction func leakHeardatTouchStubButton(_ radioButton: UIButton) {
        print(radioButton.tag)
        if radioButton.tag == 1 {
            self.vwLeakHeardTouchStub.isUserInteractionEnabled = true
        } else {
            self.vwLeakHeardTouchStub.text = ""
            self.vwLeakHeardTouchStub.isUserInteractionEnabled = false
        }
        
        if imgTouchStubOptn0.tag == radioButton.tag {
            imgTouchStubOptn0.image = UIImage(named: "checkmark")
            imgTouchStubOptn1.image = UIImage(named: "unchecked")
        } else if imgTouchStubOptn1.tag == radioButton.tag {
            imgTouchStubOptn0.image = UIImage(named: "unchecked")
            imgTouchStubOptn1.image = UIImage(named: "checkmark")
        }
        
        self.delegateLeakHeardatTouchStub?.didTapOnLeakHeardatTouchStub(_btnLeakHeardatTouchStub: radioButton.tag)
    }
}

protocol MainBuildingEntranceProtocol {
    func didTapOnMainBuildingEntrance(_btnMainBuildingEntrance: Int)
}

protocol PressureTestedForLeakProtocol {
    func didTapOnPressureTestedForLeak(_btnPressureTestedForLeak: Int)
}


class CommercialLeakInteriorCell: UITableViewCell {
    
    @IBOutlet weak var vwMainBuildingEntranceText: UITextView!
    @IBOutlet weak var vwPressureTestedText: UITextView!
    @IBOutlet weak var vwInteriorSummaryText: UITextView!
    @IBOutlet weak var vwCompleteLeakDetectionText: UITextView!
    
    
    @IBOutlet weak var imgEntranceOptn0: UIImageView!
    @IBOutlet weak var imgEntranceOptn1: UIImageView!
    @IBOutlet weak var imgEntranceOptn2: UIImageView!
    @IBOutlet weak var imgEntranceOptn3: UIImageView!
    @IBOutlet weak var imgEntranceOptn4: UIImageView!
    @IBOutlet weak var imgEntranceOptn5: UIImageView!
    @IBOutlet weak var imgEntranceOptn6: UIImageView!
    @IBOutlet weak var imgEntranceOptn7: UIImageView!
    @IBOutlet weak var imgEntranceOptn8: UIImageView!
    @IBOutlet weak var imgEntranceOptn9: UIImageView!
    @IBOutlet weak var imgEntranceOptn10: UIImageView!
    
    var delegateMainBuildingEntrance: MainBuildingEntranceProtocol?
    
    @IBOutlet weak var imgPressureOptn0: UIImageView!
    @IBOutlet weak var imgPressureOptn1: UIImageView!
    @IBOutlet weak var imgPressureOptn2: UIImageView!
    @IBOutlet weak var imgPressureOptn3: UIImageView!
    @IBOutlet weak var imgPressureOptn4: UIImageView!
    @IBOutlet weak var imgPressureOptn5: UIImageView!
    @IBOutlet weak var imgPressureOptn6: UIImageView!
    @IBOutlet weak var imgPressureOptn7: UIImageView!
    @IBOutlet weak var imgPressureOptn8: UIImageView!
    @IBOutlet weak var imgPressureOptn9: UIImageView!
    @IBOutlet weak var imgPressureOptn10: UIImageView!
    
    var delegatePressureTestedForLeak: PressureTestedForLeakProtocol?
    
    
    @IBOutlet weak var btnImgUpload50: UIButton!
    @IBOutlet weak var btnImgUpload60: UIButton!
    @IBOutlet weak var btnImgUpload70: UIButton!
    
    
    @IBOutlet weak var collect50Vw: UploadCollectionVw!
    @IBOutlet weak var collect60Vw: UploadCollectionVw!
    @IBOutlet weak var collect70Vw: UploadCollectionVw!
    
    
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
           
        self.vwPressureTestedText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        self.vwPressureTestedText.layer.borderWidth = 0.68
        self.vwPressureTestedText.layer.cornerRadius = 5
       
        self.vwMainBuildingEntranceText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        self.vwMainBuildingEntranceText.layer.borderWidth = 0.68
        self.vwMainBuildingEntranceText.layer.cornerRadius = 5
       
        self.vwInteriorSummaryText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        self.vwInteriorSummaryText.layer.borderWidth = 0.68
        self.vwInteriorSummaryText.layer.cornerRadius = 5
       
        self.vwCompleteLeakDetectionText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        self.vwCompleteLeakDetectionText.layer.borderWidth = 0.68
        self.vwCompleteLeakDetectionText.layer.cornerRadius = 5
        
        self.vwPressureTestedText.isUserInteractionEnabled = false
        self.vwMainBuildingEntranceText.isUserInteractionEnabled = false

    }
    
    //MARK:- MainBuildingEntrance Button
    @IBAction func mainBuildingEntranceButton(_ radioButton: UIButton) {
        print(radioButton.tag)
        if radioButton.tag == 10 {
            self.vwMainBuildingEntranceText.isUserInteractionEnabled = true
        } else {
            self.vwMainBuildingEntranceText.text = ""
            self.vwMainBuildingEntranceText.isUserInteractionEnabled = false
        }
        
        if imgEntranceOptn0.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "checkmark")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn1.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "checkmark")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn2.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "checkmark")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn3.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "checkmark")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn4.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "checkmark")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn5.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "checkmark")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn6.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "checkmark")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn7.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "checkmark")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn8.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "checkmark")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn9.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "checkmark")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn10.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "checkmark")
        }
        self.delegateMainBuildingEntrance?.didTapOnMainBuildingEntrance(_btnMainBuildingEntrance: radioButton.tag)
    }
    
    //MARK:- PressureTestedForLeak Button
    @IBAction func pressureTestedForLeakButton(_ radioButton: UIButton) {
        print(radioButton.tag)
        if radioButton.tag == 10 {
            self.vwPressureTestedText.isUserInteractionEnabled = true
        } else {
            self.vwPressureTestedText.text = ""
            self.vwPressureTestedText.isUserInteractionEnabled = false
        }
        
        if imgPressureOptn0.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "checkmark")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
        } else if imgPressureOptn1.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "checkmark")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
        } else if imgPressureOptn2.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "checkmark")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
        } else if imgPressureOptn3.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "checkmark")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
        } else if imgPressureOptn4.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "checkmark")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
        } else if imgPressureOptn5.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "checkmark")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
        } else if imgPressureOptn6.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "checkmark")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
        } else if imgPressureOptn7.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "checkmark")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
        } else if imgPressureOptn8.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "checkmark")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
        } else if imgPressureOptn9.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "checkmark")
            imgPressureOptn10.image = UIImage(named: "unchecked")
        } else if imgPressureOptn10.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "checkmark")
        }
        self.delegatePressureTestedForLeak?.didTapOnPressureTestedForLeak(_btnPressureTestedForLeak: radioButton.tag)
    }
}
 

class NonCommercialLeakInteriorCell: UITableViewCell {
    
    @IBOutlet weak var vwPressureTestedText: UITextView!
    @IBOutlet weak var vwMainBuildingEntranceText: UITextView!
    @IBOutlet weak var vwInteriorSummaryText: UITextView!
    @IBOutlet weak var vwCompleteLeakDetectionText: UITextView!
    
    
    @IBOutlet weak var imgEntranceOptn0: UIImageView!
    @IBOutlet weak var imgEntranceOptn1: UIImageView!
    @IBOutlet weak var imgEntranceOptn2: UIImageView!
    @IBOutlet weak var imgEntranceOptn3: UIImageView!
    @IBOutlet weak var imgEntranceOptn4: UIImageView!
    @IBOutlet weak var imgEntranceOptn5: UIImageView!
    @IBOutlet weak var imgEntranceOptn6: UIImageView!
    @IBOutlet weak var imgEntranceOptn7: UIImageView!
    @IBOutlet weak var imgEntranceOptn8: UIImageView!
    @IBOutlet weak var imgEntranceOptn9: UIImageView!
    @IBOutlet weak var imgEntranceOptn10: UIImageView!
    @IBOutlet weak var imgEntranceOptn11: UIImageView!
    @IBOutlet weak var imgEntranceOptn12: UIImageView!
    
    var delegateMainBuildingEntrance: MainBuildingEntranceProtocol?
    
    @IBOutlet weak var imgPressureOptn0: UIImageView!
    @IBOutlet weak var imgPressureOptn1: UIImageView!
    @IBOutlet weak var imgPressureOptn2: UIImageView!
    @IBOutlet weak var imgPressureOptn3: UIImageView!
    @IBOutlet weak var imgPressureOptn4: UIImageView!
    @IBOutlet weak var imgPressureOptn5: UIImageView!
    @IBOutlet weak var imgPressureOptn6: UIImageView!
    @IBOutlet weak var imgPressureOptn7: UIImageView!
    @IBOutlet weak var imgPressureOptn8: UIImageView!
    @IBOutlet weak var imgPressureOptn9: UIImageView!
    @IBOutlet weak var imgPressureOptn10: UIImageView!
    @IBOutlet weak var imgPressureOptn11: UIImageView!
    @IBOutlet weak var imgPressureOptn12: UIImageView!
    
    var delegatePressureTestedForLeak: PressureTestedForLeakProtocol?
    
    
    @IBOutlet weak var btnImgUpload50: UIButton!
    @IBOutlet weak var btnImgUpload60: UIButton!
    @IBOutlet weak var btnImgUpload70: UIButton!
    
    
    @IBOutlet weak var collect50Vw: UploadCollectionVw!
    @IBOutlet weak var collect60Vw: UploadCollectionVw!
    @IBOutlet weak var collect70Vw: UploadCollectionVw!
    
    
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
           
        self.vwPressureTestedText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        self.vwPressureTestedText.layer.borderWidth = 0.68
        self.vwPressureTestedText.layer.cornerRadius = 5
       
        self.vwMainBuildingEntranceText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        self.vwMainBuildingEntranceText.layer.borderWidth = 0.68
        self.vwMainBuildingEntranceText.layer.cornerRadius = 5
       
        self.vwInteriorSummaryText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        self.vwInteriorSummaryText.layer.borderWidth = 0.68
        self.vwInteriorSummaryText.layer.cornerRadius = 5
       
        self.vwCompleteLeakDetectionText.layer.borderColor = UIColor (red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0).cgColor
        self.vwCompleteLeakDetectionText.layer.borderWidth = 0.68
        self.vwCompleteLeakDetectionText.layer.cornerRadius = 5
        
        self.vwPressureTestedText.isUserInteractionEnabled = false
        self.vwMainBuildingEntranceText.isUserInteractionEnabled = false

    }
    
    //MARK:- MainBuildingEntrance Button
    @IBAction func mainBuildingEntranceButton(_ radioButton: UIButton) {
        print(radioButton.tag)
        if radioButton.tag == 10 {
            self.vwMainBuildingEntranceText.isUserInteractionEnabled = true
        } else {
            self.vwMainBuildingEntranceText.text = ""
            self.vwMainBuildingEntranceText.isUserInteractionEnabled = false
        }
        
        if imgEntranceOptn0.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "checkmark")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
            imgEntranceOptn11.image = UIImage(named: "unchecked")
            imgEntranceOptn12.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn1.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "checkmark")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
            imgEntranceOptn11.image = UIImage(named: "unchecked")
            imgEntranceOptn12.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn2.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "checkmark")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
            imgEntranceOptn11.image = UIImage(named: "unchecked")
            imgEntranceOptn12.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn3.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "checkmark")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
            imgEntranceOptn11.image = UIImage(named: "unchecked")
            imgEntranceOptn12.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn4.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "checkmark")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
            imgEntranceOptn11.image = UIImage(named: "unchecked")
            imgEntranceOptn12.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn5.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "checkmark")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
            imgEntranceOptn11.image = UIImage(named: "unchecked")
            imgEntranceOptn12.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn6.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "checkmark")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
            imgEntranceOptn11.image = UIImage(named: "unchecked")
            imgEntranceOptn12.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn7.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "checkmark")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
            imgEntranceOptn11.image = UIImage(named: "unchecked")
            imgEntranceOptn12.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn8.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "checkmark")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
            imgEntranceOptn11.image = UIImage(named: "unchecked")
            imgEntranceOptn12.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn9.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "checkmark")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
            imgEntranceOptn11.image = UIImage(named: "unchecked")
            imgEntranceOptn12.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn10.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "checkmark")
            imgEntranceOptn11.image = UIImage(named: "unchecked")
            imgEntranceOptn12.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn11.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
            imgEntranceOptn11.image = UIImage(named: "checkmark")
            imgEntranceOptn12.image = UIImage(named: "unchecked")
        } else if imgEntranceOptn12.tag == radioButton.tag {
            imgEntranceOptn0.image = UIImage(named: "unchecked")
            imgEntranceOptn1.image = UIImage(named: "unchecked")
            imgEntranceOptn2.image = UIImage(named: "unchecked")
            imgEntranceOptn3.image = UIImage(named: "unchecked")
            imgEntranceOptn4.image = UIImage(named: "unchecked")
            imgEntranceOptn5.image = UIImage(named: "unchecked")
            imgEntranceOptn6.image = UIImage(named: "unchecked")
            imgEntranceOptn7.image = UIImage(named: "unchecked")
            imgEntranceOptn8.image = UIImage(named: "unchecked")
            imgEntranceOptn9.image = UIImage(named: "unchecked")
            imgEntranceOptn10.image = UIImage(named: "unchecked")
            imgEntranceOptn11.image = UIImage(named: "unchecked")
            imgEntranceOptn12.image = UIImage(named: "checkmark")
        }
        self.delegateMainBuildingEntrance?.didTapOnMainBuildingEntrance(_btnMainBuildingEntrance: radioButton.tag)
    }
    
    //MARK:- PressureTestedForLeak Button
    @IBAction func pressureTestedForLeakButton(_ radioButton: UIButton) {
        print(radioButton.tag)
        if radioButton.tag == 10 {
            self.vwPressureTestedText.isUserInteractionEnabled = true
        } else {
            self.vwPressureTestedText.text = ""
            self.vwPressureTestedText.isUserInteractionEnabled = false
        }
        
        if imgPressureOptn0.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "checkmark")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
            imgPressureOptn11.image = UIImage(named: "unchecked")
            imgPressureOptn12.image = UIImage(named: "unchecked")
        } else if imgPressureOptn1.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "checkmark")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
            imgPressureOptn11.image = UIImage(named: "unchecked")
            imgPressureOptn12.image = UIImage(named: "unchecked")
        } else if imgPressureOptn2.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "checkmark")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
            imgPressureOptn11.image = UIImage(named: "unchecked")
            imgPressureOptn12.image = UIImage(named: "unchecked")
        } else if imgPressureOptn3.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "checkmark")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
            imgPressureOptn11.image = UIImage(named: "unchecked")
            imgPressureOptn12.image = UIImage(named: "unchecked")
        } else if imgPressureOptn4.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "checkmark")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
            imgPressureOptn11.image = UIImage(named: "unchecked")
            imgPressureOptn12.image = UIImage(named: "unchecked")
        } else if imgPressureOptn5.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "checkmark")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
            imgPressureOptn11.image = UIImage(named: "unchecked")
            imgPressureOptn12.image = UIImage(named: "unchecked")
        } else if imgPressureOptn6.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "checkmark")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
            imgPressureOptn11.image = UIImage(named: "unchecked")
            imgPressureOptn12.image = UIImage(named: "unchecked")
        } else if imgPressureOptn7.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "checkmark")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
            imgPressureOptn11.image = UIImage(named: "unchecked")
            imgPressureOptn12.image = UIImage(named: "unchecked")
        } else if imgPressureOptn8.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "checkmark")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
            imgPressureOptn11.image = UIImage(named: "unchecked")
            imgPressureOptn12.image = UIImage(named: "unchecked")
        } else if imgPressureOptn9.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "checkmark")
            imgPressureOptn10.image = UIImage(named: "unchecked")
            imgPressureOptn11.image = UIImage(named: "unchecked")
            imgPressureOptn12.image = UIImage(named: "unchecked")
        } else if imgPressureOptn10.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "checkmark")
            imgPressureOptn11.image = UIImage(named: "unchecked")
            imgPressureOptn12.image = UIImage(named: "unchecked")
        } else if imgPressureOptn11.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
            imgPressureOptn11.image = UIImage(named: "checkmark")
            imgPressureOptn12.image = UIImage(named: "unchecked")
        } else if imgPressureOptn12.tag == radioButton.tag {
            imgPressureOptn0.image = UIImage(named: "unchecked")
            imgPressureOptn1.image = UIImage(named: "unchecked")
            imgPressureOptn2.image = UIImage(named: "unchecked")
            imgPressureOptn3.image = UIImage(named: "unchecked")
            imgPressureOptn4.image = UIImage(named: "unchecked")
            imgPressureOptn5.image = UIImage(named: "unchecked")
            imgPressureOptn6.image = UIImage(named: "unchecked")
            imgPressureOptn7.image = UIImage(named: "unchecked")
            imgPressureOptn8.image = UIImage(named: "unchecked")
            imgPressureOptn9.image = UIImage(named: "unchecked")
            imgPressureOptn10.image = UIImage(named: "unchecked")
            imgPressureOptn11.image = UIImage(named: "unchecked")
            imgPressureOptn12.image = UIImage(named: "checkmark")
        }
        self.delegatePressureTestedForLeak?.didTapOnPressureTestedForLeak(_btnPressureTestedForLeak: radioButton.tag)
    }
}
 


