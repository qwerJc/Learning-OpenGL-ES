//
//  ViewController_CH4_1.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/27.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController_CH4_1.h"
#import "GLKViewController+BtnBack.h"
#import "AGLKContext.h"
#import "AGLKVertexAttribArrayBuffer.h"

#define NUM_FACES (8)
#define NUM_NORMAL_LINE_VERTS (48)
#define NUM_LINE_VERTS (NUM_NORMAL_LINE_VERTS + 2)

// This data type is used to store information for each vertex
typedef struct {
   GLKVector3  position;
   GLKVector3  normal;
}SceneVertex;

typedef struct {
   SceneVertex vertices[3];
}SceneTriangle;

/**
 ADG
 BEH
 CFI
*/

static const SceneVertex vertexA = {{-0.5,  0.5, -0.5}, {0.0, 0.0, 1.0}};
static const SceneVertex vertexB = {{-0.5,  0.0, -0.5}, {0.0, 0.0, 1.0}};
static const SceneVertex vertexC = {{-0.5, -0.5, -0.5}, {0.0, 0.0, 1.0}};
static const SceneVertex vertexD = {{ 0.0,  0.5, -0.5}, {0.0, 0.0, 1.0}};
static const SceneVertex vertexE = {{ 0.0,  0.0, -0.5}, {0.0, 0.0, 1.0}};
static const SceneVertex vertexF = {{ 0.0, -0.5, -0.5}, {0.0, 0.0, 1.0}};
static const SceneVertex vertexG = {{ 0.5,  0.5, -0.5}, {0.0, 0.0, 1.0}};
static const SceneVertex vertexH = {{ 0.5,  0.0, -0.5}, {0.0, 0.0, 1.0}};
static const SceneVertex vertexI = {{ 0.5, -0.5, -0.5}, {0.0, 0.0, 1.0}};

@interface ViewController_CH4_1 ()
{
    SceneTriangle triangles[NUM_FACES]; // 每个元素都是包含3个SceneVertex值
}
@property (strong, nonatomic) GLKBaseEffect *baseEffect;  // 实例指针
@property (strong, nonatomic) GLKBaseEffect *extraEffect;

@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexBuffer;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *extraBuffer;

@property (nonatomic) GLfloat centerVertexHeight; // 三角形中心的高度
@property (nonatomic) BOOL shouldUseFaceNormals; // 平面法向量
@property (nonatomic) BOOL shouldDrawNormals; // 是否显示法向量

@end

@implementation ViewController_CH4_1
#pragma mark - Triangle manipulation

static SceneTriangle SceneTriangleMake(
   const SceneVertex vertexA,
   const SceneVertex vertexB,
   const SceneVertex vertexC)
{
   SceneTriangle   result;
   
   result.vertices[0] = vertexA;
   result.vertices[1] = vertexB;
   result.vertices[2] = vertexC;
   
   return result;
}

static GLKVector3 SceneTriangleFaceNormal(
   const SceneTriangle triangle)
{
   GLKVector3 vectorA = GLKVector3Subtract(
      triangle.vertices[1].position,
      triangle.vertices[0].position);
   GLKVector3 vectorB = GLKVector3Subtract(
      triangle.vertices[2].position,
      triangle.vertices[0].position);
      
   return SceneVector3UnitNormal(
      vectorA,
      vectorB);
}

