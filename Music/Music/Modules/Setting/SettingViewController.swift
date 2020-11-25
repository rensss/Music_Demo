//
//  SettingViewController.swift
//  Music
//
//  Created by RZK on 2020/11/22.
//

import Foundation
import MessageUI
import StoreKit

let SettingsTableViewCellIdentifier = "SettingsTableViewCellIdentifier"

class SettingViewController: BaseViewController {
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
    // MARK:- Func
    func contactUs() {

        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            
            let infoDictionary = Bundle.main.infoDictionary!
            let appDisplayName: String = infoDictionary["CFBundleDisplayName"] as? String ?? "Best Widgets"  //App 名称
            let majorVersion = infoDictionary["CFBundleShortVersionString"] as? String ?? "1.0" //主程序版本号
            let minorVersion = infoDictionary["CFBundleVersion"] as? String ?? "1001" //版本号（内部标示）
            let iosVersion = UIDevice.current.systemVersion //iOS版本
            let modelName = UIDevice.current.name //设备具体型号
            
            let messageBody = """
            App Name: \(appDisplayName)
            App Version: \(majorVersion)
            Original App Version: \(minorVersion)
            Device: \(modelName)
            OS Version: \(iosVersion)
            
            
            
            """
            
            mailVC.setSubject(appDisplayName)
            mailVC.setMessageBody(messageBody, isHTML: false)
            mailVC.setToRecipients(["admin@test.com"])
            present(mailVC, animated: true, completion: nil)
        } else {
            MBProgressHUD.showMessage(NSLocalizedString("Please log in to your email and send support mail.", comment: ""), withHideAfter: 2)
        }
    }
    
    func rateUs() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
    }
    
    func shareApp() {
        let text = NSLocalizedString("This is a swift app demo.", comment: "")
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: { () -> Void in
        })
    }

    func aboutUs() {
        let infoDictionary = Bundle.main.infoDictionary!
        let bundleName  = infoDictionary["CFBundleIdentifier"] ?? "default M.Music"
        
        let alert = UIAlertController(title: "About us", message: bundleName as? String, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { _ in
            debugPrint("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK:- Other
    
    // MARK:- LazyInit
    lazy var dataArray: [String] = {
        let array = [
            "Contact us", // (使用系统发邮件，邮箱为 admin@test.com)
            "Rate us", // (iOS 系统五星好评)
            "Share app", // (分享文案为 This is a swift app demo.)
            "About us"// (点击弹出 app 的包名信息)
        ]
        
        return array
    }()
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.rowHeight = 50
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = .clear
        t.tableFooterView = UIView()
        t.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCellIdentifier)
        return t
    }()
    
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCellIdentifier, for: indexPath) as! SettingsTableViewCell
        cell.title.text = self.dataArray[indexPath.row]
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! SettingsTableViewCell
        
        if cell.title.text == "Contact us" {
            self.contactUs()
        }
        
        if cell.title.text == "Rate us" {
            self.rateUs()
        }
        
        if cell.title.text == "Share app" {
            self.shareApp()
        }
        
        if cell.title.text == "About us" {
            self.aboutUs()
        }
    }
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            if result == .sent {
//                MBProgressHUD.showMessage(NSLocalizedString("Sent successfully", comment: ""), withHideAfter: 2.0)
                debugPrint("Sent successfully")
            } else if result == .failed {
//                MBProgressHUD.showMessage(NSLocalizedString("Sent failure", comment: ""), withHideAfter: 2.0)
                debugPrint("Sent failure")
            }
        }
    }
}
