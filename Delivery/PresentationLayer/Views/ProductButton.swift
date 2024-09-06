//
//  ProductButton.swift
//  Delivery
//
//  Created by Shmatov Nikita on 22.08.2024.
//

import UIKit


public final class ProductButton: UIButton {

    // MARK: - ButtonStyle

    public enum ButtonStyle {
        case shortIcon
        case longTitle
        case longIconTitle
    }

    // MARK: - Color

    public enum Color {
        case white
        case green
    }

    // MARK: - Initializer

    public init(style: ButtonStyle, color: Color, icon: UIImage? = nil, title: String? = nil) {
        let height: Int = style == .shortIcon ? 40 : 56
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: .zero, height: height)))
        setup(style: style, color: color, icon: icon, title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Change the button method

    public func changeButton(style: ButtonStyle, color: Color, icon: UIImage? = nil, title: String? = nil) {
        setup(style: style, color: color, icon: icon, title: title)
    }
}

private extension ProductButton {

    // MARK: - Setup

    func setup(style: ButtonStyle, color: Color, icon: UIImage?, title: String?) {
        self.configuration = switch style {
        case .shortIcon: getShortIconConfiguration(icon: icon, color: color)
        case .longTitle: getLongTitleConfiguration(title: title, color: color)
        case .longIconTitle: getLongIconTitleConfiguration(title: title, icon: icon, color: color)
        }
    }

    // MARK: - Get LongTitle style

    func getLongTitleConfiguration(title: String?, color: Color) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = title

        switch color {
        case .white:
            configuration.baseBackgroundColor = .systemBackground
            configuration.baseForegroundColor = .secondaryLabel
            configuration.background.strokeColor = .systemGray2
            configuration.background.strokeWidth = 1.0
        case .green:
            configuration.baseBackgroundColor = UIColor(resource: ._0_BCE_83)
            configuration.baseForegroundColor = .white
        }

        return configuration
    }

    // MARK: - Get LongIconTitle style

    func getLongIconTitleConfiguration(title: String?, icon: UIImage?, color: Color) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.borderedProminent()

        configuration.title = title
        configuration.image = icon
        configuration.imagePlacement = .leading
        switch color {
        case .white:
            configuration.baseBackgroundColor = .systemBackground
            configuration.baseForegroundColor = .secondaryLabel
            configuration.background.strokeColor = .systemGray2
            configuration.background.strokeWidth = 1.0
        case .green:
            configuration.baseBackgroundColor = UIColor(resource: ._0_BCE_83)
            configuration.baseForegroundColor = .white
        }

        return configuration
    }

    // MARK: - Get ShortIcon style

    func getShortIconConfiguration(icon: UIImage?, color: Color) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.borderedProminent()

        configuration.image = icon
        configuration.imagePlacement = .all

        switch color {
        case .white:
            configuration.baseBackgroundColor = .systemBackground
            configuration.baseForegroundColor = .secondaryLabel
            configuration.background.strokeColor = .systemGray2
            configuration.background.strokeWidth = 1.0
        case .green:
            configuration.baseBackgroundColor = UIColor(resource: ._0_BCE_83)
            configuration.baseForegroundColor = .white
        }

        return configuration
    }
}
