//
//  DemoRewardVideoViewController.swift
//  DeepAdxSwift
//

import UIKit
import DeepAdxCore
import DeepAdxAdspot

final class DemoRewardVideoViewController: BaseDemoViewController, DeepAdxRewardVideoDelegate {

    private var adRewardVideo: DeepAdxRewardVideo?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "激励视频广告"
    }

    override func loadAd() {
        super.loadAd()
        deallocAd()
        loadAdWithState(.normal)
        ensureReward().loadAd()
        loadAdWithState(.loading)
    }

    override func showAd() {
        guard adRewardVideo != nil else {
            DemoUtils.showToast("请先加载广告")
            return
        }
        adRewardVideo?.showAd()
    }

    override func loadAndShowAd() {
        super.loadAd()
        deallocAd()
        loadAdWithState(.normal)
        ensureReward().loadAndShowAd()
        loadAdWithState(.loading)
    }

    override func deallocAd() {
        adRewardVideo?.delegate = nil
        adRewardVideo = nil
        isLoaded = false
        loadAdWithState(.normal)
    }

    private func ensureReward() -> DeepAdxRewardVideo {
        if adRewardVideo == nil {
            let r = DeepAdxRewardVideo(viewController: self)
            r.delegate = self
            if r.rewardServerParams == nil {
                r.rewardServerParams = DeepAdxRewardServerParams()
            }
            if let p = r.rewardServerParams {
                p.userId = "100001"
                p.extra = "哈哈哈"
                p.rewardName = "元宝"
                p.rewardAmount = 100
            }
            adRewardVideo = r
        }
        return adRewardVideo!
    }

    // MARK: - DeepAdxRewardVideoDelegate

    @objc func ad_supplierWillLoad(_ supplierId: String) {
        showProcessWithText("\(#function)\r\n 内部渠道开始加载")
    }

    @objc func ad_successSortTag(_ sortTag: String) {
        showProcessWithText("\(#function)\r\n 选中了 rule '\(sortTag)' ")
    }

    @objc func ad_loadSuccess(with adsType: adsType) {
        DemoUtils.showToast("广告加载成功")
        showProcessWithText("\(#function)\r\n 广告数据拉取成功")
    }

    @objc func ad_loadFailure(_ error: Error, with adsType: adsType) {}

    @objc func ad_rewardVideoOnAdVideoCached() {
        DemoUtils.showToast("视频缓存成功")
        isLoaded = true
        showProcessWithText("\(#function)\r\n 视频缓存成功")
        loadAdWithState(.loadSucceed)
    }

    @objc func ad_rewardVideoAdDidRewardEffective() {
        showProcessWithText("\(#function)\r\n 到达激励时间")
    }

    @objc func ad_exposured(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告曝光回调")
    }

    @objc func ad_clicked(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告点击")
    }

    @objc func ad_failed(with error: Error, description: [AnyHashable: Any]?) {
        DemoUtils.showToast("广告加载失败")
        showProcessWithText("\(#function)\r\n 广告加载失败")
        showErrorWithDescription(description)
        loadAdWithState(.loadFailed)
        deallocAd()
    }

    @objc func ad_didClose(with adsType: adsType) {
        showProcessWithText("\(#function)\r\n 广告关闭了")
        deallocAd()
    }

    @objc func ad_rewardVideoAdDidPlayFinish() {
        showProcessWithText("\(#function)\r\n 播放完成")
    }
}
