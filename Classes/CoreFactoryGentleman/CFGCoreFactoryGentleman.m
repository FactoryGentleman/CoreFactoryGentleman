#import "CFGCoreFactoryGentleman.h"

#import <FactoryGentleman/FGFactoryGentleman.h>
#import <FactoryGentleman/FGFactoryDefinitionRegistry.h>

#import "CFGObjectBuilder.h"

@implementation CFGCoreFactoryGentleman

#pragma mark - Public

- (id)createForContext:(NSManagedObjectContext *)context
           objectClass:(Class)objectClass
              readonly:(BOOL)readonly
{
    CFGFactoryDefinition *definition = [self coreDefinitionForContext:context
                                                          objectClass:objectClass];
    return [[[CFGObjectBuilder alloc] initWithContext:context
                                          objectClass:objectClass
                                             readonly:readonly
                                           definition:definition] create];
}

- (id)buildForContext:(NSManagedObjectContext *)context
          objectClass:(Class)objectClass
             readonly:(BOOL)readonly
{
    CFGFactoryDefinition *definition = [self coreDefinitionForContext:context
                                                          objectClass:objectClass];
    return [[[CFGObjectBuilder alloc] initWithContext:context
                                          objectClass:objectClass
                                             readonly:readonly
                                           definition:definition] build];
}

- (id)createForContext:(NSManagedObjectContext *)context
           objectClass:(Class)objectClass
              readonly:(BOOL)readonly
                 trait:(NSString *)trait
{
    CFGFactoryDefinition *definition = [self coreDefinitionForContext:context
                                                          objectClass:objectClass
                                                                trait:trait];
    return [[[CFGObjectBuilder alloc] initWithContext:context
                                          objectClass:objectClass
                                             readonly:readonly
                                           definition:definition] create];
}

- (id)buildForContext:(NSManagedObjectContext *)context
          objectClass:(Class)objectClass
             readonly:(BOOL)readonly
                trait:(NSString *)trait
{
    CFGFactoryDefinition *definition = [self coreDefinitionForContext:context
                                                          objectClass:objectClass
                                                                trait:trait];
    return [[[CFGObjectBuilder alloc] initWithContext:context
                                          objectClass:objectClass
                                             readonly:readonly
                                           definition:definition] build];
}

- (id)createForContext:(NSManagedObjectContext *)context
           objectClass:(Class)objectClass
              readonly:(BOOL)readonly
    withFactoryDefiner:(id)factoryDefiner
{
    CFGFactoryDefinition *definition = [self coreDefinitionForContext:context
                                                          objectClass:objectClass
                                                       factoryDefiner:factoryDefiner];
    return [[[CFGObjectBuilder alloc] initWithContext:context
                                          objectClass:objectClass
                                             readonly:readonly
                                           definition:definition] create];
}

- (id)buildForContext:(NSManagedObjectContext *)context
          objectClass:(Class)objectClass
             readonly:(BOOL)readonly
   withFactoryDefiner:(id)factoryDefiner
{
    CFGFactoryDefinition *definition = [self coreDefinitionForContext:context
                                                          objectClass:objectClass
                                                       factoryDefiner:factoryDefiner];
    return [[[CFGObjectBuilder alloc] initWithContext:context
                                          objectClass:objectClass
                                             readonly:readonly
                                           definition:definition] build];
}

- (id)createForContext:(NSManagedObjectContext *)context
           objectClass:(Class)objectClass
              readonly:(BOOL)readonly
                 trait:(NSString *)trait
    withFactoryDefiner:(id)factoryDefiner
{
    CFGFactoryDefinition *definition = [self coreDefinitionForContext:context
                                                          objectClass:objectClass
                                                                trait:trait
                                                       factoryDefiner:factoryDefiner];
    return [[[CFGObjectBuilder alloc] initWithContext:context
                                          objectClass:objectClass
                                             readonly:readonly
                                           definition:definition] create];
}

- (id)buildForContext:(NSManagedObjectContext *)context
          objectClass:(Class)objectClass
             readonly:(BOOL)readonly
                trait:(NSString *)trait
   withFactoryDefiner:(id)factoryDefiner
{
    CFGFactoryDefinition *definition = [self coreDefinitionForContext:context
                                                          objectClass:objectClass
                                                                trait:trait
                                                       factoryDefiner:factoryDefiner];
    return [[[CFGObjectBuilder alloc] initWithContext:context
                                          objectClass:objectClass
                                             readonly:readonly
                                           definition:definition] build];
}

#pragma mark - Private

- (CFGFactoryDefinition *)coreDefinitionForContext:(NSManagedObjectContext *)context
                                       objectClass:(Class)objectClass
{
    CFGFactoryDefinition *coreDefinition = [self baseCoreDefinitionForContext:context
                                                                  objectClass:objectClass];
    CFGFactoryDefinition *baseDefinition = [self definitionForObjectClass:objectClass];
    return [coreDefinition mergedWithDefinition:baseDefinition];
}


