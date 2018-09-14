//
//  NewsfeedViewController.swift
//  CAGradientLayer
//
//  Created by Thanh Nguyen Xuan on 9/14/18.
//  Copyright © 2018 Thanh Nguyen. All rights reserved.
//

import UIKit

class NewsfeedViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    fileprivate let numberOfPlaceHolderCells = 3

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startLoading()
    }

	private func startLoading() {
        tableView.visibleCells.forEach({
            $0.contentView.startAnimationLoading()
        })
    }

    private func stopLoading() {
        tableView.visibleCells.forEach({
            $0.contentView.stopAnimationLoading()
        })
    }

    @IBAction func startButtonTapped(_ sender: Any) {
        startLoading()
    }

    @IBAction func stopButtonTapped(_ sender: Any) {
        stopLoading()
    }

}

// MARK: - UITableViewDatasource

extension NewsfeedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfPlaceHolderCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "newsfeedCell", for: indexPath)
    }

}

// MARK: - UITableViewDelegate

extension NewsfeedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        return (view.frame.height - tabBarHeight) / CGFloat(numberOfPlaceHolderCells)
    }

}
