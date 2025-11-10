import UIKit

private extension UIConfigurationStateCustomKey {
	static let item = Self("org.xoria.CollectionViewWrapping.Item")
}

private extension UIConfigurationState {
	var item: Item? {
		get { self[.item] as? Item }
		set { self[.item] = newValue }
	}
}

final class ItemListCell: UICollectionViewListCell {
	var item: Item? {
		didSet {
			if oldValue != item { setNeedsUpdateConfiguration() }
		}
	}

	override var configurationState: UICellConfigurationState {
		var state = super.configurationState
		state.item = item
		return state
	}

	override func updateConfiguration(using state: UICellConfigurationState) {
//		var listContentConfiguration = UIListContentConfiguration.cell()
//		if let item = state.item {
//			listContentConfiguration.text = item.description
//			if item.isIndented {
//				listContentConfiguration.textProperties.color = .systemOrange
//				listContentConfiguration.directionalLayoutMargins.leading += 200
//			}
//		}
//		contentConfiguration = listContentConfiguration

		contentConfiguration = TextContentConfiguration().updated(for: state)
	}
}

private struct TextContentConfiguration: UIContentConfiguration {
	var description: String?
	var color: UIColor?
	var indentation: CGFloat = 0

	func makeContentView() -> any UIView & UIContentView {
		TextContentView(configuration: self)
	}

	func updated(for state: any UIConfigurationState) -> TextContentConfiguration {
		var updated = self
		guard let item = state.item else { return updated }
		updated.description = item.description
		if item.isIndented {
			updated.color = .systemOrange
			updated.indentation = 200
		}
		return updated
	}
}

private final class TextContentView: UIView, UIContentView {
	var configuration: any UIContentConfiguration {
		didSet {
			guard let configuration = configuration as? TextContentConfiguration else { return }
			apply(configuration: configuration)
		}
	}

	private var listContentView: UIListContentView

	init(configuration: TextContentConfiguration) {
		listContentView = UIListContentView(configuration: .cell())
		self.configuration = configuration
		super.init(frame: .zero)

		listContentView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(listContentView)
		NSLayoutConstraint.activate([
			listContentView.topAnchor.constraint(equalTo: topAnchor),
			listContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
			listContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
			listContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])

		apply(configuration: configuration)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func apply(configuration: TextContentConfiguration) {
		var listContentConfiguration = UIListContentConfiguration.cell()
		listContentConfiguration.text = configuration.description
		listContentConfiguration.textProperties.color = configuration.color ?? .label
		listContentConfiguration.directionalLayoutMargins.leading += configuration.indentation
		listContentView.configuration = listContentConfiguration
	}
}
