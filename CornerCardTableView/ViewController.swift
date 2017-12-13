//
//  ViewController.swift
//  test
//
//  Created by knightyao on 2017/11/15.
//  Copyright © 2017年 knightyao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRect(x: 20, y: 0, width: view.frame.width - 40, height: view.frame.height), style: .grouped)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.separatorStyle = .none
        tableView!.backgroundColor = .clear
        tableView!.showsVerticalScrollIndicator = false
        tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.backgroundColor = .lightGray
        cell.textLabel?.text = "第\(indexPath.section)组，第\(indexPath.row)行"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.cornerCard(radio: 5, indexPath: indexPath)
    }
}

extension UITableViewCell {
    //卡片式Cell
    func cornerCard(radio: CGFloat, indexPath: IndexPath) {
        func checkCellIndexPath(indexPath: IndexPath) -> UIRectCorner? {
            //拿到Cell的TableView
            var view: UIView? = superview
            while view != nil && !(view is UITableView) {
                view = view!.superview
            }
            guard let tableView = view as? UITableView else {return nil}
            if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                // 1.只有一行
                return .allCorners
            } else if indexPath.row == 0 {
                // 2.每组第一行
                return [.topLeft, .topRight]
            } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                // 3.每组最后一行
                return [.bottomLeft, .bottomRight]
            } else {
                return nil
            }
        }
        
        let corner = checkCellIndexPath(indexPath: indexPath)
        let contentBounds = CGRect(origin: CGPoint.zero, size: frame.size)
        let layer = CAShapeLayer()
        layer.bounds = contentBounds
        layer.position = CGPoint(x: contentBounds.midX ,y: contentBounds.midY)
        layer.path = UIBezierPath(roundedRect: contentBounds, byRoundingCorners: corner ?? [], cornerRadii: CGSize(width: radio, height: radio)).cgPath
        
        self.layer.mask = layer
    }
}
