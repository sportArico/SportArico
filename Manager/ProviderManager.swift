
//

import Foundation
import Alamofire
import KRProgressHUD

final class ProviderManager {
    
    static let shared: ProviderManager = {
        let instance = ProviderManager()
        return instance
    }()
    
    //MARK: Get Provider Dashboard
    func GetProviderDashboard(UserId: String = "", completion:@escaping(NSDictionary?, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserId]
        Alamofire.request(Endpoints.Provider_Dashboard, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(json["data"] as? NSDictionary, "")
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
    
    //MARK: Get My Pitches List
    func GetMyPitchesList(UserId: String = "", completion:@escaping([ListMyPitchData?], String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserId]
        Alamofire.request(Endpoints.ListMyPitch, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(ListMyPitchRoot.self, from: data!)
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
    
    //MARK: Get Facility List
    func GetFacilityList(UserId: String = "", completion:@escaping([FacilityData?], String?)->()) {
        KRProgressHUD.show()
        Alamofire.request(Endpoints.GetFacilitiesList, method: .get, parameters: nil, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(FacilitysRoot.self, from: data!)
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
    
    //Add New Market...
    func AddNewPitches(withParametrs parametrs: [String: String]?,
                      photo: [UIImage?],
                      offerImages: [UIImage?],
                      videoPath: URL?,
                      coverImage: UIImage?,
                      iconImage: UIImage?,
                      UploadType: String = "",
                      isEdit: Bool = false,
                      completion: @escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        var url = ""
        if UploadType == "Market"{
            if isEdit{
                url = Endpoints.EditMarketProduct
            }
            else{
                url = Endpoints.AddMarketProduct
            }
            
        }
        else if UploadType == "Court"{
            if isEdit{
                url = Endpoints.ProviderEditCourt
            }
            else{
                url = Endpoints.ProviderAddCourt
            }
        }
        else if UploadType == "Cources"{
            if isEdit{
                url = Endpoints.ProviderEditCourse
            }
            else{
                url = Endpoints.ProviderAddCourse
            }
        }
        else{
            completion(false, "Select Valid Type To Upload.")
        }
        if photo.first != nil || offerImages.first != nil{
            Alamofire.upload(multipartFormData: { multipartFormData in
                for (_,element) in photo.enumerated()
                {
                    if let imageData = UIImageJPEGRepresentation(element!, 0.5)//UIImageJPEGRepresentation(element!, 0.6)
                    {
                        multipartFormData.append(imageData, withName: "images[]", fileName: "image.jpg", mimeType: "image/*")
                        //multipartFormData.append("\r\r".data(using: String.Encoding.utf8)!, withName: "")
                    }
                }
                for (_,element) in offerImages.enumerated()
                {
                    if let imageData = UIImageJPEGRepresentation(element!, 0.5)//UIImageJPEGRepresentation(element!, 0.6)
                    {
                        multipartFormData.append(imageData, withName: "offer_images[]", fileName: "image.jpg", mimeType: "image/*")
                        //multipartFormData.append("\r\r".data(using: String.Encoding.utf8)!, withName: "")
                    }
                }
                if coverImage != nil{
                    if let imageData = UIImageJPEGRepresentation(coverImage!, 0.5){
                        if UploadType == "Cources"{
                            multipartFormData.append(imageData, withName: "cover_photo", fileName: "image.jpg", mimeType: "image/*")
                        }
                        else if UploadType == "Market"{
                            multipartFormData.append(imageData, withName: "offer_image", fileName: "image.jpg", mimeType: "image/*")
                        }
                        else{
                            completion(false, "Select Valid Type To Upload.")
                        }
                    }
                }
                if iconImage != nil{
                    if let imageData = UIImageJPEGRepresentation(iconImage!, 0.5){
                        if UploadType == "Cources"{
                            multipartFormData.append(imageData, withName: "icon", fileName: "image.jpg", mimeType: "image/*")
                        }
                        else{
                            completion(false, "Select Valid Type To Upload.")
                        }
                    }
                }
                
                if parametrs != nil
                {
                    for (key, value) in parametrs!
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
        } else if let video = videoPath {
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(video, withName: "post_attachment[ ]", fileName: "afsd.mov", mimeType: "video/mov")
                if parametrs != nil {
                    for (key, value) in parametrs! {
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
                            completion(true, nil)
                        case .failure(let error):
                            completion(false, error.localizedDescription)
                        }
                    }
                case .failure(let encodingError):
                    completion(false, encodingError.localizedDescription)
                    KRProgressHUD.dismiss()
                }
            })
            
        }else {
            Alamofire.request(url, method: .post, parameters: parametrs, headers: nil).responseJSON { response in
                KRProgressHUD.dismiss()
                switch(response.result) {
                case .success:
                    completion(true, nil)
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
    
    func EditPitches(withParametrs parametrs: [String: String]?,UploadType: String = "",completion: @escaping(Bool, String?)->()){
        KRProgressHUD.show()
        var url = ""
        if UploadType == "Market"{
            url = Endpoints.EditMarketProduct
        }
        else if UploadType == "Court"{
            url = Endpoints.ProviderEditCourt
        }
        else if UploadType == "Cources"{
            url = Endpoints.ProviderEditCourse
        }
        else{
            completion(false, "Select Valid Type To Upload.")
        }
        Alamofire.request(url, method: .post, parameters: parametrs, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    //Delete Provider court
    func DeleteProviderCourt(withID UserID: String = "",Court_Id: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserID,"court_id":Court_Id]
        Alamofire.request(Endpoints.DeleteProviderCourt, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "\(json["data"] as? String ?? "")")
                    }
                    else{
                        completion(false, "\(json["data"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    //Delete Provider court Image
    func DeleteProviderCourtImage(Court_Id: String = "",ImageName: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["court_id":Court_Id,"image_name":ImageName]
        Alamofire.request(Endpoints.DeleteCourtImage, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "\(json["data"] as? String ?? "")")
                    }
                    else{
                        completion(false, "\(json["data"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    //Upload Provider court Image
    func UploadProviderCourtImage(Court_Id: String = "",photo: [UIImage?], completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let parametrs:[String:String] = ["court_id":Court_Id]
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
            }, usingThreshold: 1, to: Endpoints.UploadCourtImages, method: .post, headers: nil, encodingCompletion: { encoding in
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
    
    //Upload Provider Market Image
    func UploadProviderMarketImage(product_id: String = "",photo: [UIImage?], completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let parametrs:[String:String] = ["product_id":product_id]
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
                for (key, value) in parametrs
                {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
            }, usingThreshold: 1, to: Endpoints.UploadMarketImages, method: .post, headers: nil, encodingCompletion: { encoding in
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
    
    //Delete Provider Market Category
    func DeleteProviderMarketCategory(withID UserID: String = "",M_Cat_Id: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserID,"m_cat_id":M_Cat_Id]
        Alamofire.request(Endpoints.DeleteMarketCategory, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "\(json["data"] as? String ?? "")")
                    }
                    else{
                        completion(false, "\(json["data"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    //Delete Provider Market Product
    func DeleteProviderMarket(withID UserID: String = "",MProductId: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserID,"m_product_id":MProductId]
        Alamofire.request(Endpoints.DeleteMarketProduct, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "\(json["data"] as? String ?? "")")
                    }
                    else{
                        completion(false, "\(json["data"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    //MARK: Provider Detail Court
    func GetProviderCourtDetail(Court_Id: String = "", completion:@escaping([ProviderDetailData?], String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["court_id":Court_Id]
        Alamofire.request(Endpoints.GetProviderCourt, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(ProviderDetailRoot.self, from: data!)
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
    
    //MARK: Provider Detail Cources
    func GetProviderCourcesDetail(Cources_Id: String = "", completion:@escaping([ProviderCourcesDetailData?], String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["course_id":Cources_Id]
        Alamofire.request(Endpoints.GetProviderCourse, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(ProviderCourcesDetailRoot.self, from: data!)
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
    
    //Delete Provider Cources
    func DeleteProviderCources(withID UserID: String = "",Cources_ID: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserID,"course_id":Cources_ID]
        Alamofire.request(Endpoints.DeleteProviderCourse, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "\(json["data"] as? String ?? "")")
                    }
                    else{
                        completion(false, "\(json["data"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    //MARK: Sport Cagetory Market
    func GetMarketCategory(withID UserID: String = "", completion:@escaping([MarketCategoryData?], String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserID]
        Alamofire.request(Endpoints.GetProviderMarketCategoryList, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(MarketCategoryRoot.self, from: data!)
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
    
    //MARK: Get Market Product By Category...
    func GetMarketProductByCategory(withID M_Cat_Id: String = "", completion:@escaping([ProviderMarketProductData?], String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["m_cat_id":M_Cat_Id]
        Alamofire.request(Endpoints.ProviderMarketProductListByCat, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(ProviderMarketProductListRoot.self, from: data!)
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
    
    //MARK: Get Market Product Detail
    func GetMarketProductDetail(withID UserID: String = "",M_Product_Id: String = "", completion:@escaping(ProviderProductDetailData?, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserID,"m_product_id":M_Product_Id]
        Alamofire.request(Endpoints.GetProviderMarketProduct, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(ProviderProductDetailRoot.self, from: data!)
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
    //Delete Provider Cources
    func DeleteProviderMarketProductImage(withID market_product_meta_id: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["market_product_meta_id":market_product_meta_id]
        Alamofire.request(Endpoints.DeleteMarketImages, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "\(json["data"] as? String ?? "")")
                    }
                    else{
                        completion(false, "\(json["data"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    //Add Provider Market Category
    func AddMarketCategory(withID UserID: String = "",M_Cat_Name: String = "",M_Cat_Slug: String = "",Is_Active: String,isEdit: Bool,M_Cat_Id: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        var param:[String:String] = [:]
        var url = ""
        if isEdit{
            url = Endpoints.EditMarketCategory
            param = ["user_id":UserID,"m_cat_name":M_Cat_Name,"m_cat_slug":M_Cat_Slug,"is_active":Is_Active,"m_cat_id":M_Cat_Id]
        }
        else{
            url = Endpoints.AddMarketCategory
            param = ["user_id":UserID,"m_cat_name":M_Cat_Name,"m_cat_slug":M_Cat_Slug,"is_active":Is_Active]
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
    
    //Upload Provider Cources icon and Image
    func UploadProviderCourcesIconImage(course_id: String = "",Image: UIImage?,Icon: UIImage?, completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let parametrs:[String:String] = ["course_id":course_id]
        if Image != nil{
            Alamofire.upload(multipartFormData: { multipartFormData in
                if let imageData = UIImageJPEGRepresentation(Image!, 0.5)
                {
                    multipartFormData.append(imageData, withName: "cover_photo", fileName: "image.jpg", mimeType: "image/*")
                }
                for (key, value) in parametrs
                {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
            }, usingThreshold: 1, to: Endpoints.UploadCourseImages, method: .post, headers: nil, encodingCompletion: { encoding in
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
        else if Icon != nil{
            Alamofire.upload(multipartFormData: { multipartFormData in
                if let imageData = UIImageJPEGRepresentation(Icon!, 0.5)
                {
                    multipartFormData.append(imageData, withName: "icon", fileName: "image.jpg", mimeType: "image/*")
                }
                for (key, value) in parametrs
                {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
            }, usingThreshold: 1, to: Endpoints.UploadCourseIcon, method: .post, headers: nil, encodingCompletion: { encoding in
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
    
    
    //Provider Change Category...
    func ProviderChangeCategory(withID UserID: String = "",Category_id: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserID,"category_id":Category_id]
        Alamofire.request(Endpoints.ChangeProviderCategory, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "\(json["data"] as? String ?? "")")
                    }
                    else{
                        completion(false, "\(json["data"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    //Delete Provider Review
    func DeleteReview(withID param:[String:String],ReviewType: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        var url = ""
        if ReviewType == "court"{
            url = Endpoints.DeleteReviewCourt
        }
        else if ReviewType == "cources"{
            url = Endpoints.DeleteReviewCourse
        }
        else{
           url = ""
        }
        Alamofire.request(url, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "\(json["data"] as? String ?? "")")
                    }
                    else{
                        completion(false, "\(json["data"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
}
