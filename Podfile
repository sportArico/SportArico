# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SprotsArico' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SprotsArico
	pod 'CountryPickerView'
    pod 'IQKeyboardManagerSwift'
    pod 'KYDrawerController'
    pod 'ImageSlideshow'
    pod 'KRProgressHUD', '~> 3.1.2'
    pod 'Alamofire', '~> 4.5.1'
    pod 'SDWebImage'
    pod 'RMPickerViewController', '~> 2.3.1'
    pod 'XLPagerTabStrip', '~> 8.0'
    pod 'RangeSeekSlider'
    pod 'Cosmos'
    
    pod 'FacebookCore'
    pod 'FacebookLogin'
    pod 'FacebookShare'
    
    pod 'GoogleMaps'
    pod 'GooglePlaces'
    pod 'GoogleSignIn'
    
    pod 'Firebase/Core'
    pod 'FirebaseInstanceID', '2.0.0'
    pod 'Firebase/Messaging'
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'DropDown'
    pod 'CreditCardValidator'
    pod 'OpalImagePicker'
    pod 'TTTAttributedLabel'

  target 'SprotsAricoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SprotsAricoUITests' do
    inherit! :search_paths
    # Pods for testing
  end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
 end   
end
