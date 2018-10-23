

import Foundation
import UIKit
import KYDrawerController

struct Constants {
    struct Colors {
        public static let MainColor = UIColor.colorFromHex(hexString: "#FEC63D")
    }
    static let gMapKey = "AIzaSyCn32093Q6msxkDik38gOSWjeJyq0hZGF4"
    static let googleKey = "820880286508-ap84durrfsddgm6t3eutn23en5ccmlng.apps.googleusercontent.com"
   /* court - 1
    courses -2
    market -3
    offers - 4
    Social - 5
    */
}

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    //static let didCompleteTask = Notification.Name("didCompleteTask")
    //static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
}

struct Endpoints {
    static let baseURL = "https://kiyansoftech.com/sport_app/admin/public/api/v1/",
    
    getChatText = baseURL + "Common/get_chat_screen_images",    
    Register = baseURL + "Users/register",
    RegisterProvider = baseURL + "Users/register_provider",
    ProviderCategory = baseURL + "Users/provider_category",
    Login = baseURL + "Users/login",
    Verifyotp = baseURL + "Users/verifyotp_login",
    Sendotp = baseURL + "Users/sendotp",
    LoginWithFB = baseURL + "Users/fblogin",
    GetProfile = baseURL + "Users/getprofile/",
    UpdateProfile = baseURL + "Users/updateprofile",
    GetSports = baseURL + "Common/getsports",
    MarketCategories = baseURL + "Common/market_categories",
    MarketSlider = baseURL + "Common/market_slider",
    MarketProductList = baseURL + "Common/market_home_product_list",
    MarketProductFavouriteList = baseURL + "Common/market_product_favourite_list",
    MarketProductListByVendor = baseURL + "Common/market_product_list_by_vendor",
    MarketProductDetails = baseURL + "Common/market_product_details/",
    AddToBookmark = baseURL + "Common/add_to_bookmark",
    AddToFavProduct = baseURL + "Common/add_to_favourite",
    GetOfferList = baseURL + "Common/get_offer_list",
    NearbyCourt = baseURL + "Common/nearby_court",
    GetCourses = baseURL + "Common/get_courses",
    GetCourseDetails = baseURL + "Common/get_course_details",
    AddToBookmarkCourse = baseURL + "Common/add_to_bookmark_course",
    GetGroupList = baseURL + "Common/get_group_list",
    GetGroupDetails = baseURL + "Common/get_group_details",
    GetCourts = baseURL + "Common/getcourts",
    GetBookmarkList = baseURL + "Common/get_bookmark_list",
    Getcourtdetails = baseURL + "Common/getcourtdetails",
    AddToBookmarkCourt = baseURL + "Common/add_to_bookmark_court",
    JoinGroup = baseURL + "Common/join_group",
    CreateGroup = baseURL + "Common/create_group",
    InsertGroupChat = baseURL + "Common/insert_group_chat",
    InsertPersonalChat = baseURL + "Common/insert_personal_chat",
    NotificationList = baseURL + "Common/notification_list",
    GetProviderNotification = baseURL + "Common/get_provider_notification",
    Get_Booking_Available_Time = baseURL + "Common/get_booking_available_time",
    Provider_Dashboard = baseURL + "Common/provider_dashboard",
    ListMyPitch = baseURL + "Common/list_my_pitch",
    GetFacilitiesList = baseURL + "Common/get_facilities_list",
    AddMarketProduct = baseURL + "Common/add_market_product",
    EditMarketProduct = baseURL + "Common/edit_market_product",
    ProviderAddCourt = baseURL + "Common/provider_addcourt",
    ProviderAddCourse = baseURL + "Common/provider_addcourse",
    ProviderEditCourse = baseURL + "Common/provider_editcourse",
    DeleteProviderCourt = baseURL + "Common/delete_provider_court",
    DeleteCourtImage = baseURL + "Common/delete_court_image",
    UploadCourtImages = baseURL + "Common/upload_court_images",
    UploadMarketImages = baseURL + "Common/upload_market_images",
    UploadCourseImages = baseURL + "Common/upload_course_images",
    UploadCourseIcon = baseURL + "Common/upload_course_icon",
    GetProviderCourt = baseURL + "Common/get_provider_court",
    ProviderEditCourt = baseURL + "Common/provider_editcourt",
    DeleteMarketProduct = baseURL + "Common/delete_market_product",
    GetProviderCourse = baseURL + "Common/get_provider_course",
    DeleteProviderCourse = baseURL + "Common/delete_provider_course",
    DeleteMarketImages = baseURL + "Common/delete_market_images",
    GetProviderMarketCategoryList = baseURL + "Common/get_provider_market_category_list",
    DeleteMarketCategory = baseURL + "Common/delete_market_category",
    ProviderMarketProductListByCat = baseURL + "Common/provider_market_product_list_by_cat",
    AddMarketCategory = baseURL + "Common/add_market_category",
    EditMarketCategory = baseURL + "Common/edit_market_category",
    GetProviderMarketProduct = baseURL + "Common/get_provider_market_product",
    GetGroupChat = baseURL + "Common/get_group_chat",
    Get_Personal_Chat = baseURL + "Common/get_personal_chat",
    Get_Group_Member_List = baseURL + "Common/get_group_member_list",
    NotificationStatusChange = baseURL + "Common/notification_status_change",
    GetHelpSupportDetails = baseURL + "Common/get_help_support_details",
    Changepassword = baseURL + "Users/changepassword",
    
