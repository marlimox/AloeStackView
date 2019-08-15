Pod::Spec.new do |s|
  s.name     = 'AloeStackView'
  s.version  = '1.2.0'
  s.license  = 'Apache License, Version 2.0'
  s.summary  = 'A simple class for laying out a collection of views with a convenient API, while leveraging the power of Auto Layout.'
  s.homepage = 'https://github.com/airbnb/AloeStackView'
  s.authors  = 'Airbnb'
  s.source   = { :git => 'https://github.com/airbnb/AloeStackView.git', :tag => "v#{ s.version.to_s }" }
  s.swift_version = '5.0'
  s.source_files = 'Sources/**/*.{swift,h}'
  s.ios.deployment_target = '9.0'
end
