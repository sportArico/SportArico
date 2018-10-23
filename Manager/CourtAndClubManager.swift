
//

import Foundation
import Alamofire
import KRProgressHUD

final class CourtAndClubManager {
    
    static let shared: CourtAndClubManager = {
        let instance = CourtAndClubManager()
        return instance
    }()
    
    //MARK: Get Court Home List
    func GetCourtHomeList(Param: [String:String] = [:], completion:@escaping([CourtHomeData?], String?)->()) {
        KRProgressHUD.show()
        //let param:[String:String] = ["category_id":CategoryId]
        print(Param)
        Alamofire.request(Endpoints.GetCourts, method: .post, parameters: Param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let data = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            let responce = try jsonDecoder.decode(CourtHomeRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion([nil], error.localizedDescription)
                        }
                    }
                    else{
                        completion([nil], "\(json["response"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion([nil], error.localizedDescription)
            }
        }
    }
    
    //MARK: Offers Home List
    func GetNearbyCourt(lat: String = "",long: String = "", completion:@escaping([NearByLocationData?], String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["latitude":lat,"longitude":long]
        Alamofire.request(Endpoints.NearbyCourt, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let data = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            let responce = try jsonDecoder.decode(NearByLocationRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion([nil], error.localizedDescription)
                        }
                    }
                    else{
                        completion([nil], "\(json["response"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion([nil], error.localizedDescription)
            }
        }
    }
    
    //MARK: Court And Club Detail
    func GetCourtDetail(CourtId: String = "", lat: String = "",long: String = "", completion:@escaping(CourtDetailData?, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["court_id":CourtId,"latitude":lat,"longitude":long]
        Alamofire.request(Endpoints.Getcourtdetails, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let data = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            let responce = try jsonDecoder.decode(CourtDetailRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion(nil, error.localizedDescription)
                        }
                    }
                    else{
                        completion(nil, "\(json["response"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    //MARK: Add To Bookmark CourtAndClub
    func AddToBookMarkCourt(CourtId: String = "", user_id: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["court_id":CourtId,"user_id":user_id]
        Alamofire.request(Endpoints.AddToBookmarkCourt, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "\(json["message_en"] as? String ?? "")")
                    }
                    else{
                        completion(false, "\(json["message_en"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    //MARK: Book Available Time/Date List Get
    func GetBookAvailable(withID Court_Id: String = "",User_Id: String = "",Type: String = "", completion:@escaping([BookAvailableTimeData?], String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["court_id":Court_Id,"user_id":User_Id,"type":Type]
        Alamofire.request(Endpoints.Get_Booking_Available_Time, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let data = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            let responce = try jsonDecoder.decode(BookAvailableTimeRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion([nil], error.localizedDescription)
                        }
                    }
                    else{
                        completion([nil], "\(json["response"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion([nil], error.localizedDescription)
            }
        }
    }
    
    //MARK: Get BookMark List
    func GetBookMarksList(Param: [String:String] = [:], completion:@escaping([CourtHomeData?], String?)->()) {
        KRProgressHUD.show()
        //let param:[String:String] = ["category_id":CategoryId]
        Alamofire.request(Endpoints.GetBookmarkList, method: .post, parameters: Param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let data = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            let responce = try jsonDecoder.decode(CourtHomeRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion([nil], error.localizedDescription)
                        }
                    }
                    else{
                        completion([nil], "\(json["response"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion([nil], error.localizedDescription)
            }
        }
    }
    
    //MARK: Book Court And Club
    func BookCourt(param:[String:String], completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        print(param)
        Alamofire.request(Endpoints.BookCourt, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "\(json["data"] as? String ?? "")")
                    }
                    else{
                        completion(false, "\(json["message_en"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    //MARK: Resent Search Location Get
    func ResentSearchLocation(param:[String:String], completion:@escaping([[String:String]]?, String?)->()) {
        KRProgressHUD.show()
        print(param)
        Alamofire.request(Endpoints.GetRecentSearch, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        let Array:[[String:String]] = (json["data"] as? [[String : String]])!
                        completion(Array, "")
                    }
                    else{
                        completion([], "\(json["message_en"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion([], error.localizedDescription)
            }
        }
    }
    
    //MARK: Add Court And Cources Rating
    func AddRating(parametrs:[String:String],photo: [UIImage?],Type:String, completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        var url = ""
        if Type == "court"{
            url = Endpoints.AddCourtRating
        }
        else if Type == "cources"{
             url = Endpoints.AddCourseRating
        }
        else{
             url = ""
        }
        if photo.first != nil{
            Alamofire.upload(multipartFormData: { multipartFormData in
                for (_,element) in photo.enumerated()
                {
                    if let imageData = UIImageJPEGRepresentation(element!, 0.5)//UIImageJPEGRepresentation(element!, 0.6)
                    {
                        multipartFormData.append(imageData, withName: "images[]", fileName: "image.jpg", mimeType: "image/*")
                        //multipartFormData.append("\r\r".data(using: String.Encoding.utf8)!, withName: "")
                    }
                }
                if parametrs != nil
                {
                    for (key, value) in parametrs
                    {
                        multipartFormData.append(value.data(using: .utf8)!, withName: key)
                    }
                }
            }, usingThreshold: 1, to: url, method: .post, headers: nil, encodingCompletion: { encoding in
                switch encoding {
                case .success(let upload, _, _):
                    upload.responseJSON {
                        response in
                        KRProgressHUD.dismiss()
                        switch(response.result) {
                        case .success:
                            if let json = response.result.value as? [String : Any]   {
                                print(json)
                                if  (json["status"] as? Bool) == true  {
                                    completion(true, json["data"] as? String ?? "")
                                    return
                                } else if let errors = json["data"] as? String{
                                    completion(false, errors)
                                    return
                                }
                                else if let errors = json["data"] as? String{
                                    completion(false, errors)
                                    return
                                } else {
                                    completion(false, "Something went wrong, please try again")
                                }
                            }
                        case .failure(let error):
                            completion(false, error.localizedDescription)
                        }
                    }
                case .failure(let encodingError):
                    completion(false, encodingError.localizedDescription)
                    KRProgressHUD.dismiss()
                }
            })
        }
        else{
            completion(false, "Please Upload One image")
        }
    }
    
    //MARK: Get Court Rating Review List
    func GetCourtRatingList(Param: [String:String] = [:],RatingType: String, completion:@escaping([CourtRatingListData?], String?)->()) {
        KRProgressHUD.show()
        //let param:[String:String] = ["category_id":CategoryId]
        var url = ""
        if RatingType == "court"{
            url = Endpoints.GetCourtRating
        }
        else if RatingType == "cources"{
            url = Endpoints.GetCourseRating
        }
        else {
            url = ""
        }
        Alamofire.request(url, method: .post, parameters: Param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let data = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            let responce = try jsonDecoder.decode(CourtRatingListRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion([nil], error.localizedDescription)
                        }
                    }
                    else{
                        completion([nil], "\(json["response"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion([nil], error.localizedDescription)
            }
        }
    }
}
