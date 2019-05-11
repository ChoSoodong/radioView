







#import <UIKit/UIKit.h>

@class SDRadioCell;
@protocol SDRadioCellDelegate <NSObject>

-(void)selectRowStr:(NSString *)cellStr indexPath:(NSIndexPath*)selectedIndexPath ;
@end

@interface SDRadioCell : UITableViewCell

@property (nonatomic , strong) UIButton *lastButton;
@property (assign, nonatomic) NSIndexPath *selectedIndexPath;

@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UIButton *selectBtn;
@property(nonatomic,weak)id<SDRadioCellDelegate>delegate;

@end


