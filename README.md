# CornerCardTableView
效果图：
![](http://upload-images.jianshu.io/upload_images/1467685-139eee2354ba0901.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

核心代码：
```
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
```
注意要在willDisplay中调用不然显示会有问题：
```
func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.cornerCard(radio: 5, indexPath: indexPath)
}
```
