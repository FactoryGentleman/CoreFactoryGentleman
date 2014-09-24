#import "CFGFactoryDefiner.h"

@interface CFGCoreFactoryGentleman : NSObject
- (id)createForContext:(NSManagedObjectContext *)context
           objectClass:(Class)objectClass
              readonly:(BOOL)readonly;

- (id)buildForContext:(NSManagedObjectContext *)context
          objectClass:(Class)objectClass
             readonly:(BOOL)readonly;

- (id)createForContext:(NSManagedObjectContext *)context
           objectClass:(Class)objectClass
              readonly:(BOOL)readonly
                 trait:(NSString *)trait;

- (id)buildForContext:(NSManagedObjectContext *)context
          objectClass:(Class)objectClass
             readonly:(BOOL)readonly
                trait:(NSString *)trait;

- (id)createForContext:(NSManagedObjectContext *)context
           objectClass:(Class)objectClass
              readonly:(BOOL)readonly
    withFactoryDefiner:(id)factoryDefiner;

- (id)buildForContext:(NSManagedObjectContext *)context
          objectClass:(Class)objectClass
             readonly:(BOOL)readonly
   withFactoryDefiner:(id)factoryDefiner;

- (id)createForContext:(NSManagedObjectContext *)context
           objectClass:(Class)objectClass
              readonly:(BOOL)readonly
                 trait:(NSString *)trait
    withFactoryDefiner:(id)factoryDefiner;

- (id)buildForContext:(NSManagedObjectContext *)context
          objectClass:(Class)objectClass
             readonly:(BOOL)readonly
                trait:(NSString *)trait
   withFactoryDefiner:(id)factoryDefiner;
@end

extern id CFGBuild(NSManagedObjectContext *context, Class objectClass);
extern id CFGBuildTrait(NSManagedObjectContext *context, Class objectClass, NSString *trait);
extern id CFGBuildWith(NSManagedObjectContext *context, Class objectClass, id factoryDefiner);
extern id CFGBuildTraitWith(NSManagedObjectContext *context, Class objectClass, NSString *trait, id factoryDefiner);
extern id CFGCreate(NSManagedObjectContext *context, Class objectClass);
extern id CFGCreateTrait(NSManagedObjectContext *context, Class objectClass, NSString *trait);
extern id CFGCreateWith(NSManagedObjectContext *context, Class objectClass, id factoryDefiner);
extern id CFGCreateTraitWith(NSManagedObjectContext *context, Class objectClass, NSString *trait, id factoryDefiner);