    AddCard = baseURL + "Common/add_card",
    BookCourt = baseURL + "Common/book_court",
    BookCourse = baseURL + "Common/book_course",
    GetRecentSearch = baseURL + "Common/get_recent_search",
    ChangeProviderCategory = baseURL + "Common/change_provider_category",
    ChangeChatReadStatus = baseURL + "Common/change_chat_read_status/",
    AddCourtRating = baseURL + "Common/add_court_rating",
    AddCourseRating = baseURL + "Common/add_course_rating",
    GetCourtRating = baseURL + "Common/get_court_rating",
    GetCourseRating = baseURL + "Common/get_course_rating",
    DeleteReviewCourt = baseURL + "Common/delete_review_court",
    DeleteReviewCourse = baseURL + "Common/delete_review_course"
}

final class ChangeCategoryClass  {
    
    static let shared: ChangeCategoryClass = {
        let instance = ChangeCategoryClass()
        return instance
    }()
    
    var storyboardmain = UIStoryboard(name: "Main", bundle: nil)
    var storyboardlogin = UIStoryboard(name: "Login", bundle: nil)
    var storyboardCategory = UIStoryboard(name: "Category", bundle: nil)
    var storyboardSocial = UIStoryboard(name: "Social", bundle: nil)
    var storyboardMarket = UIStoryboard(name: "Market", bundle: nil)
    var storyboardTraining = UIStoryboard(name: "Training", bundle: nil)
    var storyboardOffers = UIStoryboard(name: "Offers", bundle: nil)
    var storyBoardSlideMenu = UIStoryboard(name: "Menu", bundle: nil)
    
    func OpenCourtVC(selectedIndex: Int = 0) {
        UserDefaults.standard.set("CourtAndClub", forKey: "Category")
        UserDefaults.standard.synchronize()
        guard let tabBarVC = storyboardmain.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC,
            let slideMenuViewController = storyBoardSlideMenu.instantiateViewController(
                withIdentifier: "MenuVC") as? MenuVC else {
                    return
        }
        let mainViewController   = tabBarVC
        let drawerViewController = slideMenuViewController
        let drawerController     = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
        drawerController.mainViewController = UINavigationController.init(rootViewController: mainViewController)
        drawerController.drawerViewController = drawerViewController
        tabBarVC.selectedIndex = selectedIndex
        AppDelegate.sharedDelegate().window?.rootViewController = drawerController
    }
    
    func OpenSocialVC(selectedIndex: Int = 0) {
        UserDefaults.standard.set("Social", forKey: "Category")
        UserDefaults.standard.synchronize()
        guard let tabBarVC = storyboardSocial.instantiateViewController(withIdentifier: "SocialBarVC") as? SocialBarVC,
            let slideMenuViewController = storyBoardSlideMenu.instantiateViewController(
                withIdentifier: "MenuVC") as? MenuVC else {
                    return
        }
        let mainViewController   = tabBarVC
        let drawerViewController = slideMenuViewController
        let drawerController     = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
        drawerController.mainViewController = UINavigationController.init(rootViewController: mainViewController)
        drawerController.drawerViewController = drawerViewController
        tabBarVC.selectedIndex = selectedIndex
        AppDelegate.sharedDelegate().window?.rootViewController = drawerController
    }
    
    func OpenMarketVC(selectedIndex: Int = 0) {
        UserDefaults.standard.set("Market", forKey: "Category")
        UserDefaults.standard.synchronize()
        guard let tabBarVC = storyboardMarket.instantiateViewController(withIdentifier: "MarketBarVC") as? MarketBarVC,
            let slideMenuViewController = storyBoardSlideMenu.instantiateViewController(
                withIdentifier: "MenuVC") as? MenuVC else {
                    return
        }
        let mainViewController   = tabBarVC
        let drawerViewController = slideMenuViewController
        let drawerController     = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
        drawerController.mainViewController = UINavigationController.init(rootViewController: mainViewController)
        drawerController.drawerViewController = drawerViewController
        tabBarVC.selectedIndex = selectedIndex
        AppDelegate.sharedDelegate().window?.rootViewController = drawerController
    }
    
    func OpenTrainingVC(selectedIndex: Int = 0) {
        UserDefaults.standard.set("Courses", forKey: "Category")
        UserDefaults.standard.synchronize()
        guard let tabBarVC = storyboardTraining.instantiateViewController(withIdentifier: "TrainingBarVC") as? TrainingBarVC,
            let slideMenuViewController = storyBoardSlideMenu.instantiateViewController(
                withIdentifier: "MenuVC") as? MenuVC else {
                    return
        }
        let mainViewController   = tabBarVC
        let drawerViewController = slideMenuViewController
        let drawerController     = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
        drawerController.mainViewController = UINavigationController.init(rootViewController: mainViewController)
        drawerController.drawerViewController = drawerViewController
        tabBarVC.selectedIndex = selectedIndex
        AppDelegate.sharedDelegate().window?.rootViewController = drawerController
    }
    
    func OpenOffersVC(selectedIndex: Int = 0) {
        UserDefaults.standard.set("Offers", forKey: "Category")
        UserDefaults.standard.synchronize()
        guard let tabBarVC = storyboardOffers.instantiateViewController(withIdentifier: "OffersBarVC") as? OffersBarVC,
            let slideMenuViewController = storyBoardSlideMenu.instantiateViewController(
                withIdentifier: "MenuVC") as? MenuVC else {
                    return
        }
        let mainViewController   = tabBarVC
        let drawerViewController = slideMenuViewController
        let drawerController     = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
        drawerController.mainViewController = UINavigationController.init(rootViewController: mainViewController)
        drawerController.drawerViewController = drawerViewController
        tabBarVC.selectedIndex = selectedIndex
        AppDelegate.sharedDelegate().window?.rootViewController = drawerController
    }
}

