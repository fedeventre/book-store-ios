
import UIKit
import Kingfisher

extension UIImageView {
    //fetchs an image from url with built-in cache
    func setImageFrom(url: URL) {
        self.kf.setImage(with:url)
    }
}
