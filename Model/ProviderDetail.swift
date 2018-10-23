
struct ProviderDetailRoot : Codable {
    
    let data : [ProviderDetailData]?
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
        data = try values.decodeIfPresent([ProviderDetailData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}
struct ProviderDetailData : Codable {
    
    let bookingOnline : String?
    let city : String?
    let country : String?
    let courtId : String?
    let courtImage : String?
    let courtTitle : String?
    let createdAt : String?
    let createdBy : String?
    let descriptionField : String?
    let facilities : [FacilityData]?
    let images : [ProviderImage]?
    let isActive : String?
    let isDelete : String?
    let isRecommended : String?
    let latitude : String?
    let location : String?
    let longitude : String?
    let price : String?
    let sportDetails : [SportCategoryData]?
    let sportIds : String?
    let subCategories : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case bookingOnline = "booking_online"
        case city = "city"
        case country = "country"
        case courtId = "court_id"
        case courtImage = "court_image"
        case courtTitle = "court_title"
        case createdAt = "created_at"
        case createdBy = "created_by"
        case descriptionField = "description"
        case facilities = "facilities"
        case images = "images"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case isRecommended = "is_recommended"
        case latitude = "latitude"
        case location = "location"
        case longitude = "longitude"
        case price = "price"
        case sportDetails = "sport_details"
        case sportIds = "sport_ids"
        case subCategories = "sub_categories"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingOnline = try values.decodeIfPresent(String.self, forKey: .bookingOnline)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        courtId = try values.decodeIfPresent(String.self, forKey: .courtId)
        courtImage = try values.decodeIfPresent(String.self, forKey: .courtImage)
        courtTitle = try values.decodeIfPresent(String.self, forKey: .courtTitle)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        facilities = try values.decodeIfPresent([FacilityData].self, forKey: .facilities)
        images = try values.decodeIfPresent([ProviderImage].self, forKey: .images)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        isRecommended = try values.decodeIfPresent(String.self, forKey: .isRecommended)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        sportDetails = try values.decodeIfPresent([SportCategoryData].self, forKey: .sportDetails)
        sportIds = try values.decodeIfPresent(String.self, forKey: .sportIds)
        subCategories = try values.decodeIfPresent(String.self, forKey: .subCategories)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}

struct ProviderSportOffer : Codable {
    
    let categoryId : String?
    let categoryItemId : String?
    let createdAt : String?
    let createdBy : String?
    let descriptionField : String?
    let discount : String?
    let discountType : String?
    let image : String?
    let isActive : String?
    let isDelete : String?
    let offerId : String?
    let referenceId : String?
    let sportId : String?
    let updatedAt : String?
    let validFrom : String?
    let validTo : String?
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case categoryItemId = "category_item_id"
        case createdAt = "created_at"
        case createdBy = "created_by"
        case descriptionField = "description"
        case discount = "discount"
        case discountType = "discount_type"
        case image = "image"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case offerId = "offer_id"
        case referenceId = "reference_id"
        case sportId = "sport_id"
        case updatedAt = "updated_at"
        case validFrom = "valid_from"
        case validTo = "valid_to"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        categoryItemId = try values.decodeIfPresent(String.self, forKey: .categoryItemId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        discountType = try values.decodeIfPresent(String.self, forKey: .discountType)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        offerId = try values.decodeIfPresent(String.self, forKey: .offerId)
        referenceId = try values.decodeIfPresent(String.self, forKey: .referenceId)
        sportId = try values.decodeIfPresent(String.self, forKey: .sportId)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        validFrom = try values.decodeIfPresent(String.self, forKey: .validFrom)
        validTo = try values.decodeIfPresent(String.self, forKey: .validTo)
    }
    
}

struct ProviderAvailableDatetime : Codable {
    
    let availableTime : [ProviderAvailableTime]?
    let bookAvailDate : String?
    
    enum CodingKeys: String, CodingKey {
        case availableTime = "available_time"
        case bookAvailDate = "book_avail_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        availableTime = try values.decodeIfPresent([ProviderAvailableTime].self, forKey: .availableTime)
        bookAvailDate = try values.decodeIfPresent(String.self, forKey: .bookAvailDate)
    }
    
}

struct ProviderAvailableTime : Codable {
    
    let bookAvailDate : String?
    let bookAvailId : String?
    let bookAvailTime : String?
    let createdAt : String?
    let isAvailable : Int?
    let referenceId : String?
    let sportId : String?
    let type : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case bookAvailDate = "book_avail_date"
        case bookAvailId = "book_avail_id"
        case bookAvailTime = "book_avail_time"
        case createdAt = "created_at"
        case isAvailable = "is_available"
        case referenceId = "reference_id"
        case sportId = "sport_id"
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
        sportId = try values.decodeIfPresent(String.self, forKey: .sportId)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}

struct ProviderImage : Codable {
    
    let id : String?
    let image : String?
    let imageName : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case imageName = "image_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        imageName = try values.decodeIfPresent(String.self, forKey: .imageName)
    }
    
}

