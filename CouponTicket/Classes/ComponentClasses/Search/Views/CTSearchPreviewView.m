//
//  CTSearchPreviewView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSearchPreviewView.h"

#import "CLHorizontalCompactLayout.h"

#import "CTHotKeywordHeadView.h"

#import "CTHistoryKeywordHeadView.h"

#import "CTHistoryKeywordCell.h"

#define CTHotkeywordFont [UIFont systemFontOfSize:13]

const int CTSearchPreviewViewKey;

@interface CTHotkeywordViewModel:NSObject

@property (nonatomic, copy)NSString *keyword;

@property (nonatomic, assign)CGFloat keywordWidth;

@property (nonatomic, assign)CGSize itemSize;

+ (NSArray <CTHotkeywordViewModel *>*)viewModelsWithKeywords:(NSArray <NSString *>*)keywords;

@end

@implementation CTHotkeywordViewModel

+ (NSArray <CTHotkeywordViewModel *>*)viewModelsWithKeywords:(NSArray <NSString *>*)keywords{
    NSMutableArray *array = [NSMutableArray array];
    for(NSString *keyword in keywords){
        CTHotkeywordViewModel *viewModel = [CTHotkeywordViewModel new];
        viewModel.keyword = keyword;
        viewModel.keywordWidth = [keyword sizeWithFont:CTHotkeywordFont maxSize:CGSizeMake(SCREEN_WIDTH, 15)].width + 1;
        viewModel.itemSize = CGSizeMake(viewModel.keywordWidth + 20, 26);
        [array addObject:viewModel];
    }
    return array.copy;
}
@end


@interface CTHotkeywordCell :UICollectionViewCell

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)CTHotkeywordViewModel *viewModel;

@end

@implementation CTHotkeywordCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel =[[UILabel alloc]init];
        _titleLabel.font = FONT_PFRG_SIZE(13);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = RGBColor(153, 153, 153);
        _titleLabel.backgroundColor = RGBColor(245, 245, 245);
        _titleLabel.clipsToBounds = YES;
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setViewModel:(CTHotkeywordViewModel *)viewModel{
    _viewModel = viewModel;
    _titleLabel.text = _viewModel.keyword;
    [_titleLabel setFrame:CGRectMake(0, 0, _viewModel.itemSize.width, _viewModel.itemSize.height)];
    _titleLabel.layer.cornerRadius = _viewModel.itemSize.height/2;
}

@end

@interface CTSearchPreviewView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, copy) NSArray <CTHotkeywordViewModel *> *hotKeywordsViewModels;

@property (nonatomic, copy) NSArray <CTHotkeywordViewModel *> *historyKeywordsViewModels;


@end

@implementation CTSearchPreviewView

+ (void)showHistoryViewOnView:(UIView *)view frame:(CGRect)frame hotKeywords:(NSArray <NSString *> *)hotKeywords historyKeywords:(NSArray <NSString *> *)historyKeywords selectKeyBlock:(void(^)(NSString *key))selectKeyBlock clearHistoryBlock:(void(^)(void))clearHistoryBlock{
    if(!view)return;
    if(!hotKeywords.count && !historyKeywords.count)return;
    CTSearchPreviewView *historyView = objc_getAssociatedObject(view, &CTSearchPreviewViewKey);
    if(!historyView){
        historyView = [[CTSearchPreviewView alloc]initWithFrame:frame];
    }
    historyView.selectKeyBlock = selectKeyBlock;
    historyView.clearHistoryBlock = clearHistoryBlock;
    historyView.hotKeywords = hotKeywords;
    historyView.historyKeywords = historyKeywords;
    [view addSubview:historyView];
    objc_setAssociatedObject(view, &CTSearchPreviewViewKey, historyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)hidehistoryViewonView:(UIView *)view{
    CTSearchPreviewView *historyView = objc_getAssociatedObject(view, &CTSearchPreviewViewKey);
    if(historyView){
        [historyView removeFromSuperview];
    }
}

ViewInstance(setUp)

- (void)setUp{
    CLHorizontalCompactLayout *layout = [[CLHorizontalCompactLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES;
    
    [_collectionView registerClass:[CTHotkeywordCell class] forCellWithReuseIdentifier:NSStringFromClass(CTHotkeywordCell.class)];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CTHistoryKeywordCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(CTHistoryKeywordCell.class)];

    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CTHotKeywordHeadView.class) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(CTHotKeywordHeadView.class)];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CTHistoryKeywordHeadView.class) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(CTHistoryKeywordHeadView.class)];

    [self addSubview:_collectionView];
}

- (void)layoutSubviews{
    [self.collectionView setFrame:self.bounds];
}

- (void)setHotKeywords:(NSArray<NSString *> *)hotKeywords{
    _hotKeywords = [hotKeywords copy];
    self.hotKeywordsViewModels = [CTHotkeywordViewModel viewModelsWithKeywords:_hotKeywords];
    [self.collectionView reloadData];
}


- (void)setHistoryKeywords:(NSArray<NSString *> *)historyKeywords{
    _historyKeywords = [historyKeywords copy];
    self.historyKeywordsViewModels = [CTHotkeywordViewModel viewModelsWithKeywords:_historyKeywords];
    [self.collectionView reloadData];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.superview endEditing:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 0){
        if(self.hotKeywordsViewModels.count){
            return CGSizeMake(self.width, 42);
        }
    }
    if(section == 1){
        if(self.historyKeywordsViewModels.count){
            return CGSizeMake(self.width, 42);
        }
    }
    return CGSizeZero;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if(indexPath.section == 0){
            CTHotKeywordHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(CTHotKeywordHeadView.class) forIndexPath:indexPath];
            return headView;
        }
        if(indexPath.section == 1){
            CTHistoryKeywordHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(CTHistoryKeywordHeadView.class) forIndexPath:indexPath];
            @weakify(self)
            [headView.clearButton touchUpInsideSubscribeNext:^(id x) {
                @strongify(self)
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"是否删除搜索历史？" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
                [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber * _Nullable x) {
                    @strongify(self)
                    if(x.integerValue == 1){
                        if(self.clearHistoryBlock){
                            self.clearHistoryBlock();
                        }
                    }
                }];
                [alertView show];
            
            }];
            return headView;
        }

    }
    return nil;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return section==0?UIEdgeInsetsMake(15, 10, 15, 15):UIEdgeInsetsMake(0, 13, 15, 15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return section==0?15:0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return section==0?15:0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == 0){
        return self.hotKeywordsViewModels.count;
    }
    if(section == 1){
        return self.historyKeywordsViewModels.count;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return self.hotKeywordsViewModels[indexPath.row].itemSize;
    }
    if(indexPath.section == 1){
        return CGSizeMake(self.width, 40);
    }
    return CGSizeZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if(indexPath.section == 0){
        CTHotkeywordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CTHotkeywordCell.class) forIndexPath:indexPath];
        cell.viewModel = self.hotKeywordsViewModels[indexPath.row];
        return cell;
    }
    if(indexPath.section == 1){
        CTHistoryKeywordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CTHistoryKeywordCell.class) forIndexPath:indexPath];
        cell.titleLabel.text = self.historyKeywordsViewModels[indexPath.row].keyword;
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(self.selectKeyBlock){
            self.selectKeyBlock(self.hotKeywordsViewModels[indexPath.row].keyword);
        }
    }
    if(indexPath.section == 1){
        if(self.selectKeyBlock){
            self.selectKeyBlock(self.historyKeywordsViewModels[indexPath.row].keyword);
        }
    }
}



@end