#pragma mark - Utility GLKVector3 functions
/** 计算单位法向量 */
GLKVector3 SceneVector3UnitNormal(
   const GLKVector3 vectorA,
   const GLKVector3 vectorB)
{
   return GLKVector3Normalize(
      GLKVector3CrossProduct(vectorA, vectorB));
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtnBackOnView:self.view];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
    GLKView *view = (GLKView *)self.view;
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [AGLKContext setCurrentContext:view.context];
    
    /*************** 灯光 **************/
    // GLKBaseEffect中最多支持3个名为 light0, light1, light2 的模拟灯光
    // 每个灯光至少有一个位置,一个环境颜色,一个漫反射颜色,一个镜面反射颜色
    // 这里设置完灯光后 constantColor 属性就失效了，颜色由灯光决定
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.light0.enabled = GL_TRUE;
    self.baseEffect.light0.diffuseColor = GLKVector4Make(.7f, .7f, .7f, 1.f);   // 漫反射颜色被设为不透明的中等灰色
    // 镜面反射和环境颜色为默认值，分别为不透明白色和不透明的黑色。这样意味着漫反射部分不会影响场景
    
    self.baseEffect.light0.position = GLKVector4Make(1.f, 1.f, .5f, 0.f); // 前3个元素代表光源的XYZ，第4个元素为0代表前三个元素为一个方向。非0则代表一个位置
    
    self.extraEffect = [[GLKBaseEffect alloc] init];
    self.extraEffect.useConstantColor = GL_TRUE;
    self.extraEffect.constantColor = GLKVector4Make(
       0.0f, // Red
       1.0f, // Green
       0.0f, // Blue
       1.0f);// Alpha
    
    /*************** 场景旋转 **************/
    {  // Comment out this block to render the scene top down
       GLKMatrix4 modelViewMatrix = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(-60.0f), 1.0f, 0.0f, 0.0f);
       modelViewMatrix = GLKMatrix4Rotate( modelViewMatrix, GLKMathDegreesToRadians(-30.0f), 0.0f, 0.0f, 1.0f);
       modelViewMatrix = GLKMatrix4Translate( modelViewMatrix, 0.0f, 0.0f, 0.25f);

       self.baseEffect.transform.modelviewMatrix = modelViewMatrix;
       self.extraEffect.transform.modelviewMatrix = modelViewMatrix;
    }
    
    // BG color
    ((AGLKContext *)view.context).clearColor = GLKVector4Make(.7f, .7f, .5f, 1.f);
    
    /*************** 初始化三角形 **************/
       triangles[0] = SceneTriangleMake(vertexA, vertexB, vertexD);
       triangles[1] = SceneTriangleMake(vertexB, vertexC, vertexF);
       triangles[2] = SceneTriangleMake(vertexD, vertexB, vertexE);
       triangles[3] = SceneTriangleMake(vertexE, vertexB, vertexF);
       triangles[4] = SceneTriangleMake(vertexD, vertexE, vertexH);
       triangles[5] = SceneTriangleMake(vertexE, vertexF, vertexH);
       triangles[6] = SceneTriangleMake(vertexG, vertexD, vertexH);
       triangles[7] = SceneTriangleMake(vertexH, vertexF, vertexI);
    

    self.vertexBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:sizeof(SceneVertex)
                                                                 numberOfVertices:sizeof(triangles)/sizeof(SceneVertex)
                                                                            bytes:triangles
                                                                            usage:GL_DYNAMIC_DRAW];
    
    self.extraBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:sizeof(SceneVertex)
                                                                numberOfVertices:0
                                                                           bytes:NULL
                                                                           usage:GL_DYNAMIC_DRAW];
    
//    [self updateNormals];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    
    [(AGLKContext *)view.context clear:GL_COLOR_BUFFER_BIT];
    
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
                           numberOfCoordinates:3
                                          data:offsetof(SceneVertex, position)
                                  shouldEnable:YES];
    
    // 法向量
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribNormal
                           numberOfCoordinates:3
                                          data:offsetof(SceneVertex, normal)
                                  shouldEnable:YES];
    
    [self.vertexBuffer drawArrayWithMode:GL_TRIANGLES
                        startVertexIndex:0
                        numberOfVertices:sizeof(triangles)/sizeof(SceneVertex)];
    
    if(self.shouldDrawNormals)
    {
        [self drawNormals];
    }
}

#pragma mark - Normals（法向量）

- (void)updateNormals
{
   if(self.shouldUseFaceNormals)
   {
       // 使用平面法向量 产生一个多面体的外观
       // 每个顶点有相同的法向量，因此看过去一个面是平的
      SceneTrianglesUpdateFaceNormals(triangles);
   }
   else
   {  // 使用 平均法向量 产生一个圆锥体
       // 顶点法向量为 所有三角形法向量的平均值
      SceneTrianglesUpdateVertexNormals(triangles);
   }
      
   // Reinitialize the vertex buffer containing vertices to draw
    [self.vertexBuffer reinitWithAttribStride:sizeof(SceneVertex)
                             numberOfVertices:sizeof(triangles) / sizeof(SceneVertex)
                                        bytes:triangles];
}

