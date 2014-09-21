#import "CFGFactoryDefinition.h"

#import <FactoryGentleman/FGObjectBuilder.h>

@interface CFGObjectBuilder : FGObjectBuilder
- (instancetype)initWithContext:(NSManagedObjectContext *)context
                    objectClass:(Class)objectClass
                       readonly:(BOOL)readonly
                     definition:(CFGFactoryDefinition *)definition;
@end
