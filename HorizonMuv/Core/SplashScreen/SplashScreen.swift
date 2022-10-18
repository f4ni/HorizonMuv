//
//  SplashScreen.swift
//  HorizonMuv
//
//  Created by Furkan ic on 18.10.2022.
//

import UIKit
import FirebaseRemoteConfig
import Alamofire

class SplashScreen: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    private var remoteConfig = RemoteConfig.remoteConfig()
    private var timer = Timer()
    private var connectivityTimer = Timer()
    private var connectivity = Alamofire.NetworkReachabilityManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureConnectivity()
        
        connectivityTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(configureConnectivity), userInfo: nil, repeats: true)

        connectivityTimer.fire()
        
    }

    @objc
    func configureConnectivity(){
        
        print("connectivity")
        connectivity?.startListening(onUpdatePerforming: { status in
            switch status {

            case .unknown:
                break
            case .notReachable:
                self.messageLabel.text = "İnternet Bağlantısı Yok"
            case .reachable(_):
                self.configureAndFetchRemoteConfig()
                self.navigateToMainScreenfter(seconds: 3)
            }
        })
        
    }
    
    
    func navigateToMainScreenfter( seconds: Int){
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(seconds), target: self, selector: #selector(navigateToMainScreen), userInfo: nil, repeats: false)
    }
    
    @objc
    func navigateToMainScreen(){
        
        guard let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let sceneDelegate = windowsScene.delegate as? SceneDelegate else { return }
        if let window = sceneDelegate.window {
            
            timer.invalidate()
            connectivityTimer.invalidate()
            
            window.rootViewController = UINavigationController(rootViewController: MainScreen())
            window.makeKeyAndVisible()
        }
    }
    
    func configureAndFetchRemoteConfig(){
        
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0
        remoteConfig.configSettings = setting
        remoteConfig.setDefaults(fromPlist: "remote_config_defaults")
        
        remoteConfig.fetchAndActivate { status, error in
            self.messageLabel.text = self.remoteConfig.configValue(forKey: "splashScreenMessage").stringValue
        }
        
    }
}
