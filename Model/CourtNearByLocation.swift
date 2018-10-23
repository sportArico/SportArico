

import Foundation

struct NearByLocationRoot : Codable {
    
    let data : [NearByLocationData]?
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
        data = try values.decodeIfPresent([NearByLocationData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct NearByLocationData : Codable {
    
    let city : String?
    let country : String?
    let courtId : String?
    let courtTitle : String?
    let createdAt : String?
    let createdBy : String?
    let distance : String?
    let facilities : String?
    let images : [NearByLocationImage]?
    let isActive : String?
    let isDelete : String?
    let isRecommended : String?
    let latitude : String?
    let longitude : String?
    let price : String?
    let rating : Float?
    let sportIds : String?
    let subCategories : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case country = "country"
        case courtId = "court_id"
        case courtTitle = "court_title"
        case createdAt = "created_at"
        case createdBy = "created_by"
        case distance = "distance"
        case facilities = "facilities"
        case images = "images"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case isRecommended = "is_recommended"
        case latitude = "latitude"
        case longitude = "longitude"
        case price = "price"
        case rating = "rating"
        case sportIds = "sport_ids"
        case subCategories = "sub_categories"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        courtId = try values.decodeIfPresent(String.self, forKey: .courtId)
        courtTitle = try values.decodeIfPresent(String.self, forKey: .courtTitle)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        facilities = try values.decodeIfPresent(String.self, forKey: .facilities)
        images = try values.decodeIfPresent([NearByLocationImage].self, forKey: .images)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        isRecommended = try values.decodeIfPresent(String.self, forKey: .isRecommended)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        rating = try values.decodeIfPresent(Float.self, forKey: .rating)
        sportIds = try values.decodeIfPresent(String.self, forKey: .sportIds)
        subCategories = try values.decodeIfPresent(String.self, forKey: .subCategories)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}

struct NearByLocationImage : Codable {
    
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
}
