#import "SimpleObject.h"

#import "CFGFactoryDefiner.h"

CFGFactoryDefine(SimpleObject, ^(CFGDefinitionBuilder *builder, NSMutableDictionary *traitDefiners) {
    builder[@"someMandatoryString"] = @"foo";
    builder[@"additionalInteger"] = @2;
    traitDefiners[@"trait"] = ^(CFGDefinitionBuilder *traitBuilder) {
        traitBuilder[@"additionalInteger"] = @7;
    };
});