// 绘制法向量
- (void)drawNormals
{
   GLKVector3  normalLineVertices[NUM_LINE_VERTS];
   
   // calculate all 50 vertices based on 8 triangles
   SceneTrianglesNormalLinesUpdate(triangles,
      GLKVector3MakeWithArray(self.baseEffect.light0.position.v),
      normalLineVertices);

   [self.extraBuffer reinitWithAttribStride:sizeof(GLKVector3)
      numberOfVertices:NUM_LINE_VERTS
      bytes:normalLineVertices];
   
    [self.extraBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
                          numberOfCoordinates:3
                                         data:0
                                 shouldEnable:YES];
   
   // Draw lines to represent normal vectors and light direction
   // Don't use light so that line color shows
   self.extraEffect.useConstantColor = GL_TRUE;
   self.extraEffect.constantColor =
      GLKVector4Make(0.0, 1.0, 0.0, 1.0); // Green
       
   [self.extraEffect prepareToDraw];
   
   [self.extraBuffer drawArrayWithMode:GL_LINES
      startVertexIndex:0
      numberOfVertices:NUM_NORMAL_LINE_VERTS];
      
   self.extraEffect.constantColor =
      GLKVector4Make(1.0, 1.0, 0.0, 1.0); // Yellow
       
   [self.extraEffect prepareToDraw];
   
   [self.extraBuffer drawArrayWithMode:GL_LINES
      startVertexIndex:NUM_NORMAL_LINE_VERTS
      numberOfVertices:(NUM_LINE_VERTS - NUM_NORMAL_LINE_VERTS)];
}

