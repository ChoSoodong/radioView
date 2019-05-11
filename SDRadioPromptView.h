






#import <UIKit/UIKit.h>

@class SDRadioPromptView;
@protocol SDRadioPromptViewDelegate<NSObject>

-(void)radioPromptView:(SDRadioPromptView *)radioView cellStr:(NSString *)cellStr;


@end


typedef void(^RadioBlock)(NSString *cellString);

@interface SDRadioPromptView : UIView


@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong) NSArray *cellArr;

@property(nonatomic,weak) id<SDRadioPromptViewDelegate>delegate;

/** block */
@property (nonatomic, copy) RadioBlock radioBlock;


/**
 显示单选 sheet提示框 ----- block方式回调结果

 @param title 提示框的标题
 @param cellArr 每个选项的标题数组
 @param indexPath 默认选中的索引
 @param callBack 提交后block回调
 @return 提示框
 */
+(instancetype)showPromptTitle:(NSString *)title cellArray:(nonnull NSArray *)cellArr indexPath:(nullable NSIndexPath *)indexPath callBack:(RadioBlock _Nullable )callBack;



/**
 显示单选 sheet提示框 ----- 代理方式回调结果

 @param title 提示框的标题
 @param cellArr 每个选项的标题数组
 @param indexPath 默认选中的索引
 @param delegate 代理
 @return 提示框
 */
+(instancetype)showPromptTitle:(NSString *)title cellArray:(nonnull NSArray *)cellArr indexPath:(nullable NSIndexPath *)indexPath delegate:(id<SDRadioPromptViewDelegate> _Nullable )delegate;


@end

