//
//  NLApiURL.h
//  pinai
//
//  Created by LYD on 15/11/19.
//  Copyright © 2015年 LYD. All rights reserved.
//

#ifndef NLApiURL_h
#define NLApiURL_h
#define API_BASE_URL(_URL_) [NSString stringWithFormat:@"http://123.56.127.139/warman%@",_URL_]


//获取验证码
#define User_GetRegistercode @"/registercode?phone="
//注册
#define User_register @"/register"
#define User_Login @"/login"
#define Sport_record @"/record"
#define User_Consumer @"/consumer"
#define User_QRCode @"/folk"
#define user_ForgetPassWord @"/updatepwd"
#define User_MenstruationRecord @"/record"
#define Folk_Permission @"/permission"
#define User_ThirdLogin @"/thirdlogin"
#endif /* NLApiURL_h */
