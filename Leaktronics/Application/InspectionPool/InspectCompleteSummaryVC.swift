//
//  InspectCompleteSummaryVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 29/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SVProgressHUD

class InspectCompleteSummaryVC: UIViewController {

    @IBOutlet weak var tblSummaryData: UITableView!
    
    var coreDataValue = NSManagedObject()
    
    
    
    var secInspectSummary = [formInspectionPoolData]()
    var dataArray = NSArray()
    
    
     enum InspectSummary: Int {
        case summaryData = 0
    }
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tblSummaryData.estimatedRowHeight = 100.0
        tblSummaryData.rowHeight = UITableView.automaticDimension
        
        /* let string1 = "Disclaimer (TO BE INSERTED INTO TOP OF REPORT -THIS SHOULD BE THE ONLY ITEM WHICH CAN BE EDITED BY USER)\nAn inspection addresses only those components and conditions that are present, visible and accessible at the time of the inspection. While there may be other parts, components or systems present, only those items specifically noted as being inspected were inspected. The inspector is not required to move furnishings or stored items. The inspection report may address issues that are code-based or may refer to a particular code; however, this is NOT a code compliance inspection and does NOT verify compliance with manufacturer's installation instructions. This inspection is not a property zoning or easement inspection and will not address such issues. The inspection does NOT imply insurability or warrantability of the structure or its components. Although some safety issues may be addressed in this report, this inspection is NOT a safety/code inspection, and the inspector is NOT required to identify all potential hazards. In this report, the inspector will note which systems and components were inspected, not inspected, not present, and/or deficient. General deficiencies include inoperability, material distress, water / penetration, damage, deterioration, missing parts, and unsuitable installation. Comments may be provided by the inspector whether or not an item is deemed deficient. The inspector is not required to prioritize or emphasize the importance of one deficiency over another. Some items reported as deficient may be considered life-safety upgrades to the property. This inspection is not an exhaustive inspection of the structure, systems, or components. The inspection may not reveal all deficiencies due to hidden or unknown factors. This report is the exclusive property of _COMPANY NAME__ and the client whose name appears herewith, and its use by any unauthorized persons is strictly prohibited. The observations and opinions expressed within this report are those of _COMPANY NAME_ and supersede any alleged verbal comments. We inspect all of the systems, components, and conditions as described above and cannot be responsible for any work performed in order to cover or hide said repair(s). In accordance with the findings above, the service recommendations that we make in this report should be addressed. Customer agrees that in all cases our liability shall be limited to liquidated damages in an amount not greater than the fee you paid us. You waive any claim for consequential, exemplary, special or incidental damages. You acknowledge that the liquidated damages are not a penalty, but that we intend them to (1) reflect the fact that actual damages may be difficult and impractical to ascertain; (2) allocate risk between us; and (3) enable us to perform the inspection for the agreed upon fee. Customer agrees that any litigation arising out of this Agreement shall be filed only in the Court having jurisdiction in the County where we have our principal place of business. If you fail to prove any claim against us, you agree to pay all our legal costs, expenses and fees incurred in defending that claim. You agree that any legal action against itself, allegedly arising out of this Agreement, must be brought only in the District Court of _TO BE SUPPLIED BY USER. Before bringing any such action, you must provide us with 30 days’ written notice of the nature of the claim. In any action against us you waive trial by jury. If a court declares any provision of this Agreement invalid, the remaining provisions remain in effect. This Agreement represents our entire agreement; there are no terms or promises other than those set forth herein. No statement or promise by us shall be binding unless reduced to writing and signed by one of our authorized officers. Any modification of this Agreement must be in writing and signed by you and by one of our authorized officers. This Agreement shall be binding upon and enforceable by the parties and those that acquire their interests in this Agreement. You will have no cause of action against us after one year from the date of the inspection. If a court finds any term of this Agreement ambiguous or that it otherwise requires judicial interpretation, the court shall not construe that term against us by reason of the rule that any ambiguity in a document is construed against the party drafting it. You had the opportunity to consult qualified counsel before signing this Agreement. If there is more than one Client, you are signing on behalf of all of them, and you represent that you are authorized to do so./n FOOTNOTES:\n*TO CALCULATE THE SIZE OF THE BASIN PERTAINING TO THE POOL:\nMEASUREMENTS ARE SPECULATIVE. A GENERAL GUIDELINE IS THAT A CATCH BASIN WIDTH BE THE MEASUREMENT OF THE HEIGHT OF THE NEGATIVE EDGE WALL IT IS UP AGAINST.\n\n*FOR POOL HEAT PUMP SIZING, AS A GENERAL RULE, PLAN ON 50,000 BTU FOR POOL HEAT PUMP FOR EVERY 10,000 GALLONS OF POOL WATER\n*RECOMMEND REMOVING DIVING BOARD AND / OR SLIDE(S) DUE TO SAFETY AND INSURANCE PURPOSES"*/
        
        
        
        
         self.dataArray = ["Disclaimer (TO BE INSERTED INTO TOP OF REPORT -THIS SHOULD BE THE ONLY ITEM WHICH CAN BE EDITED BY USER)\nAn inspection addresses only those components and conditions that are present, visible and accessible at the time of the inspection. While there may be other parts, components or systems present, only those items specifically noted as being inspected were inspected. The inspector is not required to move furnishings or stored items. The inspection report may address issues that are code-based or may refer to a particular code; however, this is NOT a code compliance inspection and does NOT verify compliance with manufacturer's installation instructions. This inspection is not a property zoning or easement inspection and will not address such issues. The inspection does NOT imply insurability or warrantability of the structure or its components. Although some safety issues may be addressed in this report, this inspection is NOT a safety/code inspection, and the inspector is NOT required to identify all potential hazards. In this report, the inspector will note which systems and components were inspected, not inspected, not present, and/or deficient. General deficiencies include inoperability, material distress, water / penetration, damage, deterioration, missing parts, and unsuitable installation. Comments may be provided by the inspector whether or not an item is deemed deficient. The inspector is not required to prioritize or emphasize the importance of one deficiency over another. Some items reported as deficient may be considered life-safety upgrades to the property. This inspection is not an exhaustive inspection of the structure, systems, or components. The inspection may not reveal all deficiencies due to hidden or unknown factors. This report is the exclusive property of _COMPANY NAME__ and the client whose name appears herewith, and its use by any unauthorized persons is strictly prohibited. The observations and opinions expressed within this report are those of _COMPANY NAME_ and supersede any alleged verbal comments. We inspect all of the systems, components, and conditions as described above and cannot be responsible for any work performed in order to cover or hide said repair(s). In accordance with the findings above, the service recommendations that we make in this report should be addressed. Customer agrees that in all cases our liability shall be limited to liquidated damages in an amount not greater than the fee you paid us. You waive any claim for consequential, exemplary, special or incidental damages. You acknowledge that the liquidated damages are not a penalty, but that we intend them to (1) reflect the fact that actual damages may be difficult and impractical to ascertain; (2) allocate risk between us; and (3) enable us to perform the inspection for the agreed upon fee. Customer agrees that any litigation arising out of this Agreement shall be filed only in the Court having jurisdiction in the County where we have our principal place of business. If you fail to prove any claim against us, you agree to pay all our legal costs, expenses and fees incurred in defending that claim. You agree that any legal action against itself, allegedly arising out of this Agreement, must be brought only in the District Court of _TO BE SUPPLIED BY USER. Before bringing any such action, you must provide us with 30 days’ written notice of the nature of the claim. In any action against us you waive trial by jury. If a court declares any provision of this Agreement invalid, the remaining provisions remain in effect. This Agreement represents our entire agreement; there are no terms or promises other than those set forth herein. No statement or promise by us shall be binding unless reduced to writing and signed by one of our authorized officers. Any modification of this Agreement must be in writing and signed by you and by one of our authorized officers. This Agreement shall be binding upon and enforceable by the parties and those that acquire their interests in this Agreement. You will have no cause of action against us after one year from the date of the inspection. If a court finds any term of this Agreement ambiguous or that it otherwise requires judicial interpretation, the court shall not construe that term against us by reason of the rule that any ambiguity in a document is construed against the party drafting it. You had the opportunity to consult qualified counsel before signing this Agreement. If there is more than one Client, you are signing on behalf of all of them, and you represent that you are authorized to do so. \n\n FOOTNOTES:\n *TO CALCULATE THE SIZE OF THE BASIN PERTAINING TO THE POOL:\nMEASUREMENTS ARE SPECULATIVE. A GENERAL GUIDELINE IS THAT A CATCH BASIN WIDTH BE THE MEASUREMENT OF THE HEIGHT OF THE NEGATIVE EDGE WALL IT IS UP AGAINST.\n\n*FOR POOL HEAT PUMP SIZING, AS A GENERAL RULE, PLAN ON 50,000 BTU FOR POOL HEAT PUMP FOR EVERY 10,000 GALLONS OF POOL WATER\n\n*RECOMMEND REMOVING DIVING BOARD AND / OR SLIDE(S) DUE TO SAFETY AND INSURANCE PURPOSES"]
        
