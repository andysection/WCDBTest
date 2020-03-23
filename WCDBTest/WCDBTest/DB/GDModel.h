//
//  GDModel.h
//  GoDap
//
//  Created by Damion on 2018/3/1.
//  Copyright © 2018年 dingtone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MJExtension.h"

@protocol GDModel <NSObject>
@optional

/**
 *  通过字典来创建一个映射
 *  @return 映射
 */
+ (NSDictionary *)JSONMappingWithNSDictionary;


/**
 *  json->model数组
 */

+ (NSDictionary *)arrayTransformerWithModelClass;

- (id)JSONTransformerFromOldValue:(id)oldValue key:(NSString *)key;

@end

@interface GDModel : NSObject <GDModel, NSCopying, NSCoding>

@property (nonatomic, assign) long db_id;

/**
 *  属性：是否被选中
 */
@property (nonatomic, assign) BOOL isSelected;

/**
 属性：如果是列表类的model，cell高度
 */
@property (nonatomic, assign) CGFloat cellHeight;


///object转成Model(object可以是json字符串，也可以是字典)
- (instancetype)initWithObject:(id)object;

#pragma mark - 字典转模型
/**
 *  通过字典来创建一个模型
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @return 新建的对象
 */
+ (instancetype)JSONModelWithKeyValues:(id)keyValues;

/**
 通过json字符串创建一个模型
 
 @param keyValues json字符串
 @return 新建的对象
 */
+ (instancetype)objectWithKeyValues:(id)keyValues;

/**
 通过一组字典数组转成一组模型数组
 
 @param keyValuesArray keyValues数组
 @return 存储一组Model的可变数组
 */
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray;


/**
 工厂模式：通过一组字典数组转成一组模型数组【子类实现后可生产对应的模型】
 
 @param keyValuesArray keyValues数组
 @param type 模型类型[工厂模式]
 @return 存储一组Model的可变数组
 */
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray type:(NSUInteger)type;

/**
 通过一组模型数组转成一组字典数组
 
 @param keyValuesArray 模型数组
 @return 字典数组
 */
+ (NSMutableArray *)keyValuesArrayWithObjectArray:(id)keyValuesArray;

@end
