#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <FactoryGentleman/FactoryGentleman.h>
#import <FactoryGentleman/FGObjectBuilder.h>

#import "CFGFactoryDefinition.h"

@interface CFGObjectBuilder : FGObjectBuilder
- (instancetype)initWithContext:(NSManagedObjectContext *)context
                    objectClass:(Class)objectClass
                       readonly:(BOOL)readonly
                     definition:(CFGFactoryDefinition *)definition;

- (id)create;
@end