- (CFGFactoryDefinition *)coreDefinitionForContext:(NSManagedObjectContext *)context
                                       objectClass:(Class)objectClass
                                             trait:(NSString *)trait
{
    CFGFactoryDefinition *traitDefinition = [self definitionForObjectClass:objectClass
                                                                     trait:trait];
    return [[self coreDefinitionForContext:context
                               objectClass:objectClass] mergedWithDefinition:traitDefinition];
}

- (CFGFactoryDefinition *)coreDefinitionForContext:(NSManagedObjectContext *)context
                                       objectClass:(Class)objectClass
                                    factoryDefiner:(id)factoryDefiner
{
    CFGFactoryDefinition *overriddenDefinition = [self overriddenDefinitionFromFactoryDefiner:factoryDefiner];
    return [[self coreDefinitionForContext:context
                               objectClass:objectClass] mergedWithDefinition:overriddenDefinition];
}

- (CFGFactoryDefinition *)coreDefinitionForContext:(NSManagedObjectContext *)context
                                       objectClass:(Class)objectClass
                                             trait:(NSString *)trait
                                    factoryDefiner:(id)factoryDefiner
{
    CFGFactoryDefinition *overriddenDefinition = [self overriddenDefinitionFromFactoryDefiner:factoryDefiner];
    return [[self coreDefinitionForContext:context
                               objectClass:objectClass
                                     trait:trait] mergedWithDefinition:overriddenDefinition];
}

- (CFGFactoryDefinition *)baseCoreDefinitionForContext:(NSManagedObjectContext *)context
                                           objectClass:(Class)objectClass
{
    NSParameterAssert(context);
    NSParameterAssert(objectClass);
    CFGDefinitionBuilder *builder = [CFGDefinitionBuilder builder];
    [builder field:@"entityName" value:NSStringFromClass(objectClass)];
    [builder field:@"context" value:context];
    return (CFGFactoryDefinition *) [builder build];
}

- (CFGFactoryDefinition *)definitionForObjectClass:(Class)objectClass
{
    NSParameterAssert(objectClass);
    CFGFactoryDefinition *factoryDefinition = (CFGFactoryDefinition *) [[FGFactoryDefinitionRegistry sharedInstance]
            factoryDefinitionForObjectClass:objectClass];
    NSAssert(factoryDefinition, @"No core definition found for class %@", objectClass);
    return factoryDefinition;
}

- (CFGFactoryDefinition *)definitionForObjectClass:(Class)objectClass
                                             trait:(NSString *)trait
{
    NSParameterAssert(objectClass);
    NSParameterAssert(trait);
    CFGFactoryDefinition *factoryDefinition = (CFGFactoryDefinition *) [[FGFactoryDefinitionRegistry sharedInstance]
            factoryDefinitionForObjectClass:objectClass
                                      trait:trait];
    NSAssert(factoryDefinition, @"No core definition found for class %@ with trait %@", objectClass, trait);
    return factoryDefinition;
}

- (CFGFactoryDefinition *)overriddenDefinitionFromFactoryDefiner:(id)factoryDefiner
{
    if ([factoryDefiner isKindOfClass:[NSDictionary class]]) {
        return [self overriddenDefinitionFromDefinitionDictionary:factoryDefiner];
    } else {
        return [self overriddenDefinitionFromDefinitionBlock:factoryDefiner];
    }
}

- (CFGFactoryDefinition *)overriddenDefinitionFromDefinitionBlock:(void (^)(CFGDefinitionBuilder *))definitionBlock
{
    NSParameterAssert(definitionBlock);
    CFGDefinitionBuilder *builder = [CFGDefinitionBuilder builder];
    definitionBlock(builder);
    return (CFGFactoryDefinition *) [builder build];
}

- (CFGFactoryDefinition *)overriddenDefinitionFromDefinitionDictionary:(NSDictionary *)definitionDictionary
{
    NSParameterAssert(definitionDictionary);
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

id CFGCreate(NSManagedObjectContext *context, Class objectClass) {
    return [[[CFGCoreFactoryGentleman alloc] init] createForContext:context
                                                        objectClass:objectClass
                                                           readonly:FGAllowReadonly];
}

id CFGCreateTrait(NSManagedObjectContext *context, Class objectClass, NSString *trait) {
    return [[[CFGCoreFactoryGentleman alloc] init] createForContext:context
                                                        objectClass:objectClass
                                                           readonly:FGAllowReadonly
                                                              trait:trait];
}

id CFGCreateWith(NSManagedObjectContext *context, Class objectClass, id factoryDefiner) {
    return [[[CFGCoreFactoryGentleman alloc] init] createForContext:context
                                                        objectClass:objectClass
                                                           readonly:FGAllowReadonly
                                                 withFactoryDefiner:factoryDefiner];
}

id CFGCreateTraitWith(NSManagedObjectContext *context, Class objectClass, NSString *trait, id factoryDefiner) {
    return [[[CFGCoreFactoryGentleman alloc] init] createForContext:context
                                                        objectClass:objectClass
                                                           readonly:FGAllowReadonly
                                                              trait:trait
                                                 withFactoryDefiner:factoryDefiner];
}
