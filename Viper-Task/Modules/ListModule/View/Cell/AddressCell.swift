import UIKit

// MARK: - AddressCell 
class AddressCell: UITableViewCell {
    static let reuseId = "Address"
    
    // MARK: Properties
    lazy var dateTitleLabel = UILabel()
    lazy var startTitleLabel = UILabel()
    lazy var endTitleLabel = UILabel()
    lazy var priceTitleLabel = UILabel()
    
    lazy var dateAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var startAddressLabel = UILabel()
    lazy var endAddressLabel = UILabel()
    
    lazy var priceAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
}

extension AddressCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        self.dateTitleLabel.text = nil
        self.startTitleLabel.text = nil
        self.endTitleLabel.text = nil
        self.priceTitleLabel.text = nil
        
        self.dateAddressLabel.text = nil
        self.startAddressLabel.text = nil
        self.endAddressLabel.text = nil
        self.priceAddressLabel.text = nil
    }
}

// MARK: - Public methods
extension AddressCell {
    public func configureCell(with viewModel: ActiveOrderViewModel) {
        dateAddressLabel.text = viewModel.date
        startAddressLabel.text = viewModel.startAddress
        endAddressLabel.text = viewModel.endAddress
        priceAddressLabel.text = viewModel.price
        
        configureViews()
    }
}

// MARK: - Private methods
extension AddressCell {
    private func configureViews() {
        configureLabels()
        
        let startAddressStack = UIStackView(arrangedSubviews: [startTitleLabel, startAddressLabel], spacing: 3, axis: .vertical, alignment: .fill)
        
        let endAddressStack = UIStackView(arrangedSubviews: [endTitleLabel, endAddressLabel], spacing: 3, axis: .vertical, alignment: .fill)
        
        let dateAddressStack = UIStackView(arrangedSubviews: [dateTitleLabel, dateAddressLabel], spacing: 3, axis: .vertical, alignment: .fill)
        
        let priceAddressStack = UIStackView(arrangedSubviews: [priceTitleLabel, priceAddressLabel], spacing: 3, axis: .vertical, alignment: .fill)
        
        let firstVerticalStack = UIStackView(arrangedSubviews: [startAddressStack, dateAddressStack], spacing: 10, axis: .vertical, alignment: .fill)
        
        addSubview(firstVerticalStack)
        NSLayoutConstraint.activate([
            // firstVerticalStack
            firstVerticalStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            firstVerticalStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
        ])
        
        let secondVerticalStack = UIStackView(arrangedSubviews: [endAddressStack, priceAddressStack], spacing: 10, axis: .vertical, alignment: .fill)
        
        addSubview(secondVerticalStack)
        // secondVerticalStack
        NSLayoutConstraint.activate([
            secondVerticalStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            secondVerticalStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
    }
    
    private func configureLabels() {
        dateTitleLabel.text = Constants.Headers.dateAddressTitle
        dateTitleLabel.font = Constants.Fonts.titleItemFont
        dateAddressLabel.font = Constants.Fonts.descriptionItemFont
        
        startTitleLabel.text = Constants.Headers.startAddressTitle
        startTitleLabel.font = Constants.Fonts.titleItemFont
        startAddressLabel.font = Constants.Fonts.descriptionItemFont
        
        endTitleLabel.text = Constants.Headers.endAddressTitle
        endTitleLabel.font = Constants.Fonts.titleItemFont
        endTitleLabel.textAlignment = .right
        endAddressLabel.font = Constants.Fonts.descriptionItemFont
        
        priceTitleLabel.text = Constants.Headers.priceAddressTitle
        priceTitleLabel.font = Constants.Fonts.titleItemFont
        priceTitleLabel.textAlignment = .right
        priceAddressLabel.font = Constants.Fonts.descriptionItemFont
        priceAddressLabel.textAlignment = .right
    }
}
