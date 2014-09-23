#import "CFGDefinitionBuilder.h"

#import <CoreData/CoreData.h>

#import "CFGCoreFactoryGentleman.h"
#import "CFGFactoryDefinition.h"

@interface CFGDefinitionBuilder ()
@property (nonatomic, readonly) NSMutableDictionary *coreFieldDefinitions;
@end

@implementation CFGDefinitionBuilder

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _coreFieldDefinitions = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (instancetype)builder
{
    CFGDefinitionBuilder *builder = [[self alloc] init];
    [builder initFrom:[NSEntityDescription class]];
    NSArray *fieldNames = @[ @"entityName", @"context" ];
    [builder initWith:@selector(insertNewObjectForEntityForName:inManagedObjectContext:) fieldNames:fieldNames];
    return builder;
}

#pragma mark - Definition

- (instancetype)field:(NSString *)fieldName byContext:(id (^)(NSManagedObjectContext *))fieldValueBlock
{
    [self.coreFieldDefinitions setObject:fieldValueBlock
                                  forKey:fieldName];
    return self;
}

- (instancetype)field:(NSString *)fieldName coreAssoc:(Class)fieldClass
{
    [self field:fieldName byContext:^(NSManagedObjectContext *context ){ return CFGBuild(context, fieldClass); }];
    return self;
}

- (instancetype)field:(NSString *)fieldName coreAssoc:(Class)fieldClass with:(id)definer
{
    [self field:fieldName byContext:^(NSManagedObjectContext *context ){ return CFGBuildWith(context, fieldClass, definer); }];
    return self;
}

- (instancetype)field:(NSString *)fieldName coreAssoc:(Class)fieldClass trait:(NSString *)trait
{
    [self field:fieldName byContext:^(NSManagedObjectContext *context ){ return CFGBuildTrait(context, fieldClass, trait); }];
    return self;
}

- (instancetype)field:(NSString *)fieldName coreAssoc:(Class)fieldClass trait:(NSString *)trait with:(id)definer
{
    [self field:fieldName byContext:^(NSManagedObjectContext *context ){ return CFGBuildTraitWith(context, fieldClass, trait, definer); }];
    return self;
}

#pragma mark - Building

- (CFGFactoryDefinition *)build
{
    return [[CFGFactoryDefinition alloc] initWithBaseDefinition:[super build]
                                           coreFieldDefinitions:self.coreFieldDefinitions];
}

@end
