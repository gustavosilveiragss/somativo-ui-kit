import UIKit

final class ObraCell: UICollectionViewCell {

    @IBOutlet weak var imagemView: UIImageView!
    @IBOutlet weak var overlay: UIView!
    @IBOutlet weak var anoLabel: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var artistaLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor(named: "VerdeAraucaria")
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 14
        layer.shadowOpacity = 0.10
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imagemView.image = nil
    }

    func configurar(com obra: ObraDeArte) {
        anoLabel.text = "\(obra.ano)"
        tituloLabel.text = obra.titulo
        artistaLabel.text = obra.artista

        if let imagem = UIImage(named: obra.imagemNome) {
            imagemView.image = imagem
            imagemView.contentMode = .scaleAspectFill
        } else {
            imagemView.image = UIImage(systemName: "photo.artframe")
            imagemView.contentMode = .center
            imagemView.tintColor = .white.withAlphaComponent(0.5)
        }
    }
}
