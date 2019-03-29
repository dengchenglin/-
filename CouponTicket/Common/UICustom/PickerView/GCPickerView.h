
#import <UIKit/UIKit.h>

typedef void(^GCPickerCallback)(NSUInteger index);

@interface GCPickerView : UIView

+ (void)showPickerViewWithSubTitles:(NSArray <NSString *>*)subTitles callback:(GCPickerCallback)callback;


+ (void)showPickerViewWithTitle:(NSString *)title subTitles:(NSArray <NSString *>*)subTitles callback:(GCPickerCallback)callback;

+ (void)showPickerViewWithTitle:(NSString *)title subTitles:(NSArray <NSString *>*)subTitles currentTitle:(NSString *)currentTitle callback:(GCPickerCallback)callback;

+ (void)hiddenPickerView;

@end
