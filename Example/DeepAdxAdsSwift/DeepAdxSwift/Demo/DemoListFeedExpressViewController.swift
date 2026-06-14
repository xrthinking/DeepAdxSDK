//
//  DemoListFeedExpressViewController.swift
//  DeepAdxSwift
//

import UIKit
import DeepAdxAdspot
import Masonry

final class DemoListFeedExpressViewController: BaseDemoViewController, DeepAdxNativeExpressDelegate {

    private var advanceFeed: DeepAdxNativeExpress?
    private var dataArrM: [DeepAdxNativeExpressView] = []
    private var arrViewsM: [DeepAdxNativeExpressView] = []
    private var isLoadAndShow = false
    private var isShowLogView = false
    private var navAndStateBarHeight: CGFloat = 0
    private var containerView: UIView?
    private let logPanelHeight: CGFloat = 300

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "信息流"

        let statusHeight: CGFloat
        if #available(iOS 13.0, *) {
            statusHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusHeight = UIApplication.shared.statusBarFrame.height
        }
        let navHeight = navigationController?.navigationBar.frame.height ?? 44
        navAndStateBarHeight = navHeight + statusHeight

        // 默认隐藏，点击右上角按钮后以下拉面板方式展示日志
        layoutLogPanel(animated: false)

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "显示log信息",
            style: .plain,
            target: self,
            action: #selector(showLogView)
        )
    }

    override func loadAd() {
        super.loadAd()
        deallocAd()
        loadAdWithState(.normal)
        isLoadAndShow = false
        dataArrM = []
        ensureFeed().loadAd()
        loadAdWithState(.loading)
    }

    override func showAd() {
        guard advanceFeed != nil, isLoaded, !arrViewsM.isEmpty else { return }
        showNativeAd()
    }

    override func loadAndShowAd() {
        super.loadAd()
        deallocAd()
        loadAdWithState(.normal)
        isLoadAndShow = true
        dataArrM = []
        ensureFeed().loadAndShowAd()
        loadAdWithState(.loading)
    }

    override func deallocAd() {
        advanceFeed?.delegate = nil
        advanceFeed = nil
        isLoaded = false
        dataArrM.removeAll()
        arrViewsM.removeAll()
        loadAdWithState(.normal)
    }

    private func ensureFeed() -> DeepAdxNativeExpress {
        if advanceFeed == nil {
            let f = DeepAdxNativeExpress(
                viewController: self,
                adSize: CGSize(width: view.bounds.size.width, height: 0)
            )
            f.delegate = self
            advanceFeed = f
        }
        return advanceFeed!
    }

    private func showNativeAd() {
        dataArrM = []
        for v in arrViewsM {
            v.render()
            dataArrM.append(v)
        }
        guard !dataArrM.isEmpty, let first = dataArrM.first else { return }
        let express = first.expressView
        containerView?.removeFromSuperview()
        containerView = express
        view.addSubview(express)
        express.mas_remakeConstraints { make in
            make?.left.right().mas_equalTo()(0)
            make?.top.mas_equalTo()(330)
            // 高度过小会导致点击/关闭命中区域异常；占位高度在渲染/曝光回调中更新
            make?.height.mas_equalTo()(300)
        }
        view.bringSubviewToFront(express)
        view.layoutIfNeeded()
    }

    @objc private func showLogView() {
        isShowLogView.toggle()
        layoutLogPanel(animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // BaseDemoViewController 会重置 textV frame，这里回写信息流页面的下拉面板布局。
        layoutLogPanel(animated: false)
    }

    private func layoutLogPanel(animated: Bool) {
        let update = {
            self.navAndStateBarHeight = self.currentNavAndStatusHeight()
            let y: CGFloat = self.isShowLogView ? self.navAndStateBarHeight : -self.logPanelHeight
            self.textV.frame = CGRect(x: 0, y: y, width: self.view.bounds.width, height: self.logPanelHeight)
            self.view.bringSubviewToFront(self.textV)
            self.navigationItem.rightBarButtonItem?.title = self.isShowLogView ? "隐藏log信息" : "显示log信息"
        }
        if animated {
            UIView.animate(withDuration: 0.2, animations: update)
        } else {
            update()
        }
    }

    private func currentNavAndStatusHeight() -> CGFloat {
        let navHeight = navigationController?.navigationBar.frame.height ?? 44
        let statusHeight: CGFloat
        if #available(iOS 13.0, *) {
            statusHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height
                ?? UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .first?
                    .statusBarManager?
                    .statusBarFrame.height
                ?? 0
        } else {
            statusHeight = UIApplication.shared.statusBarFrame.height
        }
        return navHeight + statusHeight
    }

    // MARK: - DeepAdxNativeExpressDelegate

    @objc(ad_supplierWillLoad:)
    func ad_supplierWillLoad(_ supplierId: String) {
        showProcessWithText("\(#function)\r\n 内部渠道开始加载")
    }

    @objc(ad_successSortTag:)
    func ad_successSortTag(_ sortTag: String) {
        showProcessWithText("\(#function)\r\n 选中了 rule '\(sortTag)' ")
    }

    @objc(ad_NativeExpressOnAdLoadSuccess:)
    func ad_NativeExpress(onAdLoadSuccess views: [DeepAdxNativeExpressView]?) {
        guard let views = views, !views.isEmpty else { return }
        arrViewsM = views
        if isLoadAndShow {
            showNativeAd()
        }
        isLoaded = true
        showProcessWithText("\(#function)\r\n 广告拉取成功")
        loadAdWithState(.loadSucceed)
    }

    @objc(ad_NativeExpressOnAdLoadFailWithError:)
    func ad_NativeExpress(onAdLoadFailWithError error: Error?) {
        showProcessWithText("\(#function)\r\n 广告加载失败")
        loadAdWithState(.loadFailed)
        deallocAd()
    }

    @objc(ad_NativeExpressOnAdRenderSuccess:)
    func ad_NativeExpress(onAdRenderSuccess adView: DeepAdxNativeExpressView?) {
        guard let expressView = adView?.expressView else { return }
        expressView.setNeedsLayout()
        expressView.layoutIfNeeded()
        var h = expressView.bounds.size.height
        if h <= 0 {
            h = expressView.frame.size.height
        }
        if h <= 0 {
            let size = expressView.systemLayoutSizeFitting(
                CGSize(width: view.bounds.width, height: UIView.layoutFittingExpandedSize.height),
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            )
            h = size.height
        }
        if h <= 0 { h = 300 }
        containerView?.mas_updateConstraints { make in
            make?.height.mas_equalTo()(h)
        }
        showProcessWithText("\(#function)\r\n 广告渲染成功")
    }

    @objc(ad_NativeExpressOnAdRenderFail:withError:)
    func ad_NativeExpress(onAdRenderFail adView: DeepAdxNativeExpressView?, withError error: Error?) {
        showProcessWithText("\(#function)\r\n 广告渲染失败")
        if let adView = adView {
            dataArrM.removeAll { $0 === adView }
        }
    }

    func ad_NativeExpressOnAdGetViewIsEmpty() {}

    @objc(ad_NativeExpressOnAdShow:)
    func ad_NativeExpress(onAdShow adView: DeepAdxNativeExpressView?) {
        guard let expressView = adView?.expressView else { return }
        expressView.setNeedsLayout()
        expressView.layoutIfNeeded()
        var h = expressView.bounds.size.height
        if h <= 0 {
            h = expressView.frame.size.height
        }
        if h <= 0 {
            let size = expressView.systemLayoutSizeFitting(
                CGSize(width: view.bounds.width, height: UIView.layoutFittingExpandedSize.height),
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            )
            h = size.height
        }
        if h <= 0 { h = 300 }
        containerView?.mas_updateConstraints { make in
            make?.height.mas_equalTo()(h)
        }
        showProcessWithText("\(#function)\r\n 广告曝光成功")
    }

    @objc(ad_NativeExpressOnAdClicked:)
    func ad_NativeExpress(onAdClicked adView: DeepAdxNativeExpressView?) {
        showProcessWithText("\(#function)\r\n 广告点击")
    }

    @objc(ad_NativeExpressOnAdClosed:)
    func ad_NativeExpress(onAdClosed adView: DeepAdxNativeExpressView?) {
        deepadx_removeNativeExpressFromScreen(adView)
    }

    @objc(ad_NativeExpressOnAdDislike:)
    func ad_NativeExpress(onDislike adView: DeepAdxNativeExpressView?) {
        // 部分渠道（如快手）点「不喜欢」只走 dislike，不走 closed，需主动移除 expressView
        deepadx_removeNativeExpressFromScreen(adView)
    }

    private func deepadx_removeNativeExpressFromScreen(_ adView: DeepAdxNativeExpressView?) {
        guard let adView = adView else { return }
        dataArrM.removeAll { $0 === adView }
        arrViewsM.removeAll { $0 === adView }
        let ev = adView.expressView
        ev.removeFromSuperview()
        if containerView === ev {
            containerView = nil
        }
    }
}
