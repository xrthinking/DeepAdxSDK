//
//  DemoInterstitialViewController.swift
//  DeepAdxSwift
//

import UIKit
import DeepAdxCore
import DeepAdxAdspot

final class DemoInterstitialViewController: BaseDemoViewController, DeepAdxInterstitialDelegate {

    private var adInterstitial: DeepAdxInterstitial?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "插屏广告"
    }

    override func loadAd() {
        super.loadAd()
        deallocAd()
        loadAdWithState(.normal)
        ensureInterstitial().loadAd()
        loadAdWithState(.loading)
    }

    override func showAd() {
        adInterstitial?.showAd()
    }

    override func loadAndShowAd() {
        super.loadAndShowAd()
        loadAdWithState(.normal)
        ensureInterstitial().loadAndShowAd()
        loadAdWithState(.loading)
    }

    override func deallocAd() {
        adInterstitial?.delegate = nil
        adInterstitial = nil
        isLoaded = false
        loadAdWithState(.normal)
    }

    private func ensureInterstitial() -> DeepAdxInterstitial {
        if adInterstitial == nil {
            let i = DeepAdxInterstitial(viewController: self)
            i.delegate = self
            adInterstitial = i
        }
        return adInterstitial!
    }

    // MARK: - DeepAdxInterstitialDelegate

    @objc func ad_supplierWillLoad(_ supplierId: String) {
        showProcessWithText("\(#function)\r\n 内部渠道开始加载")
    }

    @objc func ad_successSortTag(_ sortTag: String) {
        showProcessWithText("\(#function)\r\n 选中了 rule '\(sortTag)' ")
    }

    @objc func ad_loadSuccess(with adsType: adsType) {
        isLoaded = true
        showProcessWithText("\(#function)\r\n 广告数据拉取成功")
        loadAdWithState(.loadSucceed)
    }

    @objc func ad_loadFailure(_ error: Error, with adsType: adsType) {}

    @objc func ad_exposured(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告曝光成功")
    }

    @objc func ad_clicked(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告点击成功")
    }

    @objc func ad_failed(with error: Error, description: [AnyHashable: Any]?) {
        showProcessWithText("\(#function)\r\n 广告加载失败")
        showErrorWithDescription(description)
        loadAdWithState(.loadFailed)
        deallocAd()
    }

    @objc func ad_didClose(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告关闭了")
        deallocAd()
    }
}
