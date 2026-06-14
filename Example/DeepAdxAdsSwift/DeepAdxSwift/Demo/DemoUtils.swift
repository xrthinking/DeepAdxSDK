//
//  DemoUtils.swift
//  DeepAdxSwift
//

import UIKit

enum DemoUtils {
    static func showToast(_ text: String) {
        guard let superView = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap(\.windows)
            .first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.last(where: { $0.isKeyWindow })
        else {
            return
        }
        showToast(text, in: superView)
    }

    static func showToast(_ text: String, in superView: UIView) {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 20)]
        let labelSize = (text as NSString).size(withAttributes: attrs)
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = text
        label.textAlignment = .center
        label.layer.cornerRadius = labelSize.height / 4
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(red: 38 / 255, green: 187 / 255, blue: 251 / 255, alpha: 1)
        label.textColor = .white
        label.frame = CGRect(
            x: (superView.bounds.size.width - labelSize.width) / 2,
            y: superView.bounds.size.height - labelSize.height - 100,
            width: labelSize.width,
            height: labelSize.height
        )
        superView.addSubview(label)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            label.removeFromSuperview()
        }
    }
}
