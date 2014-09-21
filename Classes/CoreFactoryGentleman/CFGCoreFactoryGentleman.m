#import "CFGCoreFactoryGentleman.h"

#import <FactoryGentleman/FGFactoryGentleman.h>
#import <FactoryGentleman/FGFactoryDefinitionRegistry.h>

#import "CFGObjectBuilder.h"

@implementation CFGCoreFactoryGentleman

- (id)buildForContext:(NSManagedObjectContext *)context
          objectClass:(Class)objectClass
             readonly:(BOOL)readonly
{
    NSParameterAssert(context);
    NSParameterAssert(objectClass);
    CFGFactoryDefinition *coreDefinition = [self coreDefinitionForContext:context
                                                              objectClass:objectClass];
    CFGFactoryDefinition *baseDefinition = [self definitionForObjectClass:objectClass];
    CFGFactoryDefinition *finalDefinition = [coreDefinition mergedWithDefinition:baseDefinition];
    return [[[CFGObjectBuilder alloc] initWithContext:context
                                          objectClass:objectClass
                                             readonly:readonly
                                           definition:finalDefinition] build];
}

- (id)buildForContext:(NSManagedObjectContext *)context
          objectClass:(Class)objectClass
             readonly:(BOOL)readonly
                trait:(NSString *)trait
{
    NSParameterAssert(context);
    NSParameterAssert(objectClass);
    NSParameterAssert(trait);
    CFGFactoryDefinition *coreDefinition = [self coreDefinitionForContext:context
                                                              objectClass:objectClass];
    CFGFactoryDefinition *baseDefinition = [self definitionForObjectClass:objectClass];
    CFGFactoryDefinition *traitDefinition = [self definitionForObjectClass:objectClass
                                                                     trait:trait];
    CFGFactoryDefinition *finalDefinition = [[coreDefinition mergedWithDefinition:baseDefinition]
            mergedWithDefinition:traitDefinition];
    return [[[CFGObjectBuilder alloc] initWithContext:context
                                          objectClass:objectClass
                                             readonly:readonly
                                           definition:finalDefinition] build];
}

- (id)buildForContext:(NSManagedObjectContext *)context
          objectClass:(Class)objectClass
             readonly:(BOOL)readonly
   withFactoryDefiner:(id)factoryDefiner
{
    NSParameterAssert(context);
    NSParameterAssert(objectClass);
    NSParameterAssert(factoryDefiner);
    CFGFactoryDefinition *coreDefinition = [self coreDefinitionForContext:context
                                                              objectClass:objectClass];
    CFGFactoryDefinition *baseDefinition = [self definitionForObjectClass:objectClass];
    CFGFactoryDefinition *overriddenDefinition;
    if ([factoryDefiner isKindOfClass:[NSDictionary class]]) {
        overriddenDefinition = [self overriddenDefinitionFromDefinitionDictionary:factoryDefiner];
    } else {
        overriddenDefinition = [self overriddenDefinitionFromDefiner:factoryDefiner];
    }
    CFGFactoryDefinition *finalDefinition = [[coreDefinition mergedWithDefinition:baseDefinition]
            mergedWithDefinition:overriddenDefinition];
    return [[[CFGObjectBuilder alloc] initWithContext:context
                                          objectClass:objectClass
                                             readonly:readonly
                                           definition:finalDefinition] build];
}

