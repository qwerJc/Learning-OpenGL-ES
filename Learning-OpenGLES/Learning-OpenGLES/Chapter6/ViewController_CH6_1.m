//
//  ViewController_CH6_1.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/30.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController_CH6_1.h"
#import "GLKViewController+BtnBack.h"
#import "AGLKContext.h"
#import "AGLKVertexAttribArrayBuffer.h"

#import "SceneCarModel.h"
#import "SceneRinkModel.h"
#import "SceneCar.h"

@interface ViewController_CH6_1 ()<SceneCarControllerProtocol>
{
   NSMutableArray      *cars; // Cars to simulate
}

@property (strong, nonatomic) GLKBaseEffect *baseEffect;
@property (strong, nonatomic) SceneModel *carModel;
@property (strong, nonatomic) SceneModel *rinkModel;
@property (nonatomic, assign) BOOL shouldUseFirstPersonPOV;
@property (nonatomic, assign) GLfloat pointOfViewAnimationCountdown;
@property (nonatomic, assign) GLKVector3 eyePosition;
@property (nonatomic, assign) GLKVector3 lookAtPosition;
@property (nonatomic, assign) GLKVector3 targetEyePosition;
@property (nonatomic, assign) GLKVector3 targetLookAtPosition;
@property (nonatomic, assign, readwrite) SceneAxisAllignedBoundingBox rinkBoundingBox;

@end

@implementation ViewController_CH6_1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtnBackOnView:self.view];
    // Do any additional setup after loading the view.
    
    // Create an array to store cars
    cars = [[NSMutableArray alloc] init];
    
    // Verify the type of view created automatically by the
    // Interface Builder storyboard
    GLKView *view = (GLKView *)self.view;
    NSAssert([view isKindOfClass:[GLKView class]],
       @"View controller's view is not a GLKView");
       
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    
    // Create an OpenGL ES 2.0 context and provide it to the
    // view
    view.context = [[AGLKContext alloc]
       initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    // Make the new context current
    [AGLKContext setCurrentContext:view.context];
    
    // Create a base effect that provides standard OpenGL ES 2.0
    // shading language programs and set constants to be used for
    // all subsequent rendering
    self.baseEffect = [[GLKBaseEffect alloc] init];

    // Configure a light
    self.baseEffect.light0.enabled = GL_TRUE;
    self.baseEffect.light0.ambientColor = GLKVector4Make(
       0.6f, // Red
       0.6f, // Green
       0.6f, // Blue
       1.0f);// Alpha
    self.baseEffect.light0.position = GLKVector4Make(
       1.0f,
       0.8f,
       0.4f,
       0.0f);
     
    // Set the background color stored in the current context
    ((AGLKContext *)view.context).clearColor = GLKVector4Make(
       0.0f, // Red
       0.0f, // Green
       0.0f, // Blue
       1.0f);// Alpha
    
    // Enable depth testing and blending with the frame buffer
    [((AGLKContext *)view.context) enable:GL_DEPTH_TEST];
    [((AGLKContext *)view.context) enable:GL_BLEND];

    // Load models used to draw the scene
    SceneCarModel *extractedExpr = [[SceneCarModel alloc] init];
    self.carModel = extractedExpr;
    self.rinkModel = [[SceneRinkModel alloc] init];
    
    // Remember the rink bounding box for future collision
    // detection with cars
    
    self.rinkBoundingBox = self.rinkModel.axisAlignedBoundingBox;
    NSAssert(0 < (self.rinkBoundingBox.max.x -
       self.rinkBoundingBox.min.x) &&
       0 < (self.rinkBoundingBox.max.z -
       self.rinkBoundingBox.min.z),
       @"Rink has no area");

    // Create and add some cars to the simulation. The number of
    // cars, colors and velocities are arbitrary
    SceneCar *newCar = [[SceneCar alloc] initWithModel:self.carModel
                                                position:GLKVector3Make(1.0, 0.0, 1.0)
                                                velocity:GLKVector3Make(1.5, 0.0, 1.5)
                                                   color:GLKVector4Make(0.0, 0.5, 0.0, 1.0)];
    [cars addObject:newCar];

    newCar = [[SceneCar alloc]
       initWithModel:self.carModel
       position:GLKVector3Make(-1.0, 0.0, 1.0)
       velocity:GLKVector3Make(-1.5, 0.0, 1.5)
       color:GLKVector4Make(0.5, 0.5, 0.0, 1.0)];
    [cars addObject:newCar];

    newCar = [[SceneCar alloc]
       initWithModel:self.carModel
       position:GLKVector3Make(1.0, 0.0, -1.0)
       velocity:GLKVector3Make(-1.5, 0.0, -1.5)
       color:GLKVector4Make(0.5, 0.0, 0.0, 1.0)];
    [cars addObject:newCar];

    newCar = [[SceneCar alloc]
       initWithModel:self.carModel
       position:GLKVector3Make(2.0, 0.0, -2.0)
       velocity:GLKVector3Make(-1.5, 0.0, -0.5)
       color:GLKVector4Make(0.3, 0.0, 0.3, 1.0)];
    [cars addObject:newCar];

    // Set initial point of view to reasonable arbitrary values
    // These values make most of the simulated rink visible
    self.eyePosition = GLKVector3Make(10.5, 5.0, 0.0);
    self.lookAtPosition = GLKVector3Make(0.0, 0.5, 0.0);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
    // Make the light white
    self.baseEffect.light0.diffuseColor = GLKVector4Make(
       1.0f, // Red
       1.0f, // Green
       1.0f, // Blue
       1.0f);// Alpha
       
    // Clear back frame buffer (erase previous drawing)
    [((AGLKContext *)view.context)
       clear:GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT];
    
    // Calculate the aspect ratio for the scene and setup a
    // perspective projection
    const GLfloat  aspectRatio =
       (GLfloat)view.drawableWidth / (GLfloat)view.drawableHeight;

    self.baseEffect.transform.projectionMatrix =
       GLKMatrix4MakePerspective(
          GLKMathDegreesToRadians(35.0f),// Standard field of view
          aspectRatio,
          0.1f,   // Don't make near plane too close
          25.0f); // Far is aritrarily far enough to contain scene

    // Set the modelview matrix to match current eye and look-at
    // positions
    self.baseEffect.transform.modelviewMatrix =
       GLKMatrix4MakeLookAt(
          self.eyePosition.x,
          self.eyePosition.y,
          self.eyePosition.z,
          self.lookAtPosition.x,
          self.lookAtPosition.y,
          self.lookAtPosition.z,
          0, 1, 0);
           
    // Draw the rink
    [self.baseEffect prepareToDraw];
    [self.rinkModel draw];

//    // Draw the cars
//    [cars makeObjectsPerformSelector:@selector(drawWithBaseEffect:)
//       withObject:self.baseEffect];
//
}

