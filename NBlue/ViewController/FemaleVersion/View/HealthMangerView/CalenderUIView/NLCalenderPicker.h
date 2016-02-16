//
//  NLCalenderPicker.h
//  NBlue
//
//  Created by LYD on 15/12/15.
//  Copyright © 2015年 LYD. All rights reserved.
//

@protocol NLCalenderPickerDelegate <NSObject>

-(void)pickerIndex:(NSInteger)index;

@end

#import <UIKit/UIKit.h>

@interface NLCalenderPicker : UIView
@property(nonatomic,assign)id<NLCalenderPickerDelegate>delegate;
@end
