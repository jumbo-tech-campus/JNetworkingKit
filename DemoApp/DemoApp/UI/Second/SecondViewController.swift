import Foundation
import UIKit

class SecondViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var plotLabel: UILabel!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Gateway().getMovie(onSuccess: onGetMovieSuccess, onError: onGetMovieError)
    }

    private func onGetMovieSuccess(movie: Movie) {
        titleLabel.text = movie.title
        plotLabel.text = movie.plot
    }

    private func onGetMovieError(error: Error) {
        print("Error fetching movies:\(error.localizedDescription)")
    }
}
