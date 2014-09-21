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

@end
