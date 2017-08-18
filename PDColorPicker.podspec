#
# Be sure to run `pod lib lint PDColorPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PDColorPicker'
  s.version          = '0.2.0'
  s.summary          = 'A clean, fast color picker for iOS apps.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'PDColorPicker provides the ability to easily add a color selection interface to an iOS app. 
                        The provided view allows the user to select any 16-bit color by sliding across the different hue, 
                        saturation, and brightness values. The user interface\'s colors and fonts are easily customized
                        to suit the appearance of any app in which PDColorPicker is used.'

  s.homepage         = 'https://github.com/pdil/PDColorPicker'
  s.screenshots      = 'https://raw.githubusercontent.com/pdil/PDColorPicker/master/Resources/colorpicker.jpg', 'https://raw.githubusercontent.com/pdil/PDColorPicker/master/Resources/example.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Paolo Di Lorenzo' => 'paolo@dilorenzo.pl' }
  s.source           = { :git => 'https://github.com/pdil/PDColorPicker.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dilorenzopl'

  s.ios.deployment_target = '9.0'

  s.source_files = 'PDColorPicker/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PDColorPicker' => ['PDColorPicker/Assets/*.png']
  # }

  s.frameworks = 'UIKit'
end
