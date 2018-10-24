#
# Be sure to run `pod lib lint PDColorPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PDColorPicker'
  s.version          = '0.8.1'
  s.summary          = 'A simple, fast color picker for iOS apps.'

  s.description      = <<-DESC
                        PDColorPicker provides the ability to easily add a color selection interface to an iOS app.
                        The provided view allows the user to select any 16-bit color by sliding across the different hue, 
                        saturation, and brightness values. The user interface\'s colors and fonts are easily customized
                        to suit the appearance of any app in which PDColorPicker is used.'
                       DESC

  s.screenshots      = 'https://raw.githubusercontent.com/pdil/PDColorPicker/master/Resources/demo.gif', 'https://raw.githubusercontent.com/pdil/PDColorPicker/master/Resources/drag-drop-demo.gif'

  s.homepage         = 'https://dilorenzo.pl/pkgs/PDColorPicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'Paolo Di Lorenzo' => 'paolo@dilorenzo.pl' }
  s.source           = { :git => 'https://github.com/pdil/PDColorPicker.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dilorenzopl'

  s.ios.deployment_target = '9.0'

  s.source_files = 'PDColorPicker/**/*'

  s.frameworks = 'UIKit'
end
