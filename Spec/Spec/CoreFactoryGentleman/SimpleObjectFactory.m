#import "SimpleObject.h"

#import "CFGFactoryDefiner.h"
#import "AssociatedObject.h"

CFGFactoryBegin(SimpleObject)
    builder[@"someMandatoryString"] = @"foo";
    builder[@"additionalInteger"] = @2;
    traitDefiners[@"trait"] = ^(CFGDefinitionBuilder *traitBuilder) {
        traitBuilder[@"additionalInteger"] = @7;
    };
    [builder field:@"associatedObject" coreAssoc:AssociatedObject.class];
CFGFactoryEnd
