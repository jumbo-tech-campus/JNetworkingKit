import Foundation
import UIKit

class SecondViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Gateway().getMovie(onSuccess: onSuccess, onError: onError)
    }

    private func onSuccess(movies: [Movie]) {
        print(movies)
    }

    private func onError(error: Error) {
        print("Error fetching movies:\(error.localizedDescription)")
    }

}
