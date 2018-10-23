

import Foundation

struct MarketSliderRoot : Codable {
    
    let data : [MarketSliderData]?
    let messageAr : String?
    let messageEn : String?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case messageAr = "message_ar"
        case messageEn = "message_en"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([MarketSliderData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}


struct MarketSliderData : Codable {
    
    let contactNumber : String?
    let createdAt : String?
    let isActive : String?
    let isDelete : String?
    let marketSliderId : String?
    let marketSliderImage : String?
    let marketSliderText : String?
    let marketSliderTitle : String?
    
    enum CodingKeys: String, CodingKey {
        case contactNumber = "contact_number"
        case createdAt = "created_at"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case marketSliderId = "market_slider_id"
        case marketSliderImage = "market_slider_image"
        case marketSliderText = "market_slider_text"
        case marketSliderTitle = "market_slider_title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        contactNumber = try values.decodeIfPresent(String.self, forKey: .contactNumber)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        marketSliderId = try values.decodeIfPresent(String.self, forKey: .marketSliderId)
        marketSliderImage = try values.decodeIfPresent(String.self, forKey: .marketSliderImage)
        marketSliderText = try values.decodeIfPresent(String.self, forKey: .marketSliderText)
        marketSliderTitle = try values.decodeIfPresent(String.self, forKey: .marketSliderTitle)
    }
    
}
