

import Foundation

struct FacilitysRoot : Codable {
    
    let data : [FacilityData]?
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
        data = try values.decodeIfPresent([FacilityData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct FacilityData : Codable {
    
    let createdAt : String?
    let facilityIcon : String?
    let facilityId : String?
    let facilityImage : String?
    let facilityName : String?
    let isActive : String?
    let isDelete : String?
    let updatedAt : String?
    var isSelected : Bool
    
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
        isSelected = false
    }
    
}
