# radioView
单选sheet提示框
```
 NSArray * array = @[@"多拍/拍错/不想要",@"未按约定时间发货",@"空包裹/少货",@"质量问题",@"卖家发错货",@"快递破损",@"其他"];

 //使用方法一 : block方式
    [SDRadioPromptView showPromptTitle:@"退款原因" cellArray:array indexPath:[NSIndexPath indexPathForRow:3 inSection:0] callBack:^(NSString *cellString) {
        NSLog(@"%@",cellString);
    }];
    
//使用方法二 : 代理方式
   [SDRadioPromptView showPromptTitle:@"" cellArray:array indexPath:nil delegate:self];



```
