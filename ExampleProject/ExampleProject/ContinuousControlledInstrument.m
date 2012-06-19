//
//  ContinuousControlledInstrument.m
//  ExampleProject
//
//  Created by Adam Boulanger on 6/18/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "ContinuousControlledInstrument.h"
#import "CSDAssignment.h"

typedef enum
{
    kPValuePitchTag=4,
}kPValueTag;

@implementation ContinuousControlledInstrument
//@synthesize myContinuousManager;
@synthesize amplitudeContinuous;
@synthesize modulationContinuous;
@synthesize modIndexContinuous;

-(id)initWithOrchestra:(CSDOrchestra *)newOrchestra
{
    self = [super initWithOrchestra:newOrchestra];
    if (self) {
        CSDSineTable *sineTable = [[CSDSineTable alloc] init];
        [self addFunctionTable:sineTable];
        
        //myContinuousManager = [[CSDContinuousManager alloc] init];
        amplitudeContinuous = [[CSDContinuous alloc] init:0.1f 
                                                      Max:1.0f 
                                                      Min:0.0f ];
        //[self addContinuous:amplitudeContinuous];
        //[myContinuousManager addContinuousParam:amplitudeContinuous forControllerNumber:12];
        
        modulationContinuous = [[CSDContinuous alloc] init:0.5f
                                                       Max:2.2f 
                                                       Min:0.25f 
                                            isControlRate:YES];
        //[self addContinuous:modulationContinuous];
        //[myContinuousManager addContinuousParam:modulationContinuous forControllerNumber:13];
        
        modIndexContinuous = [[CSDContinuous alloc] init:1.0f 
                                                     Max:25.0f
                                                     Min:0.0f 
                                           isControlRate:YES];
         //[self addContinuous:modIndexContinuous];
         //[myContinuousManager addContinuousParam:modIndexContinuous forControllerNumber:14];
         
        
         CSDFoscili *myFoscili = [[CSDFoscili alloc] 
         initFMOscillatorWithAmplitude: [CSDParamConstant paramWithFloat:0.2]
         Pitch:[CSDParamConstant paramWithInt:440] 
         Carrier:[CSDParamConstant paramWithInt:1] 
         Modulation:[CSDParamConstant paramWithFloat:0.5]
         ModIndex:[CSDParamConstant paramWithFloat:15.0]
         FunctionTable:sineTable 
         AndOptionalPhase:nil];
         [self addOpcode:myFoscili];
        
        /*
         CSDFoscili *myFoscili = [[CSDFoscili alloc] 
         initFMOscillatorWithAmplitude: [CSDParam paramWithContinuous:amplitudeContinuous]
         Pitch:[CSDParamConstant paramWithPValue:kPValuePitchTag] 
         Carrier:[CSDParamConstant paramWithInt:1] 
         Modulation:[CSDParamControl paramWithContinuous:modulationContinuous]
         ModIndex:[CSDParamControl paramWithContinuous:modIndexContinuous]
         FunctionTable:sineTable 
         AndOptionalPhase:nil];
         [self addOpcode:myFoscili];
        */
        CSDOutputMono *monoOutput = [[CSDOutputMono alloc] initWithInput:[myFoscili output]];
        [self addOpcode:monoOutput];
    }
    return self;
}

-(void) playNoteForDuration:(float)dur Pitch:(float)pitch
{
    int instrumentNumber = [[orchestra instruments] indexOfObject:self] + 1;
    
    NSString * note = [NSString stringWithFormat:@"%0.2f %0.2f", dur, pitch];
    [[CSDManager sharedCSDManager] playNote:note OnInstrument:instrumentNumber];
}

@end
