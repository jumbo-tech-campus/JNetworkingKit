#
#  Be sure to run `pod spec lint pod spec lint JNetworkingKit.podspec.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "JNetworkingKit"
  s.version      = "1.0.0"
  s.summary      = "A generic networking setup for Swift and Objective-C."

  s.author             = "Jumbo"
  s.homepage     = "https://www.jumbo.com/"
  s.social_media_url   = "https://twitter.com/jumbotechcampus"

  s.swift_version = '4.2'
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/jumbo-tech-campus/JNetworkingKit.git", :tag => "#{s.version}" }
  s.source_files  = "JNetworkingKit/Source", "JNetworkingKit/Source/**/*.{swift}"
end