- (id)buildForContext:(NSManagedObjectContext *)context
          objectClass:(Class)objectClass
             readonly:(BOOL)readonly
                trait:(NSString *)trait
   withFactoryDefiner:(id)factoryDefiner
{
    NSParameterAssert(context);
    NSParameterAssert(objectClass);
    NSParameterAssert(trait);
    NSParameterAssert(factoryDefiner);
    CFGFactoryDefinition *coreDefinition = [self coreDefinitionForContext:context
                                                              objectClass:objectClass];
    CFGFactoryDefinition *baseDefinition = [self definitionForObjectClass:objectClass];
    CFGFactoryDefinition *traitDefinition = [self definitionForObjectClass:objectClass
                                                                     trait:trait];
    CFGFactoryDefinition *overriddenDefinition;
    if ([factoryDefiner isKindOfClass:[NSDictionary class]]) {
        overriddenDefinition = [self overriddenDefinitionFromDefinitionDictionary:factoryDefiner];
    } else {
        overriddenDefinition = [self overriddenDefinitionFromDefiner:factoryDefiner];
    }
    CFGFactoryDefinition *finalDefinition = [[[coreDefinition mergedWithDefinition:baseDefinition]
            mergedWithDefinition:traitDefinition]
            mergedWithDefinition:overriddenDefinition];
    return [[[CFGObjectBuilder alloc] initWithContext:context
                                          objectClass:objectClass
                                             readonly:readonly
                                           definition:finalDefinition] build];
}

- (CFGFactoryDefinition *)coreDefinitionForContext:(NSManagedObjectContext *)context
                                       objectClass:(Class)objectClass
{
    CFGDefinitionBuilder *builder = [CFGDefinitionBuilder builder];
    [builder field:@"entityName" value:NSStringFromClass(objectClass)];
    [builder field:@"context" value:context];
    return (CFGFactoryDefinition *) [builder build];
}

- (CFGFactoryDefinition *)definitionForObjectClass:(Class)objectClass
{
    CFGFactoryDefinition *factoryDefinition = (CFGFactoryDefinition *) [[FGFactoryDefinitionRegistry sharedInstance]
            factoryDefinitionForObjectClass:objectClass];
    NSAssert(factoryDefinition, @"No core definition found for class %@", objectClass);
    return factoryDefinition;
}

- (CFGFactoryDefinition *)definitionForObjectClass:(Class)objectClass
                                             trait:(NSString *)trait
{
    CFGFactoryDefinition *factoryDefinition = (CFGFactoryDefinition *) [[FGFactoryDefinitionRegistry sharedInstance]
            factoryDefinitionForObjectClass:objectClass
                                      trait:trait];
    NSAssert(factoryDefinition, @"No core definition found for class %@ with trait %@", objectClass, trait);
    return factoryDefinition;
}

- (CFGFactoryDefinition *)overriddenDefinitionFromDefiner:(void (^)(CFGDefinitionBuilder *))factoryDefiner
{
    CFGDefinitionBuilder *builder = [CFGDefinitionBuilder builder];
    factoryDefiner(builder);
    return (CFGFactoryDefinition *) [builder build];
}

- (CFGFactoryDefinition *)overriddenDefinitionFromDefinitionDictionary:(NSDictionary *)definitionDictionary
{
    CFGDefinitionBuilder *builder = [CFGDefinitionBuilder builder];
    for (NSString *fieldName in definitionDictionary
            ) {
        [builder field:fieldName value:definitionDictionary[fieldName]];
    }
    return (CFGFactoryDefinition *) [builder build];
}

@end

id CFGBuild(NSManagedObjectContext *context, Class objectClass) {
    return [[[CFGCoreFactoryGentleman alloc] init] buildForContext:context
                                                       objectClass:objectClass
                                                          readonly:FGAllowReadonly];
}

id CFGBuildTrait(NSManagedObjectContext *context, Class objectClass, NSString *trait) {
    return [[[CFGCoreFactoryGentleman alloc] init] buildForContext:context
                                                       objectClass:objectClass
                                                          readonly:FGAllowReadonly
                                                             trait:trait];
}

id CFGBuildWith(NSManagedObjectContext *context, Class objectClass, id factoryDefiner) {
    return [[[CFGCoreFactoryGentleman alloc] init] buildForContext:context
                                                       objectClass:objectClass
                                                          readonly:FGAllowReadonly
                                                withFactoryDefiner:factoryDefiner];
}

id CFGBuildTraitWith(NSManagedObjectContext *context, Class objectClass, NSString *trait, id factoryDefiner) {
    return [[[CFGCoreFactoryGentleman alloc] init] buildForContext:context
                                                       objectClass:objectClass
                                                          readonly:FGAllowReadonly
                                                             trait:trait
                                                withFactoryDefiner:factoryDefiner];
}
