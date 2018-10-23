

import Foundation

struct ListMyPitchRoot : Codable {
    
    let data : [ListMyPitchData]?
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
        data = try values.decodeIfPresent([ListMyPitchData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct ListMyPitchData : Codable {
    
    let id : String?
    let pitchName : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case pitchName = "pitch_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        pitchName = try values.decodeIfPresent(String.self, forKey: .pitchName)
    }
    
}
