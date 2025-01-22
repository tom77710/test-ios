import Foundation
import UIKit
import Services

class PokemonDetailViewController: UIViewController {
    var pokemon: PokemonDetail

    var nameLabel: UILabel = UILabel()
    var descriptionLabel: UILabel = UILabel()
    var tipsLabel: UILabel = UILabel()
    var imageView: UIImageView = UIImageView()

    var onDismiss: (() -> Void)

    init(_ model: PokemonDetail, _ onDismiss: @escaping (() -> Void)) {
        pokemon = model
        self.onDismiss = onDismiss
        super.init(nibName: nil, bundle: nil)
        nameLabel.text = pokemon.name

        descriptionLabel.text = pokemon.weight.description
        descriptionLabel.numberOfLines = 0

        tipsLabel.text = pokemon.abilities.map({ ability in
            ability.ability.name
        }).reduce("", { partialResult, next in
            var result = partialResult
            result += "- " + next
            return result
        })
        tipsLabel.numberOfLines = 0

        let dismiss = UIBarButtonItem(barButtonSystemItem: .done,
                                      target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItem = dismiss
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = pokemon.name
        view.backgroundColor = .white

        imageView.image = .init(data: try! .init(contentsOf: URL(string: pokemon.sprites.other!.officialArtwork.frontDefault)!))

        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(tipsLabel)

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        tipsLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

            tipsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            tipsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tipsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

        ])
    }

    @objc func handleDismiss() {
        onDismiss()
    }
}
