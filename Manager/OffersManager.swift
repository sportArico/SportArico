
//

import Foundation
import Alamofire
import KRProgressHUD

final class OffersManager {
    
    static let shared: OffersManager = {
        let instance = OffersManager()
        return instance
    }()

    //MARK: Offers Home List
    func GetOffersList(withID ID: String = "", completion:@escaping([OffersData?], String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["category_id":ID]
        Alamofire.request(Endpoints.GetOfferList, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(OffersRoot.self, from: data!)
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
