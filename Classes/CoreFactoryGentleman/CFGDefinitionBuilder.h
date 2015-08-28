#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <FactoryGentleman/FactoryGentleman.h>

@interface CFGDefinitionBuilder : FGDefinitionBuilder
- (instancetype)field:(NSString *)fieldName byContext:(id (^)(NSManagedObjectContext *))fieldValueBlock;
- (instancetype)field:(NSString *)fieldName coreAssoc:(Class)fieldClass;
- (instancetype)field:(NSString *)fieldName coreAssoc:(Class)fieldClass with:(id)definer;
- (instancetype)field:(NSString *)fieldName coreAssoc:(Class)fieldClass trait:(NSString *)trait;
- (instancetype)field:(NSString *)fieldName coreAssoc:(Class)fieldClass trait:(NSString *)trait with:(id)definer;
@end
