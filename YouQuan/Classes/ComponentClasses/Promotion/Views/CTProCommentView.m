//
//  CTProCommentView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTProCommentView.h"
#import "CTProCommentItem.h"
@interface CTProCommentView()

@property (nonatomic, strong) NSMutableArray *commentItems;

@property (nonatomic, strong) NSLock *lock;

@end

@implementation CTProCommentView

ViewInstance(setUp)

- (void)setUp{
    self.clipsToBounds = YES;
}

- (NSLock *)lock{
    if(!_lock){
        _lock = [NSLock new];
    }
    return _lock;
}

- (NSMutableArray *)commentItems{
    if(!_commentItems){
        _commentItems = [NSMutableArray array];
    }
    return _commentItems;
}

- (CTProCommentItem *)itemForIndex:(NSInteger)index{
    CTProCommentItem *item = [self.commentItems safe_objectAtIndex:index];
    if(!item){
        [_lock lock];
        item = NSMainBundleClass(CTProCommentItem.class);
        [self.commentItems addObject:item];
        [_lock unlock];
    }
    return item;
}


- (void)setComments:(NSArray<NSString *> *)comments{
    _comments = comments;
    [self reloadView];
}

- (void)reloadView{
    NSInteger count = self.comments.count;
   
    for(int i = 0;i < count;i ++){
        CTProCommentItem *item = [self itemForIndex:i];
        item.tag = 100 + i;
        item.titleLabel.text = self.comments[i];
        [self addSubview:item];
        [item mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(i * (CTProGoodIndexCommentHeight + CTProGoodIndexCommentSpace));
            make.width.mas_equalTo(CTProGoodIndexCommentWidth);
            make.height.mas_equalTo(CTProGoodIndexCommentHeight);
        }];
    }

    for(int i = 0;i < self.commentItems.count;i ++){
        CTProCommentItem *item = [self.commentItems safe_objectAtIndex:i];
        item.hidden = (i<count)?NO:YES;
    }

}

@end
