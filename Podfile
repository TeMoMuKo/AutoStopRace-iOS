platform :ios, '9.0'

target 'Auto Stop Race' do
    use_frameworks!

    pod 'RxSwift', '~> 4.1.1'
    pod 'RxCocoa', '~> 4.1.1'
    pod 'SnapKit'
    
    pod 'Moya'
    
    pod 'CSV.swift'
    pod 'Moya-ObjectMapper'

    pod 'ObjectMapper+Realm'

    pod 'RealmSwift'
    pod 'GoogleMaps'
    pod 'RxReachability', :git => 'https://github.com/ivanbruel/RxReachability.git'
    pod 'ReachabilitySwift'

    pod 'Eureka', '~> 4.1.1'
    
    pod 'SKPhotoBrowser'

    pod 'Fabric'
    pod 'Crashlytics'

    pod 'SwiftLint'

    target 'Auto Stop RaceTests' do
    inherit! :search_paths
    # Pods for testing
    end

    target 'Auto Stop RaceUITests' do
    inherit! :search_paths
    # Pods for testing
    end

    post_install do |installer|
        installer.pods_project.targets.each do |target|
            if target.name == 'Eureka'
                target.build_configurations.each do |config|
                    config.build_settings['SWIFT_VERSION'] = '4.1'
                end
            end
        end
    end
end
