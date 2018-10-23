

import Foundation

struct CourtDetailRoot : Codable {
    
    let data : CourtDetailData?
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
        data = try values.decodeIfPresent(CourtDetailData.self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct CourtDetailData : Codable {
    
    let city : String?
    let country : String?
    let courtId : String?
    let courtTitle : String?
    let createdAt : String?
    let createdBy : String?
    let descriptionField : String?
    let distance : String?
    let facilities : [CourtDetailFacility]?
    let images : [CourtDetailImage]?
    let isActive : String?
    let isDelete : String?
    let isRecommended : String?
    let latitude : String?
    let location : String?
    let longitude : String?
    let price : String?
    let rating : Int?
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
        case descriptionField = "description"
        case distance = "distance"
        case facilities = "facilities"
        case images = "images"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case isRecommended = "is_recommended"
        case latitude = "latitude"
        case location = "location"
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
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        facilities = try values.decodeIfPresent([CourtDetailFacility].self, forKey: .facilities)
        images = try values.decodeIfPresent([CourtDetailImage].self, forKey: .images)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        isRecommended = try values.decodeIfPresent(String.self, forKey: .isRecommended)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
        sportIds = try values.decodeIfPresent(String.self, forKey: .sportIds)
        subCategories = try values.decodeIfPresent(String.self, forKey: .subCategories)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}
struct CourtDetailImage : Codable {
    
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
}
struct CourtDetailFacility : Codable {
    
    let createdAt : String?
    let facilityIcon : String?
    let facilityId : String?
    let facilityImage : String?
    let facilityName : String?
    let isActive : String?
    let isDelete : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case facilityIcon = "facility_icon"
        case facilityId = "facility_id"
        case facilityImage = "facility_image"
        case facilityName = "facility_name"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        facilityIcon = try values.decodeIfPresent(String.self, forKey: .facilityIcon)
        facilityId = try values.decodeIfPresent(String.self, forKey: .facilityId)
        facilityImage = try values.decodeIfPresent(String.self, forKey: .facilityImage)
        facilityName = try values.decodeIfPresent(String.self, forKey: .facilityName)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}
