//
//  UploadCollectionView.swift
//  Leaktronics
//
//  Created by ivaninfotech on 4/16/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import SDWebImage
//import SVProgressHUD
//import Alamofire

protocol UploadCollectionProtocol {
    func didTapOnCellItem(_indexpath: IndexPath,_imgUrl:String,_videoUrl:String)
    func didUpdateCellIndex(_indexpath: Int)
}

class UploadCollectionVw: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AddImgProtocol {

    var sourceController:UIViewController?
    var delegateItemCollection:UploadCollectionProtocol?
    var arrItems = [CollectionImageObject]()
    var arrImgs = [String]()
    var isEdit = Bool()
    
    var tableIndexpath:IndexPath? = nil
    var imgCount = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func reloadImageCollection() {
        self.delegate = self
        self.dataSource = self
        self.reloadData()
    }
    
    @objc func addImageCollection() {
        self.delegate = self
        self.dataSource = self
        self.reloadData()
    }
    
    func didTapImg(_indexPath: Int) {
        delegateItemCollection!.didUpdateCellIndex(_indexpath: _indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEdit == true {
            if arrImgs.count > 0 {
                imgCount = arrImgs.count
                print("arrImgs imgCount for edit:\(imgCount)")
                return imgCount + 1
            } else {
                if arrItems.count > 0 {
                    imgCount = arrItems.count
                    print("arrItems imgCount for edit:\(imgCount)")
                    return imgCount + 1
                } else {
                    return 0
                }
            }
        } else {
            if arrItems.count > 0 {
                imgCount = arrItems.count
                print("arrItems imgCount without edit:\(imgCount)")
                return imgCount + 1
            } else {
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if imgCount == indexPath.item {
//            let addImgCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageViewCell", for: indexPath) as! AddImageViewCell
            //let addImgCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageViewCell", for: indexPath) as! AddImageViewCell
            //let addImgCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageViewCell", for: indexPath)
            
//            let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageViewCell", for: indexPath) as! AddImageViewCell
            

            let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell

            
//            collectionViewCell.btnAddImgOutlet.tag = indexPath.item
//            collectionViewCell.delegate = self
//            let btnAddImg = addImgCell.viewWithTag(22) as! UIButton
//            btnAddImg.tag = indexPath.item
            //btnAddImg.addTarget(self, action: #selector(VisualLeakVC.btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            return collectionViewCell
        } else {
            let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
            
            collectionViewCell.imgV.layer.cornerRadius = 5
            collectionViewCell.imgV.contentMode = .scaleAspectFill
            if isEdit == true {
                if arrImgs.count > 0 {
                    let fullUrl = arrImgs[indexPath.item]
                    print("ImageURL: === \(fullUrl)")
                    collectionViewCell.imgV.imageFromServerURL(urlString: fullUrl)
                } else {
                    collectionViewCell.imgV.image = arrItems[indexPath.item].imgCollect
                }
            } else if isEdit == false {
                collectionViewCell.imgV.image = arrItems[indexPath.item].imgCollect
            }
            //btnDelete.isHidden = true
            
            collectionViewCell.btnToDeleteOutlet.tag = indexPath.row
            //collectionViewCell.btnDelete.addTarget(self, action: #selector(deleteImage(button:)), for: .touchUpInside)
            
            //btnDelete.isUserInteractionEnabled = false
            //btnPlay.isHidden = !arrItems[indexPath.item].isVideoItem
            
            /*if arrItems[indexPath.item].imageUrl != "" {
                let imageUrl = arrItems[indexPath.item].imageUrl
                if imageUrl.contains("http") || imageUrl.contains("https") {
                    Manager.shared.loadImage(with: URL.init(string: imageUrl)!, into: ItemImageVw)
                } else {
                    ItemImageVw.image = #imageLiteral(resourceName: "RNoimage")
                }
            } else {
                ItemImageVw.image = #imageLiteral(resourceName: "RNoimage")
            }*/
            return collectionViewCell
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: (collectionView.frame.size.width), height: self.frame.size.height)
        if UIDevice.current.userInterfaceIdiom == .phone{
            return CGSize(width: 85, height: 85)
        } else {
             return CGSize(width: 200, height: 200)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //self.delegateItemCollection?.didUpdateCellIndex(_indexpath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.delegateItemCollection?.didTapOnCellItem(_indexpath: indexPath,_imgUrl:arrItems[indexPath.item].imageUrl,_videoUrl: arrItems[indexPath.item].videoUrl )
    }
    
    
    
    
//    func setPostImage(arrOfImages: [UIImage]) {
//        SVProgressHUD.show(withStatus: "Processing...")
//        let token  = UserDefaults.standard.string(forKey: "token")!
//        
//        let headers = [
//            "Authorization": token,
//            "Content-Type": "application/x-www-form-urlencoded"
//        ]
//        let url = ServiceConstant.BASE_IMAGEURL.appending(ServiceConstant.PostPoolDetectImg)
//        
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            print(arrOfImages)
//            for image in arrOfImages {
//                let imageData = image.jpegData(compressionQuality: 1.0)
//                multipartFormData.append(imageData!, withName: "files[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
//            }
//        }, to: url,
//           method:.post,
//           headers:headers ,
//           encodingCompletion: { encodingResult in
//            switch encodingResult {
//            case .success(let upload, _, _):
//                upload.responseString(completionHandler: { (response) in
//                    if let result = response.result.value {
//                        var dictionary:NSDictionary?
//                        if let data = result.data(using: String.Encoding.utf8) {
//                            do {
//                                dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
//                                print(dictionary!)
//                                SVProgressHUD.dismiss()
////                                if ((dictionary!["status"] as! Bool) == false) {
////                                    self.actInd.stopAnimating()
////                                    self.btnCreatePost.isUserInteractionEnabled = true
////                                    self.showAlertView(title: "Message", msg: dictionary!["message"] as! String, controller: self, okClicked: {
////                                        //self.navigationController?.popViewController(animated: true)
////                                    })
////                                }
//                            } catch let error as NSError {
//                                print(error)
//                            }
//                        }
//                    }
//                    SVProgressHUD.dismiss()
//                })
//                
//            case .failure(let error):
//                print(error)
//                SVProgressHUD.dismiss()
//            }
//        })
//    }
}

public class CollectionImageObject {
    var imgCollect:UIImage? = nil
    init(imgCollect: UIImage) {
        self.imgCollect = imgCollect
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
