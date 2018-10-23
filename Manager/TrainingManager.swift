
//

import Foundation
import Alamofire
import KRProgressHUD

final class TrainingManager {
    
    static let shared: TrainingManager = {
        let instance = TrainingManager()
        return instance
    }()

    //MARK: Get Training List
    func GetTrainingList(param:[String:String] = [:], completion:@escaping([TrainingHomeData?], String?)->()) {
        KRProgressHUD.show()
        Alamofire.request(Endpoints.GetCourses, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(TrainingHomeRoot.self, from: data!)
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
    
    //MARK: Get Training Detail
    func GetTrainingDetail(lat: String = "",long: String = "",CourcesID: String = "", completion:@escaping(TrainingDetailData?, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["latitude":lat,"longitude":long,"course_id":CourcesID]
        Alamofire.request(Endpoints.GetCourseDetails, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(TrainingDetailRoot.self, from: data!)
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
    //MARK: Add To Bookmark
    func AddToBookMark(User_Id: String = "",CourcesID: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":User_Id,"course_id":CourcesID]
        Alamofire.request(Endpoints.AddToBookmarkCourse, method: .post, parameters: param, headers: nil).responseJSON { response in
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

    //MARK: Get Bookmark List
    func GetBookmarkList(param:[String:String] = [:], completion:@escaping([TrainingHomeData?], String?)->()) {
        KRProgressHUD.show()
        Alamofire.request(Endpoints.GetBookmarkList, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(TrainingHomeRoot.self, from: data!)
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
    //MARK: Book Cources
    func BookCources(param:[String:String], completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        print(param)
        Alamofire.request(Endpoints.BookCourse, method: .post, parameters: param, headers: nil).responseJSON { response in
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
}
