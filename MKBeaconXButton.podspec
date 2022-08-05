#
# Be sure to run `pod lib lint MKBeaconXButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKBeaconXButton'
  s.version          = '0.0.1'
  s.summary          = 'A short description of MKBeaconXButton.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/mokotechnology/MK-Button-iOS_SDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aadyx2007@163.com' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/mokotechnology/MK-Button-iOS_SDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'MKBeaconXButton/Classes/**/*'
  
  s.resource_bundles = {
    'MKBeaconXButton' => ['MKBeaconXButton/Assets/*.png']
  }
  
  s.subspec 'ApplicationModule' do |ss|
    ss.source_files = 'MKBeaconXButton/Classes/ApplicationModule/**'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'ConnectManager' do |ss|
    ss.source_files = 'MKBeaconXButton/Classes/ConnectManager/**'
    
    ss.dependency 'MKBeaconXButton/SDK'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKBeaconXButton/Classes/CTMediator/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'CTMediator'
  end
  
  s.subspec 'SDK' do |ss|
    ss.source_files = 'MKBeaconXButton/Classes/SDK/**'
    
    ss.dependency 'MKBaseBleModule'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKBeaconXButton/Classes/Target/**'
    
    ss.dependency 'MKBeaconXButton/Functions'
  end
  
  s.subspec 'Expand' do |ss|
    ss.subspec 'View' do |sss|
      sss.subspec 'NTPickerView' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Expand/View/NTPickerView/**'
      end
      sss.subspec 'DeviceIDCell' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Expand/View/DeviceIDCell/**'
      end
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
  end
  
  
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AboutPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AboutPage/Controller/**'
      end
    end
    
    ss.subspec 'AccelerationPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AccelerationPage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/AccelerationPage/Model'
        ssss.dependency 'MKBeaconXButton/Functions/AccelerationPage/View'
      
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AccelerationPage/Model/**'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AccelerationPage/View/**'
      end
    end
    
    ss.subspec 'AlarmDataExportPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AlarmDataExportPage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/AlarmDataExportPage/View'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AlarmDataExportPage/View/**'
      end
    end
    
    ss.subspec 'AlarmEventPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AlarmEventPage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/AlarmEventPage/Model'
        ssss.dependency 'MKBeaconXButton/Functions/AlarmEventPage/View'
        
        ssss.dependency 'MKBeaconXButton/Functions/AlarmDataExportPage/Controller'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AlarmEventPage/View/**'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AlarmEventPage/Model/**'
      end
    end
    
    ss.subspec 'AlarmModeConfigPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AlarmModeConfigPage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/AlarmModeConfigPage/Model'
        ssss.dependency 'MKBeaconXButton/Functions/AlarmModeConfigPage/View'
        
        ssss.dependency 'MKBeaconXButton/Functions/AlarmNotiTypePage/Controller'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AlarmModeConfigPage/View/**'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AlarmModeConfigPage/Model/**'
      end
    end
    
    ss.subspec 'AlarmNotiTypePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AlarmNotiTypePage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/AlarmNotiTypePage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AlarmNotiTypePage/Model/**'
      end
    end
    
    ss.subspec 'AlarmPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AlarmPage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/AlarmPage/Model'
        
        ssss.dependency 'MKBeaconXButton/Functions/AlarmModeConfigPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/AlarmPage/Model/**'
      end
    end
    
    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/DeviceInfoPage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/DeviceInfoPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/DeviceInfoPage/Model/**'
      end
    end
    
    ss.subspec 'DevicePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/DevicePage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/DevicePage/Model'
        
        ssss.dependency 'MKBeaconXButton/Functions/QuickSwitchPage/Controller'
        ssss.dependency 'MKBeaconXButton/Functions/UpdatePage/Controller'
        ssss.dependency 'MKBeaconXButton/Functions/DeviceInfoPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/DevicePage/Model/**'
      end
    end
    
    ss.subspec 'DismissConfigPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/DismissConfigPage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/DismissConfigPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/DismissConfigPage/Model/**'
      end
    end
    
    ss.subspec 'PowerSavePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/PowerSavePage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/PowerSavePage/Model'
        ssss.dependency 'MKBeaconXButton/Functions/PowerSavePage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/PowerSavePage/View/**'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/PowerSavePage/Model/**'
      end
    end
    
    ss.subspec 'QuickSwitchPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/QuickSwitchPage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/QuickSwitchPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/QuickSwitchPage/Model/**'
      end
    end
    
    ss.subspec 'RemoteReminderPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/RemoteReminderPage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/RemoteReminderPage/Model'
        ssss.dependency 'MKBeaconXButton/Functions/RemoteReminderPage/View'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/RemoteReminderPage/View/**'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/RemoteReminderPage/Model/**'
      end
    end
    
    ss.subspec 'ScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/ScanPage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/ScanPage/Model'
        ssss.dependency 'MKBeaconXButton/Functions/ScanPage/View'
        ssss.dependency 'MKBeaconXButton/Functions/ScanPage/Adopter'
        
        ssss.dependency 'MKBeaconXButton/Functions/TabBarPage/Controller'
        ssss.dependency 'MKBeaconXButton/Functions/AboutPage/Controller'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/ScanPage/View/**'
        
        ssss.dependency 'MKBeaconXButton/Functions/ScanPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/ScanPage/Model/**'
      end
      
      sss.subspec 'Adopter' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/ScanPage/Adopter/**'
        
        ssss.dependency 'MKBeaconXButton/Functions/ScanPage/Model'
        ssss.dependency 'MKBeaconXButton/Functions/ScanPage/View'
      end
    end
    
    ss.subspec 'SettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/SettingPage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/SettingPage/Model'
        
        ssss.dependency 'MKBeaconXButton/Functions/AlarmEventPage/Controller'
        ssss.dependency 'MKBeaconXButton/Functions/DismissConfigPage/Controller'
        ssss.dependency 'MKBeaconXButton/Functions/RemoteReminderPage/Controller'
        ssss.dependency 'MKBeaconXButton/Functions/AccelerationPage/Controller'
        ssss.dependency 'MKBeaconXButton/Functions/PowerSavePage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/SettingPage/Model/**'
      end
    end
    
    ss.subspec 'TabBarPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/TabBarPage/Controller/**'
        
        ssss.dependency 'MKBeaconXButton/Functions/AlarmPage/Controller'
        ssss.dependency 'MKBeaconXButton/Functions/SettingPage/Controller'
        ssss.dependency 'MKBeaconXButton/Functions/DevicePage/Controller'
      end
    end
    
    ss.subspec 'UpdatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/UpdatePage/Controller/**'
      
        ssss.dependency 'MKBeaconXButton/Functions/UpdatePage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconXButton/Classes/Functions/UpdatePage/Model/**'
      end
    
      sss.dependency 'iOSDFULibrary'
    end
    
    ss.dependency 'MKBeaconXButton/SDK'
    ss.dependency 'MKBeaconXButton/CTMediator'
    ss.dependency 'MKBeaconXButton/ConnectManager'
    ss.dependency 'MKBeaconXButton/Expand'
  
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'MKBeaconXCustomUI'
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
    
  end
  
end
