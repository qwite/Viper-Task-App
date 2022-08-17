import UIKit

// MARK: - DetailsView
class DetailsView: UIView {
    
    // MARK: Properties
    let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var startAddressTitleLabel = UILabel()
    lazy var startAddressLabel = UILabel()
    
    lazy var endAddressTitleLabel = UILabel()
    lazy var endAddressLabel = UILabel()
    
    lazy var dateTimeTitleLabel = UILabel()
    lazy var dateTimeLabel = UILabel()
    
    lazy var priceTitleLabel = UILabel()
    lazy var priceLabel = UILabel()
    
    lazy var carTitleLabel = UILabel()
    lazy var carLabel = UILabel()
    
    lazy var driverTitleLabel = UILabel()
    lazy var driverLabel = UILabel()
        
    lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
}

// MARK: - Public methods
extension DetailsView {
    public func addIndicator() {
        addSubview(activityIndicator)
        activityIndicator.center = center
    }
    
    public func startIndicator() {
        activityIndicator.startAnimating()
    }

    
    public func stopIndicator() {
        activityIndicator.stopAnimating()
    }
    
    public func configure(viewModel: DetailedActiveOrderViewModelType) {
        startAddressLabel.text = viewModel.common.startAddress
        endAddressLabel.text = viewModel.common.endAddress
        dateTimeLabel.text = viewModel.common.date
        priceLabel.text = viewModel.common.price
        carLabel.text = "\(viewModel.vehicleModelName) / \(viewModel.vehicleRegNumber)"
        driverLabel.text = viewModel.vehicleDriverName
        
        configureViews()
        configureLabels()
        configureImageView(with: viewModel.image)
    }
}

// MARK: - Private methods
extension DetailsView {
    private func configureViews() {
        backgroundColor = .groupTableViewBackground
        
        addSubview(cardView)
        
        // cardView
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            cardView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            cardView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
        
        let startAddressStack = UIStackView(arrangedSubviews: [startAddressTitleLabel, startAddressLabel], spacing: 5, axis: .vertical, alignment: .fill)
        
        let dateStack = UIStackView(arrangedSubviews: [dateTimeTitleLabel, dateTimeLabel], spacing: 5, axis: .vertical, alignment: .fill)
                
        let firstVerticalStack = UIStackView(arrangedSubviews: [startAddressStack, dateStack], spacing: 10, axis: .vertical, alignment: .fill)
        
        cardView.addSubview(firstVerticalStack)
        
        // firstHorizontalStack
        NSLayoutConstraint.activate([
            firstVerticalStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            firstVerticalStack.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 15)
        ])
        
        let endAddressStack = UIStackView(arrangedSubviews: [endAddressTitleLabel, endAddressLabel], spacing: 5, axis: .vertical, alignment: .fill)
        
        let priceStack = UIStackView(arrangedSubviews: [priceTitleLabel, priceLabel], spacing: 5, axis: .vertical, alignment: .fill)
        
        let secondVerticalStack = UIStackView(arrangedSubviews: [endAddressStack, priceStack], spacing: 10, axis: .vertical, alignment: .fill)
        
        cardView.addSubview(secondVerticalStack)
        
        // secondHorizontalStack
        NSLayoutConstraint.activate([
            secondVerticalStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            secondVerticalStack.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -15)
        ])
        
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .systemGray
        
        cardView.addSubview(separator)
        
        // separator
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: secondVerticalStack.bottomAnchor, constant: 20),
            separator.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 15),
            separator.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -15),
            separator.heightAnchor.constraint(equalToConstant: 0.3)
        ])
        
        cardView.addSubview(carImageView)
        
        // carImageView
        NSLayoutConstraint.activate([
            carImageView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20),
            carImageView.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 15),
            carImageView.widthAnchor.constraint(equalToConstant: 120),
            carImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // cardView
        NSLayoutConstraint.activate([
            cardView.bottomAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 20)
        ])
        
        let carStack = UIStackView(arrangedSubviews: [carTitleLabel, carLabel], spacing: 5, axis: .vertical, alignment: .fill)
        let driverStack = UIStackView(arrangedSubviews: [driverTitleLabel, driverLabel], spacing: 5, axis: .vertical, alignment: .fill)
        
        let thirdVerticalStack = UIStackView(arrangedSubviews: [carStack, driverStack], spacing: 5, axis: .vertical, alignment: .fill)
        
        cardView.addSubview(thirdVerticalStack)
        
        // thirdVerticalStack
        NSLayoutConstraint.activate([
            thirdVerticalStack.topAnchor.constraint(equalTo: carImageView.topAnchor),
            thirdVerticalStack.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -15)
        ])
    }
    
    private func configureLabels() {
        startAddressTitleLabel.text = Constants.Headers.startAddressTitle
        startAddressTitleLabel.font = Constants.Fonts.detailedTitleItemFont
        startAddressLabel.font = Constants.Fonts.descriptionItemFont
        
        endAddressTitleLabel.text = Constants.Headers.endAddressTitle
        endAddressTitleLabel.font = Constants.Fonts.detailedTitleItemFont
        endAddressLabel.font = Constants.Fonts.descriptionItemFont
        
        dateTimeTitleLabel.text = Constants.Headers.dateTimeAddressTitle
        dateTimeTitleLabel.font = Constants.Fonts.detailedTitleItemFont
        dateTimeLabel.font = Constants.Fonts.descriptionItemFont
        
        priceTitleLabel.text = Constants.Headers.priceAddressTitle
        priceTitleLabel.font = Constants.Fonts.detailedTitleItemFont
        priceLabel.font = Constants.Fonts.descriptionItemFont
        
        carTitleLabel.text = Constants.Headers.carAddressTitle
        carTitleLabel.font = Constants.Fonts.detailedTitleItemFont
        carLabel.font = Constants.Fonts.descriptionItemFont
        
        driverTitleLabel.text = Constants.Headers.driverAddressTitle
        driverTitleLabel.font = Constants.Fonts.detailedTitleItemFont
        driverLabel.font = Constants.Fonts.descriptionItemFont
    }
    
    private func configureImageView(with data: Data) {
        carImageView.image = UIImage(data: data)
        carImageView.layer.masksToBounds = true
        carImageView.layer.cornerRadius = 15
    }
}
