

import Foundation

struct SportCategoryRoot : Codable {
    
    let data : [SportCategoryData]?
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
        data = try values.decodeIfPresent([SportCategoryData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}


struct SportCategoryData : Codable {
    
    var availableDatetime : [AvailableDatetime]?
    let createdAt : String?
    let isActive : String?
    let isDelete : String?
    let sportId : String?
    let sportImage : String?
    let sportName : String?
    let sportIcon : String?
    var isSelected : Bool
    var valid_from : String?
    var valid_to : String?
    var is_offer : Int?
    var discount : String?
    
    enum CodingKeys: String, CodingKey {
        case availableDatetime = "available_datetime"
        case createdAt = "created_at"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case sportId = "sport_id"
        case sportImage = "sport_image"
        case sportName = "sport_name"
        case sportIcon = "sport_icon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        availableDatetime = try values.decodeIfPresent([AvailableDatetime].self, forKey: .availableDatetime)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        sportId = try values.decodeIfPresent(String.self, forKey: .sportId)
        sportImage = try values.decodeIfPresent(String.self, forKey: .sportImage)
        sportName = try values.decodeIfPresent(String.self, forKey: .sportName)
        sportIcon = try values.decodeIfPresent(String.self, forKey: .sportIcon)
        isSelected = false
        valid_from = ""
        valid_to = ""
        is_offer = 0
    }
    
}

struct AvailableDatetime : Codable {
    
    var availableDate : String?
    var availableTime : String?
    
    enum CodingKeys: String, CodingKey {
        case availableDate = "available_date"
        case availableTime = "available_time"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        availableDate = try values.decodeIfPresent(String.self, forKey: .availableDate)
        availableTime = try values.decodeIfPresent(String.self, forKey: .availableTime)
    }
}


struct MarketCategoryRoot : Codable {
    
    let data : [MarketCategoryData]?
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
        data = try values.decodeIfPresent([MarketCategoryData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct MarketCategoryData : Codable {
    
    let createdAt : String?
    let image : String?
    let isActive : String?
    let isDelete : String?
    let mCatId : String?
    let mCatName : String?
    let mCatSlug : String?
    let updatedAt : String?
    var isSelected : Bool
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case image = "image"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case mCatId = "m_cat_id"
        case mCatName = "m_cat_name"
        case mCatSlug = "m_cat_slug"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        mCatId = try values.decodeIfPresent(String.self, forKey: .mCatId)
        mCatName = try values.decodeIfPresent(String.self, forKey: .mCatName)
        mCatSlug = try values.decodeIfPresent(String.self, forKey: .mCatSlug)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        isSelected = false
    }
    
}
