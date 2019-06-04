Pod::Spec.new do |s|
  s.name          = "MightyTabBar"
  s.version       = "1.0.0"
  s.summary       = "A customizable TabBar menu that holds more than 5 items."
  s.description   = "MightyTabBar is a customizable TabBar that also doubles as a menu drawer. Instead of a hamburger menu, MightyTabBar allows your app to have up to 30 tab bar items, all positioned within the thumb zone and easily accessible via swipe up."
  s.homepage      = "https://github.com/timshim/MightyTabBar"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "Tim Shim" => "timshim@gmail.com" }
  s.platform      = :ios, "11.0"
  s.source        = { :git => "https://github.com/timshim/MightyTabBar.git", :tag => "#{s.version}" }
  s.source_files  = "MightyTabBar"
  s.swift_version = "4.2"
end