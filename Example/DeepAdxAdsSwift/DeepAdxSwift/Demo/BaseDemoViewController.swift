//
//  BaseDemoViewController.swift
//  DeepAdxSwift
//

import UIKit

enum AdState {
    case normal
    case loading
    case loadSucceed
    case loadFailed
}

class BaseDemoViewController: UIViewController {

    var isOnlyLoad = true {
        didSet {
            guard isViewLoaded else { return }
            btnLoad.isHidden = !isOnlyLoad
            btnShow.isHidden = !isOnlyLoad
        }
    }
    var isLoaded = false

    private var logText = ""

    private let btnLoad = UIButton(type: .system)
    private let btnShow = UIButton(type: .system)
    private let btnLoadAndShow = UIButton(type: .system)
    private let labNotify = UILabel()
    let textV = UITextView()

    private static let orange = UIColor(red: CGFloat(0xf5) / 255, green: CGFloat(0x82) / 255, blue: CGFloat(0x20) / 255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        logText = ""
        view.backgroundColor = .white

        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .regular)
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.standardAppearance = appearance
        }

        styleButton(btnLoad, title: "load Ad", action: #selector(loadAd))
        styleButton(btnShow, title: "show Ad", action: #selector(showAd))
        styleButton(btnLoadAndShow, title: "load and showAd", action: #selector(loadAndShowAd))

        labNotify.textColor = Self.orange
        labNotify.font = UIFont.systemFont(ofSize: 15)
        labNotify.textAlignment = .center

        textV.font = UIFont.systemFont(ofSize: 15)
        textV.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textV.textAlignment = .left
        textV.isEditable = false

        view.addSubview(btnLoad)
        view.addSubview(btnShow)
        view.addSubview(btnLoadAndShow)
        view.addSubview(labNotify)
        view.addSubview(textV)

        layoutFrames()
        btnLoad.isHidden = !isOnlyLoad
        btnShow.isHidden = !isOnlyLoad
        loadAdWithState(.normal)
    }

    private func layoutFrames() {
        btnLoad.frame = CGRect(x: 50, y: 100, width: 140, height: 40)
        btnShow.frame = CGRect(x: 50, y: 160, width: 140, height: 40)
        btnLoadAndShow.frame = CGRect(x: 50, y: 220, width: 140, height: 40)
        labNotify.frame = CGRect(x: 0, y: 280, width: view.frame.size.width, height: 40)
        let textTop = CGFloat(330)
        textV.frame = CGRect(x: 0, y: textTop, width: view.frame.size.width, height: view.frame.size.height - textTop - 20)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        labNotify.frame = CGRect(x: 0, y: 280, width: view.bounds.size.width, height: 40)
        let textTop = CGFloat(330)
        textV.frame = CGRect(x: 0, y: textTop, width: view.bounds.size.width, height: view.bounds.size.height - textTop - 20)
    }

    private func styleButton(_ b: UIButton, title: String, action: Selector) {
        b.backgroundColor = Self.orange
        b.layer.cornerRadius = 5
        b.layer.masksToBounds = true
        b.setTitle(title, for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: action, for: .touchUpInside)
    }

    @objc func loadAd() {
        clearText()
        loadAdWithState(.normal)
    }

    @objc func showAd() {}

    @objc func loadAndShowAd() {
        clearText()
        loadAdWithState(.normal)
    }

    @objc func deallocAd() {}

    func loadAdWithState(_ state: AdState) {
        switch state {
        case .normal:
            labNotify.text = "未加载广告"
        case .loading:
            labNotify.text = "广告加载中..."
        case .loadSucceed:
            labNotify.text = "广告加载成功"
        case .loadFailed:
            labNotify.text = "广告加载失败"
        }
    }

    func showProcessWithText(_ text: String) {
        logText += "\r\n\(text)"
        textV.text = logText
    }

    func showErrorWithDescription(_ description: [AnyHashable: Any]?) {
        guard let description = description else { return }
        let highlightText = getSianKeyWithDic(description)
        logText += ", 失败原因如下:\r\n\(highlightText)"
        let attr = setupAttributeString(logText, highlightText: highlightText)
        textV.attributedText = attr
    }

    func clearText() {
        logText = ""
        textV.text = nil
        textV.attributedText = nil
    }

    private func getSianKeyWithDic(_ dic: [AnyHashable: Any]) -> String {
        let keys = dic.keys.sorted { String(describing: $0) > String(describing: $1) }
        var strArray: [String] = []
        for key in keys {
            guard let err = dic[key] as? NSError else { continue }
            let code = err.code
            var desc = err.userInfo[NSLocalizedDescriptionKey] as? String
            let desc1 = err.userInfo["extra_reason"] as? String
            if desc == nil {
                desc = err.userInfo["desc"] as? String
            }
            let errorInfo = "\(key): \ncode: \(code) \n错误详情:\(desc ?? "")(\(desc1 ?? ""))"
            strArray.append(errorInfo)
        }
        return strArray.joined(separator: "\r\n")
    }

    private func setupAttributeString(_ text: String, highlightText: String) -> NSMutableAttributedString {
        let attributeStr = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: highlightText)
        if range.length > 0 {
            attributeStr.addAttribute(.foregroundColor, value: UIColor.red, range: range)
            attributeStr.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 15), range: range)
        }
        return attributeStr
    }
}
