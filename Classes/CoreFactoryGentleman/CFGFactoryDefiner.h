#import <FactoryGentleman/FactoryGentleman.h>

#define CFGFactoryBegin(__CLASS__) FGFactoryBegin(__CLASS__) \
    [builder initFrom:NSEntityDescription.class]; \
    [builder initWith:@selector(insertNewObjectForEntityForName:inManagedObjectContext:) fieldNames:@[ @"entityName", @"context" ]]; \
    [builder field:@"entityName" value:@#__CLASS__]; \

#define CFGFactoryEnd FGFactoryEnd
