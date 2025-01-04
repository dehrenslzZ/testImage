import UIKit

class Page: UIView {
        
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize.zero
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = 4
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not happening")
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(textLabel)
    }
    
    func setupConstraints() {
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        imageView.layer.removeAllAnimations()
        imageView.transform = CGAffineTransformTranslate(.identity, 0, 0)
        
        UIView.animate(withDuration: 7.0, delay: 0, animations: {
            self.imageView.transform = CGAffineTransformTranslate(.identity, 20, 0)
        }, completion: nil)
    }
        
    func configureOnboarding(theData: OnboardingData) {
        textLabel.text = theData.text
        imageView.image = UIImage(named: theData.image)
        
        setupConstraints()
    }
}
