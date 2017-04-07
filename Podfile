platform :ios, '9.0'

target 'Auto Stop Race' do
    use_frameworks!

    pod 'RxSwift', '3.2'
    pod 'RxCocoa', '3.2.0'
    pod 'SnapKit', '~> 3.2.0'
    pod 'CSV.swift'
    pod 'Moya-ObjectMapper'
    pod 'RealmSwift'
    pod 'GoogleMaps'
    pod 'RxReachability'
    pod 'Eureka'
    
    pod 'Fabric'
    pod 'Crashlytics'
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end

    target 'Auto Stop RaceTests' do
    inherit! :search_paths
    # Pods for testing
    end

    target 'Auto Stop RaceUITests' do
    inherit! :search_paths
    # Pods for testing
    end

end
