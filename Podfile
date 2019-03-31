source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

target 'Auto Stop Race' do
    use_frameworks!
    
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'SnapKit'
    
    pod 'Moya'
    
    pod 'CSV.swift'
    pod 'Moya-ObjectMapper'

    pod 'RealmSwift'
    pod 'GoogleMaps'
    pod 'RxReachability'
    pod 'ReachabilitySwift'

    pod 'Eureka'
    
    pod 'SKPhotoBrowser'

    pod 'Fabric'
    pod 'Crashlytics'

    pod 'Firebase/Core'
    pod 'Firebase/Messaging'
    pod 'Firebase/Crash'

    pod 'KeychainAccess'
    pod 'Kingfisher', '~> 5.0'
    
    target 'Auto Stop RaceTests' do
    inherit! :search_paths
    # Pods for testing
    end

    target 'Auto Stop RaceUITests' do
    inherit! :search_paths
    # Pods for testing
    end
end

target 'Networking' do
  workspace 'Auto Stop Race.xcworkspace'
  project 'Networking/Networking.xcodeproj'
  use_frameworks!

  pod 'RealmSwift'
  pod 'KeychainAccess'
end


target 'NetworkingTests' do
  workspace 'Auto Stop Race.xcworkspace'
  project 'Networking/Networking.xcodeproj'
  use_frameworks!

  pod 'Quick'
  pod 'Nimble'
end
