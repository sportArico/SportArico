

import Foundation

struct BookAvailableTimeRoot : Codable {
    
    let data : [BookAvailableTimeData]?
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
        data = try values.decodeIfPresent([BookAvailableTimeData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct BookAvailableTimeData : Codable {
    
    var availableTime : [AvailableTime]?
    let bookAvailDate : String?
    var isSelected : Bool
    
    enum CodingKeys: String, CodingKey {
        case availableTime = "available_time"
        case bookAvailDate = "book_avail_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        availableTime = try values.decodeIfPresent([AvailableTime].self, forKey: .availableTime)
        bookAvailDate = try values.decodeIfPresent(String.self, forKey: .bookAvailDate)
        isSelected = false
    }
    
}

struct AvailableTime : Codable {
    
    let bookAvailDate : String?
    let bookAvailId : String?
    let bookAvailTime : String?
    let createdAt : String?
    let isAvailable : Int?
    let referenceId : String?
    let type : String?
    let updatedAt : String?
    var isSelected : Bool
    
    enum CodingKeys: String, CodingKey {
        case bookAvailDate = "book_avail_date"
        case bookAvailId = "book_avail_id"
        case bookAvailTime = "book_avail_time"
        case createdAt = "created_at"
        case isAvailable = "is_available"
        case referenceId = "reference_id"
        case type = "type"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookAvailDate = try values.decodeIfPresent(String.self, forKey: .bookAvailDate)
        bookAvailId = try values.decodeIfPresent(String.self, forKey: .bookAvailId)
        bookAvailTime = try values.decodeIfPresent(String.self, forKey: .bookAvailTime)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isAvailable = try values.decodeIfPresent(Int.self, forKey: .isAvailable)
        referenceId = try values.decodeIfPresent(String.self, forKey: .referenceId)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        isSelected = false
    }
    
}
