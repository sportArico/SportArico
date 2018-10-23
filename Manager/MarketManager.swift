
//

import Foundation
import Alamofire
import KRProgressHUD

final class MarketManager {
    
    static let shared: MarketManager = {
        let instance = MarketManager()
        return instance
    }()

    //MARK: Market Image Slider
    func GetMarketImageSlider(withID ID: String = "", completion:@escaping([MarketSliderData?], String?)->()) {
        KRProgressHUD.show()
        Alamofire.request(Endpoints.MarketSlider, method: .get, parameters: nil, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(MarketSliderRoot.self, from: data!)
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
    
    //MARK: Market Product List
    func GetMarketProduct(withID UserID: String = "", completion:@escaping(MarketHomeProductData?, String?)->()) {
        KRProgressHUD.show()
        let param = ["user_id":UserID]
        Alamofire.request(Endpoints.MarketProductList, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(MarketHomeProductRoot.self, from: data!)
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
    
    //MARK: Market Product Detail
    func GetMarketProductDetail(withID urlvalue: String = "", completion:@escaping(MarketProductDetailData?, String?)->()) {
        KRProgressHUD.show()
        print(Endpoints.MarketProductDetails + "\(urlvalue)")
        Alamofire.request(Endpoints.MarketProductDetails + "\(urlvalue)", method: .get, parameters: nil, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(MarketProductDetailRoot.self, from: data!)
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
    
    func AddToBookMark(withID UserID: String = "",Market_Product_Id: String,IsFav: Bool = false, completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserID,"market_product_id":Market_Product_Id]
        var url = ""
        if IsFav{
            url = Endpoints.AddToFavProduct
        }
        else{
            url = Endpoints.AddToBookmark
        }
        Alamofire.request(url, method: .post, parameters: param, headers: nil).responseJSON { response in
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
    
    //MARK: Market Product List
    func GetMarketFavouriteProductList(withID UserID: String = "", completion:@escaping([MarketHomeProductList?], String?)->()) {
        KRProgressHUD.show()
        let param = ["user_id":UserID]
        Alamofire.request(Endpoints.MarketProductFavouriteList, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(FavouriteProductListRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion([nil], error.localizedDescription)
                        }
                    }
                    else{
                        completion([nil], "\(json["message_en"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion([nil], error.localizedDescription)
            }
        }
    }
    
    //MARK: Market More Product List
    func GetMarketMoreProductList(withID VendorID: String = "", completion:@escaping([MarketHomeProductList?], String?)->()) {
        KRProgressHUD.show()
        let param = ["vender":VendorID]
        Alamofire.request(Endpoints.MarketProductListByVendor, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(MarketMoreProductListRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion([nil], error.localizedDescription)
                        }
                    }
                    else{
                        completion([nil], "\(json["message_en"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion([nil], error.localizedDescription)
            }
        }
    }
    
}