- (void)updatePointOfView
{
   if(!self.shouldUseFirstPersonPOV)
   {  // Set the target point of view to arbitrary "third person"
      // perspective
      self.eyePosition = GLKVector3Make(10.5, 5.0, 0.0);
      self.lookAtPosition = GLKVector3Make(0.0, 0.5, 0.0);
   }
   else
   {  // Set the target point of view to a position within the
      // last car and facing the direction of the car's motion.
      SceneCar *viewerCar = [cars lastObject];
      
      // Set the new target position up a bit from center of
      // car
      self.targetEyePosition = GLKVector3Make(
         viewerCar.position.x,
         viewerCar.position.y + 0.45f,
         viewerCar.position.z);

      // Look from eye position in direction of motion
      self.targetLookAtPosition = GLKVector3Add(
         _eyePosition,
         viewerCar.velocity);
   }
}

- (void)update
{
//   if(0 < self.pointOfViewAnimationCountdown)
//   {
//      self.pointOfViewAnimationCountdown -=
//         self.timeSinceLastUpdate;
//
//      // Update the current eye and look-at positions with slow
//      // filter so user can savor the POV animation
//      self.eyePosition = SceneVector3SlowLowPassFilter(
//         self.timeSinceLastUpdate,
//         self.targetEyePosition,
//         self.eyePosition);
//      self.lookAtPosition = SceneVector3SlowLowPassFilter(
//         self.timeSinceLastUpdate,
//         self.targetLookAtPosition,
//         self.lookAtPosition);
//   }
//   else
//   {  // Update the current eye and look-at positions with fast
//      // filter so POV stays close to car orientation but still
//      // has a little "bounce"
//      self.eyePosition = SceneVector3FastLowPassFilter(
//         self.timeSinceLastUpdate,
//         self.targetEyePosition,
//         self.eyePosition);
//      self.lookAtPosition = SceneVector3FastLowPassFilter(
//         self.timeSinceLastUpdate,
//         self.targetLookAtPosition,
//         self.lookAtPosition);
//   }
//
//   // Update the cars
//   [cars makeObjectsPerformSelector:
//      @selector(updateWithController:) withObject:self];
//
//   // Update the target positions
//   [self updatePointOfView];
}

#pragma mark - SceneCarControllerProtocol
- (NSArray *)cars
{
   return cars;
}

@end
