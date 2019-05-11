







#import "SDRadioPromptView.h"
#import "SDRadioCell.h"

//屏幕尺寸
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface SDRadioPromptView()<UITableViewDelegate,
                            UITableViewDataSource,
                            SDRadioCellDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong) UIView * promptView;

@property (assign, nonatomic) NSIndexPath *selectedIndexPath;//单选，当前选中的行

@property(nonatomic,copy)NSString * cellStr;//单元格内容

@end
@implementation SDRadioPromptView

+(instancetype)showPromptTitle:(NSString *)title cellArray:(nonnull NSArray *)cellArr indexPath:(nullable NSIndexPath *)indexPath callBack:(RadioBlock _Nullable )callBack{
    
    SDRadioPromptView *promptView = [[SDRadioPromptView alloc] initWithPromptTitle:title cellArray:cellArr indexPath:indexPath];
    
    promptView.radioBlock = callBack;
    
    [promptView show];
    
    return promptView;
    
}

+(instancetype)showPromptTitle:(NSString *)title cellArray:(nonnull NSArray *)cellArr indexPath:(nullable NSIndexPath *)indexPath delegate:(id<SDRadioPromptViewDelegate> _Nullable )delegate{
    
    SDRadioPromptView *promptView = [[SDRadioPromptView alloc] initWithPromptTitle:title cellArray:cellArr indexPath:indexPath];
    
    promptView.delegate = delegate;
    
    [promptView show];
    
    return promptView;
}

-(instancetype)initWithPromptTitle:(NSString *)title cellArray:(nonnull NSArray * )cellArr indexPath:(NSIndexPath*)indexPath{
    
    if (self =[super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        self.cellArr = cellArr;
        self.selectedIndexPath=indexPath;
        
        self.cellStr=indexPath == nil ? @"" : cellArr[indexPath.row];

        self.title=title;
        self.backgroundColor = [UIColor clearColor];
        UIView * promptView = [UIView new];
        promptView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.5);
        [self addSubview:promptView];
        self.promptView = promptView;
        
        
        
        UILabel * titleLab= [[UILabel alloc] init];
        titleLab.backgroundColor = [UIColor whiteColor];
        titleLab.font =[UIFont boldSystemFontOfSize:19];
        titleLab.textAlignment=NSTextAlignmentCenter;
        titleLab.text=title;
        titleLab.textColor = [UIColor blackColor];
        titleLab.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        [promptView addSubview:titleLab];
    
        
        UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.backgroundColor = RGBColor(228, 52, 61);
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        submitBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
        [submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.frame = CGRectMake(0, promptView.bounds.size.height - 60, SCREEN_WIDTH, 60);
        [promptView addSubview:submitBtn];
        
        
        
        CGFloat tab_x = 0;
        CGFloat tab_y = CGRectGetMaxY(titleLab.frame);
        CGFloat tab_w = promptView.bounds.size.width;
        CGFloat tab_h = submitBtn.frame.origin.y - titleLab.bounds.size.height;

        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(tab_x, tab_y, tab_w, tab_h) style:UITableViewStylePlain];
        tableView.delegate =self;
        tableView.dataSource=self;
        [promptView addSubview:tableView];
        self.tableView = tableView;
        
        [tableView registerClass:[SDRadioCell class] forCellReuseIdentifier:NSStringFromClass([SDRadioCell class])];
        
        tableView.tableFooterView= [[UIView alloc]initWithFrame:CGRectZero];
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    
    return self;
    
  
    
}
#pragma mark ----提交

-(void)submitAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(radioPromptView:cellStr:)]) {
        [_delegate radioPromptView:self cellStr:self.cellStr];
    }
    
    
    if (self.radioBlock) {
        self.radioBlock(self.cellStr);
    }
    
    [self dismiss];
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDRadioCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SDRadioCell class])];
    if (!cell) {
        cell = [[SDRadioCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([SDRadioCell class])];
        
    }

    cell.selectedIndexPath = indexPath;
    
    [cell.selectBtn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];
    
    //当上下拉动的时候，因为cell的复用性，我们需要重新判断一下哪一行是打勾的
    if (_selectedIndexPath == indexPath) {
        [cell.selectBtn setImage:[UIImage imageNamed:@"yesSelected"] forState:UIControlStateNormal];
        
        
    }else {
        [cell.selectBtn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];
        

    }
   
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    cell.titleLab.text=self.cellArr[indexPath.row];
    
    return cell;
}
-(void)selectRowStr:(NSString *)cellStr indexPath:(NSIndexPath *)selectedIndexPath
{
    self.cellStr=cellStr;
    
    SDRadioCell *celled = [_tableView cellForRowAtIndexPath:_selectedIndexPath];
    celled.accessoryType = UITableViewCellAccessoryNone;
    [celled.selectBtn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];

    
    //记录当前选中的位置索引
    _selectedIndexPath = selectedIndexPath;
    //当前选择的打勾
    SDRadioCell *cell = [_tableView cellForRowAtIndexPath:selectedIndexPath];
    [cell.selectBtn setImage:[UIImage imageNamed:@"yesSelected"] forState:UIControlStateNormal];
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self selectRowStr:self.cellArr[indexPath.row] indexPath:indexPath];
    
}
// 点击提示框视图以外的其他地方时隐藏弹框
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [[touches anyObject] locationInView:self];
    point = [self.promptView.layer convertPoint:point fromLayer:self.layer];
    if (![self.promptView.layer containsPoint:point]) {

        [self dismiss];
    }
    
}



#pragma mark - 显示
-(void)show{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
        
        self.promptView.frame = CGRectMake(0, SCREEN_HEIGHT*0.5, SCREEN_WIDTH, SCREEN_HEIGHT*0.5);
        
    }];
    
    
}

#pragma mark - 隐藏
-(void)dismiss{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 0;
         self.promptView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.5);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}





@end