        self.prepareFormSummaryData()
    }
    
    func prepareFormSummaryData() {
       for _ in 0..<1 {
           let obj = formInspectionPoolData()
           self.secInspectSummary.append(obj)
       }
    }
    
    //MARK:- Function
    @objc func btnSubmitDidTap() {
        self.view.endEditing(true)
        //self.updateCoreData()
        self.checkNetwork()
    }
    
    func checkNetwork() {
        switch Network.reachability.status {
        case .unreachable:
            print("Check InterNet")
            updateCoreData()
            if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                self.navigationController?.pushViewController(InspectionListVC, animated: true)
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                self.navigationController?.pushViewController(InspectionListVC, animated: true)
            }
        case .wwan:
            self.postInspectSummary()
        case .wifi:
            self.postInspectSummary()
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    
    //MARK:- CoreData
    func updateCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "InspectionPool_CoreData")
        
        let userName: String = UserDefaults.standard.value(forKey: "InspectionUserName") as! String
        let predicate = NSPredicate(format: "%K == %@", "nameInspect", userName)
        fetchRequest.predicate = predicate
        
        do {
            let  rs = try managedContext.fetch(fetchRequest)
            for _ in rs as [NSManagedObject] {
                // update
                do {
                    let managedObject = rs[0]
                    
                    managedObject.setValue(self.secInspectSummary[InspectSummary.summaryData.rawValue].formTextValue, forKey: "summaryData")
                    
                    try managedContext.save()
                    print("update successfull")
                } catch let error as NSError {
                    print("Could not Update. \(error), \(error.userInfo)")
                }
                //end update
            }
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionPool_CoreData")
            request.returnsObjectsAsFaults = false

            do {
                let result = try managedContext.fetch(request)
                for data in result as! [NSManagedObject] {
                    if (data.value(forKey: "nameInspect") as! String) == userName {
                        print("Data of QuestionnaireForm1VC:: \(data)")
//                        print("TextView::",data.value(forKey: "approxDimentionDescription") as! String)
//                        print("Text::",data.value(forKey: "approxDimentionText") as! String)
//                        print("Other Find Text::",data.value(forKey: "otherFindUsText") as! String)
                    }
                }
            } catch {
                print("Failed")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //MARK:: Function Api Calling
    func postInspectSummary() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        
        let headers = [
            "Authorization": token,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let url = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectionPool)
        print("InspectionPoolDetails URL:: \(url)")
        
        let inspectDetails: NSMutableDictionary = [
            //TODO:-InspectPoolContactVC
            "device_id"             : (UIDevice.current.identifierForVendor?.uuidString)!,
            "namePoolDetection"     : coreDataValue.value(forKey: "nameInspect")!,
            "addressPool"           : coreDataValue.value(forKey: "addressInspect")!,
            "cityPool"              : coreDataValue.value(forKey: "cityInspect")!,
            "statePool"             : coreDataValue.value(forKey: "stateInspect")!,
            "zipPool"               : coreDataValue.value(forKey: "zipInspect")!,
            "phoneNoPool"           : coreDataValue.value(forKey: "phoneNoInspect")!,
            "emailPool"             : coreDataValue.value(forKey: "emailInspect")!,
            "paymentPersonInspect"  : coreDataValue.value(forKey: "paymentPersonInspect")!,
            "notesPool"             : coreDataValue.value(forKey: "notesInspect")!,
            "otherNotesPool"        : coreDataValue.value(forKey: "otherNotesInspect")!,
            "priceForLeakPool"      : coreDataValue.value(forKey: "priceForLeakInspect")!,
            "inpectTimePool"        : coreDataValue.value(forKey: "inspection_date_time")!,
            "inspection_date_time"  : coreDataValue.value(forKey: "inspection_date_time")!,
            //TODO:-InspectQuestionnaireFormVC
            "inspectFindUsOption"        : coreDataValue.value(forKey: "inspectFindUsOption")!,
            "otherFindUsText"            : coreDataValue.value(forKey: "otherFindUsText")!,
            "realEstateOption"           : coreDataValue.value(forKey: "realEstateOption")!,
            "insuranceOption"            : coreDataValue.value(forKey: "insuranceOption")!,
            //TODO:-InspectionVC
            "waterConditionOption"  : coreDataValue.value(forKey: "waterConditionOption")!,
            "waterLevelHtOption"    : coreDataValue.value(forKey: "waterLevelHtOption")!,
            "waterLevelHtData"      : coreDataValue.value(forKey: "waterLevelHtData")!,
            "drainVisibleOption"    : coreDataValue.value(forKey: "drainVisibleOption")!,
            "mainDrainData"         : coreDataValue.value(forKey: "mainDrainData")!,
            "lowerPoolOption"       : coreDataValue.value(forKey: "lowerPoolOption")!,
            "nearByData"            : coreDataValue.value(forKey: "nearByData")!,
            "floodRiskOption"       : coreDataValue.value(forKey: "floodRiskOption")!,
            "floodRiskData"         : coreDataValue.value(forKey: "floodRiskData")!,
            "poolLevelOption"       : coreDataValue.value(forKey: "poolLevelOption")!,
            "poolLevelData"         : coreDataValue.value(forKey: "poolLevelData")!,
            "spaLevelOption"        : coreDataValue.value(forKey: "spaLevelOption")!,
            "spaLevelData"          : coreDataValue.value(forKey: "spaLevelData")!,
            "spaConstructOption"    : coreDataValue.value(forKey: "spaConstructOption")!,
            "constructedSPAData"    : coreDataValue.value(forKey: "constructedSPAData")!,
            "spaMaterialOption"     : coreDataValue.value(forKey: "spaMaterialOption")!,
            "surfaceMaterialData"   : coreDataValue.value(forKey: "surfaceMaterialData")!,
            "spaTouchOption"        : coreDataValue.value(forKey: "spaTouchOption")!,
            "touchData"             : coreDataValue.value(forKey: "touchData")!,
            "surfaceOption"         : coreDataValue.value(forKey: "surfaceOption")!,
            "structOption"          : coreDataValue.value(forKey: "structOption")!,
            "structData"            : coreDataValue.value(forKey: "structData")!,
            //TODO:-InspectFittingsVC
            "physicalOption"    : coreDataValue.value(forKey: "physicalOption")!,
            "physicalData"      : coreDataValue.value(forKey: "physicalData")!,
            "properFlowOption"  : coreDataValue.value(forKey: "properFlowOption")!,
            "properFlowData"    : coreDataValue.value(forKey: "properFlowData")!,
            "positionOption"    : coreDataValue.value(forKey: "positionOption")!,
            "positionData"      : coreDataValue.value(forKey: "positionData")!,
            "crackBeamOption"   : coreDataValue.value(forKey: "crackBeamOption")!,
            "crackBeamData"     : coreDataValue.value(forKey: "crackBeamData")!,
            "crackTileOption"   : coreDataValue.value(forKey: "crackTileOption")!,
            "crackTileData"     : coreDataValue.value(forKey: "crackTileData")!,
            "tileLevelOption"   : coreDataValue.value(forKey: "tileLevelOption")!,
            "tileLevelData"     : coreDataValue.value(forKey: "tileLevelData")!,
            "copingTypeOption"  : coreDataValue.value(forKey: "copingTypeOption")!,
            "copingTypeData"    : coreDataValue.value(forKey: "copingTypeData")!,
            "copingLevelOption" : coreDataValue.value(forKey: "copingLevelOption")!,
            "copingLevelData"   : coreDataValue.value(forKey: "copingLevelData")!,
            //TODO:-InspectDeckVC
            "deckMaterialOption"    : coreDataValue.value(forKey: "deckMaterialOption")!,
            "deckMaterialData"      : coreDataValue.value(forKey: "deckMaterialData")!,
            "deckControlOption"     : coreDataValue.value(forKey: "deckControlOption")!,
            "deckControlData"       : coreDataValue.value(forKey: "deckControlData")!,
            "deckSealOption"        : coreDataValue.value(forKey: "deckSealOption")!,
            "deckSealData"          : coreDataValue.value(forKey: "deckSealData")!,
            "deckLiftOption"        : coreDataValue.value(forKey: "deckLiftOption")!,
            "deckLiftData"          : coreDataValue.value(forKey: "deckLiftData")!,
            "deckHazardsOption"     : coreDataValue.value(forKey: "deckHazardsOption")!,
            "deckHazardsData"       : coreDataValue.value(forKey: "deckHazardsData")!,
            "deckLevelOption"       : coreDataValue.value(forKey: "deckLevelOption")!,
            "deckLevelData"         : coreDataValue.value(forKey: "deckLevelData")!,
            "deckSlopeOption"       : coreDataValue.value(forKey: "deckSlopeOption")!,
            "deckSlopeData"         : coreDataValue.value(forKey: "deckSlopeData")!,
            "deckDrainageOption"    : coreDataValue.value(forKey: "deckDrainageOption")!,
            "deckDrainageData"      : coreDataValue.value(forKey: "deckDrainageData")!,
            "deckHandrailsOption"   : coreDataValue.value(forKey: "deckHandrailsOption")!,
            "deckHandrailsData"     : coreDataValue.value(forKey: "deckHandrailsData")!,
            "deckDeepDropOption"    : coreDataValue.value(forKey: "deckDeepDropOption")!,
            "deckDeepDropData"      : coreDataValue.value(forKey: "deckDeepDropData")!,
            //TODO:-InspectHandrailsVC
            "entranceOption"        : coreDataValue.value(forKey: "entranceOption")!,
            "entranceData"          : coreDataValue.value(forKey: "entranceData")!,
            "deepEndOption"         : coreDataValue.value(forKey: "deepEndOption")!,
            "deepEndData"           : coreDataValue.value(forKey: "deepEndData")!,
            "grabRailsOption"       : coreDataValue.value(forKey: "grabRailsOption")!,
            "grabRailsData"         : coreDataValue.value(forKey: "grabRailsData")!,
            "raisedWallOption"      : coreDataValue.value(forKey: "raisedWallOption")!,
            "raisedWallData"        : coreDataValue.value(forKey: "raisedWallData")!,
            "subRaisedWallOption"   : coreDataValue.value(forKey: "subRaisedWallOption")!,
            "subRaisedWallData"     : coreDataValue.value(forKey: "subRaisedWallData")!,
            "grabEdgeOption"        : coreDataValue.value(forKey: "grabEdgeOption")!,
            "grabEdgeData"          : coreDataValue.value(forKey: "grabEdgeData")!,
            //TODO:-InspectEdgeVC
            "negativeOption"    : coreDataValue.value(forKey: "negativeOption")!,
            "negativeData"      : coreDataValue.value(forKey: "negativeData")!,
            "basinOption"       : coreDataValue.value(forKey: "basinOption")!,
            "basinData"         : coreDataValue.value(forKey: "basinData")!,
            "drainOption"       : coreDataValue.value(forKey: "drainOption")!,
            "drainData"         : coreDataValue.value(forKey: "drainData")!,
            "tankOption"        : coreDataValue.value(forKey: "tankOption")!,
            "tankData"          : coreDataValue.value(forKey: "tankData")!,
            "edge0Option"       : coreDataValue.value(forKey: "edge0Option")!,
            "edge0Data"         : coreDataValue.value(forKey: "edge0Data")!,
            "edge1Option"       : coreDataValue.value(forKey: "edge1Option")!,
            "edge1Data"         : coreDataValue.value(forKey: "edge1Data")!,
            "basin0Option"      : coreDataValue.value(forKey: "basin0Option")!,
            "basin0Data"        : coreDataValue.value(forKey: "basin0Data")!,
            "basin1Option"      : coreDataValue.value(forKey: "basin1Option")!,
            "basin1Data"        : coreDataValue.value(forKey: "basin1Data")!,
            "basin2Option"      : coreDataValue.value(forKey: "basin2Option")!,
            "basin2Data"        : coreDataValue.value(forKey: "basin2Data")!,
            "basin3Option"      : coreDataValue.value(forKey: "basin3Option")!,
            "basin3Data"        : coreDataValue.value(forKey: "basin3Data")!,
            "basin4Option"      : coreDataValue.value(forKey: "basin4Option")!,
            "basin4Data"        : coreDataValue.value(forKey: "basin4Data")!,
            "basin5Option"      : coreDataValue.value(forKey: "basin5Option")!,
            "basin5Data"        : coreDataValue.value(forKey: "basin5Data")!,
            "drain0Option"      : coreDataValue.value(forKey: "drain0Option")!,
            "drain0Data"        : coreDataValue.value(forKey: "drain0Data")!,
            "tank0Option"       : coreDataValue.value(forKey: "tank0Option")!,
            "tank0Data"         : coreDataValue.value(forKey: "tank0Data")!,
            //TODO:-InspectWaterFeatureVC
            "waterFeaturePresentOption" : coreDataValue.value(forKey: "summaryData")!,
            "waterFeaturePresentData"   : coreDataValue.value(forKey: "summaryData")!,
            "divingPresentOption"       : coreDataValue.value(forKey: "summaryData")!,
            "slidesPresentOption"       : coreDataValue.value(forKey: "summaryData")!,
            "mainDrainOption"           : coreDataValue.value(forKey: "summaryData")!,
            "poolSubData"               : coreDataValue.value(forKey: "summaryData")!,
            "spaSubData"                : coreDataValue.value(forKey: "summaryData")!,
            "featureMainDrainData"      : coreDataValue.value(forKey: "summaryData")!,
            "splitDrainOption"          : coreDataValue.value(forKey: "summaryData")!,
            "splitDrainData"            : coreDataValue.value(forKey: "summaryData")!,
            "coverVGBOption"            : coreDataValue.value(forKey: "summaryData")!,
            "coverVGBData"              : coreDataValue.value(forKey: "summaryData")!,
            "coverMountedOption"        : coreDataValue.value(forKey: "summaryData")!,
            "coverMountedData"          : coreDataValue.value(forKey: "summaryData")!,
            "subWaterOperateOption"     : coreDataValue.value(forKey: "summaryData")!,
            "subWaterOperateData"       : coreDataValue.value(forKey: "summaryData")!,
            "subWaterHazardOption"      : coreDataValue.value(forKey: "summaryData")!,
            "subWaterHazardData"        : coreDataValue.value(forKey: "summaryData")!,
            "subWaterSwimmerOption"     : coreDataValue.value(forKey: "summaryData")!,
            "subWaterSwimmerData"       : coreDataValue.value(forKey: "summaryData")!,
            "subWaterBasinCrackOption"  : coreDataValue.value(forKey: "summaryData")!,
            "subWaterBasinCrackData"    : coreDataValue.value(forKey: "summaryData")!,
            //TODO:-InspectSideSuctionVC
            "mainSuctionOption"         : coreDataValue.value(forKey: "mainSuctionOption")!,
            "mainSuctionData"           : coreDataValue.value(forKey: "mainSuctionData")!,
            "mainSkimmerOption"         : coreDataValue.value(forKey: "mainSkimmerOption")!,
            "mainSkimmerData"           : coreDataValue.value(forKey: "mainSkimmerData")!,
            "suctionInchesOption"       : coreDataValue.value(forKey: "suctionInchesOption")!,
            "suctionInchesData"         : coreDataValue.value(forKey: "suctionInchesData")!,
            "suctionVGBComplaintOption" : coreDataValue.value(forKey: "suctionVGBComplaintOption")!,
            "suctionVGBComplaintData"   : coreDataValue.value(forKey: "suctionVGBComplaintData")!,
            "suctionMountedOption"      : coreDataValue.value(forKey: "suctionMountedOption")!,
            "suctionMountedData"        : coreDataValue.value(forKey: "suctionMountedData")!,
            "skimmerOperateOption"      : coreDataValue.value(forKey: "skimmerOperateOption")!,
            "skimmerOperateData"        : coreDataValue.value(forKey: "skimmerOperateData")!,
            "skimmerRepairOption"       : coreDataValue.value(forKey: "skimmerRepairOption")!,
            "skimmerRepairData"         : coreDataValue.value(forKey: "skimmerRepairData")!,
            "skimmerProperHtOption"     : coreDataValue.value(forKey: "skimmerProperHtOption")!,
            "skimmerProperHtData"       : coreDataValue.value(forKey: "skimmerProperHtData")!,
            "skimmerWeirDoorOption"     : coreDataValue.value(forKey: "skimmerWeirDoorOption")!,
            "skimmerWeirDoorData"       : coreDataValue.value(forKey: "skimmerWeirDoorData")!,
            "skimmerDoorWorkOption"     : coreDataValue.value(forKey: "skimmerDoorWorkOption")!,
            "skimmerDoorWorkData"       : coreDataValue.value(forKey: "skimmerDoorWorkData")!,
            "skimmerBasementOption"     : coreDataValue.value(forKey: "skimmerBasementOption")!,
            "skimmerBasementData"       : coreDataValue.value(forKey: "skimmerBasementData")!,
            "skimmerConditionOption"    : coreDataValue.value(forKey: "skimmerConditionOption")!,
            "skimmerConditionData"      : coreDataValue.value(forKey: "skimmerConditionData")!,
            "skimmerDiverOption"        : coreDataValue.value(forKey: "skimmerDiverOption")!,
            "skimmerDiverData"          : coreDataValue.value(forKey: "skimmerDiverData")!,
            "skimmerSeamOption"         : coreDataValue.value(forKey: "skimmerSeamOption")!,
            "skimmerSeamData"           : coreDataValue.value(forKey: "skimmerSeamData")!,
            "skimmerCrackOption"        : coreDataValue.value(forKey: "skimmerCrackOption")!,
            "skimmerCrackData"          : coreDataValue.value(forKey: "skimmerCrackData")!,
            "skimmerSuctionWorkOption"  : coreDataValue.value(forKey: "skimmerSuctionWorkOption")!,
            "skimmerSuctionWorkData"    : coreDataValue.value(forKey: "skimmerSuctionWorkData")!,
            "skimmerEqualizerOption"    : coreDataValue.value(forKey: "skimmerEqualizerOption")!,
            "skimmerEqualizerData"      : coreDataValue.value(forKey: "skimmerEqualizerData")!,
            "skimmerEqualizerVGBOption" : coreDataValue.value(forKey: "skimmerEqualizerVGBOption")!,
            "skimmerEqualizerVGBData"   : coreDataValue.value(forKey: "skimmerEqualizerVGBData")!,
            "skimmerMainDrainOption"    : coreDataValue.value(forKey: "skimmerMainDrainOption")!,
            "skimmerMainDrainData"      : coreDataValue.value(forKey: "skimmerMainDrainData")!,
            //TODO:-InspectAutofillVC
            "autofillOption"    : coreDataValue.value(forKey: "autofillOption")!,
            "overFlowOption"    : coreDataValue.value(forKey: "overFlowOption")!,
            "overFlowData"      : coreDataValue.value(forKey: "overFlowData")!,
            "autoWaterOption0"  : coreDataValue.value(forKey: "autoWaterOption0")!,
            "autofillOption1"   : coreDataValue.value(forKey: "autofillOption1")!,
            "autofill1Data"     : coreDataValue.value(forKey: "autofill1Data")!,
            "autofillOption2"   : coreDataValue.value(forKey: "autofillOption2")!,
            "autofill2Data"     : coreDataValue.value(forKey: "autofill2Data")!,
            "autofillOption3"   : coreDataValue.value(forKey: "autofillOption3")!,
            "autofill3Data"     : coreDataValue.value(forKey: "autofill3Data")!,
            "autofillOption4"   : coreDataValue.value(forKey: "autofillOption4")!,
            "autofill4Data"     : coreDataValue.value(forKey: "autofill4Data")!,
            "autofillOption5"   : coreDataValue.value(forKey: "autofillOption5")!,
            "autofill5Data"     : coreDataValue.value(forKey: "autofill5Data")!,
            "autofillOption6"   : coreDataValue.value(forKey: "autofillOption6")!,
            "autofill6Data"     : coreDataValue.value(forKey: "autofill6Data")!,
            "autofillOption7"   : coreDataValue.value(forKey: "autofillOption7")!,
            "autofill7Data"     : coreDataValue.value(forKey: "autofill7Data")!,
            "autofillOption8"   : coreDataValue.value(forKey: "autofillOption8")!,
            "autofill8Data"     : coreDataValue.value(forKey: "autofill8Data")!,
            "overFlowOption0"   : coreDataValue.value(forKey: "overFlowOption0")!,
            "overFlow0Data"     : coreDataValue.value(forKey: "overFlow0Data")!,
            "overFlowOption1"   : coreDataValue.value(forKey: "overFlowOption1")!,
            "overFlow1Data"     : coreDataValue.value(forKey: "overFlow1Data")!,
            //TODO:-InspectPortableSpaVC
            "mainSpaOption"     : coreDataValue.value(forKey: "mainSpaOption")!,
            "mainSpaData"       : coreDataValue.value(forKey: "mainSpaData")!,
            "equipRoomOption"   : coreDataValue.value(forKey: "equipRoomOption")!,
            "equipRoomData"     : coreDataValue.value(forKey: "equipRoomData")!,
            "equipClearOption"  : coreDataValue.value(forKey: "equipClearOption")!,
            "equipClearData"    : coreDataValue.value(forKey: "equipClearData")!,
            "equipElementOption": coreDataValue.value(forKey: "equipElementOption")!,
            "equipElementData"  : coreDataValue.value(forKey: "equipElementData")!,
            "equipUVOption"     : coreDataValue.value(forKey: "equipUVOption")!,
            "equipUVData"       : coreDataValue.value(forKey: "equipUVData")!,
            "spa0Option"        : coreDataValue.value(forKey: "spa0Option")!,
            "spa0Data"          : coreDataValue.value(forKey: "spa0Data")!,
            "spa1Option"        : coreDataValue.value(forKey: "spa1Option")!,
            "spa1Data"          : coreDataValue.value(forKey: "spa1Data")!,
            "spa2Option"        : coreDataValue.value(forKey: "spa2Option")!,
            "spa2Data"          : coreDataValue.value(forKey: "spa2Data")!,
            "spa3Option"        : coreDataValue.value(forKey: "spa3Option")!,
            "spa3Data"          : coreDataValue.value(forKey: "spa3Data")!,
            "spa4Option"        : coreDataValue.value(forKey: "spa4Option")!,
            "spa4Data"          : coreDataValue.value(forKey: "spa4Data")!,
            "spa5Option"        : coreDataValue.value(forKey: "spa5Option")!,
            "spa5Data"          : coreDataValue.value(forKey: "spa5Data")!,
            "spa6Option"        : coreDataValue.value(forKey: "spa6Option")!,
            "spa6Data"          : coreDataValue.value(forKey: "spa6Data")!,
            "spa7Option"        : coreDataValue.value(forKey: "spa7Option")!,
            "spa7Data"          : coreDataValue.value(forKey: "spa7Data")!,
            "spa8Option"        : coreDataValue.value(forKey: "spa8Option")!,
            "spa8Data"          : coreDataValue.value(forKey: "spa8Data")!,
            "spa9Option"        : coreDataValue.value(forKey: "spa9Option")!,
            "spa9Data"          : coreDataValue.value(forKey: "spa9Data")!,
            //TODO:-InspectSolarVC
            "solarMainOption"   : coreDataValue.value(forKey: "solarMainOption")!,
            "solarMainData"     : coreDataValue.value(forKey: "solarMainData")!,
            "solar0Option"      : coreDataValue.value(forKey: "solar0Option")!,
            "solar0Data"        : coreDataValue.value(forKey: "solar0Data")!,
            "solar1Option"      : coreDataValue.value(forKey: "solar1Option")!,
            "solar1Data"        : coreDataValue.value(forKey: "solar1Data")!,
            "solar2Option"      : coreDataValue.value(forKey: "solar2Option")!,
            "solar2Data"        : coreDataValue.value(forKey: "solar2Data")!,
            "solar3Option"      : coreDataValue.value(forKey: "solar3Option")!,
            "solar3Data"        : coreDataValue.value(forKey: "solar3Data")!,
            "solar4Option"      : coreDataValue.value(forKey: "solar4Option")!,
            "solar4Data"        : coreDataValue.value(forKey: "solar4Data")!,
            "flitOption"        : coreDataValue.value(forKey: "flitOption")!,
            "flitData"          : coreDataValue.value(forKey: "flitData")!,
            "flit1Option"       : coreDataValue.value(forKey: "flit1Option")!,
            "flit1Data"         : coreDataValue.value(forKey: "flit1Data")!,
            "flit2Option"       : coreDataValue.value(forKey: "flit2Option")!,
            "flit2Data"         : coreDataValue.value(forKey: "flit2Data")!,
            "flit3Option"       : coreDataValue.value(forKey: "flit3Option")!,
            "flit3Data"         : coreDataValue.value(forKey: "flit3Data")!,
            "flit4Option"       : coreDataValue.value(forKey: "flit4Option")!,
            "flit4Data"         : coreDataValue.value(forKey: "flit4Data")!,
            "flit5Option"       : coreDataValue.value(forKey: "flit5Option")!,
            "flit5Data"         : coreDataValue.value(forKey: "flit5Data")!,
            "flit6Option"       : coreDataValue.value(forKey: "flit6Option")!,
            "flit6Data"         : coreDataValue.value(forKey: "flit6Data")!,
            "flit7Option"       : coreDataValue.value(forKey: "flit7Option")!,
            "flit7Data"         : coreDataValue.value(forKey: "flit7Data")!,
            "flit8Option"       : coreDataValue.value(forKey: "flit8Option")!,
            "flit8Data"         : coreDataValue.value(forKey: "flit8Data")!,
            "flit9Option"       : coreDataValue.value(forKey: "flit9Option")!,
            "flit9Data"         : coreDataValue.value(forKey: "flit9Data")!,
            "flit10Option"      : coreDataValue.value(forKey: "flit10Option")!,
            "flit10Data"        : coreDataValue.value(forKey: "flit10Data")!,
            "flit11Option"      : coreDataValue.value(forKey: "flit11Option")!,
            "flit11Data"        : coreDataValue.value(forKey: "flit11Data")!,
            "flit12Option"      : coreDataValue.value(forKey: "flit12Option")!,
            "flit12Data"        : coreDataValue.value(forKey: "flit12Data")!,
            //TODO:-InspectPoolPumpVC
            "pumpFiltrationOption"      : coreDataValue.value(forKey: "pumpFiltrationOption")!,
            "pumpFiltrationData"        : coreDataValue.value(forKey: "pumpFiltrationData")!,
            "pumpMaintainanceOption"    : coreDataValue.value(forKey: "pumpMaintainanceOption")!,
            "pumpMaintainanceData"      : coreDataValue.value(forKey: "pumpMaintainanceData")!,
            "pumpAdequateOption"        : coreDataValue.value(forKey: "pumpAdequateOption")!,
            "pumpAdequateData"          : coreDataValue.value(forKey: "pumpAdequateData")!,
            "pumpMountedOption"         : coreDataValue.value(forKey: "pumpMountedOption")!,
            "pumpMountedData"           : coreDataValue.value(forKey: "pumpMountedData")!,
            "pumpLeakption"             : coreDataValue.value(forKey: "pumpLeakption")!,
            "pumpLeakData"              : coreDataValue.value(forKey: "pumpLeakData")!,
            "pumpGasketsOption"         : coreDataValue.value(forKey: "pumpGasketsOption")!,
            "pumpGasketsData"           : coreDataValue.value(forKey: "pumpGasketsData")!,
            "pumpSizeOption"            : coreDataValue.value(forKey: "pumpSizeOption")!,
            "pumpSizeData"              : coreDataValue.value(forKey: "pumpSizeData")!,
            "pumpEquipmentOption"       : coreDataValue.value(forKey: "pumpEquipmentOption")!,
            "pumpEquipmentData"         : coreDataValue.value(forKey: "pumpEquipmentData")!,
            "spaJetsOption"             : coreDataValue.value(forKey: "spaJetsOption")!,
            "spaJetsMainData"           : coreDataValue.value(forKey: "spaJetsMainData")!,
            "pumpOperatingOption"       : coreDataValue.value(forKey: "pumpOperatingOption")!,
            "pumpOperatingData"         : coreDataValue.value(forKey: "pumpOperatingData")!,
            "maintaianceAccessOption"   : coreDataValue.value(forKey: "maintaianceAccessOption")!,
            "maintaianceAccessData"     : coreDataValue.value(forKey: "maintaianceAccessData")!,
            "adequateSizeOption"        : coreDataValue.value(forKey: "adequateSizeOption")!,
            "adequateSizeData"          : coreDataValue.value(forKey: "adequateSizeData")!,
            "mountedOption"             : coreDataValue.value(forKey: "mountedOption")!,
            "mountedData"               : coreDataValue.value(forKey: "mountedData")!,
            "visibleLeakOption"         : coreDataValue.value(forKey: "visibleLeakOption")!,
            "visibleLeakData"           : coreDataValue.value(forKey: "visibleLeakData")!,
            "gasketsOption"             : coreDataValue.value(forKey: "gasketsOption")!,
            "gasketsData"               : coreDataValue.value(forKey: "gasketsData")!,
            "visibleAdequateSizeOption" : coreDataValue.value(forKey: "visibleAdequateSizeOption")!,
            "visibleAdequateSizeData"   : coreDataValue.value(forKey: "visibleAdequateSizeData")!,
            "runQuietlyOption"          : coreDataValue.value(forKey: "runQuietlyOption")!,
            "runQuietlyData"            : coreDataValue.value(forKey: "runQuietlyData")!,
            //TODO:-InspectSwimJetSystemVC
            "swimJetsOption"            : coreDataValue.value(forKey: "swimJetsOption")!,
            "swimJetsData"              : coreDataValue.value(forKey: "swimJetsData")!,
            "waterFeatureOption"        : coreDataValue.value(forKey: "waterFeatureOption")!,
            "waterFeatureData"          : coreDataValue.value(forKey: "waterFeatureData")!,
            "swimPumpOperatingOption"   : coreDataValue.value(forKey: "swimPumpOperatingOption")!,
            "swimPumpOperatingData"     : coreDataValue.value(forKey: "swimPumpOperatingData")!,
            "swimMaintainceOption"      : coreDataValue.value(forKey: "swimMaintainceOption")!,
            "swimMaintainceData"        : coreDataValue.value(forKey: "swimMaintainceData")!,
            "swimAdequateSizeOption"    : coreDataValue.value(forKey: "swimAdequateSizeOption")!,
            "swimAdequateSizeData"      : coreDataValue.value(forKey: "swimAdequateSizeData")!,
            "swimMountedOption"         : coreDataValue.value(forKey: "swimMountedOption")!,
            "swimMountedData"           : coreDataValue.value(forKey: "swimMountedData")!,
            "swimVisibleLeakOption"     : coreDataValue.value(forKey: "swimVisibleLeakOption")!,
            "swimVisibleLeakData"       : coreDataValue.value(forKey: "swimVisibleLeakData")!,
            "swimGasketsdOption"        : coreDataValue.value(forKey: "swimGasketsdOption")!,
            "swimGasketsData"           : coreDataValue.value(forKey: "swimGasketsData")!,
            "swimVisibleAdequateOption" : coreDataValue.value(forKey: "swimVisibleAdequateOption")!,
            "swimVisibleAdequateData"   : coreDataValue.value(forKey: "swimVisibleAdequateData")!,
            "swimRunQuietlyOption"      : coreDataValue.value(forKey: "swimRunQuietlyOption")!,
            "swimRunQuietlyData"        : coreDataValue.value(forKey: "swimRunQuietlyData")!,
            "waterOperatingOption"      : coreDataValue.value(forKey: "waterOperatingOption")!,
            "waterOperatingData"        : coreDataValue.value(forKey: "waterOperatingData")!,
            "waterMaintainceOption"     : coreDataValue.value(forKey: "waterMaintainceOption")!,
            "waterMaintainceData"       : coreDataValue.value(forKey: "waterMaintainceData")!,
            "waterAdequateSizeOption"   : coreDataValue.value(forKey: "waterAdequateSizeOption")!,
            "waterAdequateSizeData"     : coreDataValue.value(forKey: "waterAdequateSizeData")!,
            "waterMountedOption"        : coreDataValue.value(forKey: "waterMountedOption")!,
            "waterMountedData"          : coreDataValue.value(forKey: "waterMountedData")!,
            "waterVisibleLeakOption"    : coreDataValue.value(forKey: "waterVisibleLeakOption")!,
            "waterVisibleLeakData"      : coreDataValue.value(forKey: "waterVisibleLeakData")!,
            "waterGasketsOption"        : coreDataValue.value(forKey: "waterGasketsOption")!,
            "waterGasketsData"          : coreDataValue.value(forKey: "waterGasketsData")!,
            "waterVisibleAdequateOption": coreDataValue.value(forKey: "waterVisibleAdequateOption")!,
            "waterVisibleAdequateData"  : coreDataValue.value(forKey: "waterVisibleAdequateData")!,
            "waterRunQuietlyOption"     : coreDataValue.value(forKey: "waterRunQuietlyOption")!,
            "waterRunQuietlyData"       : coreDataValue.value(forKey: "waterRunQuietlyData")!,
            //TODO:-InspectSelfCleaningVC
            "selfCleanOption"                   : coreDataValue.value(forKey: "selfCleanOption")!,
            "selfCleanData"                     : coreDataValue.value(forKey: "selfCleanData")!,
            "boosterPumpOption"                 : coreDataValue.value(forKey: "boosterPumpOption")!,
            "boosterPumpData"                   : coreDataValue.value(forKey: "boosterPumpData")!,
            "selfCleanOperatingOption"          : coreDataValue.value(forKey: "selfCleanOperatingOption")!,
            "selfCleanOperatingData"            : coreDataValue.value(forKey: "selfCleanOperatingData")!,
            "selfCleanMaintainceOption"         : coreDataValue.value(forKey: "selfCleanMaintainceOption")!,
            "selfCleanMaintainceData"           : coreDataValue.value(forKey: "selfCleanMaintainceData")!,
            "selfCleanAdequateSizeOption"       : coreDataValue.value(forKey: "selfCleanAdequateSizeOption")!,
            "selfCleanAdequateSizeData"         : coreDataValue.value(forKey: "selfCleanAdequateSizeData")!,
            "selfCleanMountedOption"            : coreDataValue.value(forKey: "selfCleanMountedOption")!,
            "selfCleanMountedData"              : coreDataValue.value(forKey: "selfCleanMountedData")!,
            "selfCleanVisibleLeakOption"        : coreDataValue.value(forKey: "selfCleanVisibleLeakOption")!,
            "selfCleanVisibleLeakData"          : coreDataValue.value(forKey: "selfCleanVisibleLeakData")!,
            "selfCleanGasketsOption"            : coreDataValue.value(forKey: "selfCleanGasketsOption")!,
            "selfCleanGasketsData"              : coreDataValue.value(forKey: "selfCleanGasketsData")!,
            "selfCleanVisibleAdequateOption"    : coreDataValue.value(forKey: "selfCleanVisibleAdequateOption")!,
            "selfCleanVisibleAdequateData"      : coreDataValue.value(forKey: "selfCleanVisibleAdequateData")!,
            "selfCleanRunQuietlyOption"         : coreDataValue.value(forKey: "selfCleanRunQuietlyOption")!,
            "selfCleanRunQuietlyData"           : coreDataValue.value(forKey: "selfCleanRunQuietlyData")!,
            "boosterPumpOperatingOption"        : coreDataValue.value(forKey: "boosterPumpOperatingOption")!,
            "boosterPumpOperatingData"          : coreDataValue.value(forKey: "boosterPumpOperatingData")!,
            "boosterMaintainceOption"           : coreDataValue.value(forKey: "boosterMaintainceOption")!,
            "boosterMaintainceData"             : coreDataValue.value(forKey: "boosterMaintainceData")!,
            "boosterAdequateSizeOption"         : coreDataValue.value(forKey: "boosterAdequateSizeOption")!,
            "boosterAdequateSizeData"           : coreDataValue.value(forKey: "boosterAdequateSizeData")!,
            "boosterMountedOption"              : coreDataValue.value(forKey: "boosterMountedOption")!,
            "boosterMountedData"                : coreDataValue.value(forKey: "boosterMountedData")!,
            "boosterVisibleLeakOption"          : coreDataValue.value(forKey: "boosterVisibleLeakOption")!,
            "boosterVisibleLeakData"            : coreDataValue.value(forKey: "boosterVisibleLeakData")!,
            "boosterGasketsOption"              : coreDataValue.value(forKey: "boosterGasketsOption")!,
            "boosterGasketsData"                : coreDataValue.value(forKey: "boosterGasketsData")!,
            "boosterVisibleAdequateSizeOption"  : coreDataValue.value(forKey: "boosterVisibleAdequateSizeOption")!,
            "boosterVisibleAdequateSizeData"    : coreDataValue.value(forKey: "boosterVisibleAdequateSizeData")!,
            "boosterRunQuietlyOption"           : coreDataValue.value(forKey: "boosterRunQuietlyOption")!,
            "boosterRunQuietlyData"             : coreDataValue.value(forKey: "boosterRunQuietlyData")!,
            //TODO:-InspectOtherPump
            "otherPumpOption"           : coreDataValue.value(forKey: "otherPumpOption")!,
            "otherPumpData"             : coreDataValue.value(forKey: "otherPumpData")!,
            "blowersOption"             : coreDataValue.value(forKey: "blowersOption")!,
            "blowersData"               : coreDataValue.value(forKey: "blowersData")!,
            "otherPumpTypesData"        : coreDataValue.value(forKey: "otherPumpTypesData")!,
            "otherPumpOperatingOption"  : coreDataValue.value(forKey: "otherPumpOperatingOption")!,
            "otherPumpOperatingData"    : coreDataValue.value(forKey: "otherPumpOperatingData")!,
            "otherPumpMaintainceOption" : coreDataValue.value(forKey: "otherPumpMaintainceOption")!,
            "otherPumpMaintainceData"   : coreDataValue.value(forKey: "otherPumpMaintainceData")!,
            "otherPumpRightSizeOption"  : coreDataValue.value(forKey: "otherPumpRightSizeOption")!,
            "otherPumpRightSizeData"    : coreDataValue.value(forKey: "otherPumpRightSizeData")!,
            "otherPumpMountedOption"    : coreDataValue.value(forKey: "otherPumpMountedOption")!,
            "otherPumpMountedData"      : coreDataValue.value(forKey: "otherPumpMountedData")!,
            "otherPumpVisibleLeakOption": coreDataValue.value(forKey: "otherPumpVisibleLeakOption")!,
            "otherPumpVisibleLeakData"  : coreDataValue.value(forKey: "otherPumpVisibleLeakData")!,
            "otherPumpGasketsOption"    : coreDataValue.value(forKey: "otherPumpGasketsOption")!,
            "otherPumpGasketsData"      : coreDataValue.value(forKey: "otherPumpGasketsData")!,
            "otherPumpPlumbingOption"   : coreDataValue.value(forKey: "otherPumpPlumbingOption")!,
            "otherPumpPlumbingData"     : coreDataValue.value(forKey: "otherPumpPlumbingData")!,
            "otherPumpEquipmentOption"  : coreDataValue.value(forKey: "otherPumpEquipmentOption")!,
            "otherPumpEquipmentData"    : coreDataValue.value(forKey: "otherPumpEquipmentData")!,
            "blowerRepairOption"        : coreDataValue.value(forKey: "blowerRepairOption")!,
            "blowerRepairData"          : coreDataValue.value(forKey: "blowerRepairData")!,
            "blowerBondingOption"       : coreDataValue.value(forKey: "blowerBondingOption")!,
            "blowerBondingData"         : coreDataValue.value(forKey: "blowerBondingData")!,
            "blowerAdequateSizeOption"  : coreDataValue.value(forKey: "blowerAdequateSizeOption")!,
            "blowerAdequateSizeData"    : coreDataValue.value(forKey: "blowerAdequateSizeData")!,
            "blowerMountedOption"       : coreDataValue.value(forKey: "blowerMountedOption")!,
            "blowerMountedData"         : coreDataValue.value(forKey: "blowerMountedData")!,
            "blowerStrappedOption"      : coreDataValue.value(forKey: "blowerStrappedOption")!,
            "blowerStrappedData"        : coreDataValue.value(forKey: "blowerStrappedData")!,
            "blowerValveOption"         : coreDataValue.value(forKey: "blowerValveOption")!,
            "blowerValveData"           : coreDataValue.value(forKey: "blowerValveData")!,
            "blowerQuietOption"         : coreDataValue.value(forKey: "blowerQuietOption")!,
            "blowerQuietData"           : coreDataValue.value(forKey: "blowerQuietData")!,
            //TODO:-InspectValvesVC
            "valvesProperOption"    : coreDataValue.value(forKey: "valvesProperOption")!,
            "valvesProperData"      : coreDataValue.value(forKey: "valvesProperData")!,
            "valvesHandlesOption"   : coreDataValue.value(forKey: "valvesHandlesOption")!,
            "valvesHandlesData"     : coreDataValue.value(forKey: "valvesHandlesData")!,
            "valvesSpringsOption"   : coreDataValue.value(forKey: "valvesSpringsOption")!,
            "valvesSpringsData"     : coreDataValue.value(forKey: "valvesSpringsData")!,
            "valvesReplacedOption"  : coreDataValue.value(forKey: "valvesReplacedOption")!,
            "valvesReplacedData"    : coreDataValue.value(forKey: "valvesReplacedData")!,
            "valvesAppearOption"    : coreDataValue.value(forKey: "valvesAppearOption")!,
            "valvesAppearData"      : coreDataValue.value(forKey: "valvesAppearData")!,
            "valvesAutomatedOption" : coreDataValue.value(forKey: "valvesAutomatedOption")!,
            "valvesAutomatedData"   : coreDataValue.value(forKey: "valvesAutomatedData")!,
            "feedOption"            : coreDataValue.value(forKey: "feedOption")!,
            "feedData"              : coreDataValue.value(forKey: "feedData")!,
            "feedMountedOption"     : coreDataValue.value(forKey: "feedMountedOption")!,
            "feedMountedData"       : coreDataValue.value(forKey: "feedMountedData")!,
            "feedWorkingOption"     : coreDataValue.value(forKey: "feedWorkingOption")!,
            "feedWorkingData"       : coreDataValue.value(forKey: "feedWorkingData")!,
            "feedVisibleLeaksOption": coreDataValue.value(forKey: "feedVisibleLeaksOption")!,
            "feedVisibleLeaksData"  : coreDataValue.value(forKey: "feedVisibleLeaksData")!,
            //TODO:-InspectSaltSystemVC
            "saltSystemOption"              : coreDataValue.value(forKey: "saltSystemOption")!,
            "saltSystemData"                : coreDataValue.value(forKey: "saltSystemData")!,
            "purificationOption"            : coreDataValue.value(forKey: "purificationOption")!,
            "purificationData"              : coreDataValue.value(forKey: "purificationData")!,
            "selfCleaningOption"            : coreDataValue.value(forKey: "selfCleaningOption")!,
            "selfCleaningData"              : coreDataValue.value(forKey: "selfCleaningData")!,
            "saltSystemMaintainOption"      : coreDataValue.value(forKey: "saltSystemMaintainOption")!,
            "saltSystemMaintainData"        : coreDataValue.value(forKey: "saltSystemMaintainData")!,
            "saltSystemPowerBtnOption"      : coreDataValue.value(forKey: "saltSystemPowerBtnOption")!,
            "saltSystemPowerBtnData"        : coreDataValue.value(forKey: "saltSystemPowerBtnData")!,
            "saltSystemWorkingOption"       : coreDataValue.value(forKey: "saltSystemWorkingOption")!,
            "saltSystemWorkingData"         : coreDataValue.value(forKey: "saltSystemWorkingData")!,
            "saltSystemLeakOption"          : coreDataValue.value(forKey: "saltSystemLeakOption")!,
            "saltSystemLeakData"            : coreDataValue.value(forKey: "saltSystemLeakData")!,
            "saltSystemCalcificationOption" : coreDataValue.value(forKey: "saltSystemCalcificationOption")!,
            "saltSystemCalcificationData"   : coreDataValue.value(forKey: "saltSystemCalcificationData")!,
            "selfFloorHeadOption"           : coreDataValue.value(forKey: "selfFloorHeadOption")!,
            "selfFloorHeadData"             : coreDataValue.value(forKey: "selfFloorHeadData")!,
            "selfConditionOption"           : coreDataValue.value(forKey: "selfConditionOption")!,
            "selfConditionData"             : coreDataValue.value(forKey: "selfConditionData")!,
            "selfHeadSyncOption"            : coreDataValue.value(forKey: "selfHeadSyncOption")!,
            "selfHeadSyncData"              : coreDataValue.value(forKey: "selfHeadSyncData")!,
            "selfLatchingSafetyOption"      : coreDataValue.value(forKey: "selfLatchingSafetyOption")!,
            "selfLatchingSafetyData"        : coreDataValue.value(forKey: "selfLatchingSafetyData")!,
            "selfControllerLeakOption"      : coreDataValue.value(forKey: "selfControllerLeakOption")!,
            "selfControllerLeakData"        : coreDataValue.value(forKey: "selfControllerLeakData")!,
            //TODO:-InspectClockVC
            "timeMainOption"                : coreDataValue.value(forKey: "timeMainOption")!,
            "clockMountedOption"            : coreDataValue.value(forKey: "clockMountedOption")!,
            "clockMountedData"              : coreDataValue.value(forKey: "clockMountedData")!,
            "deviceRustyOption"             : coreDataValue.value(forKey: "deviceRustyOption")!,
            "deviceRustyData"               : coreDataValue.value(forKey: "deviceRustyData")!,
            "deviceRunProperlyOption"       : coreDataValue.value(forKey: "deviceRunProperlyOption")!,
            "deviceRunProperlyData"         : coreDataValue.value(forKey: "deviceRunProperlyData")!,
            "exposedWireOption"             : coreDataValue.value(forKey: "exposedWireOption")!,
            "exposedWireData"               : coreDataValue.value(forKey: "exposedWireData")!,
            "systemGroundedOption"          : coreDataValue.value(forKey: "systemGroundedOption")!,
            "systemGroundedData"            : coreDataValue.value(forKey: "systemGroundedData")!,
            "systemWeatherProofOption"      : coreDataValue.value(forKey: "systemWeatherProofOption")!,
            "systemWeatherProofData"        : coreDataValue.value(forKey: "systemWeatherProofData")!,
            "automatedDisplayOption"        : coreDataValue.value(forKey: "automatedDisplayOption")!,
            "automatedDisplayData"          : coreDataValue.value(forKey: "automatedDisplayData")!,
            "automatedRemotePanelOption"    : coreDataValue.value(forKey: "automatedRemotePanelOption")!,
            "automatedRemotePanelData"      : coreDataValue.value(forKey: "automatedRemotePanelData")!,
            "remotePanelWorkOption"         : coreDataValue.value(forKey: "remotePanelWorkOption")!,
            "remotePanelWorkData"           : coreDataValue.value(forKey: "remotePanelWorkData")!,
            "remoteControlOption"           : coreDataValue.value(forKey: "remoteControlOption")!,
            "remoteControlData"             : coreDataValue.value(forKey: "remoteControlData")!,
            "spaSideSwitchOption"           : coreDataValue.value(forKey: "spaSideSwitchOption")!,
            "spaSideSwitchData"             : coreDataValue.value(forKey: "spaSideSwitchData")!,
            "spaAirSwitchOption"            : coreDataValue.value(forKey: "spaAirSwitchOption")!,
            "spaAirSwitchData"              : coreDataValue.value(forKey: "spaAirSwitchData")!,
            "phoneBasedAppOption"           : coreDataValue.value(forKey: "phoneBasedAppOption")!,
            "phoneBasedAppData"             : coreDataValue.value(forKey: "phoneBasedAppData")!,
            "remotelyOperatedSystemOption"  : coreDataValue.value(forKey: "remotelyOperatedSystemOption")!,
            "remotelyOperatedSystemData"    : coreDataValue.value(forKey: "remotelyOperatedSystemData")!,
            "serviceModeOption"             : coreDataValue.value(forKey: "serviceModeOption")!,
            "serviceModeData"               : coreDataValue.value(forKey: "serviceModeData")!,
            "properlyLabelOption"           : coreDataValue.value(forKey: "properlyLabelOption")!,
            "properlyLabelData"             : coreDataValue.value(forKey: "properlyLabelData")!,
            "automatedValvesWorkingOption"  : coreDataValue.value(forKey: "automatedValvesWorkingOption")!,
            "automatedValvesWorkingData"    : coreDataValue.value(forKey: "automatedValvesWorkingData")!,
            "heatOption"                    : coreDataValue.value(forKey: "heatOption")!,
            "heatOrHeaterOption"            : coreDataValue.value(forKey: "heatOrHeaterOption")!,
            "heaterPurposeOption"           : coreDataValue.value(forKey: "heaterPurposeOption")!,
            "heaterPurposeData"             : coreDataValue.value(forKey: "heaterPurposeData")!,
            "heaterSizedOption"             : coreDataValue.value(forKey: "heaterSizedOption")!,
            "heaterSizedData"               : coreDataValue.value(forKey: "heaterSizedData")!,
            "heaterFireUpOption"            : coreDataValue.value(forKey: "heaterFireUpOption")!,
            "heaterFireUpData"              : coreDataValue.value(forKey: "heaterFireUpData")!,
            "errorCodeDisplayOption"        : coreDataValue.value(forKey: "errorCodeDisplayOption")!,
            "errorCodeDisplayData"          : coreDataValue.value(forKey: "errorCodeDisplayData")!,
            "gasShutoutValveOption"         : coreDataValue.value(forKey: "gasShutoutValveOption")!,
            "gasShutoutValveData"           : coreDataValue.value(forKey: "gasShutoutValveData")!,
            "heaterSafeDistanceOption"      : coreDataValue.value(forKey: "heaterSafeDistanceOption")!,
            "heaterSafeDistanceData"        : coreDataValue.value(forKey: "heaterSafeDistanceData")!,
            "heaterExhaustBlockOption"      : coreDataValue.value(forKey: "heaterExhaustBlockOption")!,
            "heaterExhaustBlockData"        : coreDataValue.value(forKey: "heaterExhaustBlockData")!,
            "internalDebrisFreeOption"      : coreDataValue.value(forKey: "internalDebrisFreeOption")!,
            "internalDebrisFreeData"        : coreDataValue.value(forKey: "internalDebrisFreeData")!,
            "heatExposedWireOption"         : coreDataValue.value(forKey: "heatExposedWireOption")!,
            "heatExposedWireData"           : coreDataValue.value(forKey: "heatExposedWireData")!,
            "terminalCleanOption"           : coreDataValue.value(forKey: "terminalCleanOption")!,
            "terminalCleanData"             : coreDataValue.value(forKey: "terminalCleanData")!,
            "burnerTrayCleanOption"         : coreDataValue.value(forKey: "burnerTrayCleanOption")!,
            "burnerTrayCleanData"           : coreDataValue.value(forKey: "burnerTrayCleanData")!,
            "heatPumpOperateOption"         : coreDataValue.value(forKey: "heatPumpOperateOption")!,
            "heatPumpOperateData"           : coreDataValue.value(forKey: "heatPumpOperateData")!,
            "heatPumpDisplayPanelOption"    : coreDataValue.value(forKey: "heatPumpDisplayPanelOption")!,
            "heatPumpDisplayPanelData"      : coreDataValue.value(forKey: "heatPumpDisplayPanelData")!,
            "heatPumpColdAirOption"         : coreDataValue.value(forKey: "heatPumpColdAirOption")!,
            "heatPumpColdAirData"           : coreDataValue.value(forKey: "heatPumpColdAirData")!,
            "heatPumpDrainFreeOption"       : coreDataValue.value(forKey: "heatPumpDrainFreeOption")!,
            "heatPumpDrainFreeData"         : coreDataValue.value(forKey: "heatPumpDrainFreeData")!,
            "heatPumpExposedWiringOption"   : coreDataValue.value(forKey: "heatPumpExposedWiringOption")!,
            "heatPumpExposedWiringData"     : coreDataValue.value(forKey: "heatPumpExposedWiringData")!,
            //TODO:-InspectLightVC
            "lightWorkingOption"            : coreDataValue.value(forKey: "lightWorkingOption")!,
           "lightWorkingData"              : coreDataValue.value(forKey: "lightWorkingData")!,
           "lowVoltageOption"              : coreDataValue.value(forKey: "lowVoltageOption")!,
           "lowVoltageData"                : coreDataValue.value(forKey: "lowVoltageData")!,
           "fiberOpticOption"              : coreDataValue.value(forKey: "fiberOpticOption")!,
           "fiberOpticData"                : coreDataValue.value(forKey: "fiberOpticData")!,
           "fiberWorkingOption"            : coreDataValue.value(forKey: "fiberWorkingOption")!,
           "fiberWorkingData"              : coreDataValue.value(forKey: "fiberWorkingData")!,
           "multiSynchOption"              : coreDataValue.value(forKey: "multiSynchOption")!,
           "multiSynchData"                : coreDataValue.value(forKey: "multiSynchData")!,
           "spaLightOption"                : coreDataValue.value(forKey: "spaLightOption")!,
           "spaLightData"                  : coreDataValue.value(forKey: "spaLightData")!,
           "basinLightOption"              : coreDataValue.value(forKey: "basinLightOption")!,
           "basinLightData"                : coreDataValue.value(forKey: "basinLightData")!,
           "freeWaterOption"               : coreDataValue.value(forKey: "freeWaterOption")!,
           "freeWaterData"                 : coreDataValue.value(forKey: "freeWaterData")!,
           "lightMountedOption"            : coreDataValue.value(forKey: "lightMountedOption")!,
           "lightMountedData"              : coreDataValue.value(forKey: "lightMountedData")!,
           "lightProperGFIOption"          : coreDataValue.value(forKey: "lightProperGFIOption")!,
           "lightProperGFIData"            : coreDataValue.value(forKey: "lightProperGFIData")!,
           "trippedOption"                 : coreDataValue.value(forKey: "trippedOption")!,
           "trippedData"                   : coreDataValue.value(forKey: "trippedData")!,
           "poolSafetyOption"              : coreDataValue.value(forKey: "poolSafetyOption")!,
           "poolSafetyData"                : coreDataValue.value(forKey: "poolSafetyData")!,
           "exposeWiringOption"            : coreDataValue.value(forKey: "exposeWiringOption")!,
           "exposeWiringData"              : coreDataValue.value(forKey: "exposeWiringData")!,
           "disconnectedAccessoriesOption" : coreDataValue.value(forKey: "disconnectedAccessoriesOption")!,
           "disconnectedAccessoriesData"   : coreDataValue.value(forKey: "disconnectedAccessoriesData")!,
           "equipmentBondOption"           : coreDataValue.value(forKey: "equipmentBondOption")!,
           "equipmentBondData"             : coreDataValue.value(forKey: "equipmentBondData")!,
           "electricalProperGFIOption"     : coreDataValue.value(forKey: "electricalProperGFIOption")!,
           "electricalProperGFIData"       : coreDataValue.value(forKey: "electricalProperGFIData")!,
           "electricalGFITrippedOption"    : coreDataValue.value(forKey: "electricalGFITrippedOption")!,
           "electricalGFITrippedData"      : coreDataValue.value(forKey: "electricalGFITrippedData")!,
           "wireHiringOption"              : coreDataValue.value(forKey: "wireHiringOption")!,
           "wireHiringData"                : coreDataValue.value(forKey: "wireHiringData")!,
           "boxMountedOption"              : coreDataValue.value(forKey: "boxMountedOption")!,
           "boxMountedData"                : coreDataValue.value(forKey: "boxMountedData")!,
            //TODO:-InspectFencingVC
            "fencePerimeterOption"  : coreDataValue.value(forKey: "fencePerimeterOption")!,
            "fencePerimeterData"    : coreDataValue.value(forKey: "fencePerimeterData")!,
            "fenceHeightOption"     : coreDataValue.value(forKey: "fenceHeightOption")!,
            "fenceHeightData"       : coreDataValue.value(forKey: "fenceHeightData")!,
            "fenceMinimalOption"    : coreDataValue.value(forKey: "fenceMinimalOption")!,
            "fenceMinimalData"      : coreDataValue.value(forKey: "fenceMinimalData")!,
            "fenceDefectsOption"    : coreDataValue.value(forKey: "fenceDefectsOption")!,
            "fenceDefectsData"      : coreDataValue.value(forKey: "fenceDefectsData")!,
            "fenceLatchingOption"   : coreDataValue.value(forKey: "fenceLatchingOption")!,
            "fenceLatchingData"     : coreDataValue.value(forKey: "fenceLatchingData")!,
            "fenceGatesOption"      : coreDataValue.value(forKey: "fenceGatesOption")!,
            "fenceGatesData"        : coreDataValue.value(forKey: "fenceGatesData")!,
            "fenceMountedOption"    : coreDataValue.value(forKey: "fenceMountedOption")!,
            "fenceMountedData"      : coreDataValue.value(forKey: "fenceMountedData")!,
            "fenceInstalledOption"  : coreDataValue.value(forKey: "fenceInstalledOption")!,
            "fenceInstalledData"    : coreDataValue.value(forKey: "fenceInstalledData")!,
            "fenceLockingOption"    : coreDataValue.value(forKey: "fenceLockingOption")!,
            "fenceLockingData"      : coreDataValue.value(forKey: "fenceLockingData")!,
            "fenceIsolateOption"    : coreDataValue.value(forKey: "fenceIsolateOption")!,
            "fenceIsolateData"      : coreDataValue.value(forKey: "fenceIsolateData")!,
            "coverMainOption"       : coreDataValue.value(forKey: "coverMainOption")!,
            "coverMainData"         : coreDataValue.value(forKey: "coverMainData")!,
            "coverMaterialOption"   : coreDataValue.value(forKey: "coverMaterialOption")!,
            "coverMaterialData"     : coreDataValue.value(forKey: "coverMaterialData")!,
            "coverMaintenanceOption": coreDataValue.value(forKey: "coverMaintenanceOption")!,
            "coverMaintenanceData"  : coreDataValue.value(forKey: "coverMaintenanceData")!,
            "coverBondedOption"     : coreDataValue.value(forKey: "coverBondedOption")!,
            "coverBondedData"       : coreDataValue.value(forKey: "coverBondedData")!,
            "coverLockoutOption"    : coreDataValue.value(forKey: "coverLockoutOption")!,
            "coverLockoutData"      : coreDataValue.value(forKey: "coverLockoutData")!,
            "coverRanOption"        : coreDataValue.value(forKey: "coverRanOption")!,
            "coverRanData"          : coreDataValue.value(forKey: "coverRanData")!,
            "coverReelOption"       : coreDataValue.value(forKey: "coverReelOption")!,
            "coverReelData"         : coreDataValue.value(forKey: "coverReelData")!,
            "coverManualOption"     : coreDataValue.value(forKey: "coverManualOption")!,
            "coverManualData"       : coreDataValue.value(forKey: "coverManualData")!,
            //TODO:-InspectVisualLeakVC
            "equipmentOption"           : coreDataValue.value(forKey: "visualEquipmentOption")!,
            "equipmentData"             : coreDataValue.value(forKey: "visualEquipmentData")!,
            "backwashOption"            : coreDataValue.value(forKey: "visualBackwashOption")!,
            "arroundWaterFeatureOption" : coreDataValue.value(forKey: "visualArroundWaterFeatureOption")!,
            "solarOption"               : coreDataValue.value(forKey: "visualSolarOption")!,
            "basinOption"               : coreDataValue.value(forKey: "visualBasinOption")!,
            "slotDrainOption"           : coreDataValue.value(forKey: "visualSlotDrainOption")!,
            "vinylOption"               : coreDataValue.value(forKey: "visualVinylOption")!,
            "noticeableOption"          : coreDataValue.value(forKey: "visualNoticeableOption")!,
            "structuralCracksOption"    : coreDataValue.value(forKey: "visualStructuralCracksOption")!,
            "structuralCracksData"      : coreDataValue.value(forKey: "visualStructuralCracksData")!,
            "bondBeamOption"            : coreDataValue.value(forKey: "visualBondBeamOption")!,
            "bondBeamData"              : coreDataValue.value(forKey: "visualBondBeamData")!,
            "surgeTankOption"           : coreDataValue.value(forKey: "visualSurgeTankOption")!,
            "surgeTankData"             : coreDataValue.value(forKey: "visualSurgeTankData")!,
            "scumGuttersOption"         : coreDataValue.value(forKey: "visualScumGuttersOption")!,
            "scumGuttersData"           : coreDataValue.value(forKey: "visualScumGuttersData")!,
            "returnsData"               : coreDataValue.value(forKey: "visualReturnsData")!,
            "skimmersData"              : coreDataValue.value(forKey: "visualSkimmersData")!,
            "skimmerSeamData"           : coreDataValue.value(forKey: "visualSkimmerSeamData")!,
            "mainDrainData"             : coreDataValue.value(forKey: "visualMainDrainData")!,
            "nichesData"                : coreDataValue.value(forKey: "visualNichesData")!,
            "sideSuctionData"           : coreDataValue.value(forKey: "visualSideSuctionData")!,
            "cleanerLinesData"          : coreDataValue.value(forKey: "visualCleanerLinesData")!,
            "skimmerPortsData"          : coreDataValue.value(forKey: "visualSkimmerPortsData")!,
            "equalizerData"             : coreDataValue.value(forKey: "visualEqualizerData")!,
            "structuralCracksValueData" : coreDataValue.value(forKey: "visualStructuralCracksValueData")!,
            "explainData"               : coreDataValue.value(forKey: "visualExplainData")!,
            "spaJetsData"               : coreDataValue.value(forKey: "visualSpaJetsData")!,
            "spaFillData"               : coreDataValue.value(forKey: "visualSpaFillData")!,
            "suctionData"               : coreDataValue.value(forKey: "visualSuctionData")!,
            "surgeTankValueData"        : coreDataValue.value(forKey: "visualSurgeTankValueData")!,
            "scumGuttersValueData"      : coreDataValue.value(forKey: "visualScumGuttersValueData")!,
            "autoFillData"              : coreDataValue.value(forKey: "visualAutoFillData")!,
            "arroundFittingsData"       : coreDataValue.value(forKey: "visualArroundFittingsData")!,
            "notedCracksData"           : coreDataValue.value(forKey: "visualNotedCracksData")!,
            "otherData"                 : coreDataValue.value(forKey: "visualOtherData")!,
            //TODO:-InspectPlumbingStatisticVC
            "suction"           : coreDataValue.value(forKey: "suction")!,
            "cleanerLines"      : coreDataValue.value(forKey: "cleanerLines")!,
            "skimmerSuction"    : coreDataValue.value(forKey: "skimmerSuction")!,
            "spaJets"           : coreDataValue.value(forKey: "spaJets")!,
            "spaFill"           : coreDataValue.value(forKey: "spaFill")!,
            "autofillEQ"        : coreDataValue.value(forKey: "autofillEQ")!,
            "isVinylLinearLeak" : coreDataValue.value(forKey: "isVinylLinearLeak")!,
            "isLeaking"         : coreDataValue.value(forKey: "isLeaking")!,
            //TODO:-InspectPlumbingStatistic2VC
            "suctionAir"            : coreDataValue.value(forKey: "suctionAir")!,
            "suctionLineAirOption"  : coreDataValue.value(forKey: "suctionLineAirOption")!,
            "surgeTank"             : coreDataValue.value(forKey: "surgeTank")!,
            "markLocationDescribe"  : coreDataValue.value(forKey: "markLocationDescribe")!,
            "leaksNoted"            : coreDataValue.value(forKey: "leaksNoted")!,
            "summaryNote"           : coreDataValue.value(forKey: "summaryNote")!,
            "isLocationMarked"      : coreDataValue.value(forKey: "isLocationMarked")!,
            "isEstimateToFollow"    : coreDataValue.value(forKey: "isEstimateToFollow")!,
            //TODO:-InspectCompleteSummaryVC
            "summaryData"    : coreDataValue.value(forKey: "summaryData")!
        ]
        
          print(inspectDetails)
        Alamofire.upload(multipartFormData: { multipartFormData in
            //TODO:-InspectionVC
            //for waterFeatuesImg
            if self.coreDataValue.value(forKey: "waterFeatuesImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterFeatuesImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterFeatues_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for waterConditionImg
            if self.coreDataValue.value(forKey: "waterConditionImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterConditionImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterCondition_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for waterLevelHeightImg
            if self.coreDataValue.value(forKey: "waterLevelHeightImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterLevelHeightImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterLevelHeight_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for drainVisibleImg
            if self.coreDataValue.value(forKey: "drainVisibleImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "drainVisibleImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "drainVisible_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for lowerPoolImg
            if self.coreDataValue.value(forKey: "lowerPoolImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "lowerPoolImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "lowerPool_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for floodRiskImg
            if self.coreDataValue.value(forKey: "floodRiskImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "floodRiskImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "floodRisk_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for poolSpaImg
            if self.coreDataValue.value(forKey: "poolSpaImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "poolSpaImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "poolSpa_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for poolLevelImg
            if self.coreDataValue.value(forKey: "poolLevelImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "poolLevelImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "poolLevel_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spaLevelImg
            if self.coreDataValue.value(forKey: "spaLevelImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spaLevelImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaLevel_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spaConstructImg
            if self.coreDataValue.value(forKey: "spaConstructImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spaConstructImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaConstruct_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spaMaterialImg
            if self.coreDataValue.value(forKey: "spaMaterialImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spaMaterialImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaMaterial_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spaTouchImg
            if self.coreDataValue.value(forKey: "spaTouchImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spaTouchImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaTouch_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for surfaceImg
            if self.coreDataValue.value(forKey: "surfaceImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "surfaceImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "surface_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for structImg
            if self.coreDataValue.value(forKey: "structImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "structImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "struct_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //TODO:-InspectFittingsVC
            //for physicalImg
            if self.coreDataValue.value(forKey: "physicalImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "physicalImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "physical_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for properFlowImg
            if self.coreDataValue.value(forKey: "properFlowImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "properFlowImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "properFlow_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for positionImg
            if self.coreDataValue.value(forKey: "positionImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "positionImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "position_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for beamTileImg
            if self.coreDataValue.value(forKey: "beamTileImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "beamTileImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "beamTile_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for crackBeamImg
            if self.coreDataValue.value(forKey: "crackBeamImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "crackBeamImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "crackBeam_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for crackTileImg
            if self.coreDataValue.value(forKey: "crackTileImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "crackTileImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "crackTile_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for tileLevelImg
            if self.coreDataValue.value(forKey: "tileLevelImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "tileLevelImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "tileLevel_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for copingTypeImg
            if self.coreDataValue.value(forKey: "copingTypeImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "copingTypeImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "copingType_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for copingLevelImg
            if self.coreDataValue.value(forKey: "copingLevelImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "copingLevelImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "copingLevel_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            
            //TODO:-InspectDeckVC
            //for deckCondiMainImg
            if self.coreDataValue.value(forKey: "deckCondiMainImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deckCondiMainImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deckCondiMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for deckMaterialImg
            if self.coreDataValue.value(forKey: "deckMaterialImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deckMaterialImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deckMaterial_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for deckControlImg
            if self.coreDataValue.value(forKey: "deckControlImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deckControlImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deckControl_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for deckSealImg
            if self.coreDataValue.value(forKey: "deckSealImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deckSealImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deckSeal_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for deckLiftImg
            if self.coreDataValue.value(forKey: "deckLiftImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deckLiftImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deckLift_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for deckHazardsImg
            if self.coreDataValue.value(forKey: "deckHazardsImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deckHazardsImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deckHazards_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for deckLevelImg
            if self.coreDataValue.value(forKey: "deckLevelImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deckLevelImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deckLevel_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for deckSlopeImg
            if self.coreDataValue.value(forKey: "deckSlopeImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deckSlopeImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deckSlope_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for deckDrainageImg
            if self.coreDataValue.value(forKey: "deckDrainageImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deckDrainageImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deckDrainage_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for deckHandrailsImg
            if self.coreDataValue.value(forKey: "deckHandrailsImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deckHandrailsImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deckHandrails_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for deckDeepDropImg
            if self.coreDataValue.value(forKey: "deckDeepDropImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deckDeepDropImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deckDeepDrop_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            
            //TODO:-InspectHandrailsVC
            //for handrailsImg
            if self.coreDataValue.value(forKey: "handrailsImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "handrailsImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "handrails_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for entranceImg
            if self.coreDataValue.value(forKey: "entranceImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "entranceImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "entrance_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for deepEndImg
            if self.coreDataValue.value(forKey: "deepEndImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deepEndImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deepEnd_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for grabRailsImg
            if self.coreDataValue.value(forKey: "grabRailsImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "grabRailsImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "grabRails_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for raisedWallImg
            if self.coreDataValue.value(forKey: "raisedWallImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "raisedWallImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "raisedWall_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for subRaisedWallImg
            if self.coreDataValue.value(forKey: "subRaisedWallImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "subRaisedWallImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "subRaisedWall_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for grabEdgeImg
            if self.coreDataValue.value(forKey: "grabEdgeImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "grabEdgeImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "grabEdge_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //TODO:-InspectEdgeVC
            //for negativeImg
            if self.coreDataValue.value(forKey: "negativeImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "negativeImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "negative_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for basinImg
            if self.coreDataValue.value(forKey: "basinImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "basinImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "basin_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for drainImg
            if self.coreDataValue.value(forKey: "drainImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "drainImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "drain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for tankImg
            if self.coreDataValue.value(forKey: "tankImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "tankImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "tank_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for edge0Img
            if self.coreDataValue.value(forKey: "edge0Img") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "edge0Img") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "edgeProper_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for edge1Img
            if self.coreDataValue.value(forKey: "edge1Img") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "edge1Img") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "edgedrivingHazard_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for basin0Img
            if self.coreDataValue.value(forKey: "basin0Img") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "basin0Img") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "basinAdequateSize_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for basin1Img
            if self.coreDataValue.value(forKey: "basin1Img") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "basin1Img") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "basinAutofill_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for basin2Img
            if self.coreDataValue.value(forKey: "basin2Img") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "basin2Img") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "basinWorkProperly_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for basin3Img
            if self.coreDataValue.value(forKey: "basin3Img") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "basin3Img") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "basinProperOverflow_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for basin4Img
            if self.coreDataValue.value(forKey: "basin4Img") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "basin4Img") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "basinFlood_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for basin5Img
            if self.coreDataValue.value(forKey: "basin5Img") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "basin5Img") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "basinCrackFree_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for drain0Img
            if self.coreDataValue.value(forKey: "drain0Img") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "drain0Img") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "drain0_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for tank0Img
            if self.coreDataValue.value(forKey: "tank0Img") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "tank0Img") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "tank0_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //TODO:-InspectWaterFeatureVC
            //for mainWaterFeatureImage
            if self.coreDataValue.value(forKey: "mainWaterFeatureImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "mainWaterFeatureImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "mainWaterFeature_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for waterFeaturePresentImage
            if self.coreDataValue.value(forKey: "waterFeaturePresentImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterFeaturePresentImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterFeaturePresent_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for mainDivingImage
            if self.coreDataValue.value(forKey: "mainDivingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "mainDivingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "mainDivingWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for divingPresentImage
            if self.coreDataValue.value(forKey: "divingPresentImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "divingPresentImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "divingPresentWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for slidesPresentImage
            if self.coreDataValue.value(forKey: "slidesPresentImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "slidesPresentImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "slidesPresentWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for mainDrainImage
            if self.coreDataValue.value(forKey: "mainDrainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "mainDrainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "mainDrainWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for poolImage
            if self.coreDataValue.value(forKey: "poolImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "poolImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "poolWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spaImage
            if self.coreDataValue.value(forKey: "spaImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spaImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for basinImage
            if self.coreDataValue.value(forKey: "basinImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "basinImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "basinWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for featureImage
            if self.coreDataValue.value(forKey: "featureImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "featureImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "featureWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for drainWaterImage
            if self.coreDataValue.value(forKey: "drainWaterImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "drainWaterImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "drainWaterWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for splitDrainImage
            if self.coreDataValue.value(forKey: "splitDrainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "splitDrainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "splitDrainWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for coverVGBImage
            if self.coreDataValue.value(forKey: "coverVGBImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "coverVGBImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "coverVGBWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for coverMountedImage
            if self.coreDataValue.value(forKey: "coverMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "coverMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "coverMountedWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for subWaterOperateImage
            if self.coreDataValue.value(forKey: "subWaterOperateImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "subWaterOperateImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "subWaterOperateWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for subWaterHazardImage
            if self.coreDataValue.value(forKey: "subWaterHazardImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "subWaterHazardImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "subWaterHazardWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for subWaterSwimmerImage
            if self.coreDataValue.value(forKey: "subWaterSwimmerImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "subWaterSwimmerImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "subWaterSwimmerWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for subWaterBasinCrackImage
            if self.coreDataValue.value(forKey: "subWaterBasinCrackImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "subWaterBasinCrackImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "subWaterBasinCrackWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //TODO:-InspectSideSuctionVC
            //for mainSuctionImage
            if self.coreDataValue.value(forKey: "subWaterBasinCrackImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "subWaterBasinCrackImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "subWaterBasinCrackWF_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for mainSkimmerImage
            //for suctionInchesImage
            if self.coreDataValue.value(forKey: "suctionInchesImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "suctionInchesImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "suctionInches_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for suctionVGBComplaintImage
            if self.coreDataValue.value(forKey: "suctionVGBComplaintImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "suctionVGBComplaintImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "suctionVGBComplaint_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for suctionMountedImage
            if self.coreDataValue.value(forKey: "suctionMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "suctionMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "suctionMounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerOperateImage
            if self.coreDataValue.value(forKey: "skimmerOperateImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerOperateImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerOperate_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerRepairImage
            if self.coreDataValue.value(forKey: "skimmerRepairImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerRepairImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerRepair_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerProperHtImage
            if self.coreDataValue.value(forKey: "skimmerProperHtImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerProperHtImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerProperHt_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerWeirDoorImage
            if self.coreDataValue.value(forKey: "skimmerWeirDoorImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerWeirDoorImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerWeirDoor_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerDoorWorkImage
            if self.coreDataValue.value(forKey: "skimmerDoorWorkImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerDoorWorkImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerDoorWork_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerBasementImage
            if self.coreDataValue.value(forKey: "skimmerBasementImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerBasementImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerBasement_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerConditionImage
            if self.coreDataValue.value(forKey: "skimmerConditionImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerConditionImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerCondition_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerDiverImage
            if self.coreDataValue.value(forKey: "skimmerDiverImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerDiverImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerDiver_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerSeamImage
            if self.coreDataValue.value(forKey: "skimmerSeamImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerSeamImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerSeam_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerCrackImage
            if self.coreDataValue.value(forKey: "skimmerCrackImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerCrackImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerCrack_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerSuctionWorkImage
            if self.coreDataValue.value(forKey: "skimmerSuctionWorkImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerSuctionWorkImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerSuctionWork_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerEqualizerImage
            if self.coreDataValue.value(forKey: "skimmerEqualizerImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerEqualizerImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerEqualizer_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerEqualizerVGBImage
            if self.coreDataValue.value(forKey: "skimmerEqualizerVGBImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerEqualizerVGBImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerEqualizerVGB_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for skimmerMainDrainImage
            if self.coreDataValue.value(forKey: "skimmerMainDrainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerMainDrainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerMainDrain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //TODO:-InspectAutofillVC
            //for mainAutofillImg
            if self.coreDataValue.value(forKey: "mainAutofillImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "mainAutofillImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "mainAutofill_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for mainOverFlowImg
            if self.coreDataValue.value(forKey: "mainOverFlowImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "mainOverFlowImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "mainOverFlow_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for overFlowImg
            if self.coreDataValue.value(forKey: "skimmerMainDrainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "skimmerMainDrainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "skimmerMainDrain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for autofillImage1
            if self.coreDataValue.value(forKey: "autofillImage1") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "autofillImage1") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "autofillWaterLine_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for autofillImage2
            if self.coreDataValue.value(forKey: "autofillImage2") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "autofillImage2") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "autofillLeakFree_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for autofillImage3
            if self.coreDataValue.value(forKey: "autofillImage3") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "autofillImage3") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "autofillShutOff_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for autofillImage4
            if self.coreDataValue.value(forKey: "autofillImage4") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "autofillImage4") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "autofillBackFlow_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for autofillImage5
            if self.coreDataValue.value(forKey: "autofillImage5") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "autofillImage5") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "autofillMaintain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for autofillImage6
            if self.coreDataValue.value(forKey: "autofillImage6") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "autofillImage6") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "autofillBackfill_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for autofillImage7
            if self.coreDataValue.value(forKey: "autofillImage7") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "autofillImage7") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "autofillMounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for autofillImage8
            if self.coreDataValue.value(forKey: "autofillImage8") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "autofillImage8") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "autofillAdjust_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for overFlowImage0
            if self.coreDataValue.value(forKey: "overFlowImage0") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "overFlowImage0") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "overFlowProperly_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for overFlowImage1
            if self.coreDataValue.value(forKey: "overFlowImage1") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "overFlowImage1") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "overFlowHeight_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            
            //TODO:-InspectPortableSpaVC
            //for portableSpaImage
            if self.coreDataValue.value(forKey: "portableSpaImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "portableSpaImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "portableSpa_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for mainSpaImage
            if self.coreDataValue.value(forKey: "mainSpaImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "mainSpaImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "mainSpa_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for equipmentImage
            if self.coreDataValue.value(forKey: "equipmentImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "equipmentImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "equipment_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for equipRoomImage
            if self.coreDataValue.value(forKey: "equipRoomImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "equipRoomImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "equipRoom_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for equipClearImage
            if self.coreDataValue.value(forKey: "equipClearImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "equipClearImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "equipClear_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for equipElementImage
            if self.coreDataValue.value(forKey: "equipElementImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "equipElementImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "equipElement_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for equipUVImage
            if self.coreDataValue.value(forKey: "equipUVImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "equipUVImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "equipUV_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spa0Image
            if self.coreDataValue.value(forKey: "spa0Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spa0Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaEquipment_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spa1Image
            if self.coreDataValue.value(forKey: "spa1Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spa1Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaHeight_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spa2Image
            if self.coreDataValue.value(forKey: "spa2Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spa2Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaVGB_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spa3Image
            if self.coreDataValue.value(forKey: "spa3Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spa3Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaCondition_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spa4Image
            if self.coreDataValue.value(forKey: "spa4Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spa4Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaConstruct_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spa5Image
            if self.coreDataValue.value(forKey: "spa5Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spa5Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaRough_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spa6Image
            if self.coreDataValue.value(forKey: "spa6Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spa6Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaSurface_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spa7Image
            if self.coreDataValue.value(forKey: "spa7Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spa7Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaBonded_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spa8Image
            if self.coreDataValue.value(forKey: "spa8Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spa8Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaCovered_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spa9Image
            if self.coreDataValue.value(forKey: "spa9Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spa9Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaChildProo_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //TODO:-InspectSolarVC
            //for solarImg
            if self.coreDataValue.value(forKey: "solarImg") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "solarImg") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "solar_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for solarMainImage
            if self.coreDataValue.value(forKey: "solarMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "solarMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "solarMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for solar0Image
            if self.coreDataValue.value(forKey: "solar0Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "solar0Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "solar0_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for solar1Image
            if self.coreDataValue.value(forKey: "solar1Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "solar1Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "solar1_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for solar2Image
            if self.coreDataValue.value(forKey: "solar2Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "solar2Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "solar2_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for solar3Image
            if self.coreDataValue.value(forKey: "solar3Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "solar3Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "solar3_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for solar4Image
            if self.coreDataValue.value(forKey: "solar4Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "solar4Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "solar4_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filtMainImage
            if self.coreDataValue.value(forKey: "filtMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filtMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filtMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filtImage
            if self.coreDataValue.value(forKey: "filtImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filtImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filt_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filt1Image
            if self.coreDataValue.value(forKey: "filt1Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filt1Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filt1_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filt2Image
            if self.coreDataValue.value(forKey: "filt2Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filt2Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filt2_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filt3Image
            if self.coreDataValue.value(forKey: "filt3Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filt3Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filt3_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filt4Image
            if self.coreDataValue.value(forKey: "filt4Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filt4Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filt4_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filt5Image
            if self.coreDataValue.value(forKey: "filt5Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filt5Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filt5_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filt6Image
            if self.coreDataValue.value(forKey: "filt6Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filt6Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filt6_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filt7Image
            if self.coreDataValue.value(forKey: "filt7Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filt7Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filt7_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filt8Image
            if self.coreDataValue.value(forKey: "filt8Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filt8Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filt8_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filt9Image
            if self.coreDataValue.value(forKey: "filt9Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filt9Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filt9_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filt10Image
            if self.coreDataValue.value(forKey: "filt10Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filt10Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filt10_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filt11Image
            if self.coreDataValue.value(forKey: "filt11Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filt11Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filt11_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for filt12Image
            if self.coreDataValue.value(forKey: "filt12Image") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "filt12Image") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "filt12_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //TODO:-InspectPoolPumpVC
            //for pumpMainImage
            if self.coreDataValue.value(forKey: "pumpMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "pumpMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "pumpMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for pumpFiltrationImage
            if self.coreDataValue.value(forKey: "pumpFiltrationImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "pumpFiltrationImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "pumpFiltration_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for pumpMaintainanceImage
            if self.coreDataValue.value(forKey: "pumpMaintainanceImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "pumpMaintainanceImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "pumpMaintainance_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for pumpAdequateImage
            if self.coreDataValue.value(forKey: "pumpAdequateImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "pumpAdequateImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "pumpAdequate_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for pumpMountedImage
            if self.coreDataValue.value(forKey: "pumpMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "pumpMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "pumpMounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for pumpLeakImage
            if self.coreDataValue.value(forKey: "pumpLeakImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "pumpLeakImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "pumpLeak_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for pumpGasketsImage
            if self.coreDataValue.value(forKey: "pumpGasketsImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "pumpGasketsImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "pumpGaskets_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for pumpSizeImage
            if self.coreDataValue.value(forKey: "pumpSizeImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "pumpSizeImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "pumpSize_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for pumpEquipmentImage
            if self.coreDataValue.value(forKey: "pumpEquipmentImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "pumpEquipmentImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "pumpEquipment_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spaJetsMainImage
            if self.coreDataValue.value(forKey: "spaJetsMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spaJetsMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaJetsMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spaJetsImage
            if self.coreDataValue.value(forKey: "spaJetsImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spaJetsImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaJets_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for pumpOperatingImage
            if self.coreDataValue.value(forKey: "pumpOperatingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "pumpOperatingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "pumpOperating_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for maintaianceAccessImage
            if self.coreDataValue.value(forKey: "maintaianceAccessImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "maintaianceAccessImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "maintaianceAccess_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for adequateSizeImage
            if self.coreDataValue.value(forKey: "adequateSizeImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "adequateSizeImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "adequateSize_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for mountedImage
            if self.coreDataValue.value(forKey: "mountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "mountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "mounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for visibleLeakImage
            if self.coreDataValue.value(forKey: "visibleLeakImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visibleLeakImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visibleLeak_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for gasketsImage
            if self.coreDataValue.value(forKey: "gasketsImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "gasketsImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "gaskets_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for visibleAdequateSizeImage
            if self.coreDataValue.value(forKey: "visibleAdequateSizeImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visibleAdequateSizeImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visibleAdequateSize_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for runQuietlyImage
            if self.coreDataValue.value(forKey: "runQuietlyImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "runQuietlyImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "runQuietly_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //TODO:-InspectSwimJetSystemVC
            //for swimJetsMainImage
            if self.coreDataValue.value(forKey: "swimJetsMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "swimJetsMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "swimJetsMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for swimJetsImage
            if self.coreDataValue.value(forKey: "swimJetsImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "swimJetsImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "swimJets_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for waterFeatureMainImage
            if self.coreDataValue.value(forKey: "waterFeatureMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterFeatureMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterFeatureMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for waterFeatureImage
            if self.coreDataValue.value(forKey: "waterFeatureImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterFeatureImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterFeature_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for swimPumpOperatingImage
            if self.coreDataValue.value(forKey: "swimPumpOperatingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "swimPumpOperatingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "swimPumpOperating_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for swimMaintainceImage
            if self.coreDataValue.value(forKey: "swimMaintainceImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "swimMaintainceImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "swimMaintaince_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for swimAdequateSizeImage
            if self.coreDataValue.value(forKey: "swimAdequateSizeImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "swimAdequateSizeImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "swimAdequateSize_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for swimMountedImage
            if self.coreDataValue.value(forKey: "swimMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "swimMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "swimMounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for swimVisibleLeakImage
            if self.coreDataValue.value(forKey: "swimVisibleLeakImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "swimVisibleLeakImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "swimVisibleLeak_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for swimGasketsImage
            if self.coreDataValue.value(forKey: "swimGasketsImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "swimGasketsImage") as! Data) as? NSArray {

                //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "swimGaskets_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for swimVisibleAdequateImage
            if self.coreDataValue.value(forKey: "swimVisibleAdequateImage") == nil {
                print("no image")
            } else {
//                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "swimVisibleAdequateImage") as! Data) as? NSArray {
                 if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "blowerRepairImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "swimVisibleAdequate_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for swimRunQuietlyImage
            if self.coreDataValue.value(forKey: "swimRunQuietlyImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "swimRunQuietlyImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "swimRunQuietly_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for waterOperatingImage
            if self.coreDataValue.value(forKey: "waterOperatingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterOperatingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterOperating_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for waterMaintainceImage
            if self.coreDataValue.value(forKey: "waterMaintainceImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterMaintainceImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterMaintaince_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for waterAdequateSizeImage
            if self.coreDataValue.value(forKey: "waterAdequateSizeImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterAdequateSizeImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterAdequateSize_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for waterMountedImage
            if self.coreDataValue.value(forKey: "waterMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterMounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for waterVisibleLeakImage
            if self.coreDataValue.value(forKey: "waterVisibleLeakImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterVisibleLeakImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterVisibleLeak_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for waterGasketsImage
            if self.coreDataValue.value(forKey: "waterGasketsImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterGasketsImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterGaskets_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for waterVisibleAdequateImage
            if self.coreDataValue.value(forKey: "waterVisibleAdequateImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterVisibleAdequateImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterVisibleAdequate_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for waterRunQuietlyImage
            if self.coreDataValue.value(forKey: "waterRunQuietlyImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "waterRunQuietlyImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "waterRunQuietly_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //TODO:-InspectSelfCleaningVC
            //for selfCleanMainImage
            if self.coreDataValue.value(forKey: "selfCleanMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfCleanMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfCleanMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfCleanImage
            if self.coreDataValue.value(forKey: "selfCleanImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfCleanImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfClean_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for boosterPumpMainImage
            if self.coreDataValue.value(forKey: "boosterPumpMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "boosterPumpMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "boosterPumpMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for boosterPumpImage
            if self.coreDataValue.value(forKey: "boosterPumpImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "boosterPumpImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "boosterPump_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfCleanOperatingImage
            if self.coreDataValue.value(forKey: "selfCleanOperatingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfCleanOperatingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfCleanOperating_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfCleanMaintainceImage
            if self.coreDataValue.value(forKey: "selfCleanMaintainceImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfCleanMaintainceImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfCleanMaintaince_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfCleanAdequateSizeImage
            if self.coreDataValue.value(forKey: "selfCleanAdequateSizeImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfCleanAdequateSizeImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfCleanAdequateSize_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfCleanMountedImage
            if self.coreDataValue.value(forKey: "selfCleanMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfCleanMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfCleanMounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfCleanVisibleLeakImage
            if self.coreDataValue.value(forKey: "selfCleanVisibleLeakImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfCleanVisibleLeakImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfCleanVisibleLeak_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfCleanGasketsImage
            if self.coreDataValue.value(forKey: "selfCleanGasketsImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfCleanGasketsImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfCleanGaskets_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfCleanVisibleAdequateImage
            if self.coreDataValue.value(forKey: "selfCleanVisibleAdequateImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfCleanVisibleAdequateImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfCleanVisibleAdequate_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfCleanRunQuietlyImage
            if self.coreDataValue.value(forKey: "selfCleanRunQuietlyImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfCleanRunQuietlyImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfCleanRunQuietly_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for boosterPumpOperatingImage
            if self.coreDataValue.value(forKey: "boosterPumpOperatingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "boosterPumpOperatingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "boosterPumpOperating_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for boosterMaintainceImage
            if self.coreDataValue.value(forKey: "boosterMaintainceImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "boosterMaintainceImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "boosterMaintaince_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for boosterAdequateSizeImage
            if self.coreDataValue.value(forKey: "boosterAdequateSizeImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "boosterAdequateSizeImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "boosterAdequateSize_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for boosterMountedImage
            if self.coreDataValue.value(forKey: "boosterMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "boosterMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "boosterMounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for boosterVisibleLeakImage
            if self.coreDataValue.value(forKey: "boosterVisibleLeakImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "boosterVisibleLeakImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "boosterVisibleLeak_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for boosterGasketsImage
            if self.coreDataValue.value(forKey: "boosterGasketsImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "boosterGasketsImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "boosterGaskets_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for boosterVisibleAdequateSizeImage
            if self.coreDataValue.value(forKey: "boosterVisibleAdequateSizeImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "boosterVisibleAdequateSizeImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "boosterVisibleAdequateSize_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for boosterRunQuietlyImage
            if self.coreDataValue.value(forKey: "boosterRunQuietlyImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "boosterRunQuietlyImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "boosterRunQuietly_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            
            //TODO:-InspectOtherPumpVC
            //for otherPumpMainImage
            if self.coreDataValue.value(forKey: "otherPumpMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "otherPumpMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "otherPumpMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for otherPumpImage
            if self.coreDataValue.value(forKey: "otherPumpImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "otherPumpImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "otherPump_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for blowersMainImage
            if self.coreDataValue.value(forKey: "blowersMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "blowersMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "blowersMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for blowersImage
            if self.coreDataValue.value(forKey: "blowersImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "blowersImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "blowers_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for otherPumpMaintainceImage
            if self.coreDataValue.value(forKey: "otherPumpMaintainceImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "otherPumpMaintainceImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "otherPumpMaintaince_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for otherPumpRightSizeImage
            if self.coreDataValue.value(forKey: "otherPumpRightSizeImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "otherPumpRightSizeImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "otherPumpRightSize_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for otherPumpMountedImage
            if self.coreDataValue.value(forKey: "otherPumpMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "otherPumpMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "otherPumpMounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for otherPumpVisibleLeakImage
            if self.coreDataValue.value(forKey: "otherPumpVisibleLeakImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "otherPumpVisibleLeakImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "otherPumpVisibleLeak_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for otherPumpGasketsImage
            if self.coreDataValue.value(forKey: "otherPumpGasketsImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "otherPumpGasketsImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "otherPumpGaskets_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for otherPumpPlumbingImage
            if self.coreDataValue.value(forKey: "otherPumpPlumbingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "otherPumpPlumbingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "otherPumpPlumbing_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for otherPumpEquipmentImage
            if self.coreDataValue.value(forKey: "otherPumpEquipmentImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "otherPumpEquipmentImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "otherPumpEquipment_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for blowerRepairImage
            if self.coreDataValue.value(forKey: "blowerRepairImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "blowerRepairImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "blowerRepair_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for blowerBondingImage
            if self.coreDataValue.value(forKey: "blowerBondingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "blowerBondingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "blowerBonding_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for blowerAdequateSizeImage
            if self.coreDataValue.value(forKey: "blowerAdequateSizeImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "blowerAdequateSizeImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "blowerAdequateSize_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for blowerMountedImage
            if self.coreDataValue.value(forKey: "blowerMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "blowerMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "blowerMounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for blowerStrappedImage
            if self.coreDataValue.value(forKey: "blowerStrappedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "blowerStrappedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "blowerStrapped_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for blowerValveImage
            if self.coreDataValue.value(forKey: "blowerValveImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "blowerValveImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "blowerValve_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for blowerQuietImage
            if self.coreDataValue.value(forKey: "blowerQuietImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "blowerQuietImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "blowerQuiet_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            
            //TODO:-InspectValvesVC
            //for valvesMainImage
            if self.coreDataValue.value(forKey: "valvesMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "valvesMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "valvesMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for valvesProperImage
            if self.coreDataValue.value(forKey: "valvesProperImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "valvesProperImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "valvesProper_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for valvesHandlesImage
            if self.coreDataValue.value(forKey: "valvesHandlesImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "valvesHandlesImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "valvesHandles_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for valvesSpringsImage
            if self.coreDataValue.value(forKey: "valvesSpringsImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "valvesSpringsImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "valvesSprings_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for valvesReplacedImage
            if self.coreDataValue.value(forKey: "valvesReplacedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "valvesReplacedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "valvesReplaced_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for valvesAppearImage
            if self.coreDataValue.value(forKey: "valvesAppearImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "valvesAppearImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "valvesAppear_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for valvesAutomatedImage
            if self.coreDataValue.value(forKey: "valvesAutomatedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "valvesAutomatedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "valvesAutomated_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for feedMainImage
            if self.coreDataValue.value(forKey: "feedMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "feedMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "feedMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for feedImage
            if self.coreDataValue.value(forKey: "feedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "feedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "feed_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for feedMountedImage
            if self.coreDataValue.value(forKey: "feedMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "feedMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "feedMounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for feedWorkingImage
            if self.coreDataValue.value(forKey: "feedWorkingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "feedWorkingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "feedWorking_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for feedVisibleLeaksImage
            if self.coreDataValue.value(forKey: "feedVisibleLeaksImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "feedVisibleLeaksImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "feedVisibleLeaks_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            
            //TODO:-InspectSlatSystemVC
            //for saltSystemMainImage
            if self.coreDataValue.value(forKey: "saltSystemMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "saltSystemMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "saltSystemMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for saltSystemImage
            if self.coreDataValue.value(forKey: "saltSystemImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "saltSystemImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "saltSystem_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for purificationImage
            if self.coreDataValue.value(forKey: "purificationImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "purificationImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "purification_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfCleaningImage
            if self.coreDataValue.value(forKey: "selfCleaningImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfCleaningImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfCleaning_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for saltSystemMaintainImage
            if self.coreDataValue.value(forKey: "saltSystemMaintainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "saltSystemMaintainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "saltSystemMaintain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for saltSystemPowerBtnImage
            if self.coreDataValue.value(forKey: "saltSystemPowerBtnImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "saltSystemPowerBtnImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "saltSystemPowerBtn_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for saltSystemWorkingImage
            if self.coreDataValue.value(forKey: "saltSystemWorkingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "saltSystemWorkingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "saltSystemWorking_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for saltSystemLeakImage
            if self.coreDataValue.value(forKey: "saltSystemLeakImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "saltSystemLeakImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "saltSystemLeak_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for saltSystemCalcificationImage
            if self.coreDataValue.value(forKey: "saltSystemCalcificationImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "saltSystemCalcificationImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "saltSystemCalcification_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfFloorHeadImage
            if self.coreDataValue.value(forKey: "selfFloorHeadImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfFloorHeadImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfFloorHead_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfConditionImage
            if self.coreDataValue.value(forKey: "selfConditionImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfConditionImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfCondition_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfHeadSyncImage
            if self.coreDataValue.value(forKey: "selfHeadSyncImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfHeadSyncImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfHeadSync_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfLatchingSafetyImage
            if self.coreDataValue.value(forKey: "selfLatchingSafetyImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfLatchingSafetyImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfLatchingSafety_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for selfControllerLeakImage
            if self.coreDataValue.value(forKey: "selfControllerLeakImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "selfControllerLeakImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "selfControllerLeak_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            
            //TODO:-InspectClockVC
            //for timeMainImage
            if self.coreDataValue.value(forKey: "timeMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "timeMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "timeMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for clockMountedImage
            if self.coreDataValue.value(forKey: "clockMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "clockMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "clockMountedImage[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for deviceRustyImage
            if self.coreDataValue.value(forKey: "deviceRustyImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deviceRustyImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deviceRusty_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for deviceRunProperlyImage
            if self.coreDataValue.value(forKey: "deviceRunProperlyImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "deviceRunProperlyImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "deviceRunProperly_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for exposedWireImage
            if self.coreDataValue.value(forKey: "exposedWireImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "exposedWireImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "exposedWire_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for systemGroundedImage
            if self.coreDataValue.value(forKey: "systemGroundedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "systemGroundedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "systemGrounded_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for systemWeatherProofImage
            if self.coreDataValue.value(forKey: "systemWeatherProofImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "systemWeatherProofImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "systemWeatherProof_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for automatedDisplayImage
            if self.coreDataValue.value(forKey: "automatedDisplayImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "automatedDisplayImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "automatedDisplay_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for automatedRemotePanelImage
            if self.coreDataValue.value(forKey: "automatedRemotePanelImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "automatedRemotePanelImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "automatedRemotePanel_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for remotePanelWorkImage
            if self.coreDataValue.value(forKey: "remotePanelWorkImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "remotePanelWorkImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "remotePanelWork_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for remoteControlImage
            if self.coreDataValue.value(forKey: "remoteControlImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "remoteControlImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "remoteControl_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spaSideSwitchImage
            if self.coreDataValue.value(forKey: "spaSideSwitchImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spaSideSwitchImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaSideSwitch_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spaAirSwitchImage
            if self.coreDataValue.value(forKey: "spaAirSwitchImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spaAirSwitchImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaAirSwitch_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for phoneBasedAppImage
            if self.coreDataValue.value(forKey: "phoneBasedAppImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "phoneBasedAppImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "phoneBasedApp_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for remotelyOperatedSystemImage
            if self.coreDataValue.value(forKey: "remotelyOperatedSystemImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "remotelyOperatedSystemImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "remotelyOperatedSystem_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for serviceModeImage
            if self.coreDataValue.value(forKey: "serviceModeImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "serviceModeImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "serviceMode_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for properlyLabelImage
            if self.coreDataValue.value(forKey: "properlyLabelImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "properlyLabelImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "properlyLabel_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for automatedValvesWorkingImage
            if self.coreDataValue.value(forKey: "automatedValvesWorkingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "automatedValvesWorkingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "automatedValvesWorking_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for heaterMainImage
            if self.coreDataValue.value(forKey: "heaterMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "heaterMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "heaterMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for heaterSizedImage
            if self.coreDataValue.value(forKey: "heaterSizedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "heaterSizedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "heaterSized_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for heaterFireUpImage
            if self.coreDataValue.value(forKey: "heaterFireUpImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "heaterFireUpImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "heaterFireUp_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for errorCodeDisplayImage
            if self.coreDataValue.value(forKey: "errorCodeDisplayImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "errorCodeDisplayImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "errorCodeDisplay_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for gasShutoutValveImage
            if self.coreDataValue.value(forKey: "gasShutoutValveImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "gasShutoutValveImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "gasShutoutValve_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for heaterSafeDistanceImage
            if self.coreDataValue.value(forKey: "heaterSafeDistanceImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "heaterSafeDistanceImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "heaterSafeDistance_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for heaterExhaustBlockImage
            if self.coreDataValue.value(forKey: "heaterExhaustBlockImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "heaterExhaustBlockImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "heaterExhaustBlock_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for internalDebrisFreeImage
            if self.coreDataValue.value(forKey: "internalDebrisFreeImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "internalDebrisFreeImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "internalDebrisFree_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for heatExposedWireImage
            if self.coreDataValue.value(forKey: "heatExposedWireImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "heatExposedWireImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "heatExposedWire_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for terminalCleanImage
            if self.coreDataValue.value(forKey: "terminalCleanImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "terminalCleanImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "terminalClean_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for burnerTrayCleanImage
            if self.coreDataValue.value(forKey: "burnerTrayCleanImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "burnerTrayCleanImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "burnerTrayClean_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for heatPumpOperateImage
            if self.coreDataValue.value(forKey: "heatPumpOperateImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "heatPumpOperateImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "heatPumpOperate_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for heatPumpDisplayPanelImage
            if self.coreDataValue.value(forKey: "heatPumpDisplayPanelImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "heatPumpDisplayPanelImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "heatPumpDisplayPanel_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for heatPumpColdAirImage
            if self.coreDataValue.value(forKey: "heatPumpColdAirImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "heatPumpColdAirImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "heatPumpColdAir_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for heatPumpDrainFreeImage
            if self.coreDataValue.value(forKey: "heatPumpDrainFreeImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "heatPumpDrainFreeImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "heatPumpDrainFree_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for heatPumpExposedWiringImage
            if self.coreDataValue.value(forKey: "heatPumpExposedWiringImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "heatPumpExposedWiringImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "heatPumpExposedWiring_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            
            //TODO:-InspectLightVC
            //for lightMainImage
            if self.coreDataValue.value(forKey: "lightMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "lightMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "lightMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for lightWorkingImage
            if self.coreDataValue.value(forKey: "lightWorkingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "lightWorkingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "lightWorking_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for lowVoltageImage
            if self.coreDataValue.value(forKey: "lowVoltageImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "lowVoltageImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "lowVoltage_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for fiberOpticImage
            if self.coreDataValue.value(forKey: "fiberOpticImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "fiberOpticImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "fiberOptic_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for fiberWorkingImage
            if self.coreDataValue.value(forKey: "fiberWorkingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "fiberWorkingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "fiberWorking_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for multiSynchImage
            if self.coreDataValue.value(forKey: "multiSynchImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "multiSynchImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "multiSynch_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for spaLightImage
            if self.coreDataValue.value(forKey: "spaLightImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "spaLightImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "spaLight_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for basinLightImage
            if self.coreDataValue.value(forKey: "basinLightImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "basinLightImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "basinLight_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for freeWaterImage
            if self.coreDataValue.value(forKey: "freeWaterImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "freeWaterImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "freeWater_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for lightMountedImage
            if self.coreDataValue.value(forKey: "lightMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "lightMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "lightMounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for lightProperGFIImage
            if self.coreDataValue.value(forKey: "lightProperGFIImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "lightProperGFIImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "lightProperGFI_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for trippedImage
            if self.coreDataValue.value(forKey: "trippedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "trippedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "tripped_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for poolSafetyImage
            if self.coreDataValue.value(forKey: "poolSafetyImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "poolSafetyImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "poolSafety_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for exposeWiringImage
            if self.coreDataValue.value(forKey: "exposeWiringImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "exposeWiringImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "exposeWiring_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for disconnectedAccessoriesImage
            if self.coreDataValue.value(forKey: "disconnectedAccessoriesImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "disconnectedAccessoriesImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "disconnectedAccessories_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for equipmentBondImage
            if self.coreDataValue.value(forKey: "equipmentBondImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "equipmentBondImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "equipmentBond_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for electricalProperGFIImage
            if self.coreDataValue.value(forKey: "electricalProperGFIImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "electricalProperGFIImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "electricalProperGFI_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for electricalGFITrippedImage
            if self.coreDataValue.value(forKey: "electricalGFITrippedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "electricalGFITrippedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "electricalGFITripped_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for wireHiringImage
            if self.coreDataValue.value(forKey: "wireHiringImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "wireHiringImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "wireHiring_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for boxMountedImage
            if self.coreDataValue.value(forKey: "boxMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "boxMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "boxMounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //TODO:-InspectFencing
            //for fenceMainImage
            if self.coreDataValue.value(forKey: "fenceMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "fenceMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "fenceMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for fencePerimeterImage
            if self.coreDataValue.value(forKey: "fencePerimeterImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "fencePerimeterImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "fencePerimeter_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for fenceHeightImage
            if self.coreDataValue.value(forKey: "fenceHeightImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "fenceHeightImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "fenceHeight_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for fenceMinimalImage
            if self.coreDataValue.value(forKey: "fenceMinimalImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "fenceMinimalImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "fenceMinimal_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for fenceDefectsImage
            if self.coreDataValue.value(forKey: "fenceDefectsImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "fenceDefectsImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "fenceDefects_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for fenceLatchingImage
            if self.coreDataValue.value(forKey: "fenceLatchingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "fenceLatchingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "fenceLatching_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for fenceGatesImage
            if self.coreDataValue.value(forKey: "fenceGatesImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "fenceGatesImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "fenceGates_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for fenceMountedImage
            if self.coreDataValue.value(forKey: "fenceMountedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "fenceMountedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "fenceMounted_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for fenceInstalledImage
            if self.coreDataValue.value(forKey: "fenceInstalledImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "fenceInstalledImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "fenceInstalled_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for fenceLockingImage
            if self.coreDataValue.value(forKey: "fenceLockingImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "fenceLockingImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "fenceLocking_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for fenceIsolateImage
            if self.coreDataValue.value(forKey: "fenceIsolateImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "fenceIsolateImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "fenceIsolate_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for coverMainImage
            if self.coreDataValue.value(forKey: "coverMainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "coverMainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "coverMain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for coverMaterialImage
            if self.coreDataValue.value(forKey: "coverMaterialImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "coverMaterialImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "coverMaterial_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for coverMaintenanceImage
            if self.coreDataValue.value(forKey: "coverMaintenanceImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "coverMaintenanceImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "coverMaintenance_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for coverBondedImage
            if self.coreDataValue.value(forKey: "coverBondedImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "coverBondedImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "coverBonded_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for coverLockoutImage
            if self.coreDataValue.value(forKey: "coverLockoutImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "coverLockoutImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "coverLockout_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for coverRanImage
            if self.coreDataValue.value(forKey: "coverRanImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "coverRanImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "coverRan_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for coverReelImage
            if self.coreDataValue.value(forKey: "coverReelImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "coverReelImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "coverReel_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for coverManualImage
            if self.coreDataValue.value(forKey: "coverManualImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "coverManualImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "coverManual_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            
            //TODO:-InspectVisualLeakVC
            //for visualEquipmentImage
            if self.coreDataValue.value(forKey: "visualEquipmentImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visualEquipmentImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visualEquipment_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for visualBackwashImage
            if self.coreDataValue.value(forKey: "visualBackwashImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visualBackwashImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visualBackwash_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for visualArroundWaterFeatureImage
            if self.coreDataValue.value(forKey: "visualArroundWaterFeatureImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visualArroundWaterFeatureImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visualArroundWaterFeature_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for visualSolarImage
            if self.coreDataValue.value(forKey: "visualSolarImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visualSolarImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visualSolar_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for visualBasinImage
            if self.coreDataValue.value(forKey: "visualBasinImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visualBasinImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visualBasin_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for visualSlotDrainImage
            if self.coreDataValue.value(forKey: "visualSlotDrainImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visualSlotDrainImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visualSlotDrain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for visualVinylImage
            if self.coreDataValue.value(forKey: "visualVinylImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visualVinylImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visualVinyl_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for visualNoticeableImage
            if self.coreDataValue.value(forKey: "visualNoticeableImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visualNoticeableImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visualNoticeable_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for visualStructuralCracksImage
            if self.coreDataValue.value(forKey: "visualStructuralCracksImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visualStructuralCracksImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visualStructuralCracks_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for visualBondBeamImage
            if self.coreDataValue.value(forKey: "visualBondBeamImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visualBondBeamImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visualBondBeam_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for visualSurgeTankImage
            if self.coreDataValue.value(forKey: "visualSurgeTankImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visualSurgeTankImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visualSurgeTank_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            //for visualScumGuttersImage
            if self.coreDataValue.value(forKey: "visualScumGuttersImage") == nil {
                print("no image")
            } else {
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visualScumGuttersImage") as! Data) as? NSArray {
                    //extract data..
                    print(mySavedData)
                    let arrImgs = mySavedData as! [UIImage]
                    for image in arrImgs {
                        let imageData = image.jpegData(compressionQuality: 1.0)
                        multipartFormData.append(imageData!, withName: "visualScumGutters_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            for (key, value) in inspectDetails {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key as! String)
            }
        }, to: url,
           method:.post,
           headers:headers ,
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    guard let json = response.result.value as? [String: Any] else {
                        print(response)
                        print(response.data as Any)
                        print("didn't get todo object as JSON from API")
                        //print("Error: \(response.result.error as! NSString)")
                        SVProgressHUD.dismiss()
                        return
                    }
                    
                    print("JSON: \(json)")
                    if ((json["status"]  as! Int) == 1) {
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                            return
                        }

                        let managedContext = appDelegate.persistentContainer.viewContext
                        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PlumberLeak_CoreData")

                        //let userName: String = UserDefaults.standard.value(forKey: "PlumberLeakUserName") as! String
                        //let predicate = NSPredicate(format: "%K == %@", "namePlumberLeak", userName)
                        
                        //fetchRequest.predicate = predicate
                        
                        do {
                            let  rs = try managedContext.fetch(fetchRequest)
                            print(rs)
                            let countNo: Int = (rs as [NSManagedObject]).count
                            let countNumber: Int = countNo-1
                            if (rs as [NSManagedObject]).count > 0 {
                                managedContext.delete(rs[countNumber])

                                try managedContext.save()
                            }
                        } catch let error as NSError {
                            print("Could not fetch. \(error), \(error.userInfo)")
                        }
                        let alertController = UIAlertController(title: "", message: (json["message"] as! String), preferredStyle: UIAlertController.Style.alert) //Replace
                        
                        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            (result : UIAlertAction) -> Void in
                            
                            if UIDevice.current.userInterfaceIdiom == .phone {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                                self.navigationController?.pushViewController(InspectionListVC, animated: true)
                            } else if UIDevice.current.userInterfaceIdiom == .pad {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                                self.navigationController?.pushViewController(InspectionListVC, animated: true)
                            }
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        let alertController = UIAlertController(title: "", message: (json["message"] as! String), preferredStyle: UIAlertController.Style.alert) //Replace
                        
                        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            (result : UIAlertAction) -> Void in
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
    /*func postInspectSummary() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForPoolDetect")
           
        let postInspectSummaryDetails:  NSMutableDictionary = [
           "return_data_id" : return_id!,
           "summaryData"    : self.secInspectSummary[InspectSummary.summaryData.rawValue].formTextValue
        ]
        
        print("postInspectSummaryDetails :: \(postInspectSummaryDetails)")
        ApiManager.sharedInstanceAPI.PostInspectSummary(postId: 1, summaryDetails: postInspectSummaryDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PostInspectSummary json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                        let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                        self.navigationController?.pushViewController(InspectionListVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                        let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                        self.navigationController?.pushViewController(InspectionListVC, animated: true)
                    }
                    SVProgressHUD.dismiss()
                })
            }
        }, onFailure: { error in
            DispatchQueue.main.sync(execute: {() -> Void in
                SVProgressHUD.dismiss()
                print(error)
                let alert = UIAlertController(title: "", message: error["message"] as? String, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
                    DispatchQueue.main.async(execute: {() -> Void in
                        
                    })
                }
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            })
        })
    }*/
}

extension InspectCompleteSummaryVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let SummaryDataTableCell = cell as? SummaryDataTableCell {
            if textView == SummaryDataTableCell.txtSummaryData {
                self.secInspectSummary[InspectSummary.summaryData.rawValue].formTextValue = (textView.text)!
           }
        }
    }
}

extension InspectCompleteSummaryVC: UITableViewDataSource, UITableViewDelegate {
    //MARK: - TableView Deleagte/DataSource
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0 // You can set any other value, it's up to you
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if indexPath.row == 0 {
                return 243
            } else if indexPath.row == 1 {
                return UITableView.automaticDimension
            } else {
                return 61
            }
        } else {
            if indexPath.row == 0 {
                return 350
            } else if indexPath.row == 1 {
                return UITableView.automaticDimension
            } else {
                return 91
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let dataCell = tableView.dequeueReusableCell(withIdentifier: "SummaryDataCell", for: indexPath) as! SummaryDataTableCell
            
            dataCell.txtSummaryData.delegate = self
            
            return dataCell
        } else  if indexPath.row == 1 {
            let cell = tblSummaryData.dequeueReusableCell(withIdentifier:"DisclaimerCell", for: indexPath)as! DisclaimerTableCell
            cell.txtNote.text = self.dataArray[0] as? String
            
            cell.callBack = {
                textView in
                // update data source
                cell.txtNote.text = self.dataArray[0] as? String
                // tell table view we're starting layout updates
                tableView.beginUpdates()
                // get current content offset
                var scOffset = tableView.contentOffset
                // get current text view height
                let tvHeight = textView.frame.size.height
                // telll text view to size itself
                textView.sizeToFit()
                // get the difference between previous height and new height (if word-wrap or newline change)
                let yDiff = textView.frame.size.height - tvHeight
                // adjust content offset
                scOffset.y += yDiff
                // update table content offset so edit caret is not covered by keyboard
                tableView.contentOffset = scOffset
                // tell table view to apply layout updates
                tableView.endUpdates()
            }
            return cell
        } else {
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "SubmitFormCell", for: indexPath) as! SubmitFormTableCell
            
            cellBtn.btnSubmit.addTarget(self, action: #selector(btnSubmitDidTap), for: UIControl.Event.touchUpInside)
                return cellBtn
        }
    }
}
