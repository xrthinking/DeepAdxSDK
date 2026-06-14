//
//  DemoBannerViewController.swift
//  DeepAdxSwift
//

import UIKit
import DeepAdxCore
import DeepAdxAdspot

final class DemoBannerViewController: BaseDemoViewController, DeepAdxBannerDelegate {

    private var adBanner: DeepAdxBanner?
    private var bannerContainer: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Banner"
        isOnlyLoad = false
        setupBannerContainer()
    }

    private func setupBannerContainer() {
        let scale: CGFloat = 100.0 / 640.0
        let h = view.bounds.size.width * scale
        var insets = UIEdgeInsets.zero
        if #available(iOS 11.0, *) {
            insets = view.safeAreaInsets
        }
        let y = view.bounds.size.height - insets.bottom - h - 100
        let container = UIView(frame: CGRect(x: 0, y: y, width: view.bounds.size.width, height: h))
        container.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        container.backgroundColor = .clear
        view.addSubview(container)
        bannerContainer = container
    }

    override func loadAndShowAd() {
        super.loadAndShowAd()
        loadAdWithState(.normal)
        ensureBanner().loadAndShowAd()
        loadAdWithState(.loading)
    }

    override func deallocAd() {
        adBanner?.delegate = nil
        adBanner = nil
        loadAdWithState(.normal)
    }

    private func ensureBanner() -> DeepAdxBanner {
        if adBanner == nil {
            let b = DeepAdxBanner(adViewController: self)
            b.delegate = self
            b.adContainer = bannerContainer
            adBanner = b
        }
        return adBanner!
    }

    // MARK: - DeepAdxBannerDelegate

    @objc func ad_supplierWillLoad(_ supplierId: String) {
        showProcessWithText("\(#function)\r\n 内部渠道开始加载时调用")
    }

    @objc func ad_successSortTag(_ sortTag: String) {
        showProcessWithText("\(#function)\r\n 选中了 rule '\(sortTag)' ")
    }

    @objc func ad_loadSuccess(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告拉取成功")
        loadAdWithState(.loadSucceed)
    }

    @objc func ad_loadFailure(_ error: Error, with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告加载失败")
        loadAdWithState(.loadFailed)
    }

    @objc func ad_exposuredFailed(_ error: Error, with adsType: adsType) {}

    @objc func ad_failed(with error: Error, description: [AnyHashable: Any]?) {
        showProcessWithText("\(#function)\r\n 广告加载失败")
        showErrorWithDescription(description)
        loadAdWithState(.loadFailed)
        deallocAd()
    }

    @objc func ad_exposured(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告曝光成功")
    }

    @objc func ad_clicked(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告点击")
    }

    @objc func ad_didClose(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告关闭了")
    }
}
