






#import "SDRadioCell.h"

@implementation SDRadioCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.text = @"test";
        _titleLab.numberOfLines = 1;
        [self.contentView addSubview:_titleLab];
        
        _selectBtn = [[UIButton alloc] init];
        [_selectBtn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];
        [_selectBtn sizeToFit];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectBtn];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margin = 16;
    
    CGFloat btn_w = self.selectBtn.imageView.bounds.size.width;
    CGFloat btn_h = self.selectBtn.imageView.bounds.size.height;
    CGFloat btn_x = self.contentView.bounds.size.width - btn_w - margin;
    CGFloat btn_y = (self.contentView.bounds.size.height - btn_h)*0.5;
    _selectBtn.frame = CGRectMake(btn_x, btn_y, btn_w, btn_h);
    
    CGFloat lab_w = self.contentView.bounds.size.width - margin*3 - btn_w;
    CGFloat lab_h = self.contentView.bounds.size.height;
    CGFloat lab_x = margin;
    CGFloat lab_y = 0;
    _titleLab.frame = CGRectMake(lab_x, lab_y, lab_w, lab_h);
    
    
    
}

- (void)selectAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(selectRowStr:indexPath:)]) {
        [_delegate selectRowStr:self.titleLab.text indexPath:self.selectedIndexPath];
    }
    
}

@end
