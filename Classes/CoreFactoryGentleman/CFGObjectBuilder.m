#import "CFGObjectBuilder.h"

#import <CoreData/CoreData.h>

@interface CFGObjectBuilder ()
@property (nonatomic, readonly) NSManagedObjectContext *context;
@end

@implementation CFGObjectBuilder

#pragma mark - Initialization

- (instancetype)initWithContext:(NSManagedObjectContext *)context
                    objectClass:(Class)objectClass
                       readonly:(BOOL)readonly
                     definition:(CFGFactoryDefinition *)definition
{
    self = [super initWithObjectClass:objectClass
                             readonly:readonly
                           definition:definition];
    if (self) {
        NSParameterAssert(context);
        _context = context;
    }
    return self;
}

- (id)create
{
    id createdObject = [self build];
    [self saveObject:createdObject];
    return createdObject;
}

- (id)build
{
    id builtObject = [super build];
    [self buildAssociatedObjects:builtObject];
    return builtObject;
}

#pragma mark - Private

- (void)saveObject:(id)object
{
    NSError *error;
    if (![self.context save:&error]) {
        [NSException raise:@"Error saving object" format:@"Failed to save %@ with error %@", object, error];
    }
}

- (void)buildAssociatedObjects:(id)object
{
    for (NSString *fieldName in [self coreFieldDefinitions]) {
        id (^fieldValueBlock)(NSManagedObjectContext *) = [self coreFieldDefinitions][fieldName];
        if ([object respondsToSelector:@selector(performSelector:withObject:)]) {
            [object performSelector:[self setterForField:fieldName]
                         withObject:fieldValueBlock(self.context)];
        }
    };
}

- (NSDictionary *)coreFieldDefinitions
{
    return ((CFGFactoryDefinition *) self.definition).coreFieldDefinitions;
}

- (SEL)setterForField:(NSString *)field
{
    NSString *setterString = [NSString stringWithFormat:@"set%@:", [self camelcaseForField:field]];
    return NSSelectorFromString(setterString);
}

- (NSString *)camelcaseForField:(NSString *)field
{
    return [field stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                          withString:[[field substringToIndex:1] capitalizedString]];
}

@end
