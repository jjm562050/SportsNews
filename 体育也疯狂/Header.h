//
//  Header.h
//  体育也疯狂
//
//  Created by MAC22 on 15/10/14.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#ifndef ______Header_h
#define ______Header_h


/*
  
 视频
 中超：http://platform.sina.com.cn/sports_client/feed?app_key=2586208540&feed_id=698&f=title%2Curl%2Ccategoryid%2Cimg%2Ccomment_show%2Cctime%2Cvid%2Cvideo_info&num=20&pdps_params=%7B%22app%22%3A%7B%22timestamp%22%3A%221426662145292%22%2C%22os%22%3A%22Android%22%2C%22model%22%3A%22MI+2SC%22%2C%22device_type%22%3A%224%22%2C%22osv%22%3A%224.1.1%22%2C%22name%22%3A%22cn.com.sina.sports%22%2C%22carrier%22%3A%22%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1%22%2C%22device_id%22%3A%2299000519437585%22%2C%22make%22%3A%22MI+2SC%22%2C%22channel%22%3A%22%22%2C%22connection_type%22%3A%222%22%2C%22version%22%3A30000012%2C%22ip%22%3A%2210.0.2.15%22%7D%7D
 亚冠：http://platform.sina.com.cn/sports_client/feed?app_key=2586208540&feed_id=699&f=title%2Curl%2Ccategoryid%2Cimg%2Ccomment_show%2Cctime%2Cvid%2Cvideo_info&num=20&pdps_params=%7B%22app%22%3A%7B%22timestamp%22%3A%221426672296479%22%2C%22os%22%3A%22Android%22%2C%22model%22%3A%22MI+2SC%22%2C%22device_type%22%3A%224%22%2C%22osv%22%3A%224.1.1%22%2C%22name%22%3A%22cn.com.sina.sports%22%2C%22carrier%22%3A%22%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1%22%2C%22device_id%22%3A%2299000519437585%22%2C%22make%22%3A%22MI+2SC%22%2C%22channel%22%3A%22%22%2C%22connection_type%22%3A%222%22%2C%22version%22%3A30000012%2C%22ip%22%3A%2210.0.2.15%22%7D%7D
 欧冠：http://platform.sina.com.cn/sports_client/feed?app_key=2586208540&feed_id=700&f=title%2Curl%2Ccategoryid%2Cimg%2Ccomment_show%2Cctime%2Cvid%2Cvideo_info&num=20&pdps_params=%7B%22app%22%3A%7B%22timestamp%22%3A%221426660515117%22%2C%22os%22%3A%22Android%22%2C%22model%22%3A%22MI+2SC%22%2C%22device_type%22%3A%224%22%2C%22osv%22%3A%224.1.1%22%2C%22name%22%3A%22cn.com.sina.sports%22%2C%22carrier%22%3A%22%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1%22%2C%22device_id%22%3A%2299000519437585%22%2C%22make%22%3A%22MI+2SC%22%2C%22channel%22%3A%22%22%2C%22connection_type%22%3A%222%22%2C%22version%22%3A30000012%2C%22ip%22%3A%2210.0.2.15%22%7D%7D
 CBA:http://platform.sina.com.cn/sports_client/feed?app_key=2586208540&feed_id=708&f=title%2Curl%2Ccategoryid%2Cimg%2Ccomment_show%2Cctime%2Cvid%2Cvideo_info&ctime=1427037492&num=20&pdps_params=%7B%22app%22%3A%7B%22timestamp%22%3A%221426660181786%22%2C%22os%22%3A%22Android%22%2C%22model%22%3A%22MI+2SC%22%2C%22device_type%22%3A%224%22%2C%22osv%22%3A%224.1.1%22%2C%22name%22%3A%22cn.com.sina.sports%22%2C%22carrier%22%3A%22%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1%22%2C%22device_id%22%3A%2299000519437585%22%2C%22make%22%3A%22MI+2SC%22%2C%22channel%22%3A%22%22%2C%22connection_type%22%3A%222%22%2C%22version%22%3A30000012%2C%22ip%22%3A%2210.0.2.15%22%7D%7D
 
 新闻：
 头条：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=headline&page=1&page_size=12&screen_size=160x120&big_pic=1
 足球：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getList&catid=6&page=1&page_size=12&screen_size=160x120&big_pic=1
 篮球：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getList&catid=7&page=1&page_size=12&screen_size=160x120&big_pic=1
 综合：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getList&catid=12&page=1&page_size=12&screen_size=160x120&big_pic=1
 
 图库：
 
 热门：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getPictureList&hot=1&catid=15&page=1&page_size=12
 足球：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getPictureList&catid=54&page=1&page_size=12
 篮球：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getPictureList&catid=55&page=1&page_size=12
 综合：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getPictureList&catid=58&page=1&page_size=12
 明星：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getPictureList&catid=59&page=1&page_size=12
 
 
 
 */

#endif
