import UIKit

final class GaleriaViewController: UIViewController {

    @IBOutlet weak var buscaTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!

    private var obrasOriginais: [ObraDeArte] = []
    private var obrasFiltradas: [ObraDeArte] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        buscaTextField.addTarget(self, action: #selector(buscaMudou), for: .editingChanged)

        obrasOriginais = ObraRepository.shared.carregarObras()
        obrasFiltradas = obrasOriginais
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostrarDetalhe",
           let destino = segue.destination as? DetalheObraViewController,
           let obra = sender as? ObraDeArte {
            destino.obra = obra
        }
    }

    @objc private func buscaMudou() {
        let texto = normalizar(buscaTextField.text ?? "")
        if texto.isEmpty {
            obrasFiltradas = obrasOriginais
        } else {
            obrasFiltradas = obrasOriginais.filter {
                normalizar($0.titulo).contains(texto) ||
                normalizar($0.artista).contains(texto)
            }
        }
        collectionView.reloadData()
    }

    private func normalizar(_ texto: String) -> String {
        texto.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
    }
}

extension GaleriaViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        obrasFiltradas.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ObraCell", for: indexPath) as! ObraCell
        cell.configurar(com: obrasFiltradas[indexPath.item])
        return cell
    }
}

extension GaleriaViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "mostrarDetalhe", sender: obrasFiltradas[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.3) { cell.alpha = 1 }
    }
}

extension GaleriaViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colunas: CGFloat = traitCollection.horizontalSizeClass == .regular ? 3 : 2
        let espacoDisponivel = collectionView.bounds.width - 40 - (14 * (colunas - 1))
        let largura = floor(espacoDisponivel / colunas)
        return CGSize(width: largura, height: largura * 1.25)
    }
}
