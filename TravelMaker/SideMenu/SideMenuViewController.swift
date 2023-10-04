//
//  SideViewController.swift
//  TravelMaker
//
//  Created by 정태영 on 2023/09/25.
//

import UIKit
import GoogleSignIn
import FirebaseAuth


class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var imgLoadImage: UIImageView!
    @IBOutlet weak var lblLoadName: UILabel!
    @IBOutlet weak var lblLoadEmail: UILabel!
    
    @IBOutlet weak var lblModeStatus: UILabel!
    @IBOutlet weak var swMode: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgLoadImage.image = DataLoad.profile
        lblLoadName.text = DataLoad.name
        lblLoadEmail.text = DataLoad.email
        
        setupDarkMode()
        setupSwitchState()


//        loadProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupDarkMode()
        setupSwitchState()
    }


    func setupDarkMode() {
        if let appearance = UserDefaults.standard.string(forKey: "Appearance") {
            if appearance == "Dark" {
                lblModeStatus.text = "다크모드"
                self.overrideUserInterfaceStyle = .dark
            } else {
                lblModeStatus.text = "기본모드"
                self.overrideUserInterfaceStyle = .light
            }
        }
    }
    
    func setupSwitchState() {
        if let switchState = UserDefaults.standard.value(forKey: "SwitchState") as? Bool {
            swMode.isOn = switchState
            updateModeStatusLabel(isDarkMode: switchState)
        }
    }

    // 라벨 업데이트
    func updateModeStatusLabel(isDarkMode: Bool) {
        if isDarkMode {
            lblModeStatus.text = "다크모드"
        } else {
            lblModeStatus.text = "기본모드"
        }
    }
    
    
    @IBAction func modeSwitch(_ sender: UISwitch) {
        if sender.isOn { // 스위치가 켜진경우
            updateModeStatusLabel(isDarkMode: true)
            self.overrideUserInterfaceStyle = .dark
        } else { // 스위치가 꺼진경우
            updateModeStatusLabel(isDarkMode: false)
            self.overrideUserInterfaceStyle = .light
        }
         UserDefaults.standard.set(sender.isOn, forKey: "SwitchState")
         UserDefaults.standard.set(sender.isOn ? "Dark" : "Light", forKey: "Appearance")
    }
    
    
    
    // 데이터를 불러와 UI에 설정하는 함수
//    func loadUserData(_ dataLoad: DataLoad) {
//        if let profilePicUrl = dataLoad.profile1,
//           let fullName = dataLoad.name1,
//           let emailAddress = dataLoad.email1 {
//            DispatchQueue.global().async {
//                if let data = try? Data(contentsOf: profilePicUrl),
//                   let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        // 이미지 뷰에 프로필 이미지 설정
//                        self.imgLoadImage.image = image
//
//                        // 레이블에 이름과 이메일 설정
//                        self.lblLoadName.text = fullName
//                        self.lblLoadEmail.text = emailAddress
//                    }
//                }
//            }
//        }
//    }

    
} // SideMenuViewController

extension SideMenuViewController {
    // 프로필 가져오기
    func loadProfile(){
        //        guard let userData = userData else { return }
        //        imgLoadImage.image = userData.profile
        //        lblLoadName.text = userData.name
        //        lblLoadEmail.text = userData.email
    }
    func logOut() {
        GIDSignIn.sharedInstance.signOut()
        print("Logout")
        
        // Side Menu 화면을 dismiss
        self.dismiss(animated: true, completion: nil)
        
        // 다음 화면으로 이동
        let board = UIStoryboard(name: "Main", bundle: nil)
        guard let nextVC = board.instantiateViewController(withIdentifier: "LoginSB") as? LoginViewController else { return }
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .overFullScreen
        UIApplication.shared.windows.first?.rootViewController = nextVC
        
        // Firebase 로그아웃
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

extension SideMenuViewController {
    @IBAction func clickLogOut(_ sender: UIButton){
        logOut()
    }
}

