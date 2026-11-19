//
//  ApiManager.swift
//  Leaktronics
//
//  Created by ivaninfotech on 4/24/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD


class ApiManager: NSObject {
    static let sharedInstanceAPI = ApiManager()
    
    var token: String = UserDefaults.standard.value(forKey: "key_token") as! String
    
    
    //self.token = "\(logIndict .value(forKey: "token")!)"
    
    //MARK:- RegistraionVC
    //MARK:- PostUpdateProfileDetails
    func PostUpdateProfileDetails(postId: Int, profileDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.UpdateProfile)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: profileDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PoolDetectionContactDetails jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    
    //MARK::- PoolDetect
    //MARK:- PoolDetectionContact
    func PostPoolDetectionContactDetails(postId: Int, contactDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolDetectionContact)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20

        let jsonData = try? JSONSerialization.data(withJSONObject: contactDetails , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PoolDetectionContactDetails jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    func PostPoolDetectionContactDetailsUpdate(postId: Int, contactDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolDetectionContactUpdate)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20

        let jsonData = try? JSONSerialization.data(withJSONObject: contactDetails , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PoolDetectionContactDetails jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }

    //MARK:- PoolDetectionPhoneQuestionnaire1
    func PostPoolPhoneQuestionnaire1(postId: Int, questionnaire1Details: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolPhoneQuestionnaire1)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20

        let jsonData = try? JSONSerialization.data(withJSONObject: questionnaire1Details , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PostPoolPhoneQuestionnaire1 jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    func PostPoolPhoneQuestionnaire1Update(postId: Int, questionnaire1Details: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolPhoneQuestionnaire1Update)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20

        let jsonData = try? JSONSerialization.data(withJSONObject: questionnaire1Details , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PostPoolPhoneQuestionnaire1 jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PoolDetectionPhoneQuestionnaire2
    func PostPoolPhoneQuestionnaire2(postId: Int, questionnaire2Details: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolPhoneQuestionnaire2)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20

        let jsonData = try? JSONSerialization.data(withJSONObject: questionnaire2Details , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PostPoolPhoneQuestionnaire2 jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    func PostPoolPhoneQuestionnaire2Update(postId: Int, questionnaire2Details: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolPhoneQuestionnaire2Update)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20

        let jsonData = try? JSONSerialization.data(withJSONObject: questionnaire2Details , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PostPoolPhoneQuestionnaire2 jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    //MARK:- PostPoolVisualLeakInspect
    func PostPoolVisualLeakInspect(postId: Int, visualLeakDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolVisualLeakInspect)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20

        let jsonData = try? JSONSerialization.data(withJSONObject: visualLeakDetails , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PostPoolPhoneQuestionnaire2 jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    func PostPoolVisualLeakInspectUpdate(postId: Int, visualLeakDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolVisualLeakInspectUpdate)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20

        let jsonData = try? JSONSerialization.data(withJSONObject: visualLeakDetails , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PostPoolPhoneQuestionnaire2 jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostPoolPlumbingStaticTest1
    func PostPoolPlumbingStaticTest1(postId: Int, plumbingStatic1Details: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolPlumbingStaticTest1)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20

        let jsonData = try? JSONSerialization.data(withJSONObject: plumbingStatic1Details , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PostPoolPhoneQuestionnaire2 jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    func PostPoolPlumbingStaticTest1Update(postId: Int, plumbingStatic1Details: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolPlumbingStaticTest1Update)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20

        let jsonData = try? JSONSerialization.data(withJSONObject: plumbingStatic1Details , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PostPoolPhoneQuestionnaire2 jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostPoolPlumbingStaticTest2
    func PostPoolPlumbingStaticTest2(postId: Int, plumbingStatic2Details: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolPlumbingStaticTest2)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 300

        let jsonData = try? JSONSerialization.data(withJSONObject: plumbingStatic2Details , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PostPoolPhoneQuestionnaire2 jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    func PostPoolPlumbingStaticTest2Update(postId: Int, plumbingStatic2Details: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolPlumbingStaticTest2Update)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 300

        let jsonData = try? JSONSerialization.data(withJSONObject: plumbingStatic2Details , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PostPoolPhoneQuestionnaire2 jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostPoolDetailsEdit
    func PostReportDetailsEdit(postId: Int, reportDetailsEdit: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostReportEdit)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 300

        let jsonData = try? JSONSerialization.data(withJSONObject: reportDetailsEdit , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PostPoolPhoneQuestionnaire2 jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PlumberLeak
    //MARK:- PostPlumberLeakDetection
    func PostPlumberLeakDetection(postId: Int, plumberDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPlumberLeakDetection)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20

        let jsonData = try? JSONSerialization.data(withJSONObject: plumberDetails , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberLeakContactDetails jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    ////MARK: Plumber Module
    //MARK:- PostPlumberLeakContact
    func PostPlumberLeakContactDetails(postId: Int, contactDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPlumberLeakContact)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20

        let jsonData = try? JSONSerialization.data(withJSONObject: contactDetails , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberLeakContactDetails jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }


    //MARK:- PostPlumberPhoneQuestionnaire
    func PostPlumberPhoneQuestionnaire(postId: Int, questionnaireDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPlumberPhoneQuestionnaire)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20

        let jsonData = try? JSONSerialization.data(withJSONObject: questionnaireDetails , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }

    //MARK:- PostCommercialLeakDetection
    func PostCommercialLeakDetection(postId: Int, commercialDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostCommercialLeakDetection)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 300

        let jsonData = try? JSONSerialization.data(withJSONObject: commercialDetails , options: [])
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("CommercialLeakDetection jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    

    //MARK::- Inspection Pool
    /*//MARK:-InspectionPoolContact
    func PostInspectionPoolContactDetails(postId: Int, contactDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectPoolContact)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: contactDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PoolDetectionContactDetails jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectionPoolPhoneQuestionnaire
    func PostInspectionPoolPhoneQuestionnaire(postId: Int, questionnaireDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectPhoneQuestionnaire)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: questionnaireDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspection
    func PostInspection(postId: Int, inspectDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectPool)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: inspectDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectFittings
    func PostInspectFittings(postId: Int, fittingsDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectFittings)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: fittingsDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectDeck
    func PostInspectDeck(postId: Int, deckDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectDeck)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: deckDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    
    //MARK:- PostInspectHandrails
    func PostInspectHandrails(postId: Int, handrailsDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectHandrails)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: handrailsDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectEdge
    func PostInspectEdge(postId: Int, edgeDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectEdge)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: edgeDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectWaterFeature
    func PostInspectWaterFeature(postId: Int, waterFeatureDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectWaterFeature)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: waterFeatureDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectSideSuction
    func PostInspectSideSuction(postId: Int, sideSuctionDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectSideSuction)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: sideSuctionDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectAutofill
    func PostInspectAutofill(postId: Int, autofillDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectAutofill)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: autofillDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectPortableSpa
    func PostInspectPortableSpa(postId: Int, spaDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectPortableSpa)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: spaDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectSolar
    func PostInspectSolar(postId: Int, solarDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectSolar)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: solarDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectPoolPump
    func PostInspectPoolPump(postId: Int, pumpDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectPoolPump)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: pumpDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectSwimJetSystem
    func PostInspectSwimJetSystem(postId: Int, swimDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectSwimJetSystem)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: swimDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectSelfCleaning
    func PostInspectSelfCleaning(postId: Int, cleaningDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectSelfCleaning)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: cleaningDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectOtherPump
    func PostInspectOtherPump(postId: Int, pumpDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectOtherPump)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: pumpDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectValves
    func PostInspectValves(postId: Int, valvesDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectValves)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: valvesDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectSaltSystem
    func PostInspectSaltSystem(postId: Int, saltDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectSaltSystem)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: saltDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectClock
    func PostInspectClock(postId: Int, clockDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectClock)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: clockDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectLight
    func PostInspectLight(postId: Int, lightDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectLight)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: lightDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectFencing
    func PostInspectFencing(postId: Int, fencingDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectFencing)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: fencingDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectVisualLeak
    func PostInspectVisualLeak(postId: Int, visualDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectVisualLeak)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: visualDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectStatic
    func PostInspectStatic(postId: Int, staticDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectStatic)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: staticDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK:- PostInspectStatic2
    func PostInspectStatic2(postId: Int, staticDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectStatic2)
        print("URL::\(urlString)")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        
        let jsonData = try? JSONSerialization.data(withJSONObject: staticDetails , options: [])
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if data != nil {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
                if (error != nil) {
                    onFailure(jsonResponse!)
                } else {
                    if (jsonResponse != nil) {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                                onFailure(jsonResponse!)
                            } else {
                                onSuccess(jsonResponse!)
                            }
                        } else {
                            onFailure(jsonResponse!)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    
    //MARK:- PostInspectSummary
   func PostInspectSummary(postId: Int, summaryDetails: NSDictionary, onSuccess: @escaping(NSDictionary) -> Void, onFailure: @escaping(NSDictionary) -> Void) {
       let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostInspectSummary)
       print("URL::\(urlString)")
       let url = URL(string: urlString)!
       var request = URLRequest(url: url)
       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       request.setValue(token, forHTTPHeaderField: "Authorization")
       request.httpMethod = "POST"
       request.timeoutInterval = 20
       
       let jsonData = try? JSONSerialization.data(withJSONObject: summaryDetails , options: [])
       request.httpBody = jsonData
       
       let session = URLSession.shared
       let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
           
           if data != nil {
               let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
               //print("PlumberPhoneQuestionnaire jsonResponse:: \(String(describing: jsonResponse))")
               if (error != nil) {
                   onFailure(jsonResponse!)
               } else {
                   if (jsonResponse != nil) {
                       if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                           if (jsonResponse?.value(forKey: "status") as! Bool == false) {
                               onFailure(jsonResponse!)
                           } else {
                               onSuccess(jsonResponse!)
                           }
                       } else {
                           onFailure(jsonResponse!)
                       }
                   }
               }
           }
       })
       task.resume()
    }*/
    
    
}
