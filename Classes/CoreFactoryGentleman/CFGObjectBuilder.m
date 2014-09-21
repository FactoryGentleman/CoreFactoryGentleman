#import "CFGObjectBuilder.h"

@interface CFGObjectBuilder ()
@property (nonatomic, readonly) FGObjectBuilder *baseBuilder;
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

- (id)build
{
    return [super build];
}

@end
