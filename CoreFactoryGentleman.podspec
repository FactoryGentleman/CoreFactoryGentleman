Pod::Spec.new do |s|
  s.name = 'CoreFactoryGentleman'
  s.version = '0.1.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'A simple library to help define CoreData model factories for use when testing your iOS/Mac applications with a data store.'

  s.homepage = 'https://github.com/SoundCloud/CoreFactoryGentleman'
  s.author = {
    'Michael England' => 'mg.england@gmail.com'
  }
  s.source = { :git => 'https://github.com/soundcloud/CoreFactoryGentleman.git', :tag => s.version.to_s }

  s.source_files = 'Classes/CoreFactoryGentleman/*.{h,m}'
  s.public_header_files = 'Classes/CoreFactoryGentleman/*.h'

  s.dependency 'FactoryGentleman', '~> 1.2.2'
  s.frameworks = 'CoreData'
  s.requires_arc = true
end
