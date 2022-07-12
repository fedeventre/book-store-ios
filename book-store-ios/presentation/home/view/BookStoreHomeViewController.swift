
import UIKit

class BookStoreHomeViewController: UICollectionViewController {
    
    private let reuseIdentifierCell = "BookCell"
    private let reuseIdentifierSection = "sectionHeader"
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(
        top: 20.0,
        left: 20.0,
        bottom: 20.0,
        right: 20.0)
    
    var homeViewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "BookCellView", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierCell)
        self.title = "Book Store"
        self.homeViewModel?.onViewDisplayed()
        
    }
}

///MARK: - UICollectionViewDataSource
extension BookStoreHomeViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.homeViewModel?.homeSection?.sections.count ?? 0
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let section =  self.homeViewModel?.homeSection?.getSectionAtIndex(section)
        return section?.books.count ?? 0
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifierCell,
            for: indexPath) as! BookCollectionViewCell
        guard let book = self.homeViewModel?.homeSection?.getSectionAtIndex(indexPath.section)?
                .books[indexPath.item]
        else {
            cell.backgroundColor = .black
            return cell
        }
        
        cell.configure(model: book)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierSection, for: indexPath) as? HeaderSectionCollectionReusableView,
            let section = self.homeViewModel?.homeSection?.getSectionAtIndex(indexPath.section)
        else { return UICollectionReusableView() }
        
        sectionHeader.sectionHeaderLabel.text = "\(section.name) (\(section.amountOfBooks()))"
        return sectionHeader
    }
    
    
}

// MARK: - Collection View Flow Layout Delegate
extension BookStoreHomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem * 1.8)
        
    }
     
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
   
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }    
}

extension BookStoreHomeViewController: HomeViewDelegate {
    func reloadData() {
        self.collectionView.reloadData()
    }
}

