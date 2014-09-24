#import <CoreData/CoreData.h>
#import "CFGObjectBuilder.h"

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
    return [super build];
}

#pragma mark - Private

- (void)saveObject:(id)object
{
    NSError *error;
    if (![self.context save:&error]) {
        [NSException raise:@"Error saving object" format:@"Failed to save %@ with error %@", object, error];
    }
}

@end
