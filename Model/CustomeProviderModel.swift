

import Foundation

struct CustomeProviderModelRoot : Codable {
    
    let availableDatetime : [CustomeProviderModelAvailableDatetime]
    let discount : String
    let is_offer : Int
    let sport_id : Int
    let valid_from : String
    let valid_to : String
    let offer_title : String
    let offer_description : String
    
}

struct CustomeProviderModelAvailableDatetime : Codable {
    
    let availableDate : String
    let availableTime : String
    
}


struct CustomeProviderCourcesModelRoot : Codable {
    
    let availableDatetime : [CustomeProviderModelAvailableDatetime]
    let packages : [CustomeProviderModelpackages]
    let discount : String
    let is_offer : Int
    let sport_id : Int
    let valid_to : String
    let valid_from : String
    let offer_title : String
    let offer_description : String
}

struct CustomeProviderModelpackages : Codable {
    
    let package_name : String
    let price : String
    
}
