//
//  CTNetworkEngine+Goods.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Goods.h"

#define CTGoods(path)   [CTUrlPath(@"goods") stringByAppendingPathComponent:path]

@implementation CTGoodsImgModel
+ (CTGoodsImgModel *)modelWithData:(NSDictionary *)data{
    CTGoodsImgModel *model = [CTGoodsImgModel new];
    model.img = data[@"img"];
   
    NSString *sizeStr = data[@"size"];
    if(sizeStr.length){
        NSArray *sizes = [sizeStr componentsSeparatedByString:@"x"];
        if(sizes.count == 2){
            CGSize size = CGSizeMake([sizes[0] floatValue], [sizes[1] floatValue]);
            model.size = [NSValue valueWithCGSize:size];
        }
    }
    return model;
}
+ (NSArray <CTGoodsImgModel *>*)modelsWithDatas:(NSDictionary *)datas{
    NSMutableArray *array = [NSMutableArray array];
    for(NSDictionary *d in datas){
        [array addObject:[self modelWithData:d]];
    }
    return array;
}
@end
@implementation CTNetworkEngine (Goods)

//商品详情
- (CLRequest *)goodsDetailWithId:(NSString *)Id callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:Id forKey:@"id"];
    return [self postWithPath:CTGoods(@"goodsDetail") params:params callback:callback];
}

//获取商品链接（转链）
- (CLRequest *)goodsUrlConvertWithTbGoodsInfo:(NSDictionary *)goodsInfo callback:(CTResponseBlock)callback{
    return [self postWithPath:CTGoods(@"goods_url_convert") params:goodsInfo callback:callback];
}

//搜索
- (CLRequest *)goodsSearchWithKeyword:(NSString *)keyword page:(NSInteger)page size:(NSInteger)size order:(NSString *)order callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    [params setValue:order forKey:@"order"];
    return [self postWithPath:CTGoods(@"goods_search") params:params  showHud:page>1?NO:YES callback:callback];
}

//商品收藏
- (CLRequest *)favoriteWithGoodsId:(NSString *)goodsId isFavorite:(BOOL)isFavorite callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:goodsId forKey:@"goods_id"];
    [params setValue:@(isFavorite) forKey:@"is_favorite"];
    return [self postWithPath:CTGoods(@"favorite") params:params showHud:NO callback:callback];
}

//热搜和搜索历史
- (CLRequest *)searchHistoryWithCallback:(CTResponseBlock)callback{
    NSString *path = CLDocumentPath(@"search_history");
    
    NSDictionary *data = [[NSDictionary alloc]initWithContentsOfFile:path];
    if(callback && data){
        callback(data,nil,0);
    }
    return  [self postWithPath:CTGoods(@"search_history") params:nil showHud:NO callback:^(id data, CLRequest *request, CTNetError error) {
        if(callback){
            callback(data,request,error);
        }
        if(!error){
            [((NSDictionary *)data) writeToFile:path atomically:YES];
        }
    }];
   
}


//获取商品图片
- (CLRequest *)goodsImgWithItemId:(NSString *)itemId callback:(CTResponseBlock)callback{
    if(!itemId.length)return nil;
    NSString *jsonStr = [@{@"id":itemId,@"type":@"1"} yy_modelToJSONString];
    NSString *url = @"https://h5api.m.taobao.com/h5/mtop.taobao.detail.getdesc/6.0/?jsv=2.4.11&api=mtop.taobao.detail.getdesc&v=6.0&type=jsonp&dataType=jsonp";
    [[CLURLRequest request].setCustomUrl(url).setMethod(GET).setParams(@{@"data":jsonStr}).setCallBack(^(CLURLRequest * __nonnull request, id __nullable responseObject, NSError * __nullable error){
        if(!error){
            NSDictionary *contentData = responseObject[@"data"];
            if(contentData){
                NSString *html5 = contentData[@"pcDescContent"];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSArray <NSString *>*firstResults = [RegalurUtil resultsWithMatchString:html5 withRule:@"src=\"(.*?)\"\\s[^>]+size=\"(.*?)\""];
                NSMutableArray *secondResults = [NSMutableArray array];
                for(NSString *firstResult in firstResults){
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [secondResults addObject:dic];
                    NSArray *result1s = [RegalurUtil resultsWithMatchString:firstResult withRule:@"src=\"(.*?)\""];
                    if(result1s.count){
                        NSString *newResult = [[result1s.firstObject stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString:@"src=" withString:@""];
                        [dic setValue:[@"http:" stringByAppendingString:newResult] forKey:@"img"];
                    }
                    NSArray *result2s = [RegalurUtil resultsWithMatchString:firstResult withRule:@"size=\"(.*?)\""];
                    if(result2s.count){
                        NSString *sizeStr = result2s.firstObject;
                        NSString *newSizeStr = [[sizeStr stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString:@"size=" withString:@""];
                        [dic setValue:newSizeStr forKey:@"size"];
                        
                    }
                }
                NSLog(@"%@",secondResults);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(callback){
                        callback(secondResults,nil,CTNetErrorNone);
                    }
                });
                });
            }
        }
    }) start];
    return nil;
}
@end
