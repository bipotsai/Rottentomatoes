# Uncomment this line to define a global platform for your project
# platform :ios, '6.0'

target 'Rottentomatoes' do
   pod "AFNetworking"
   pod "SVProgressHUD"
end

target 'RottentomatoesTests' do

end

post_install do |installer_representation|
    installer_representation.project.targets.each do |target|
        if target.to_s.include? 'Pods'
            target.build_configurations.each do |config|
                if !config.to_s.include? 'Debug'
                    config.build_settings['CODE_SIGN_IDENTITY[sdk=iphoneos*]'] = 'iPhone Distribution'
                end
            end
        end
    end
end

