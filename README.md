# TableViews

Introduction to UITableViews and UITableViewDataSource. In the process we overviewed UITableViewCell, IndexPath and what it means to dequeue a cell.

## Topics Covered

 * UITableView
 * cells can be static or dynamic
 * prototype cell
 * reuse identifier e.g "countryCell"
 * dataSource object (WE NEED TO SET THE DATASOURCE OBJECT e.g tableView.dataSource = self), configured in viewDidLoad()
 * UITableViewDataSource - 2 required methods
 * first required methdod is numberOfRows()
 * second required methods is cellForRow()
 * dequeueCell - recycles a cell if in memory, if not it creates a new cell
