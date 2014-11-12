#import "CFGFactoryDefinition.h"

@implementation CFGFactoryDefinition

#pragma mark - Initialization

- (instancetype)initWithBaseDefinition:(FGFactoryDefinition *)baseDefinition
                  coreFieldDefinitions:(NSDictionary *)coreFieldDefinitions
{
    self = [super initWithConstructor:baseDefinition.constructor
                initializerDefinition:baseDefinition.initializerDefinition
                     fieldDefinitions:baseDefinition.fieldDefinitions];
    if (self) {
        NSParameterAssert(coreFieldDefinitions);
        _coreFieldDefinitions = coreFieldDefinitions;
    }
    return self;
}

- (instancetype)mergedWithDefinition:(id)other
{
    CFGFactoryDefinition *otherDefinition = other;
    return [[CFGFactoryDefinition alloc] initWithBaseDefinition:[super mergedWithDefinition:otherDefinition]
                                           coreFieldDefinitions:[self mergedCoreFieldDefinitionsWith:otherDefinition.coreFieldDefinitions
                                                                             minusOtherFieldsDefined:otherDefinition.fieldDefinitions.allKeys]];
}

#pragma mark - Private

- (NSDictionary *)mergedCoreFieldDefinitionsWith:(NSDictionary *)otherCoreFieldDefinitions
                         minusOtherFieldsDefined:(NSArray *)otherFieldsDefined
{
    NSMutableDictionary *mergedFieldDefinitions = [self.coreFieldDefinitions mutableCopy];
    for (NSString *fieldName in otherFieldsDefined) {
        [mergedFieldDefinitions removeObjectForKey:fieldName];
    }
    [mergedFieldDefinitions addEntriesFromDictionary:otherCoreFieldDefinitions];
    return [mergedFieldDefinitions copy];
}

@end
