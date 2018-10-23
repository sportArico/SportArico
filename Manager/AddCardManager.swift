
//

import Foundation
import Alamofire
import KRProgressHUD

final class AddCardManager {
    
    static let shared: AddCardManager = {
        let instance = AddCardManager()
        return instance
    }()
    
    //MARK: New Card Add
    func AddCard(withParametrs parametrs: [String: String],
                completion:@escaping (Bool, String? )->()) {
        KRProgressHUD.show()
        Alamofire.request(Endpoints.AddCard, method: .post, parameters: parametrs, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success:
                KRProgressHUD.dismiss()
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                            completion(true,nil)
                    }
                    else{
                        completion(false, "\(json["response"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                KRProgressHUD.dismiss()
                completion(false, error.localizedDescription)
            }
        }
        
    }
    //MARK: Get Cart List
   /* func GetCardList(withUserID userID: String, completion:@escaping([CardListResponse?], String?)->()) {
        let params:[String:String] = ["user_id": userID]
        print(params)
        KRProgressHUD.show()
        Alamofire.request(Endpoints.GetCardList, method: .post, parameters: params, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success:
                KRProgressHUD.dismiss()
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let data = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            let responce = try jsonDecoder.decode(RootCardList.self, from: data!)
                            completion(responce.response!, "")
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
                KRProgressHUD.dismiss()
                completion([nil], error.localizedDescription)
            }
        }
    }*/
}
