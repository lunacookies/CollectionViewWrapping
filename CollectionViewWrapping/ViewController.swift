import UIKit

final class ViewController: UICollectionViewController {
	private var dataSource: UICollectionViewDiffableDataSource<Section, UUID>!
	private var items = testData

	init() {
		let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
		let layout = UICollectionViewCompositionalLayout.list(using: configuration)
		super.init(collectionViewLayout: layout)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		collectionView.allowsMultipleSelectionDuringEditing = true
		navigationItem.rightBarButtonItem = editButtonItem

		let registration = UICollectionView.CellRegistration<ItemListCell, UUID>
			{ [weak self] cell, indexPath, uuid in
				guard let self else { return }
				cell.item = items[uuid]!
				cell.accessories = [.multiselect()]
			}

		dataSource = .init(collectionView: collectionView) { collectionView, indexPath, uuid in
			collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: uuid)
		}

		var snapshot = NSDiffableDataSourceSnapshot<Section, UUID>()
		snapshot.appendSections([.section])
		snapshot.appendItems(Array(items.keys))
		dataSource.apply(snapshot)
	}

	override func collectionView(_: UICollectionView, performPrimaryActionForItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let uuid = dataSource.itemIdentifier(for: indexPath)!
		items[uuid]!.isIndented.toggle()
		var snapshot = dataSource.snapshot()
		snapshot.reconfigureItems([uuid])
		dataSource.apply(snapshot)
	}

	private nonisolated enum Section {
		case section
	}
}

