//
//  TopViewController.swift
//  TapticSampler
//
//  Created by Keisuke Tatsumi on 2018/08/23.
//  Copyright © 2018年 Keisuke Tatsumi. All rights reserved.
//

import UIKit

final class TopViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerCell(SwitchTableViewCell.self)
            tableView.registerCell(PickerViewTableViewCell.self)
            tableView.registerCell(PeekAndPopTableViewCell.self)
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: Const.defaultCellIdentifier)
            tableView.refreshControl = refreshControl
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    private let pickerView = UIPickerView()

    private lazy var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Taptic Sampler"

        refreshControl.addTarget(self,
                                 action: #selector(refreshAction(sender:)),
                                 for: .valueChanged)

        // Check force touch available.
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            // Set target view for Peek and Pop.
            registerForPreviewing(with: self, sourceView: view)
        }
    }

    @objc private func refreshAction(sender: UIRefreshControl) {
        sender.endRefreshing()
    }

    fileprivate func showPickerAlert() {

        let alert = UIAlertController(title: nil,
                                      message: "Virtual YouTubers\n\n\n\n\n\n",
                                      preferredStyle: .alert)

        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.frame = CGRect(x: 0, y: 40, width: 270, height: 160)
        pickerView.dataSource = self
        pickerView.delegate = self
        alert.view.addSubview(pickerView)

        alert.addAction(UIAlertAction.init(title: "OK",
                                           style: .default,
                                           handler: { _ in
                                            alert.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
}

// MARK: Const

extension TopViewController {
    private enum Const {
        static let defaultCellIdentifier = "cell"
        static let pickerItems = ["Kizuna Ai",
                                  "Kaguya Luna",
                                  "Mirai Akari",
                                  "Dennou Shojo Siro",
                                  "Nekomiya Hinata",
                                  "Tsukino Mito",
                                  "Yomemi",
                                  "Tokino Sora",
                                  "Hatoba Tsugu",
                                  "Shizuka Rin",
                                  "Higuchi Kaede",
                                  "Fuji Aoi",
                                  "Azuma Lim",
                                  "Mononobe Alice",
                                  "Tanaka Hime",
                                  "Oda Nobuhime",
                                  "Nora Cat",
                                  "Natori Sana"]
    }
}

// MARK: - UITableViewDataSource

extension TopViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return 3
        case 2:
            return 3
        case 3:
            return 3
        case 4:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(SwitchTableViewCell.self, forIndexPath: indexPath)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(PickerViewTableViewCell.self, forIndexPath: indexPath)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(PeekAndPopTableViewCell.self, forIndexPath: indexPath)
                return cell
            default:
                break
            }
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Const.defaultCellIdentifier, for: indexPath)
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Light"
                cell.textLabel?.textColor = .lightGray
            case 1:
                cell.textLabel?.text = "Medium"
                cell.textLabel?.textColor = .darkGray
            case 2:
                cell.textLabel?.text = "Heavy"
                cell.textLabel?.textColor = .black
            default:
                break
            }
            cell.textLabel?.font = .boldSystemFont(ofSize: 18)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: Const.defaultCellIdentifier, for: indexPath)
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Error"
                cell.textLabel?.textColor = .red
            case 1:
                cell.textLabel?.text = "Warning"
                cell.textLabel?.textColor = .yellow
            case 2:
                cell.textLabel?.text = "Success"
                cell.textLabel?.textColor = .green
            default:
                break
            }
            cell.textLabel?.font = .boldSystemFont(ofSize: 18)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: Const.defaultCellIdentifier, for: indexPath)
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Selection Changed"
                cell.textLabel?.textColor = .blue
            default:
                break
            }
            cell.textLabel?.font = .boldSystemFont(ofSize: 18)
            return cell

        default:
            break
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "UIKit"
        case 2:
            return "Impact Feedback"
        case 3:
            return "Notification Feedback"
        case 4:
            return "Selection Feedback"
        default:
            return nil
        }
    }
}

// MARK: - UITableViewDelegate

extension TopViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
            titleLabel.backgroundColor = .clear
            titleLabel.font = .boldSystemFont(ofSize: 16)
            titleLabel.textAlignment = .center
            titleLabel.text = "↓ UIRefreshControl ↓"
            return titleLabel
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 1:
                showPickerAlert()
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                HapticFeedback.generate(.impact(.light))
            case 1:
                HapticFeedback.generate(.impact(.medium))
            case 2:
                HapticFeedback.generate(.impact(.heavy))
            default:
                break
            }
        case 3:
            switch indexPath.row {
            case 0:
                HapticFeedback.generate(.notification(.error))
            case 1:
                HapticFeedback.generate(.notification(.warning))
            case 2:
                HapticFeedback.generate(.notification(.success))
            default:
                break
            }
        case 4:
            switch indexPath.row {
            case 0:
                HapticFeedback.generate(.selection)
            default:
                break
            }
        default:
            break
        }
    }
}

// MARK: - UIPickerViewDataSource

extension TopViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Const.pickerItems.count
    }
}

// MARK: - UIPickerViewDelegate

extension TopViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Const.pickerItems[row]
    }
}

// MARK: - UIViewControllerPreviewingDelegate

extension TopViewController: UIViewControllerPreviewingDelegate {

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {

        // Get touched location on table view.
        let touchedTableViewLocation = tableView.convert(location, from: view)

        // Check index path.
        guard let indexPath = tableView.indexPathForRow(at: touchedTableViewLocation) else {
            return nil
        }

        // Check PeekAndPopTableViewCell.
        guard let cell = tableView.cellForRow(at: indexPath),
            cell is PeekAndPopTableViewCell else {
                return nil
        }

        // Make view controller instance from storyboard.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PeekAndPopViewController")

        // Set preview size for peek.
        // Note: Set width 0 because it is ignored.
        viewController.preferredContentSize = CGSize(width: 0,
                                                     height: UIScreen.main.bounds.height / 2.0)

        // Set cleary visible rect while peek.
        previewingContext.sourceRect = view.convert(cell.frame, from: tableView)

        return viewController
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: false)
    }
}
