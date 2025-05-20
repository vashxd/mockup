import Foundation
import UIKit

class IOSAssetManager {
    
    static let shared = IOSAssetManager()
    
    private init() {}
    
    func loadImage(named: String) -> UIImage? {
        return UIImage(named: named)
    }
    
    func cacheImage(_ image: UIImage, forKey key: String) {
        // Implementação de cache pode ser adicionada aqui se necessário
    }
}
