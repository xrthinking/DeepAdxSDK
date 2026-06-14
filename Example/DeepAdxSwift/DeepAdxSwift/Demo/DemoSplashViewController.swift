//
//  DemoSplashViewController.swift
//  DeepAdxSwift
//

import UIKit
import DeepAdxCore
import DeepAdxAdspot

final class DemoSplashViewController: BaseDemoViewController, DeepAdxSplashDelegate {

    private var adSplash: DeepAdxSplash?
    private var autoShowOnLoadSuccess = false
    private var didAutoRequestOnAppear = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "开屏广告"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !didAutoRequestOnAppear {
            didAutoRequestOnAppear = true
            loadAndShowSplashAd()
        }
    }

    override func loadAndShowAd() {
        super.loadAndShowAd()
        loadAndShowSplashAd()
    }

    override func loadAd() {
        super.loadAd()
        deallocAd()
        loadAdWithState(.normal)
        autoShowOnLoadSuccess = true
        ensureSplash().loadAd()
        loadAdWithState(.loading)
    }

    override func showAd() {
        guard let s = adSplash else {
            DemoUtils.showToast("请先加载广告")
            return
        }
        s.showAd()
    }

    private func loadAndShowSplashAd() {
        deallocAd()
        loadAdWithState(.normal)
        autoShowOnLoadSuccess = false
        ensureSplash().loadAndShowAd()
        loadAdWithState(.loading)
    }

    override func deallocAd() {
        adSplash?.delegate = nil
        adSplash = nil
        isLoaded = false
        loadAdWithState(.normal)
    }

    private func ensureSplash() -> DeepAdxSplash {
        if adSplash == nil {
            let s = DeepAdxSplash(viewController: self)
            s.delegate = self
            adSplash = s
        }
        return adSplash!
    }

    // MARK: - DeepAdxSplashDelegate

    @objc func ad_supplierWillLoad(_ supplierId: String) {
        showProcessWithText("\(#function)\r\n 内部渠道开始加载时调用")
    }

    @objc func ad_successSortTag(_ sortTag: String) {
        showProcessWithText("\(#function)\r\n 选中了 rule '\(sortTag)' ")
    }

    @objc func ad_loadSuccess(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告拉取成功")
        loadAdWithState(.loadSucceed)
        if autoShowOnLoadSuccess {
            showAd()
        }
    }

    @objc func ad_loadFailure(_ error: Error, with adsType: adsType) {
        loadAdWithState(.loadFailed)
        deallocAd()
    }

    @objc func ad_exposured(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告曝光成功")
    }

    @objc func ad_failed(with error: Error, description: [AnyHashable: Any]?) {
        showProcessWithText("\(#function)\r\n 广告加载失败")
        showErrorWithDescription(description)
        loadAdWithState(.loadFailed)
        deallocAd()
    }

    @objc func ad_clicked(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告点击")
    }

    @objc func ad_didClose(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告关闭")
        loadAdWithState(.normal)
        deallocAd()
    }

    @objc func ad_splashOnAdCountdownToZero() {
        showProcessWithText("\(#function)\r\n 广告倒计时结束")
    }

    @objc func ad_splashOnAdSkipClicked() {
        showProcessWithText("\(#function)\r\n 点击了跳过")
        loadAdWithState(.normal)
        deallocAd()
    }
}
