//
//  SystemDefinition.h
//  TangBangMathJong
//
//  Created by JoshuaGeng on 16/3/21.
//  Copyright © 2016年 Joshua. All rights reserved.
//

/**
 *  系统属性的 宏定义 以DEF_ 开头
 */

#ifndef SystemDefinition_h
#define SystemDefinition_h

/**
 *	获取视图宽度
 *
 *	@param 	view 	视图对象
 *
 *	@return	宽度
 */
#define DEF_WIDTH(view) view.bounds.size.width

/**
 *	获取视图高度
 *
 *	@param 	view 	视图对象
 *
 *	@return	高度
 */
#define DEF_HEIGHT(view) view.bounds.size.height

/**
 *	获取视图原点横坐标
 *
 *	@param 	view 	视图对象
 *
 *	@return	原点横坐标
 */
#define DEF_LEFT(view) view.frame.origin.x

/**
 *	获取视图原点纵坐标
 *
 *	@param 	view 	视图对象
 *
 *	@return	原点纵坐标
 */
#define DEF_TOP(view) view.frame.origin.y

/**
 *	获取视图右下角横坐标
 *
 *	@param 	view 	视图对象
 *
 *	@return	右下角横坐标
 */
#define DEF_RIGHT(view) (DEF_LEFT(view) + DEF_WIDTH(view))

/**
 *	获取视图右下角纵坐标
 *
 *	@param 	view 	视图对象
 *
 *	@return	右下角纵坐标
 */
#define DEF_BOTTOM(view) (DEF_TOP(view) + DEF_HEIGHT(view))

/**
 *  主屏的宽
 */
#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  主屏的高
 */
#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

/**
 *  主屏的size
 */
#define DEF_SCREEN_SIZE   [[UIScreen mainScreen] bounds].size

/**
 *  主屏的frame
 */
#define DEF_SCREEN_FRAME  [UIScreen mainScreen].applicationFrame



#define IPHONE4     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE5S     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6P    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define ViewHeight(height) (height * (IPHONE4 ? 1.0 : (IPHONE5S ? 1.0 : (IPHONE6 ? 1.1718 : (IPHONE6P ? 1.2937 : height)))))

/**
 *	生成RGB颜色
 *
 *	@param 	red 	red值（0~255）
 *	@param 	green 	green值（0~255）
 *	@param 	blue 	blue值（0~255）
 *
 *	@return	UIColor对象
 */
#define DEF_RGB_COLOR(_red, _green, _blue) [UIColor colorWithRed:(_red)/255.0f green:(_green)/255.0f blue:(_blue)/255.0f alpha:1]

/**
 *	生成RGBA颜色
 *
 *	@param 	red 	red值（0~255）
 *	@param 	green 	green值（0~255）
 *	@param 	blue 	blue值（0~255）
 *	@param 	alpha 	blue值（0~1）
 *
 *	@return	UIColor对象
 */
#define DEF_RGBA_COLOR(_red, _green, _blue, _alpha) [UIColor colorWithRed:(_red)/255.0f green:(_green)/255.0f blue:(_blue)/255.0f alpha:(_alpha)]

/**
 *	生成RGB颜色
 *
 *	@param 	rgb 	RGB颜色值（必须0x开头，例如:0xffffff）
 *
 *	@return	UIColor对象
 */
#define DEF_RGB_INT_COLOR(rgb) [UIColor colorWithRGB:rgb]

/**
 *	生成RGBA颜色
 *
 *	@param 	string 	颜色描述字符串，带“＃”开头
 *
 *	@return	UIColor对象
 */
#define DEF_STRING_COLOR(string) [UIColor colorWithString:string]


/** 随机色 */
#define DEF_RANDOM_COLOR DEF_RGB_COLOR(arc4random_uniform(256.0),arc4random_uniform(256.0),arc4random_uniform(256.0))


/**
 *	永久存储对象
 *
 *	@param	object    需存储的对象
 *	@param	key    对应的key
 */
#define DEF_PERSISTENT_SET_OBJECT(object, key)                                                                                                 \
({                                                                                                                                             \
NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];                                                                         \
[defaults setObject:object forKey:key];                                                                                                    \
[defaults synchronize];                                                                                                                    \
})

/**
 *	取出永久存储的对象
 *
 *	@param	key    所需对象对应的key
 *	@return	key所对应的对象
 */
#define DEF_PERSISTENT_GET_OBJECT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]


#if TARGET_IPHONE_SIMULATOR
#define DEF_SIMULATOR 1 // 模拟器
#elif TARGET_OS_IPHONE
#define DEF_SIMULATOR 0 // 真机
#endif

// 获取沙盒主目录路径
#define DEF_Sandbox_HomeDir     NSHomeDirectory()


// 获取tmp目录路径
#define DEF_TmpDir              NSTemporaryDirectory()


// 获取Documents目录路径
#define DEF_DocumentsDir        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


// 获取Caches目录路径
#define DEF_CachesDir           [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]


//获取系统版本
#define DEF_CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define DEF_CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//----------------------图片----------------------------
//建议使用前两种宏定义,性能高于后者 宏定义不能自动提示图片名称
//读取本地图片 需要全称包括 @2x
#define DEF_LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象 需要显示全称，包括.png
#define DEF_IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
//#define DEF_ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//方正黑体简体字体定义
#define DEF_FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]

//由角度获取弧度 有弧度获取角度
#define DEF_degreesToRadian(x) (M_PI * (x) / 180.0)
#define DEF_radianToDegrees(radian) (radian*180.0)/(M_PI)

//程序的本地化,引用国际化的文件
#define DEF_MyLocal(x, ...) NSLocalizedString(x, nil)

// block 防止循环引用
#define weakSelf(wSelf) __weak __typeof(self) wSelf = self

#define DEF_NAV_H 64 // 导航高度
#define DEF_TABBAR_H 49 // tabbar高度


#endif /* SystemDefinition_h */
