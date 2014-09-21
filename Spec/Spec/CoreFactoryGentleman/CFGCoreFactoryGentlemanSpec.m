#import "CFGCoreFactoryGentleman.h"

#import "SimpleObject.h"

#import "NSManagedObjectContextFactory.h"

SpecBegin(CFGFactoryGentleman)
    __block NSManagedObjectContext *moc;
    __block SimpleObject *builtObject;

    before(^{
        moc = [NSManagedObjectContextFactory testContext];
    });

    describe(@"FGBuild", ^{
        before(^{
            builtObject = CFGBuild(moc, [SimpleObject class]);
        });

        it(@"builds an object from the definition", ^{
            expect(builtObject.managedObjectContext).to.equal(moc);
            expect(builtObject.someMandatoryString).to.equal(@"foo");
            expect(builtObject.additionalInteger).to.equal(@2);
        });
    });

    describe(@"FGBuildTrait", ^{
        before(^{
            builtObject = CFGBuildTrait(moc, [SimpleObject class], @"trait");
        });

        it(@"builds an object from the trait definition", ^{
            expect(builtObject.managedObjectContext).to.equal(moc);
            expect(builtObject.someMandatoryString).to.equal(@"foo");
            expect(builtObject.additionalInteger).to.equal(@7);
        });
    });

    describe(@"FGBuildWith", ^{
        context(@"when definer is dictionary", ^{
            before(^{
                builtObject = CFGBuildWith(moc, [SimpleObject class], @{ @"someMandatoryString" : @"overriden" });
            });

            it(@"builds an object from the overriden definition", ^{
                expect(builtObject.managedObjectContext).to.equal(moc);
                expect(builtObject.someMandatoryString).to.equal(@"overriden");
                expect(builtObject.additionalInteger).to.equal(@2);
            });
        });

        context(@"when definer is block", ^{
            before(^{
                builtObject = CFGBuildWith(moc, [SimpleObject class], ^(CFGDefinitionBuilder *builder) {
                    [builder field:@"someMandatoryString" value:@"overriden"];
                });
            });

            it(@"builds an object from the overriden definition", ^{
                expect(builtObject.managedObjectContext).to.equal(moc);
                expect(builtObject.someMandatoryString).to.equal(@"overriden");
                expect(builtObject.additionalInteger).to.equal(@2);
            });
        });
    });

    describe(@"FGBuildTraitWith", ^{
        context(@"when definer is dictionary", ^{
            before(^{
                builtObject = CFGBuildTraitWith(moc, [SimpleObject class], @"trait", @{ @"someMandatoryString" : @"overriden" });
            });

            it(@"builds an object from the overriden trait definition", ^{
                expect(builtObject.managedObjectContext).to.equal(moc);
                expect(builtObject.someMandatoryString).to.equal(@"overriden");
                expect(builtObject.additionalInteger).to.equal(@7);
            });
        });

        context(@"when definer is block", ^{
            before(^{
                builtObject = CFGBuildTraitWith(moc, [SimpleObject class], @"trait", ^(CFGDefinitionBuilder *builder) {
                    [builder field:@"someMandatoryString" value:@"overriden"];
                });
            });

            it(@"builds an object from the overriden trait definition", ^{
                expect(builtObject.managedObjectContext).to.equal(moc);
                expect(builtObject.someMandatoryString).to.equal(@"overriden");
                expect(builtObject.additionalInteger).to.equal(@7);
            });
        });
    });
SpecEnd