#pragma mark - UI
- (void)createUI {
    UISwitch *switch1 = [[UISwitch alloc] init];
    switch1.backgroundColor = [UIColor redColor];
    switch1.center = CGPointMake(100, 80);
    [switch1 addTarget:self action:@selector(onSwith1Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switch1];
    
    UISwitch *switch2 = [[UISwitch alloc] init];
    switch2.backgroundColor = [UIColor redColor];
    switch2.center = CGPointMake(200, 80);
    [switch2 addTarget:self action:@selector(onSwith2Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switch2];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 120, 330, 50)];
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

- (void)onSwith1Action:(UISwitch *)sender {
    self.shouldUseFaceNormals = sender.isOn;
}

- (void)onSwith2Action:(UISwitch *)sender {
    self.shouldDrawNormals = sender.isOn;
}

- (void)sliderChange:(UISlider *)sender {
    NSLog(@"value :%f",sender.value);
    self.centerVertexHeight = sender.value;
}

#pragma mark - Over Write
- (void)setCenterVertexHeight:(GLfloat)aValue
{
    _centerVertexHeight = aValue;
    
    SceneVertex newVertexE = vertexE;
    newVertexE.position.z = self.centerVertexHeight;
    
    triangles[2] = SceneTriangleMake(vertexD, vertexB, newVertexE);
    triangles[3] = SceneTriangleMake(newVertexE, vertexB, vertexF);
    triangles[4] = SceneTriangleMake(vertexD, newVertexE, vertexH);
    triangles[5] = SceneTriangleMake(newVertexE, vertexF, vertexH);
    
    [self updateNormals];
}

- (void)setShouldUseFaceNormals:(BOOL)aValue
{
   if(aValue != _shouldUseFaceNormals)
   {
      _shouldUseFaceNormals = aValue;
      
      [self updateNormals];
   }
}

#pragma mark - 新增
static void SceneTrianglesUpdateFaceNormals(
   SceneTriangle someTriangles[NUM_FACES])
{
   int                i;
   
   for (i=0; i<NUM_FACES; i++)
   {
      GLKVector3 faceNormal = SceneTriangleFaceNormal(someTriangles[i]);
      someTriangles[i].vertices[0].normal = faceNormal;
      someTriangles[i].vertices[1].normal = faceNormal;
      someTriangles[i].vertices[2].normal = faceNormal;
   }
}

static void SceneTrianglesUpdateVertexNormals(
   SceneTriangle someTriangles[NUM_FACES])
{
   SceneVertex newVertexA = vertexA;
   SceneVertex newVertexB = vertexB;
   SceneVertex newVertexC = vertexC;
   SceneVertex newVertexD = vertexD;
   SceneVertex newVertexE = someTriangles[3].vertices[0];
   SceneVertex newVertexF = vertexF;
   SceneVertex newVertexG = vertexG;
   SceneVertex newVertexH = vertexH;
   SceneVertex newVertexI = vertexI;
   GLKVector3 faceNormals[NUM_FACES];
   
   // Calculate the face normal of each triangle
   for (int i=0; i<NUM_FACES; i++)
   {
      faceNormals[i] = SceneTriangleFaceNormal(
         someTriangles[i]);
   }
   
   // Average each of the vertex normals with the face normals of
   // the 4 adjacent vertices
   newVertexA.normal = faceNormals[0];
   newVertexB.normal = GLKVector3MultiplyScalar(
      GLKVector3Add(
         GLKVector3Add(
            GLKVector3Add(
               faceNormals[0],
               faceNormals[1]),
            faceNormals[2]),
         faceNormals[3]), 0.25);
   newVertexC.normal = faceNormals[1];
   newVertexD.normal = GLKVector3MultiplyScalar(
      GLKVector3Add(
         GLKVector3Add(
            GLKVector3Add(
               faceNormals[0],
               faceNormals[2]),
            faceNormals[4]),
         faceNormals[6]), 0.25);
   newVertexE.normal = GLKVector3MultiplyScalar(
      GLKVector3Add(
         GLKVector3Add(
            GLKVector3Add(
               faceNormals[2],
               faceNormals[3]),
            faceNormals[4]),
         faceNormals[5]), 0.25);
   newVertexF.normal = GLKVector3MultiplyScalar(
      GLKVector3Add(
         GLKVector3Add(
            GLKVector3Add(
               faceNormals[1],
               faceNormals[3]),
            faceNormals[5]),
         faceNormals[7]), 0.25);
   newVertexG.normal = faceNormals[6];
   newVertexH.normal = GLKVector3MultiplyScalar(
      GLKVector3Add(
         GLKVector3Add(
            GLKVector3Add(
               faceNormals[4],
               faceNormals[5]),
            faceNormals[6]),
         faceNormals[7]), 0.25);
   newVertexI.normal = faceNormals[7];
   
   // Recreate the triangles for the scene using the new
   // vertices that have recalculated normals
   someTriangles[0] = SceneTriangleMake(
      newVertexA,
      newVertexB,
      newVertexD);
   someTriangles[1] = SceneTriangleMake(
      newVertexB,
      newVertexC,
      newVertexF);
   someTriangles[2] = SceneTriangleMake(
      newVertexD,
      newVertexB,
      newVertexE);
   someTriangles[3] = SceneTriangleMake(
      newVertexE,
      newVertexB,
      newVertexF);
   someTriangles[4] = SceneTriangleMake(
      newVertexD,
      newVertexE,
      newVertexH);
   someTriangles[5] = SceneTriangleMake(
      newVertexE,
      newVertexF,
      newVertexH);
   someTriangles[6] = SceneTriangleMake(
      newVertexG,
      newVertexD,
      newVertexH);
   someTriangles[7] = SceneTriangleMake(
      newVertexH,
      newVertexF,
      newVertexI);
}


/////////////////////////////////////////////////////////////////
// This function initializes the values in someNormalLineVertices
// with vertices for lines that represent the normal vectors for
// 8 triangles and a line that represents the light direction.
static  void SceneTrianglesNormalLinesUpdate(
   const SceneTriangle someTriangles[NUM_FACES],
   GLKVector3 lightPosition,
   GLKVector3 someNormalLineVertices[NUM_LINE_VERTS])
{
   int                       trianglesIndex;
   int                       lineVetexIndex = 0;
   
   // Define lines that indicate direction of each normal vector
   for (trianglesIndex = 0; trianglesIndex < NUM_FACES;
      trianglesIndex++)
   {
      someNormalLineVertices[lineVetexIndex++] =
         someTriangles[trianglesIndex].vertices[0].position;
      someNormalLineVertices[lineVetexIndex++] =
         GLKVector3Add(
            someTriangles[trianglesIndex].vertices[0].position,
            GLKVector3MultiplyScalar(
               someTriangles[trianglesIndex].vertices[0].normal,
               0.5));
      someNormalLineVertices[lineVetexIndex++] =
         someTriangles[trianglesIndex].vertices[1].position;
      someNormalLineVertices[lineVetexIndex++] =
         GLKVector3Add(
            someTriangles[trianglesIndex].vertices[1].position,
            GLKVector3MultiplyScalar(
               someTriangles[trianglesIndex].vertices[1].normal,
               0.5));
      someNormalLineVertices[lineVetexIndex++] =
         someTriangles[trianglesIndex].vertices[2].position;
      someNormalLineVertices[lineVetexIndex++] =
         GLKVector3Add(
            someTriangles[trianglesIndex].vertices[2].position,
            GLKVector3MultiplyScalar(
               someTriangles[trianglesIndex].vertices[2].normal,
               0.5));
   }
   
   // Add a line to indicate light direction
   someNormalLineVertices[lineVetexIndex++] =
      lightPosition;
      
   someNormalLineVertices[lineVetexIndex] = GLKVector3Make(
      0.0,
      0.0,
      -0.5);
}


@end
