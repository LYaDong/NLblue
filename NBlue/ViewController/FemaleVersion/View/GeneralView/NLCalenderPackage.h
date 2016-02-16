//
//  NLCalenderPackage.h
//  NBlue
//
//  Created by LYD on 15/11/25.
//  Copyright © 2015年 LYD. All rights reserved.
//

@protocol NLCalenderPackageDelegate <NSObject>

-(void)returnCalenderTime:(NSString *)time;

@end

#import <UIKit/UIKit.h>
@interface NLCalenderPackage : UIView
@property(nonatomic,assign)id<NLCalenderPackageDelegate>delegate;

@end
