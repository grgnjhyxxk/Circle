import UIKit
import SnapKit

class ActivityCollectionCell: UICollectionViewCell {
    let categoryView: UIView = {
        let button = UIView()
        button.backgroundColor = UIColor(named: "BackgroundColor")
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 8
        return button
    }()
    
    let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                categoryView.backgroundColor = .white
                categoryTitleLabel.textColor = .black
            } else {
                categoryView.backgroundColor = UIColor(named: "BackgroundColor")
                categoryTitleLabel.textColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryView)
        contentView.addSubview(categoryTitleLabel)
        
        categoryView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 105, height: 33))
        }
        
        categoryTitleLabel.snp.makeConstraints { make in
            make.center.equalTo(categoryView)
        }
        
        contentView.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
