platform :ios, '9.0'

target 'Auto Stop Race' do
    use_frameworks!
    
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'SnapKit'
    
    pod 'Moya'
    
    pod 'CSV.swift'
    pod 'Moya-ObjectMapper'

    pod 'ObjectMapper+Realm'

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

    target 'Auto Stop RaceTests' do
    inherit! :search_paths
    # Pods for testing
    end

    target 'Auto Stop RaceUITests' do
    inherit! :search_paths
    # Pods for testing
    end
end

target 'NetworkingTests' do
  workspace 'Auto Stop Race.xcworkspace'
  project 'Networking/Networking.xcodeproj'
  use_frameworks!

  pod 'Quick'
  pod 'Nimble'
end
