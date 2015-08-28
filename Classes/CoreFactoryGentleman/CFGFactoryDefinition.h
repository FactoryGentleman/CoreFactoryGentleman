#import <Foundation/Foundation.h>
#import <FactoryGentleman/FactoryGentleman.h>

@interface CFGFactoryDefinition : FGFactoryDefinition
@property (nonatomic, readonly) NSDictionary *coreFieldDefinitions;

- (instancetype)initWithBaseDefinition:(FGFactoryDefinition *)baseDefinition
                  coreFieldDefinitions:(NSDictionary *)coreFieldDefinitions;

- (instancetype)mergedWithDefinition:(id)other;
@end
