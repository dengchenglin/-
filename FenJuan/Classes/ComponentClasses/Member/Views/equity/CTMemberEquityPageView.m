//
//  CTMemberEquityPageView.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/27.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTMemberEquityPageView.h"
#import "CTMemberEquityItemView.h"

@interface CTMemberEquityPageView()<UIScrollViewDelegate>

@end

@implementation CTMemberEquityPageView
{
    UIScrollView *_scrollView;
    UIView *_containerView;
}
ViewInstance(setUp)

- (void)setUp{
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    _containerView = [UIView new];
    [_scrollView addSubview:_containerView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.height.mas_equalTo(self->_scrollView.mas_height);
    }];
    
}

- (void)setList:(NSArray *)list{
    _list = list;
    UIView *tempView;
    NSArray *titles = @[@"粉券小生",@"粉券导师",@"粉券大咖",@"粉券合伙人"];
    for(int i = 0;i < _list.count;i ++){
        NSArray *subList = _list[i];

        CTMemberEquityItemView *view = NSMainBundleClass(CTMemberEquityItemView.class);
        view.titleLabel.text = [titles safe_objectAtIndex:i];
        view.datas = [CTMemberRebateModel yy_modelsWithDatas:subList];
        view.tag = 100 + i;
        [_containerView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if(tempView){
                make.left.mas_equalTo(tempView.mas_right);
            }
            else{
                make.left.mas_equalTo(0);
            }
            if(i == _list.count - 1){
                make.right.mas_equalTo(0);
            }
            make.width.mas_equalTo(self->_scrollView.mas_width);
            make.top.bottom.mas_equalTo(0);
        }];
        tempView = view;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(!self.width)return;
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    if(_delegate && [_delegate respondsToSelector:@selector(pageView:didScrollWithIndex:)]){
        [_delegate pageView:self didScrollWithIndex:index];
    }
}

- (void)scrollToIndex:(NSInteger)index{
    [_scrollView setContentOffset:CGPointMake(_scrollView.width * index, 0) animated:YES];
}

@end
