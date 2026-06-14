//
//  HomeViewController.swift
//  DeepAdxSwift
//

import UIKit
import AdSupport
import Masonry

private let kIDFACopyToastTag = 929_929

final class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private lazy var idfaLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        return l
    }()

    private struct Row {
        let title: String
        let destinationType: UIViewController.Type?
    }

    private let rows: [Row] = [
        Row(title: "开屏广告", destinationType: DemoSplashViewController.self),
        Row(title: "Banner广告", destinationType: DemoBannerViewController.self),
        Row(title: "插屏广告", destinationType: DemoInterstitialViewController.self),
        Row(title: "激励视频广告", destinationType: DemoRewardVideoViewController.self),
        Row(title: "原生广告", destinationType: DemoListFeedExpressViewController.self),
        Row(title: "IDFA", destinationType: nil)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "DEEPADX-聚合广告平台"
        view.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.backgroundView = UIView()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        view.addSubview(tableView)
        tableView.mas_makeConstraints { make in
            make?.edges.mas_equalTo()(0)
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid")
            ?? UITableViewCell(style: .default, reuseIdentifier: "cellid")
        cell.textLabel?.text = rows[indexPath.row].title
        if indexPath.row == rows.count - 1 {
            addIdfaLabel(to: cell.contentView)
        } else {
            idfaLabel.removeFromSuperview()
        }
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let type = rows[indexPath.row].destinationType else { return }
        let vc = type.init()
        vc.title = rows[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - IDFA

    private func getIDFA() -> String {
        ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }

    private func addIdfaLabel(to host: UIView) {
        host.addSubview(idfaLabel)
        idfaLabel.mas_makeConstraints { make in
            make?.top.bottom().right().equalTo()(host)
            make?.left.equalTo()(host)?.offset()(100)
        }
        let idfa = getIDFA()
        let hasValue = !idfa.isEmpty
        idfaLabel.text = hasValue ? idfa : "请在设置-隐私-跟踪中允许App请求跟踪"
        if #available(iOS 13.0, *) {
            idfaLabel.textColor = hasValue ? .systemBlue : .label
        } else {
            idfaLabel.textColor = hasValue ? .systemBlue : .darkText
        }
        idfaLabel.isUserInteractionEnabled = hasValue
        idfaLabel.gestureRecognizers?.forEach { idfaLabel.removeGestureRecognizer($0) }
        if hasValue {
            let tap = UITapGestureRecognizer(target: self, action: #selector(copyIDFAToPasteboard))
            idfaLabel.addGestureRecognizer(tap)
        }
    }

    @objc private func copyIDFAToPasteboard() {
        let idfa = getIDFA()
        guard !idfa.isEmpty else { return }
        UIPasteboard.general.string = idfa
        showCopyToast()
    }

    private func showCopyToast() {
        view.viewWithTag(kIDFACopyToastTag)?.removeFromSuperview()
        let toast = UILabel()
        toast.tag = kIDFACopyToastTag
        toast.text = "已复制"
        toast.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        toast.textColor = .white
        toast.textAlignment = .center
        toast.backgroundColor = UIColor.black.withAlphaComponent(0.78)
        toast.layer.cornerRadius = 10
        toast.clipsToBounds = true
        view.addSubview(toast)
        toast.mas_makeConstraints { make in
            make?.centerX.equalTo()(view)
            make?.centerY.equalTo()(view)?.offset()(-40)
            make?.height.mas_equalTo()(40)
            make?.width.mas_equalTo()(120)
        }
        toast.alpha = 0
        UIView.animate(withDuration: 0.2) { toast.alpha = 1 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            UIView.animate(withDuration: 0.2, animations: { toast.alpha = 0 }) { _ in
                toast.removeFromSuperview()
            }
        }
    }
}
