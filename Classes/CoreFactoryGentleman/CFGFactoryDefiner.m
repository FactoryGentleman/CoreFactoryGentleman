#import "CFGFactoryDefiner.h"

@implementation CFGFactoryDefiner

- (void)registerTraitDefiner:(NSString *)trait traitDefiner:(id)traitDefiner
{
    void (^traitDefinitionBlock)(CFGDefinitionBuilder *) = traitDefiner;
    CFGDefinitionBuilder *builder = [CFGDefinitionBuilder builder];
    traitDefinitionBlock(builder);
    FGFactoryDefinition *traitDefinition = [builder build];
    [self.factoryDefinitionRegistry registerFactoryDefinition:traitDefinition
                                                     forClass:self.objectClass
                                                        trait:trait];
}

@end
