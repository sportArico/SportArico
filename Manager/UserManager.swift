
//

import Foundation
import KRProgressHUD
import Alamofire

final class UserManager {
    
    var currentUser: User?
    
    static let shared: UserManager = {
        let instance = UserManager()
        return instance
    }()
    
    func login(withEmail email: String, password: String, FCM_Token: String,email_phone: String,isremember:Bool = true, completion:@escaping(User?, String?)->()) {
        KRProgressHUD.show()
        let params:[String:String] = ["email_phone": email, "password": password,"fcm_token": FCM_Token,"otp_to":email_phone]
        print(params)
        Alamofire.request(Endpoints.Login, method: .post, parameters: params, headers: nil).responseJSON { [weak self] response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == false {
                        completion(nil, "\(json["message_en"] as? String ?? "")")
                    }
                    else{
                        self?.configureSuccessLogin(byJSON: json, isremember: isremember, completion: completion)
                    }
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    //MARK: Login With FB
    func LoginWithFB(withParam param: [String:String], completion:@escaping(User?, String?)->()) {
        KRProgressHUD.show()
        print("------------------------------------------------------------------------------")
        print("URL --> \(Endpoints.LoginWithFB)")
        print("Send Data --> \(param)")
        print("------------------------------------------------------------------------------")
        
        Alamofire.request(Endpoints.LoginWithFB, method: .post, parameters: param, headers: nil).responseJSON { [weak self] response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    if (json["status"] as? Bool) == false {
                        completion(nil, "\(json["message_en"] as? String ?? "")")
                    }
                    else{
                        self?.configureSuccessLogin(byJSON: json, completion: completion)
                    }
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    func signUp(withParametrs parametrs: [String: String],
                avatar: UIImage?,
                completion:@escaping (Bool, NSDictionary? ,String? )->()) {
        KRProgressHUD.show()
        if let image = avatar {
            Alamofire.upload(multipartFormData: { multipartFormData in
                if let imageData = UIImageJPEGRepresentation(image, 0.6) {
                    multipartFormData.append(imageData, withName: "image", fileName: "file.jpg", mimeType: "image/png")
                }
                for (key, value) in parametrs {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
            }, to: Endpoints.Register, encodingCompletion: { encoding in
                switch encoding {
                case .success(let upload, _, _):
                    upload.responseJSON { [weak self]
                        response in
                        KRProgressHUD.dismiss()
                        switch(response.result) {
                        case .success:
                            if let json = response.result.value as? [String : Any]   {
                                self?.handleSignUpResponse(json, completion: completion)
                            } else {
                                completion(false, nil, nil)
                            }
                        case .failure(let error):
                            completion(false, nil, error.localizedDescription)
                        }
                    }
                case .failure(let encodingError):
                    KRProgressHUD.dismiss()
                    completion(false, nil, encodingError.localizedDescription)
                }
            })
        } else {
            Alamofire.request(Endpoints.Register, method: .post, parameters: parametrs, headers: nil).responseJSON { [weak self] response in
                KRProgressHUD.dismiss()
                switch(response.result) {
                case .success:
                    if let json = response.result.value as? [String : Any]   {
                        self?.handleSignUpResponse(json, completion: completion)
                    } else {
                        completion(false, nil,nil)
                    }
                case .failure(let error):
                    completion(false, nil, error.localizedDescription)
                }
            }
        }
    }
    //MARK: Private methods
    private func handleSignUpResponse(_ json: [String: Any],
                                      completion:@escaping (Bool, NSDictionary?, String? )->()) {
        print(json)
        if  (json["status"] as? Bool) == true  {
            configureSuccessLoginWithoutCompletionBlock(byJSON: json)
            completion(true, json["data"] as? NSDictionary, json["message_en"] as? String ?? "")
            return
        } else if let errors = json["message_en"] as? String{
            completion(false, nil, errors)
            return
        } else {
            completion(false, nil,"Something went wrong, please try again")
        }
    }
    
    private func configureSuccessLoginWithoutCompletionBlock(byJSON json: [String : Any]) {
        print(json)
        if let user = json["data"] as? [String : Any] {
            let obj = User(user_id: user["user_id"] as! String, email: user["email"] as? String ?? "", phone: user["phone"] as? String ?? "", role_id: user["role_id"] as? String ?? "", role_name: user["role_name"] as? String ?? "", category_id: user["category_id"] as? String ?? "", profile_image: user["profile_image"] as? String ?? "", fcm_token: user["fcm_token"] as? String ?? "", provider_categories: user["provider_categories"] as? String ?? "", course_count: String(user["course_count"] as? Int ?? 0), court_count: String(user["court_count"] as? Int ?? 0), market_product_count: String(user["market_product_count"] as? Int ?? 0), offer_count: String(user["offer_count"] as? Int ?? 0))
            self.currentUser = obj
            
                self.SetUserDefaultData(obj: self.currentUser!)
        
        }
        
    }
    
    
    private func configureSuccessLogin(byJSON json: [String : Any],isremember:Bool = true,
                                       completion: @escaping(User?, String?)->()) {
        print(json)
        if let user = json["data"] as? [String : Any] {
            let obj = User(user_id: user["user_id"] as! String, email: user["email"] as! String, phone: user["phone"] as! String, role_id: user["role_id"] as? String ?? "", role_name: user["role_name"] as? String ?? "", category_id: user["category_id"] as? String ?? "", profile_image: user["profile_image"] as? String ?? "", fcm_token: user["fcm_token"] as? String ?? "", provider_categories: user["provider_categories"] as? String ?? "", course_count: String(user["course_count"] as? Int ?? 0), court_count: String(user["court_count"] as? Int ?? 0), market_product_count: String(user["market_product_count"] as? Int ?? 0), offer_count: String(user["offer_count"] as? Int ?? 0))
                self.currentUser = obj
                if isremember{
                    self.SetUserDefaultData(obj: self.currentUser!)
                }
            completion(self.currentUser, nil)
        } else {
            completion(nil, json["message_en"] as? String ?? "")
        }
    }
    private func SetUserDefaultData(obj: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(obj){
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedUser")
            defaults.set(true, forKey: "IsLogin")
            defaults.set(obj.category_id, forKey: "Merchant_Category_Id")
        }
    }
    
    public func saveUserdata()
    {
        self.SetUserDefaultData(obj: self.currentUser!)
    }
    
    func GetUserDefaultData(){
        let defaults = UserDefaults.standard
        if let savedPerson = defaults.object(forKey: "SavedUser") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(User.self, from: savedPerson) {
                self.currentUser = loadedPerson
                self.currentUser?.category_id = UserDefaults.standard.value(forKey: "Merchant_Category_Id") as! String
                AppDelegate.sharedDelegate().location_name = defaults.value(forKey: "LocationName") as? String ?? ""
                AppDelegate.sharedDelegate().userLatitude = defaults.value(forKey: "lat") as? String ?? ""
                AppDelegate.sharedDelegate().userLatitude = defaults.value(forKey: "long") as? String ?? ""
            }
        }
    }
    func UpdateProfile(withParametrs parametrs: [String: String],
                avatar: UIImage?,
                completion:@escaping (Bool, NSDictionary?,String? )->()) {
        KRProgressHUD.show()
        if let image = avatar {
            Alamofire.upload(multipartFormData: { multipartFormData in
                if let imageData = UIImageJPEGRepresentation(image, 0.6) {
                    multipartFormData.append(imageData, withName: "profile_image", fileName: "userProfile.jpg", mimeType: "image/*")
                }
                for (key, value) in parametrs {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
            }, to: Endpoints.UpdateProfile, encodingCompletion: { encoding in
                switch encoding {
                case .success(let upload, _, _):
                    upload.responseJSON { [weak self]
                        response in
                        KRProgressHUD.dismiss()
                        switch(response.result) {
                        case .success:
                            if let json = response.result.value as? [String : Any]   {
                                self?.handleSignUpResponse(json, completion: completion)
                            } else {
                                completion(false,nil, nil)
                            }
                        case .failure(let error):
                            completion(false,nil ,error.localizedDescription)
                        }
                    }
                case .failure(let encodingError):
                    KRProgressHUD.dismiss()
                    completion(false, nil,encodingError.localizedDescription)
                }
            })
        } else {
            Alamofire.request(Endpoints.UpdateProfile, method: .post, parameters: parametrs, headers: nil).responseJSON { [weak self] response in
                KRProgressHUD.dismiss()
                switch(response.result) {
                case .success:
                    if let json = response.result.value as? [String : Any]   {
                        self?.handleSignUpResponse(json, completion: completion)
                    } else {
                        completion(false,nil, nil)
                    }
                case .failure(let error):
                    completion(false,nil, error.localizedDescription)
                }
            }
        }
    }
    func signUpProvider(withParametrs parametrs: [String: String],
                avatar: UIImage?,
                completion:@escaping (Bool, NSDictionary?, String? )->()) {
        KRProgressHUD.show()
        if let image = avatar {
            Alamofire.upload(multipartFormData: { multipartFormData in
                if let imageData = UIImageJPEGRepresentation(image, 0.6) {
                    multipartFormData.append(imageData, withName: "image", fileName: "file.jpg", mimeType: "image/png")
                }
                for (key, value) in parametrs {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
            }, to: Endpoints.RegisterProvider, encodingCompletion: { encoding in
                switch encoding {
                case .success(let upload, _, _):
                    upload.responseJSON { [weak self]
                        response in
                        KRProgressHUD.dismiss()
                        switch(response.result) {
                        case .success:
                            if let json = response.result.value as? [String : Any]   {
                                self?.handleSignUpResponse(json, completion: completion)
                            } else {
                                completion(false,nil, nil)
                            }
                        case .failure(let error):
                            completion(false, nil,error.localizedDescription)
                        }
                    }
                case .failure(let encodingError):
                    KRProgressHUD.dismiss()
                    completion(false, nil,encodingError.localizedDescription)
                }
            })
        } else {
            Alamofire.request(Endpoints.RegisterProvider, method: .post, parameters: parametrs, headers: nil).responseJSON { [weak self] response in
                KRProgressHUD.dismiss()
                switch(response.result) {
                case .success:
                    if let json = response.result.value as? [String : Any]   {
                        self?.handleSignUpResponse(json, completion: completion)
                    } else {
                        completion(false, nil ,nil)
                    }
                case .failure(let error):
                    completion(false, nil ,error.localizedDescription)
                }
            }
        }
    }
    
   
    func ProviderCategory(withParametrs parametrs: [String: String],
                          completion:@escaping (Bool, NSDictionary?, String? )->()) {
        KRProgressHUD.show()
        Alamofire.request(Endpoints.ProviderCategory, method: .post, parameters: parametrs, headers: nil).responseJSON { [weak self] response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any]   {
                    self?.handleSignUpResponse(json, completion: completion)
                } else {
                    completion(false, nil ,nil)
                }
            case .failure(let error):
                completion(false, nil ,error.localizedDescription)
            }
        }
        
    }
    
    
    
    func signUpProviderForSocial(withParametrs parametrs: [String: String],
                        
                        completion:@escaping (Bool, NSDictionary?, String? )->()) {
        
        
        print("------------------------------------------------------------------------------")
        print("URL --> \(Endpoints.LoginWithFB)")
        print("Send Data --> \(parametrs)")
        print("------------------------------------------------------------------------------")
        
        
        
        
        KRProgressHUD.show()
            Alamofire.request(Endpoints.LoginWithFB, method: .post, parameters: parametrs, headers: nil).responseJSON { [weak self] response in
                KRProgressHUD.dismiss()
                switch(response.result) {
                case .success:
                    if let json = response.result.value as? [String : Any]   {
                        self?.configureSuccessLoginWithoutCompletionBlock(byJSON: json)
                        self?.handleSignUpResponse(json, completion: completion)
                    } else {
                        completion(false, nil ,nil)
                    }
                case .failure(let error):
                    completion(false, nil ,error.localizedDescription)
                }
            }
    }

    
    
    func getChatText(completion:@escaping([NSDictionary])->())
    {
        Alamofire.request(Endpoints.getChatText, method: .get, parameters: [:], headers: nil).responseJSON { [weak self] response in
            
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any]   {
                    
                    if  (json["status"] as? Bool) == true  {
                        completion((json["data"] as? [NSDictionary])!)
                    }
                    
                }
            case .failure(_):
                completion([NSDictionary]())
            }
            
        }
    }
    
    //MARK: Get User Profile
    func GetUserProfile(withUserID UserID: String, completion:@escaping(UserProfileData?, String?)->()) {
        KRProgressHUD.show()
        Alamofire.request(Endpoints.GetProfile + UserID, method: .get, parameters: nil, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    if (json["status"] as? Bool) == true {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let data = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            let responce = try jsonDecoder.decode(UserProfileRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion(nil, error.localizedDescription)
                        }
                    }
                    else{
                       completion(nil, "\(json["message_en"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    //MARK: Veryfy OTP
    func VeryfyOTP(param param: [String:String], completion:@escaping(Bool?, String?)->()) {
        KRProgressHUD.show()
       
        Alamofire.request(Endpoints.Verifyotp, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    if (json["status"] as? Bool) == false {
                        completion(false, "\(json["message_en"] as? String ?? "")")
                    }
                    else if (json["status"] as? Bool) == true{
                        completion(true, "\(json["message_en"] as? String ?? "")")
                    }
                    else{
                        completion(false, "Something went wrong, please try again")
                    }
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    //MARK: ReSend OTP
    func ResendOTP(Param param: [String:String], completion:@escaping(Bool?, String?)->()) {
        KRProgressHUD.show()
        
        Alamofire.request(Endpoints.Sendotp, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    if (json["status"] as? Bool) == false {
                        completion(false, "\(json["message_en"] as? String ?? "")")
                    }
                    else if (json["status"] as? Bool) == true{
                        completion(true, "\(json["message_en"] as? String ?? "")")
                    }
                    else{
                        completion(false, "Something went wrong, please try again")
                    }
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
}

