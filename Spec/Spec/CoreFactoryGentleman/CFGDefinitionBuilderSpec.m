#import "CFGDefinitionBuilder.h"

#import "SimpleObject.h"
#import "CFGFactoryDefinition.h"
#import "NSManagedObjectContextFactory.h"

SpecBegin(CFGDefinitionBuilder)
    __block NSManagedObjectContext *moc;
    __block CFGDefinitionBuilder *subject;

    before(^{
        moc = [NSManagedObjectContextFactory testContext];
        subject = [CFGDefinitionBuilder builder];
    });

    describe(@"-field:coreAssoc:", ^{
        it(@"defines an associatve field with class given", ^{
            CFGFactoryDefinition *definition = (CFGFactoryDefinition *) [[subject field:@"field" coreAssoc:[SimpleObject class]] build];
            SimpleObject *(^fieldDefinition)(NSManagedObjectContext *) = definition.coreFieldDefinitions[@"field"];
            expect(fieldDefinition).toNot.beNil();
            expect(fieldDefinition(moc).someMandatoryString).to.equal(@"foo");
            expect(fieldDefinition(moc).additionalInteger).to.equal(@2);
        });
    });

    describe(@"-field:coreAssoc:with:", ^{
        context(@"when definer is dictionary", ^{
            it(@"defines an associatve field with class and definer given", ^{
                CFGFactoryDefinition *definition = (CFGFactoryDefinition *) [[subject field:@"field" coreAssoc:[SimpleObject class] with:@{ @"someMandatoryString" : @"oh" }] build];
                SimpleObject *(^fieldDefinition)(NSManagedObjectContext *) = definition.coreFieldDefinitions[@"field"];
                expect(fieldDefinition).toNot.beNil();
                expect(fieldDefinition(moc).someMandatoryString).to.equal(@"oh");
                expect(fieldDefinition(moc).additionalInteger).to.equal(@2);
            });
        });

        context(@"when definer is block", ^{
            it(@"defines an associatve field with class and definer given", ^{
                CFGFactoryDefinition *definition = (CFGFactoryDefinition *) [[subject field:@"field" coreAssoc:[SimpleObject class] with:^(CFGDefinitionBuilder *builder) {
                    builder[@"someMandatoryString"] = @"oh";
                }] build];
                SimpleObject *(^fieldDefinition)(NSManagedObjectContext *) = definition.coreFieldDefinitions[@"field"];
                expect(fieldDefinition).toNot.beNil();
                expect(fieldDefinition(moc).someMandatoryString).to.equal(@"oh");
                expect(fieldDefinition(moc).additionalInteger).to.equal(@2);
            });
        });
    });

    describe(@"-field:coreAssoc:trait:", ^{
        it(@"defines an associatve field with class and trait given", ^{
            CFGFactoryDefinition *definition = (CFGFactoryDefinition *) [[subject field:@"field" coreAssoc:[SimpleObject class] trait:@"trait"] build];
            SimpleObject *(^fieldDefinition)(NSManagedObjectContext *) = definition.coreFieldDefinitions[@"field"];
            expect(fieldDefinition(moc).someMandatoryString).to.equal(@"foo");
            expect(fieldDefinition(moc).additionalInteger).to.equal(@7);
        });
    });

    describe(@"-field:coreAssoc:trait:with:", ^{
        context(@"when definer is dictionary", ^{
            it(@"defines an associatve field with class, trait and definer given", ^{
                CFGFactoryDefinition *definition = (CFGFactoryDefinition *) [[subject field:@"field" coreAssoc:[SimpleObject class] trait:@"trait" with:@{ @"someMandatoryString" : @"oh" }] build];
                SimpleObject *(^fieldDefinition)(NSManagedObjectContext *) = definition.coreFieldDefinitions[@"field"];
                expect(fieldDefinition(moc).someMandatoryString).to.equal(@"oh");
                expect(fieldDefinition(moc).additionalInteger).to.equal(@7);
            });
        });

        context(@"when definer is block", ^{
            it(@"defines an associatve field with class, trait and definer given", ^{
                CFGFactoryDefinition *definition = (CFGFactoryDefinition *) [[subject field:@"field" coreAssoc:[SimpleObject class] trait:@"trait" with:^(CFGDefinitionBuilder *builder) {
                    builder[@"someMandatoryString"] = @"oh";
                }] build];
                SimpleObject *(^fieldDefinition)(NSManagedObjectContext *) = definition.coreFieldDefinitions[@"field"];
                expect(fieldDefinition(moc).someMandatoryString).to.equal(@"oh");
                expect(fieldDefinition(moc).additionalInteger).to.equal(@7);
            });
        });
    });
SpecEnd
