#import <FactoryGentleman/FGFactoryDefinitionRegistry.h>

#import "CoreFactoryGentleman.h"
#import "SimpleObject.h"

CFGFactoryBegin(SimpleObject)
    [builder field:@"someMandatoryString" value:@"Amazing string"];
CFGFactoryEnd

SpecBegin(CFGObjectBuilder)
    __block CFGObjectBuilder *subject;
    __block NSManagedObjectContext *context;

    before(^{
        FGFactoryDefinition *definition = [[FGFactoryDefinitionRegistry sharedInstance] factoryDefinitionForObjectClass:SimpleObject.class];
        subject = [[CFGObjectBuilder alloc] initWithObjectClass:SimpleObject.class
                                                       readonly:YES
                                                     definition:definition];
    });

    it(@"builds objects in the context given", ^{
        expect([[subject build] managedObjectContext]).to.equal(context);
    });

    it(@"builds objects with the fields defined", ^{
        expect([[subject build] someMandatoryString]).to.equal(@"Amazing string");
    });
SpecEnd
