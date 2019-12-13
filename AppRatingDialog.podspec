#
# Be sure to run `pod lib lint AppRatingDialog.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'AppRatingDialog'
    s.version          = '0.0.4'
    s.summary          = 'AppRatingDialog is a practically framework for getting app store reviews or feedback via email.'
    
    s.homepage         = 'https://github.com/invers-gmbh/appratingdialog'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Michael Rothkegel' => 'rothkegel.michael@gmail.com' }
    s.source           = { :git => 'https://github.com/invers-gmbh/appratingdialog.git', :tag => s.version.to_s }
   
    s.swift_versions = ['5.0', '5.1']

    s.ios.deployment_target = '10.3'
    s.source_files = 'appratingdialog/Classes/**/*.swift'
    s.resources = ["appratingdialog/Assets/**/*.xib"]
end
