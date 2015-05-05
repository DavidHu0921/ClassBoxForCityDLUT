//
//  API.h
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/4.
//  Copyright (c) 2015年 DavidHu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NewsAPI @"https://www.kimonolabs.com/api/bg3nrkz0?apikey=600efbca1fa20767b1ab92a9283f2b1d"

#define ReportsAPI @"https://www.kimonolabs.com/api/arrsbbjc?apikey=600efbca1fa20767b1ab92a9283f2b1d"

#define VerifyAPI @"http://1.csxyxzs1.sinaapp.com/verify?name=%@&password=%@"                               //验证登录

#define ProfileAPI @"http://1.csxyxzs1.sinaapp.com/info?name=%@&password=%@"                                //个人信息

//http://1.csxyxzs.sinaapp.com/xyxw.php 20个
//http://1.csxyxzs.sinaapp.com/xygg.php 20个，时间顺序从新到旧

/*
 图书馆 http://1.csxyxzs.sinaapp.com/library.php?book_name=%s
 http://csxyxzs.sinaapp.com/new_query.php?q=[]&p=[]&type=[]
 
 课程表 http://1.csxyxzs1.sinaapp.com/schedule?name=%s&password=%s[&term=%s]
 成绩 http://1.csxyxzs1.sinaapp.com/grades?name=%s&password=%s[&term=%s]
 
 halfcrazy 4月28日
 成绩，课表查询提速。
 
 halfcrazy 5月7日
 CET 4/6 http://1.csxyxzs1.sinaapp.com/cet?num=%s&name=%s
 
 halfcrazy 5月7日
 快递 http://1.csxyxzs1.sinaapp.com/kuaidi?postid=%snote:返回跳转链接。未处理跳转链接数据
 
 halfcrazy 5月18日
 大连天气：http://v.juhe.cn/weather/index?cityname=%E5%A4%A7%E8%BF%9E&key=9a8dc37abaf5e2e97ccdb17f27765a2a
 
 halfcrazy 5月19日
 在线代码格式化（可以贴json）http://tool.oschina.net/codeformat/json
 
 halfcrazy 8月12日
 教师课程表
 http://1.csxyxzs1.sinaapp.com/teacher_schedule?id=%d
 
 halfcrazy 9月5日
 通识课接口
 http://1.csxyxzs1.sinaapp.com/general_course?name=%s&password=%s
 
 halfcrazy 9月7日
 简易版个人信息接口http://1.csxyxzs1.sinaapp.com/info?name=%s&password=%s
 */
