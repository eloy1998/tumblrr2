import UIKit
import Nuke

class DetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!

    // MARK: - Properties
    var post: Post!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Disable editing for the text view
        captionTextView.isEditable = false

        // Set the caption text, stripping HTML tags
        captionTextView.text = post.caption.trimHTMLTags()

        // Load the image using Nuke 12+ style
        if let photo = post.photos.first {
            let url = photo.originalSize.url
            let request = ImageRequest(url: url)
            Task {
                do {
                    let image = try await ImagePipeline.shared.image(for: request)
                    self.detailImageView.image = image
                } catch {
                    print("Image loading failed: \(error)")
                }
            }
        }
    }
}
