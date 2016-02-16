//
//  NLUserInformat.h
//  NBlue
//
//  Created by LYD on 15/12/26.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLUserInformat : NSObject

@property(nonatomic,strong)UILabel *imageUrl;
@property(nonatomic,strong)UILabel *userName;
@property(nonatomic,strong)UILabel *age;
@property(nonatomic,strong)UILabel *height;
@property(nonatomic,strong)UILabel *width;
@property(nonatomic,strong)UILabel *periodTime;
@property(nonatomic,strong)UILabel *cycleTime;

- (instancetype)initWithDic:(NSDictionary *)dic;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
