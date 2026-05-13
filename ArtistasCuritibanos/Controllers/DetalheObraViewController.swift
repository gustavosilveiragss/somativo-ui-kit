import UIKit

final class DetalheObraViewController: UIViewController {

    var obra: ObraDeArte!

    @IBOutlet weak var imagemView: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var artistaLabel: UILabel!
    @IBOutlet weak var estiloContainer: UIView!
    @IBOutlet weak var estiloLabel: UILabel!
    @IBOutlet weak var anoLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        imagemView.layer.cornerRadius = 16
        imagemView.clipsToBounds = true

        if let imagem = UIImage(named: obra.imagemNome) {
            imagemView.image = imagem
            imagemView.contentMode = .scaleAspectFill
        } else {
            imagemView.image = UIImage(systemName: "photo.artframe")
            imagemView.contentMode = .scaleAspectFit
            imagemView.tintColor = .systemGray3
        }

        tituloLabel.text = obra.titulo
        artistaLabel.text = obra.artista
        anoLabel.text = "\(obra.ano)"
        estiloLabel.text = obra.estilo
        descricaoLabel.text = obra.descricao
    }

    @IBAction func voltarTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func compartilharTapped(_ sender: UIButton) {
        let texto = "\"\(obra.titulo)\", de \(obra.artista). Conheça mais artistas curitibanos no app Galeria."
        let activityVC = UIActivityViewController(activityItems: [texto], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = sender
        present(activityVC, animated: true)
    }
}
