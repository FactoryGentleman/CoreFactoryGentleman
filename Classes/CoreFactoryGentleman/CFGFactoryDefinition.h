#import <FactoryGentleman/FGFactoryDefinition.h>

@interface CFGFactoryDefinition : FGFactoryDefinition
@property (nonatomic, readonly) NSDictionary *coreFieldDefinitions;

- (instancetype)initWithBaseDefinition:(FGFactoryDefinition *)baseDefinition
                  coreFieldDefinitions:(NSDictionary *)coreFieldDefinitions;
@end
