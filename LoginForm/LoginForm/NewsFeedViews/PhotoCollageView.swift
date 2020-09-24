import UIKit

@IBDesignable
class PhotoCollageView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var post = Post()
    //    { didSet { print("postNo did change to:\(post.postNo)") } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("PhotoCollageView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .red
        initCollectionView()
    }
    
    private func initCollectionView() {
        let nib = UINib(nibName: "PhotoCollageCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "PhotoCollageCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = PhotosCollageLayout()
    }
}

extension PhotoCollageView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("post.photoUrls.count:\(post.photoUrls.count)")
        if post.photoUrls.count <= 2 {
            return post.photoUrls.count
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollageCollectionViewCell", for: indexPath) as? PhotoCollageCollectionViewCell else {
            fatalError("can't dequeue PhotoCollageCollectionViewCell")
        }
        //        cell.testLabel.text = "\(indexPath.item)"
        
        cell.backgroundColor = .black
        
        if indexPath.row <= 2 {
        
        cell.configure(for: post.photoUrls[indexPath.row])
            
        } else {
            cell.addLabel()
        }
        print("indexPath.row is:\(indexPath.row)")
        //        print("cell configured for postNo\(post.postNo)")
        
        return cell
    }
}
