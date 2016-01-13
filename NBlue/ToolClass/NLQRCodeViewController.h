//
//  NLQRCodeViewController.h
//  NBlue
//
//  Created by LYD on 16/1/12.
//  Copyright © 2016年 LYD. All rights reserved.
//

typedef void  (^QRCount)(NSString *count);

#import "NLSubRootViewController.h"

@interface NLQRCodeViewController : NLSubRootViewController
@property(nonatomic,strong)QRCount qrCount;

@end
