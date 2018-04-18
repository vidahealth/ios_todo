# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def shared_dependencies
  pod 'RxSwift', '= 4.0.0'
  pod 'RxOptional', '= 3.3.0'
  pod 'RxSwiftExt', '= 3.0.0'
end

platform :ios, '11.3'

target 'VidaToDo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for VidaToDo
  shared_dependencies
  
  target 'VidaFoundation' do
    inherit! :search_paths
    # Pods for testing
	  pod 'Alamofire', '~> 4.6'
	  shared_dependencies
  end
  
  target 'VidaFoundationTests' do
    inherit! :search_paths
    # Pods for testing
	  pod 'Alamofire', '~> 4.6'
	  shared_dependencies
  end
  
  target 'VidaUIKit' do
    inherit! :search_paths
    # Pods for testing
	shared_dependencies
  end
  
  target 'VidaUIKitTests' do
    inherit! :search_paths
    # Pods for testing
	shared_dependencies
  end

  target 'VidaToDoTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'VidaToDoEGTests' do
    project 'VidaToDo'

    use_frameworks!
    inherit! :search_paths
    shared_dependencies
    pod 'EarlGrey', '= 1.12.0'
  end

end
