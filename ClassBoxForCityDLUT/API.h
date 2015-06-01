//
//  API.h
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/4.
//  Copyright (c) 2015年 DavidHu. All rights reserved.
//

#import <Foundation/Foundation.h>


#define NewsAPI     @"http://1.csxyxzs.sinaapp.com/xyxw.php"
#define ReportsAPI  @"http://1.csxyxzs.sinaapp.com/xygg.php"
#define VerifyAPI   @"http://1.csxyxzs1.sinaapp.com/verify?name=%@&password=%@"                               //验证登录
#define ProfileAPI  @"http://1.csxyxzs1.sinaapp.com/info?name=%@&password=%@"                                //个人信息
#define ClassesAPI  @"http://1.csxyxzs1.sinaapp.com/schedule?name=%@&password=%@&term=%ld"
#define LibraryAPI  @"http://1.csxyxzs.sinaapp.com/library.php?book_name=%@"
#define ExaminationAPI @"http://1.csxyxzs1.sinaapp.com/grades?name=%@&password=%@&term=%ld"

/*
 成绩 http://1.csxyxzs1.sinaapp.com/grades?name=%s&password=%s[&term=%s]
 
 CET 4/6 http://1.csxyxzs1.sinaapp.com/cet?num=%s&name=%s
 
 快递 http://1.csxyxzs1.sinaapp.com/kuaidi?postid=%snote:返回跳转链接。未处理跳转链接数据
 
 大连天气：http://v.juhe.cn/weather/index?cityname=%E5%A4%A7%E8%BF%9E&key=9a8dc37abaf5e2e97ccdb17f27765a2a
 
 教师课程表
 http://1.csxyxzs1.sinaapp.com/teacher_schedule?id=%d
 
 通识课接口
 http://1.csxyxzs1.sinaapp.com/general_course?name=%s&password=%s
 
 简易版个人信息接口http://1.csxyxzs1.sinaapp.com/info?name=%s&password=%s
 */
