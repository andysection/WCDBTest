//
//  GDModel.m
//  GoDap
//
//  Created by Damion on 2018/3/1.
//  Copyright © 2018年 dingtone. All rights reserved.
//

#import "GDModel.h"

@implementation GDModel

///object转成Model
- (instancetype)initWithObject:(id)object {
    self = [super init];
    if (self) {
        self = [[self class] JSONModelWithKeyValues:object];
    }
    return self;
}

//字典一些属性我们不需要时, 即我们模型的属性与字典的key不一一匹配时, 使用该方法会报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    //    NSLog(@"key = %@, value = %@", key, value);
}

#pragma mark - LPModel
+ (instancetype)JSONModelWithKeyValues:(id)keyValues {
    if ([keyValues isKindOfClass:[NSString class]]) {
        keyValues = [self repalceToJsonFormat:keyValues];
    }
    return [self mj_objectWithKeyValues:keyValues context:nil];
}

+ (instancetype)objectWithKeyValues:(id)keyValues {
    return [self mj_objectWithKeyValues:keyValues context:nil];
}

+ (NSMutableArray *)keyValuesArrayWithObjectArray:(id)keyValuesArray {
    return [self mj_keyValuesArrayWithObjectArray:keyValuesArray];
}

+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray{
    
    return [self mj_objectArrayWithKeyValuesArray:keyValuesArray];
}

+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray type:(NSUInteger)type {
    return [self mj_objectArrayWithKeyValuesArray:keyValuesArray];
}

+ (NSString *)repalceToJsonFormat:(NSString *)originString {
    NSMutableString *s = [NSMutableString stringWithString:originString];
    //    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //[s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}


/**
 * 值为空nil 返回@""
 */
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if (oldValue == nil || [oldValue isKindOfClass:[NSNull class]]) {
        if ([property.type.typeClass isSubclassOfClass:[NSArray class]]) {
            if ([property.type.typeClass isSubclassOfClass:[NSMutableArray class]]) {
                return [NSMutableArray array];
            }else
            {
                return @[];
            }
        }
        else if ([property.type.typeClass isSubclassOfClass:[NSDictionary class]]) {
            if ([property.type.typeClass isSubclassOfClass:[NSMutableDictionary class]]) {
                return [NSMutableDictionary dictionary];
            }else
            {
                return @{};
            }
        }
        else if ([property.type.typeClass isSubclassOfClass:[NSNumber class]]) {
            return @(0);
        }
        else if ([property.type.typeClass isSubclassOfClass:[NSString class]]) {
            return @"";
        }
        else if (property.type.isBoolType) {
            return FALSE;
        }
        return nil;
    }
    
    if ([self respondsToSelector:@selector(JSONTransformerFromOldValue:key:)]) {
        return [self JSONTransformerFromOldValue:oldValue key:property.name];
    }
    
    return oldValue;
}

#pragma mark - copying & coding
-(instancetype)copyWithZone:(NSZone *)zone {
    return [NSKeyedUnarchiver unarchiveObjectWithData:
            [NSKeyedArchiver archivedDataWithRootObject:self]
            ];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [self mj_decode:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [self mj_encode:encoder];
}

+ (NSArray *)mj_ignoredCodingPropertyNames {
    return @[@"superclass",@"hash",@"description",@"debugDescription",@"db_id",@"cellHeight"];
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"superclass",@"hash",@"description",@"debugDescription",@"isSelected",@"db_id",@"cellHeight"];
}

#pragma mark - protocol
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    if ([self respondsToSelector:@selector(JSONMappingWithNSDictionary)]) {
        return [self JSONMappingWithNSDictionary];
    }
    
    return nil;
}

+ (NSDictionary *)mj_objectClassInArray {
    if ([self respondsToSelector:@selector(arrayTransformerWithModelClass)]) {
        return [self arrayTransformerWithModelClass];
    }
    
    return nil;
}

@end
