# ZHNTempStatusHelper
轻松添加tableview数据为空的时候的站位视图功能，实现的思路差不多和https://github.com/ChenYilong/CYLTableViewPlaceHolder 一样，但是在使用的过程当中发现这个库的侵入性还是稍微大了一点点，而且数据为空但是为空的情况不一样的情况下还是有些问题。稍作了修改。

#### 使用方法

##### 1
+ 导入`DTTempStatusMan`文件夹到项目


##### 2
+ 在需要处理空数据占位的控制器里导入头文件`#import "ZHNTempStatusMan.h"`


##### 3
+ 指定`tableview`的控制器`self.tableView.superViewController = self;`


##### 4
+ 重写`- (UIView *)ZHN_tempStatusPlaceholderView `方法来返回占位视图。你可以在这个方法里面做判断空数据的情况是网络的问题还是返回的数据就是为空。


##### 5
+ 还提供了一个方法`- (BOOL)ZHN_tempStatusEnableTableViewScroll `来设置占位视图显示的情况下是否可以滑动。你可以重写这个方法来设置。

如何还有疑问你可以看看demo里的代码。或者提issue
