

import Foundation

struct ProviderMarketProductListRoot : Codable {
    
    let data : [ProviderMarketProductData]?
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
        data = try values.decodeIfPresent([ProviderMarketProductData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct ProviderMarketProductData : Codable {
    
    let categoryName : String?
    let createdAt : String?
    let isActive : String?
    let isDelete : String?
    let mCatId : String?
    let mProductId : String?
    let productDescription : String?
    let productImages : [ProviderMarketProductImage]?
    let productPrice : String?
    let productTitle : String?
    let recommended : String?
    let sku : String?
    let updatedAt : String?
    let vender : String?
    
    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case createdAt = "created_at"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case mCatId = "m_cat_id"
        case mProductId = "m_product_id"
        case productDescription = "product_description"
        case productImages = "product_images"
        case productPrice = "product_price"
        case productTitle = "product_title"
        case recommended = "recommended"
        case sku = "sku"
        case updatedAt = "updated_at"
        case vender = "vender"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        mCatId = try values.decodeIfPresent(String.self, forKey: .mCatId)
        mProductId = try values.decodeIfPresent(String.self, forKey: .mProductId)
        productDescription = try values.decodeIfPresent(String.self, forKey: .productDescription)
        productImages = try values.decodeIfPresent([ProviderMarketProductImage].self, forKey: .productImages)
        productPrice = try values.decodeIfPresent(String.self, forKey: .productPrice)
        productTitle = try values.decodeIfPresent(String.self, forKey: .productTitle)
        recommended = try values.decodeIfPresent(String.self, forKey: .recommended)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        vender = try values.decodeIfPresent(String.self, forKey: .vender)
    }
    
}

struct ProviderMarketProductImage : Codable {
    
    let createdAt : String?
    let image : String?
    let isActive : String?
    let marketProductId : String?
    let marketProductMetaId : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case image = "image"
        case isActive = "is_active"
        case marketProductId = "market_product_id"
        case marketProductMetaId = "market_product_meta_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        marketProductId = try values.decodeIfPresent(String.self, forKey: .marketProductId)
        marketProductMetaId = try values.decodeIfPresent(String.self, forKey: .marketProductMetaId)
    }
    
}


