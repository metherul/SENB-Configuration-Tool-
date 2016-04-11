//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ENBSeries effect file
// visit http://enbdev.com for updates
// Copyright (c) 2007-2011 Boris Vorontsov
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Edited by gp65cj04
// Rewritten by Soulwynd
// Version: 12
// Tweaked by Bronze316
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//internal parameters, can be modified
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Define Toggles
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
// NOT_BLURRING_SKY_MODE
// Turn Bokeh ignores sky off if this is on
//
// BOKEH_QUALITY
// Range: 1 - 10
// Taps = Quality * 5
// Higher values will generally bias the bokeh shape towards the
// center, so you might want to increase both BokehBias and
// BokehCurve to get a decent looking effect. If you reduce this to
// 1 or 2 for performance, you might want to lower the bokeh brightness
// multiplier and bokeh scale multiplier to avoid artifacts.
//
// BOKEH_IGNORES_SKY
// Turn not blurring sky mode off if this is on
// This turns off the bokeh brightness gain for the sky, if you
// turn this off, the sky might clip past white when out of focus
// due to how sky and terrain color ranges are separate.
// You might be able to turn this off for a bokeh effect on the sky
// If you adjust sky brightness correctly in the ini and on other
// shaders. I haven't been able to do so myself, so I implemented this.
//
// NOISE
// Gives blurry area a certain level of noise, can be used as an
// alternative grain effect.
//
// TIMED_NOISE
// Requires NOISE to be on
// This make the noise flicker over time
//
// BOKEH_FLICKER
// This causes the bright areas of the bokeh to pulse
//
// CLIPPING
// A way to increase performance by not calculating pixels that will
// not be blurred by DoF, thus wouldn't be affected by the effect
// anyway
//
// LENS_SHAPE
// You can pick from several focus shapes for fun and profit
// 1 - Pentagonal for low quality settings
// 2 - Pentagonal Poisson for high quality settings
// 3 - Straight 5 sided star poisson
// 4 - Tilted 4 sided star poisson
// 5 - Ultra high quality pentagonal poisson
// 6 - Octagonal Poisson
// 7 - HQ Octagonal Poisson
// All shapes except for 1 have been computer generated, so they
// most likely will not fill out the initial bokeh shape at quality
// setting 1 and maybe not even 2, so for very low quality bokeh, pick
// shape 1.
//
// DEPTH_DARKENING
// This applies an unsharp mask to the depth buffer and uses its
// derivative to add the illusion of perceived depth. 
// 1 - Dark outline
// 2 - Dark outline + bright inline
// 3 - Same as 1, but respects luma and color (Recommended)
// 4 - Same as 2, but respects luma and color (Recommended)
//
// ALTERNATE_DOF_WEIGHT
// Commented out: Depth based weight, avoids certain blur halos around 
// non-blurred edges.
// 1 - Weights based on luma level compared to the center point. Slightly darker.
//     and devalues bokeh shapes, you might have to adjust bias/curve.
// 2 - Weights based on tap luma, slightly brighter
// 3 - Weights based on luma differences, slightly brighter and enhances bokeh shapes
//     but causes some blur around non-blurry edges.
// 4 - Weights on depth first and then based on luma. Gives decent results,
//     but it's a bit slow.
// 5 - Weights based on luma while respecting local blur levels, most realistic.
//     But also might be a bit slower than other methods.
//
// GAUSS_BLUR
// Adds a final pass over the bokeh with gaussian blur. You can disable
// this for performance or for the HQ lenses.
//
// GAUSS_BEFORE_BOKEH (Requires GAUSS_BLUR)
// Does the gauss pass before the bokeh pass, should give more pastel
// looks to the scene, more realistically matching real life bokeh.
//
// GAUSS_BLUR_CONTRAST
// In real life, lens blurring tends to favour brightness, which is most noticeable
// in dark high contrast scenes. Gaussian blur on the other hand is luma neutral.
// This toggle allows you to add an artificial contrast to the blurred area of the scenes.
//
// BOKEH_SECOND_PASS - Only works with GAUSS_BEFORE_BOKEH enabled
// This adds a second pass to the bokeh, the result is that the blur is bigger and the
// shapes clearer. I recommend you keep a separate file just for this setting.
// It is very GPU intensive, so you might want to use it when screenshooting only.
//
// TWEAK
// Allows you to use the in game menu instead, comment this out for
// performance, but only after you input the values to the defines
// bellow.
//
// VISUALIZE_FOCUS
// Lets you see the focus area for debugging and tweaking, black is
// in focus, white is out of focus.
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//#define NOT_BLURRING_SKY_MODE	// Default: Off
#define	AUTO_FOCUS		// Default: ON - Legacy from gp65cj04 and Boris
//#define	TILT_SHIFT		// Default: OFF - Legacy from gp65cj04 and Boris
#define HYPERFOCAL			// Default: ON - Read variables bellow for description
#define FOCUS_RANGE			// Default: ON - Read variables bellow for description
#define BOKEH_IGNORES_SKY	// Default: ON
//#define NOISE			// Default: OFF
//#define TIMED_NOISE		// Default: OFF
#define BOKEH_FLICKER		// Default: ON
//#define CLIPPING		// Default: OFF
#define ADAPTIVE_QUALITY	// Default: ON
#define LENS_SHAPE 2		// Default: 1
#define DEPTH_DARKENING	4	// Default: 4 - Comment out to disable
#define ALTERNATE_DOF_WEIGHT 5	// Default: 5
#define GAUSS_BLUR			// Default: ON
#define GAUSS_BEFORE_BOKEH	// Default: ON
#define GAUSS_BLUR_CONTRAST 
//#define BOKEH_SECOND_PASS
//#define TWEAK				// Default: OFF
//#define VISUALIZE_FOCUS	// Default: OFF

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Constants
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Legacy focus by Boris
// Tiltshift by gp65cj04 and possible modifications
//
// FocusPoint - 0.0 to 1.0
// Sets the point of the screen which the shader will try to focus on
// 0.5, 0.5 means the center, you might want to change this towards
// 0.25, 0.5 or 0.75, 0.5 to do cinematic shots with the focus target
// not in the middle of the screen.
//
// FocusSampleRange
// The focus does a few taps to determine the overall depth of the focus
// point. Increasing this value will increase the area used to determine
// the average depth of the focus
//
// NearBlurCurve - >1.0
// Controls how out of focus things closer than the focal point will be
// 1.0 is completely out of focus, increasing values will ease the blur
//
// FarBlurCurve
// Likewise, this will ease the blur on things further away from the focal
// point. For a macro looking screenshot, you can set both to 1.0 for maximum
// blur.
//
// Near/FarFocusWindow & FocusWindowDistance
// These are used to increase the depth range in which objects will be devoid
// of blurring. Near is for when the focus is very close to the camera and Far
// is for when the focus is close and past the FocusWindowDistance setting.
//
// HyperfocalDistance
// In real camera lenses, Hyperfocal range is the distance in which when set to
// infinite focus, the light rays will be close to being parallel when entering
// the lenses. In the case of the DoF, it controls the distance in which that happens
// and focusing near and past that point will mean everything past it will be
// focused and not blurred. Please note that the TiltShift technique, both here
// and in real life, counters that effect, so if you want hyperfocal distances
// to be simulated correctly, turn off Tiltshift.
//
// DepthClip
// Controls at which point the focus will clip out, no point in changing this
// Unless you want to reduce your focus range to make sure the background
// is always blurred.
//
// FocalPlaneDepth and FarBlurDepth
// Only used when auto focus is off, they determine the focus range
//
// TiltShiftAngle - 0.0 to 90.0
// Tilts the depth map counterclockwise, normally used to give things
// a miniature-like effect or to shift the near blur to the right
// and the far blur to the left.

//No longer used, just for reference.
//float2	FocusPoint=float2(0.5, 0.5);

#ifdef TWEAK
float	FocusPointX <string UIName="DoF Focus Center X"; string UIWidget="Spinner"; float UIMin=0.0; float UIMax=1.0;> = 0.5;
float	FocusPointY <string UIName="DoF Focus Center Y"; string UIWidget="Spinner"; float UIMin=0.0; float UIMax=1.0;> = 0.5;
float	FocusSampleRange <string UIName="DoF Focus Radius"; string UIWidget="Spinner"; float UIMin=0.1;> = 1.00;
float	NearBlurCurveINT <string UIName="I-DoF Near Blur Curve"; string UIWidget="Spinner"; float UIMin=0.1;> = 10.00;
float	FarBlurCurveINT <string UIName="I-DoF Far Blur Curve"; string UIWidget="Spinner"; float UIMin=0.1;> = 1.00;
float	NearBlurCurveEXT <string UIName="E-DoF Near Blur Curve"; string UIWidget="Spinner"; float UIMin=0.1;> = 10.00;
float	FarBlurCurveEXT <string UIName="E-DoF Far Blur Curve"; string UIWidget="Spinner"; float UIMin=0.1;> = 1.00;
float	NearFocusWindowINT <string UIName="I-Near Focus Window"; string UIWidget="Spinner"; float UIMin=0.0;> = 0.055556;
float	FarFocusWindowINT <string UIName="I-Far Focus Window"; string UIWidget="Spinner"; float UIMin=0.0;> = 1.111112;
int		FocusWindowDistanceINT <string UIName="I-Focus Window Distance"; string UIWidget="Spinner"; int UIMin=1;> = 2;
float	NearFocusWindowEXT <string UIName="E-Near Focus Window"; string UIWidget="Spinner"; float UIMin=0.0;> = 3.333334;
float	FarFocusWindowEXT <string UIName="E-Far Focus Window"; string UIWidget="Spinner"; float UIMin=0.0;> = 1.666667;
int		FocusWindowDistanceEXT <string UIName="E-Focus Window Distance"; string UIWidget="Spinner"; int UIMin=1;> = 3;
int		HyperfocalDistance <string UIName="Hyperfocal Distance"; string UIWidget="Spinner"; int UIMin=1;> = 2147483647;


float	DepthClip=10000.0;
// for static dof
float	FocalPlaneDepth <string UIName="Static Focus"; string UIWidget="Spinner"; float UIMin=0.0;> = 0.0;
float	FarBlurDepth <string UIName="Static Focus Depth"; string UIWidget="Spinner"; float UIMin=0.0;> = 150.00;
// for tilt shift
float	TiltShiftAngle <string UIName="Tilt Shift"; string UIWidget="Spinner"; float UIMin=0.0; float UIMax=90.0;> = 0.0;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Bokeh Settings, mostly rewritten
//
// ClipThreshold
// This value is compared with the amount of blur of a given pixel
// and if the blur is less than the threshold, the effect is skipped
// for that pixel to avoid unnecessary calculations in order to
// increase performance.
//
// QualityThreshold
// Controls how many taps will be dropped for areas with small circles
// of confusion. Helps increase performance but may be noticeable with
// really high bokeh radiuses. Requires ADAPTIVE_QUALITY to be enabled.
// 1.0 = Full quality at all times
// 0.0 = Full quality only on fully blurred areas.
//
// BokehBrightnessThreshold
// Luma levels above this threshold will be brighter, used to determine
// how bright a point of the screen has to be to create the visible
// bokeh shape.
//
// BokehBrightnessMultiplier - >0.0
// Used to create bokeh shaped flares where blured lights are. 1.0 turns
// it off, values between 0.0 and 1.0 inverts the effect.
//
// BokehRadiusMultiplier - 0.1 to 7.0 
// Controls the size of the bokeh and resulting lens shape blur. The higher
// this value, the more blur you will get and the bigger the bokeh shape.
// Values too high might create artifacts and/or create a pinhole lens effect
// and distortions. You might be able to pump this past 7 for extreme blur
// but you will most likely need a lot of tweaking to make it work without
// artifacts.
//
// BokehBias
// Used in conjunction with Bokeh Curve, it's the base weight of the bokeh
// shape when compared with the light at the center of the bokeh shape.
// You might want to increase this value when increasing bokeh quality
//
// BokehCurve - Less than 1/5*BOKEH_QUALITY/10
// Moves the weight towards the edge of the bokeh, increasing this helps with
// the extra blur caused by higher bokeh qualities, to bring back the bokeh
// shape on bright spots, be aware of the max value to avoid artifacts.
//
// BokehCenter
// Adds light to the center of the bokeh to counter the blur that builds up
// used to give a better shape and look tot he bokeh effect.
//
// BokehFlicker - >= 1.0
// How strong will be the flicker effect, affects both bright and dark states.
//
// BokehFlickerTimer
// How fast the flicker cycle will occour, increase to make it faster, decrease
// to make it slower.
//
// BokehFlickerBias - 0.0 to 2.0
// 1.0 is egual amounts of flicker towards light/dark, less than 1.0 biases towards
// light flickers and more than 1.0 biases towards darker flickers
//
// NoiseAmount
// Controls how much noise the blur will receive if NOISE is on. Keep this
// very low unless you want to see weird things.
//
// UnsharpRadius, Strenght, Range AKA Depth darkening
// Adds a darkened edge around things based on the depth diferential. Good to add
// depth detail to near objects and counter some of the effect of the blur.
// Remember to check the DEPTH_DARKENING define as well for options.
// Effect is based on this illusion: http://en.wikipedia.org/wiki/Cornsweet_illusion
//
// ChromaticAberrationAmount
// How much aberration you will have
//
// ChromaticRadiusMultiplier
// How distant the aberration colors will be from the central point.

#if LENS_SHAPE == 5
int	BokehQuality <string UIName="Bokeh Quality"; string UIWidget="Spinner"; int UIMin=1; int UIMax=28;> = 4;
#elif LENS_SHAPE == 7
int	BokehQuality <string UIName="Bokeh Quality"; string UIWidget="Spinner"; int UIMin=1; int UIMax=15;> = 4;
#else
int	BokehQuality <string UIName="Bokeh Quality"; string UIWidget="Spinner"; int UIMin=1; int UIMax=10;> = 4;
#endif
float	ClipThreshold <string UIName="Clip Threshold"; string UIWidget="Spinner"; float UIMin=0.0; float UIMax=1.0;> = 0.15;
float	QualityThreshold <string UIName="Quality Threshold"; string UIWidget="Spinner"; float UIMin=0.0; float UIMax=1.0;> = 1.0;

float	bbtDAY <string UIName="D-Bokeh Threshold"; string UIWidget="Spinner"; float UIMin=0.1;> = 4.0;
float	bbmDAY <string UIName="D-Bokeh Multiplier"; string UIWidget="Spinner"; float UIMin=0;> = 3.00;
float3	balDAY <string UIName="D-Bokeh Added Light"; string UIWidget="Color"; float UIMin=0;> = float3(0.0, 0.0, 0.0);
float	bbtNIGHT <string UIName="N-Bokeh Threshold"; string UIWidget="Spinner"; float UIMin=0.1;> = 1.6;
float	bbmNIGHT <string UIName="N-Bokeh Multiplier"; string UIWidget="Spinner"; float UIMin=0;> = 3.00;
float3	balNIGHT <string UIName="N-Bokeh Added Light"; string UIWidget="Color"; float UIMin=0;> = float3(0.0, 0.0, 0.0);
float	bbtINT <string UIName="I-Bokeh Threshold"; string UIWidget="Spinner"; float UIMin=0.1;> = 1.6;
float	bbmINT <string UIName="I-Bokeh Multiplier"; string UIWidget="Spinner"; float UIMin=0;> = 3.00;
float3	balINT <string UIName="I-Bokeh Added Light"; string UIWidget="Color"; float UIMin=0;> = float3(0.0, 0.0, 0.0);

float	GaussContrastMultiplierDAY <string UIName="D-Gaussian Contrast"; string UIWidget="Spinner"; float UIMin=0.0; float UIMax=1.0;> = 0.00;
float	GaussContrastMultiplierNIGHT <string UIName="N-Gaussian Contrast"; string UIWidget="Spinner"; float UIMin=0.0; float UIMax=1.0;> = 0.00;
float	GaussContrastMultiplierINT <string UIName="I-Gaussian Contrast"; string UIWidget="Spinner"; float UIMin=0.0; float UIMax=1.0;> = 0.00;

float	BokehRadiusMultiplier <string UIName="Bokeh Radius"; string UIWidget="Spinner"; float UIMin=0.1;> = 3.3334;
float	BokehBias <string UIName="Bokeh Bias"; string UIWidget="Spinner"; float UIMin=0.0;> = 1.0;
float	BokehCurve <string UIName="Bokeh Curve"; string UIWidget="Spinner";> = 0.1;
float	BokehCenter <string UIName="Bokeh Center"; string UIWidget="Spinner";> = 3.0;
float	BokehFlicker <string UIName="Bokeh Flicker Strength"; string UIWidget="Spinner"; float UIMin=0.0;> = 2.0;

int	BokehFlickerTimer <string UIName="Bokeh Flicker Timer"; string UIWidget="Spinner"; int UIMin=1;> = 10000;
float	BokehFlickerBias <string UIName="Bokeh Flicker Bias"; string UIWidget="Spinner"; float UIMin=0.1; float UIMax=2.0;> = 0.7;

float	NoiseAmount <string UIName="Depth Noise"; string UIWidget="Spinner"; float UIMin=0.0;> = 0.5;

float	UnsharpRadius <string UIName="Depth Darkening Radius"; string UIWidget="Spinner"; float UIMin=1.0;> = 1.5;
float	UnsharpStrenght <string UIName="Depth Darkening Strenght"; string UIWidget="Spinner";> = 0.35;
int	UnsharpRange <string UIName="Depth Darkening Range"; string UIWidget="Spinner"; int UIMin=1;> = 15;

float	ChromaticAberrationAmount <string UIName="Chromatic Power"; string UIWidget="Spinner"; float UIMin=0.0;> = 1.00;
float	ChromaticRadiusMultiplier <string UIName="Chromatic Radius"; string UIWidget="Spinner"; float UIMin=0.1;> = 2.00;
#else
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Performance, comment out #define TWEAK to use these #defines instead
//Remember to tweak in game first, things like bias and curve can cause
//artifacts that are easier to fix in game.
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#define	FocusPointX			0.5	//DoF Focus Center X
#define	FocusPointY			0.5	//DoF Focus Center Y
#define	FocusSampleRange		1.0	//DoF Focus Radius
#define	NearBlurCurveINT		10.0	//I-DoF Near Blur Curve
#define	FarBlurCurveINT			1.0	//I-DoF Far Blur Curve
#define	NearBlurCurveEXT		10.0	//E-DoF Near Blur Curve
#define	FarBlurCurveEXT			1.0	//E-DoF Far Blur Curve
#define	NearFocusWindowINT 		0.055556 //I-Near Focus Window
#define	FarFocusWindowINT 		1.111112 //I-Far Focus Window
#define	FocusWindowDistanceINT 	2 //I-Focus Window Distance
#define	NearFocusWindowEXT 		3.333334 //E-Near Focus Window
#define	FarFocusWindowEXT 		1.666667 //E-Far Focus Window
#define	FocusWindowDistanceEXT 	3 //E-Focus Window Distance
#define	HyperfocalDistance 		2147483647 //Hyperfocal Distance
#define	DepthClip 			10000.0	//No real reason to change this

#define	FocalPlaneDepth 		0.0	//Static Focus
#define	FarBlurDepth			150.0	//Static Focus Depth

#define	TiltShiftAngle			10.0	//Tilt Shift

#if LENS_SHAPE == 5
//Dirty little bypass to force ENB to compile for lens 5.
int	BokehQuality <string UIName="Bokeh Quality"; string UIWidget="Spinner"; int UIMin=1; int UIMax=28;> = 15;
#elif LENS_SHAPE == 7
#define	BokehQuality			4	//Bokeh Quality for lens 7
#else
#define	BokehQuality			4	//Bokeh Quality for every other lens
#endif
#define	ClipThreshold			0.15	//Clip Threshold
#define QualityThreshold		1.0		//Quality Threshold

#define	bbtDAY 				4.0	//D-Bokeh Threshold
#define	bbmDAY				3.0	//D-Bokeh Multiplier
#define	balDAY float3(0.0, 0.0, 0.0)	//D-Bokeh Added Light
#define	bbtNIGHT			1.6	//N-Bokeh Threshold
#define	bbmNIGHT 			3.0	//N-Bokeh Multiplier
#define	balNIGHT float3(0.0, 0.0, 0.0)	//N-Bokeh Added Light
#define	bbtINT				1.6	//I-Bokeh Threshold
#define	bbmINT 				3.0	//I-Bokeh Multiplier
#define	balINT float3(0.0, 0.0, 0.0)		//I-Bokeh Added Light

#define	GaussContrastMultiplierDAY		0.00
#define	GaussContrastMultiplierNIGHT	0.00
#define	GaussContrastMultiplierINT		0.00

#define	BokehRadiusMultiplier		5.0	//Bokeh Radius
#define	BokehBias 			1.0	//Bokeh Bias
#define	BokehCurve			0.1	//Bokeh Curve
#define	BokehCenter			3.0	//Bokeh Center
#define	BokehFlicker			2.0	//Bokeh Flicker Strength

#define	BokehFlickerTimer		10000	//Bokeh Flicker Timer
#define	BokehFlickerBias		0.7	//Bokeh Flicker Bias

#define	NoiseAmount			0.5	//Depth Noise

#define	UnsharpRadius			1.5	//Depth Darkening Radius
#define	UnsharpStrenght			0.35	//Depth Darkening Strenght
#define	UnsharpRange			15	//Depth Darkening Range

#define	ChromaticAberrationAmount	1.0	//Chromatic Power
#define	ChromaticRadiusMultiplier	2.0	//Chromatic Radius
#endif

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//external parameters, do not modify
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//keyboard controlled temporary variables (in some versions exists in the config file). Press and hold key 1,2,3...8 together with PageUp or PageDown to modify. By default all set to 1.0
float4 tempF1; //0,1,2,3
float4 tempF2; //5,6,7,8
float4 tempF3; //9,0
//x=Width, y=1/Width, z=ScreenScaleY, w=1/ScreenScaleY
float4 ScreenSize;
//x=generic timer in range 0..1, period of 16777216 ms (4.6 hours), w=frame time elapsed (in seconds)
float4 Timer;
//adaptation delta time for focusing
float FadeFactor;
//changes in range 0..1, 0 means that night time, 1 - day time
float ENightDayFactor;
//changes 0 or 1. 0 means that exterior, 1 - interior
float EInteriorFactor;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Main code area, do not modify unless you know what you're doing
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//textures
texture2D texColor;
texture2D texDepth;
texture2D texNoise;
texture2D texPalette;
texture2D texFocus; //computed focusing depth
texture2D texCurr; //4*4 texture for focusing
texture2D texPrev; //4*4 texture for focusing

sampler2D SamplerColor = sampler_state
{
	Texture   = <texColor>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerDepth = sampler_state
{
	Texture   = <texDepth>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=2;
	MipMapLodBias=0;
};

sampler2D SamplerNoise = sampler_state
{
	Texture   = <texNoise>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;//NONE;
	AddressU  = Wrap;
	AddressV  = Wrap;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerPalette = sampler_state
{
	Texture   = <texPalette>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

//for focus computation
sampler2D SamplerCurr = sampler_state
{
	Texture   = <texCurr>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

//for focus computation
sampler2D SamplerPrev = sampler_state
{
	Texture   = <texPrev>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};
//for dof only in PostProcess techniques
sampler2D SamplerFocus = sampler_state
{
	Texture   = <texFocus>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

struct VS_OUTPUT_POST
{
	float4 vpos  : POSITION;
	float2 txcoord : TEXCOORD0;
};

struct VS_INPUT_POST
{
	float3 pos  : POSITION;
	float2 txcoord : TEXCOORD0;
};



////////////////////////////////////////////////////////////////////
//begin focusing code
////////////////////////////////////////////////////////////////////
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST VS_Focus(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	float4 pos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);

	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;

	return OUT;
}


float linearlizeDepth(float nonlinearDepth)
{
	float2 dofProj=float2(0.0509804, 3098.0392);
	float2 dofDist=float2(0.0, 0.0509804);
		
	float4 depth=nonlinearDepth;
	
	
	depth.y=-dofProj.x + dofProj.y;
	depth.y=1.0/depth.y;
	depth.z=depth.y * dofProj.y; 
	depth.z=depth.z * -dofProj.x; 
	depth.x=dofProj.y * -depth.y + depth.x;
	depth.x=1.0/depth.x;

	depth.y=depth.z * depth.x;

	depth.x=depth.z * depth.x - dofDist.y; 
	depth.x+=dofDist.x * -0.5;

	depth.x=max(depth.x, 0.0);
		
	return depth.x;
}


//SRCpass1X=ScreenWidth;
//SRCpass1Y=ScreenHeight;
//DESTpass2X=4;
//DESTpass2Y=4;
float4 PS_ReadFocus(VS_OUTPUT_POST IN) : COLOR
{

	float2 uvsrc;
	uvsrc.x = FocusPointX;
	uvsrc.y = FocusPointY;

	float2 pixelSize=ScreenSize.y;
	pixelSize.y*=ScreenSize.z;
	
	const float2 offset[4]=
	{
		float2(0.0, 1.0),
		float2(0.0, -1.0),
		float2(1.0, 0.0),
		float2(-1.0, 0.0)
	};

	float res=linearlizeDepth(tex2D(SamplerDepth, uvsrc.xy).x);
	for (int i=0; i<4; i++)
	{
		uvsrc.xy=uvsrc.xy;
		uvsrc.xy+=offset[i] * pixelSize.xy * FocusSampleRange;
		#ifdef NOT_BLURRING_SKY_MODE
			res+=linearlizeDepth(tex2D(SamplerDepth, uvsrc).x);
		#else
			res+=min(linearlizeDepth(tex2D(SamplerDepth, uvsrc).x), DepthClip);
		#endif
	}
	res*=0.2;

	return res;
}



//SRCpass1X=4;
//SRCpass1Y=4;
//DESTpass2X=4;
//DESTpass2Y=4;
float4 PS_WriteFocus(VS_OUTPUT_POST IN) : COLOR
{

	float2 uvsrc;
	uvsrc.x = FocusPointX;
	uvsrc.y = FocusPointY;

	float res=0.0;
	float curr=tex2D(SamplerCurr, uvsrc.xy).x;
	float prev=tex2D(SamplerPrev, uvsrc.xy).x;

	
	res=lerp(prev, curr, saturate(FadeFactor));//time elapsed factor

	return res;
}



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


technique ReadFocus
{
	pass P0
	{
		VertexShader = compile vs_3_0 VS_Focus();
		PixelShader  = compile ps_3_0 PS_ReadFocus();

		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}



technique WriteFocus
{
	pass P0
	{
		VertexShader = compile vs_3_0 VS_Focus();
		PixelShader  = compile ps_3_0 PS_WriteFocus();

		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}


////////////////////////////////////////////////////////////////////
//end focusing code
////////////////////////////////////////////////////////////////////



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST VS_PostProcess(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	float4 pos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);

	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;

	return OUT;
}

#ifdef DEPTH_DARKENING
float FastDepthUNSharp(float2 coord) {
	const float weight[5] = {0.2270270270, 0.0972972973, 0.0608108108, 0.02702702705, 0.0081081081};
	float2 pixelSize=ScreenSize.y;
	pixelSize.y*=ScreenSize.z;
	
	float sample = tex2D(SamplerDepth, coord).x;

	float ret = sample * weight[0];

	for(int i=1; i < 5; i++)
	{
		ret += tex2D(SamplerDepth, coord + float2(i*pixelSize.x * UnsharpRadius, 0.0)).x * weight[i];
		ret += tex2D(SamplerDepth, coord - float2(i*pixelSize.x * UnsharpRadius, 0.0)).x * weight[i];
		ret += tex2D(SamplerDepth, coord + float2(0.0, i*pixelSize.y * UnsharpRadius)).x * weight[i];
		ret += tex2D(SamplerDepth, coord - float2(0.0, i*pixelSize.y * UnsharpRadius)).x * weight[i];
	}

	ret = saturate(linearlizeDepth(ret)/UnsharpRange);
	sample = saturate(linearlizeDepth(sample)/UnsharpRange);

	ret -= sample;

	ret *= smoothstep(0.0, 10.0, 1.0 / sample);


	return ret;
}
#endif

//Tilt Shift + Depth to alpha
float4 PS_ProcessPass1(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{

	const float FarBlurCurve = (EInteriorFactor) ? FarBlurCurveINT : FarBlurCurveEXT;

	float4 res;
	float2 coord=IN.txcoord.xy;

	const float4 origcolor=tex2D(SamplerColor, coord.xy);
	const float scenedepth=tex2D(SamplerDepth, IN.txcoord.xy).x;
	#ifdef HYPERFOCAL
	const float scenefocus=min(HyperfocalDistance, tex2D(SamplerFocus, 0.5).x);
	#else
	const float scenefocus=tex2D(SamplerFocus, 0.5).x;
	#endif
	res.xyz=origcolor.xyz;

	const float depth=linearlizeDepth(scenedepth);
	
	#ifdef FOCUS_RANGE
	const float FocusRange = 	(EInteriorFactor) ? 
								lerp(NearFocusWindowINT, FarFocusWindowINT, scenefocus / FocusWindowDistanceINT) :
								lerp(NearFocusWindowEXT, FarFocusWindowEXT, scenefocus / FocusWindowDistanceEXT);
	#endif

	#ifdef AUTO_FOCUS
		float focalPlaneDepth=scenefocus;
		float farBlurDepth=scenefocus*pow(4.0, FarBlurCurve);
	#else
		float focalPlaneDepth=FocalPlaneDepth;
		float farBlurDepth=FarBlurDepth;
	#endif
	
	#ifdef TILT_SHIFT
		float shiftAngle=(frac(TiltShiftAngle / 90.0) == 0) ? 0.0 : TiltShiftAngle;
		float depthShift=1.0 + (0.5 - coord.x)*tan(-shiftAngle * 0.017453292);
		focalPlaneDepth*=depthShift;
		farBlurDepth*=depthShift;
	#endif
	

	if(depth < focalPlaneDepth)
		#ifdef FOCUS_RANGE
		res.w=min(0.0, (depth + FocusRange - focalPlaneDepth)/focalPlaneDepth);
		#else
		res.w=(depth - focalPlaneDepth)/focalPlaneDepth;
		#endif
	else
	{
		#ifdef FOCUS_RANGE
		res.w=(depth - FocusRange - focalPlaneDepth)/(farBlurDepth - focalPlaneDepth);
		#else
		res.w=(depth - focalPlaneDepth)/(farBlurDepth - focalPlaneDepth);
		#endif
		#ifdef HYPERFOCAL
		res.w = lerp(res.w, 0.0, focalPlaneDepth / HyperfocalDistance);
		#endif
		res.w=saturate(res.w);
	}

	res.w=res.w * 0.5 + 0.5;
	
	#ifdef NOT_BLURRING_SKY_MODE
	res.w=(depth > 1000.0) ? 0.5 : res.w;
	#endif
	#ifdef BOKEH_IGNORES_SKY
	res.w=(depth > 3000.0) ? 10 + res.w : res.w;
	#endif

	#ifdef DEPTH_DARKENING
	if (depth < UnsharpRange)
	#if DEPTH_DARKENING == 1 //Flat darkening
	res.rgb += min(FastDepthUNSharp(IN.txcoord.xy), 0.0) * UnsharpStrenght;
	#elif DEPTH_DARKENING == 2 //Flat dark and bright
	res.rgb += FastDepthUNSharp(IN.txcoord.xy) * UnsharpStrenght;
	#elif DEPTH_DARKENING == 3 //Multiplied Darkening
	res.rgb += res.rgb * min(FastDepthUNSharp(IN.txcoord.xy), 0.0) * UnsharpStrenght;
	#elif DEPTH_DARKENING == 4 //Multiplied dark and bright
	res.rgb += res.rgb * FastDepthUNSharp(IN.txcoord.xy) * UnsharpStrenght;
	#endif
	#endif
	
	return res;
}

#ifdef BOKEH_FLICKER
float4 PS_ProcessPassFlicker(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{

	const float BokehBrightnessThreshold = (EInteriorFactor) ? bbtINT : lerp(bbtNIGHT, bbtDAY, ENightDayFactor);

	float4 res=tex2D(SamplerColor, IN.txcoord.xy);

	float centerDepth = res.w;

	#ifdef BOKEH_IGNORES_SKY
	bool ignoreSky = 0;
	if (centerDepth > 9.0) {
		centerDepth -= 10.0;
		ignoreSky = 1;
	}
	#endif

	float blurAmount=abs(centerDepth * 2.0 - 1.0);

	float noisegrad = max(dot(res.rgb, 0.3333) - BokehBrightnessThreshold, 0.0) * blurAmount;


	#ifdef BOKEH_IGNORES_SKY
	if (noisegrad && !ignoreSky) {
	#else
	if (noisegrad) {
	#endif
	// Alternative method for banding instead of noise
	//	float fnoise = Timer.x * BokehFlickerTimer * IN.txcoord.x;
		float fnoise=tex2D(SamplerNoise, IN.txcoord.xy*8) * Timer.x * BokehFlickerTimer;
		fnoise = abs(frac(fnoise)-0.5)*2-BokehFlickerBias;
		res.rgb += fnoise * noisegrad * BokehFlicker;
	}


	return res;

}
#endif

//Bokeh
float4 PS_ProcessPass2(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	#if LENS_SHAPE == 1
	const float2 offset[50]=
	{
		float2(0.0000, 1.0000), float2(-0.9511, 0.3090), float2(-0.5878, -0.8090), float2(0.5878, -0.8090), float2(0.9511, 0.3090),
		float2(-0.4755, 0.6545), float2(-0.7694, -0.2500), float2(-0.0000, -0.8090), float2(0.7694, -0.2500), float2(0.4755, 0.6545),
		float2(-0.2023, 0.6225), float2(-0.6545, 0.0000), float2(-0.2023, -0.6225), float2(0.5295, -0.3847), float2(0.5295, 0.3847),
		float2(-0.5295, 0.3847), float2(-0.5295, -0.3847), float2(0.2023, -0.6225), float2(0.6545, -0.0000), float2(0.2023, 0.6225),
		float2(0.0000, 0.7318), float2(-0.6959, 0.2261), float2(-0.4301, -0.5920), float2(0.4301, -0.5920), float2(0.6959, 0.2261),
		float2(-0.3393, 0.4670), float2(-0.5490, -0.1784), float2(-0.0000, -0.5773), float2(0.5490, -0.1784), float2(0.3393, 0.4670),
		float2(-0.1784, 0.5490), float2(-0.5773, 0.0000), float2(-0.1784, -0.5490), float2(0.4670, -0.3393), float2(0.4670, 0.3393),
		float2(-0.4670, 0.3393), float2(-0.4670, -0.3393), float2(0.1784, -0.5490), float2(0.5773, -0.0000), float2(0.1784, 0.5490),
		float2(0.0000, 0.6545), float2(-0.6225, 0.2023), float2(-0.3847, -0.5295), float2(0.3847, -0.5295), float2(0.6225, 0.2023),
		float2(-0.2939, 0.4045), float2(-0.4755, -0.1545), float2(-0.0000, -0.5000), float2(0.4755, -0.1545), float2(0.2939, 0.4045)
	};
	#elif LENS_SHAPE == 2
	const float2 offset[50]=
	{
		float2(0.0000, 1.0000), float2(-0.9511, 0.3090), float2(-0.5878, -0.8090), float2(0.5878, -0.8090), float2(0.9511, 0.3090),
		float2(-0.9517, 0.0855), float2(0.8864, 0.3334), float2(-0.1477, -0.9004), float2(-0.6441, -0.6011), float2(0.8691, 0.0495),
		float2(-0.8234, 0.2559), float2(-0.7388, -0.4075), float2(0.2055, -0.8173), float2(0.5950, -0.5931), float2(-0.7134, 0.4369),
		float2(0.6606, 0.4541), float2(-0.4283, -0.6558), float2(0.7003, -0.3333), float2(0.3596, 0.6825), float2(-0.4242, 0.6342),
		float2(-0.0871, 0.7523), float2(-0.7302, -0.0596), float2(0.1438, 0.7184), float2(0.7132, -0.1085), float2(0.6804, 0.2112),
		float2(-0.0667, -0.6918), float2(0.3797, -0.5716), float2(-0.4789, -0.4617), float2(-0.5037, 0.3885), float2(-0.2541, -0.5555),
		float2(0.3918, 0.4634), float2(-0.5550, 0.1892), float2(0.4628, -0.3451), float2(-0.2930, 0.4755), float2(-0.0749, 0.5454),
		float2(-0.4577, -0.2417), float2(0.4908, -0.0944), float2(0.2105, -0.4445), float2(-0.4674, -0.0198), float2(-0.0775, -0.4527),
		float2(0.4275, 0.1153), float2(-0.3377, 0.2766), float2(-0.2679, -0.3145), float2(0.0638, 0.3875), float2(0.2681, 0.2593),
		float2(-0.1356, 0.3473), float2(0.2365, -0.2267), float2(-0.2143, 0.1137), float2(-0.2142, -0.0978), float2(0.2235, 0.0031)
	};
	#elif LENS_SHAPE == 3
	const float2 offset[50]=
	{
		float2(0.0000, 1.0000), float2(-0.9511, 0.3090), float2(-0.5878, -0.8090), float2(0.5878, -0.8090), float2(0.9511, 0.3090),
		float2(0.0161, 0.9932), float2(-0.4368, -0.8632), float2(0.8538, 0.3141), float2(-0.8165, 0.3298), float2(-0.8610, 0.1633),
		float2(0.5181, -0.6823), float2(0.3152, -0.7867), float2(-0.2666, -0.7684), float2(-0.5647, -0.5677), float2(-0.3907, -0.6536),
		float2(-0.1504, 0.7383), float2(-0.6345, 0.3608), float2(-0.6928, 0.1920), float2(0.1268, 0.7048), float2(0.6804, 0.2112),
		float2(0.6791, 0.0245), float2(0.3562, -0.5503), float2(0.5222, -0.3684), float2(0.5143, 0.3529), float2(-0.4552, -0.3991),
		float2(0.2608, 0.5453), float2(-0.5992, -0.0150), float2(0.1778, -0.5677), float2(-0.1583, 0.5627), float2(-0.2907, -0.5018),
		float2(-0.4512, 0.3581), float2(-0.0783, -0.5571), float2(0.5207, -0.0462), float2(0.3462, -0.3546), float2(0.4674, 0.1304),
		float2(-0.4518, 0.1362), float2(-0.4273, -0.1923), float2(0.0050, 0.4555), float2(0.3332, 0.2517), float2(-0.1819, 0.3659),
		float2(0.1945, 0.3577), float2(-0.3171, 0.2471), float2(-0.2229, -0.2890), float2(0.0857, -0.3503), float2(0.3066, -0.1576),
		float2(0.2956, 0.0360), float2(-0.2762, 0.0791), float2(-0.0544, -0.2495), float2(0.1619, 0.1803), float2(0.1385, -0.1734)
	};
	#elif LENS_SHAPE == 4
	const float2 offset[50]=
	{
		float2(0.9392, 0.9414), float2(-0.9924, 0.8819), float2(0.9895, -0.8212), float2(-0.9425, -0.8744), float2(-0.7394, 0.8768),
		float2(0.7154, 0.8907), float2(0.8597, 0.7396), float2(-0.8903, 0.6822), float2(0.7297, -0.8427), float2(0.8527, -0.6744),
		float2(-0.6754, -0.8168), float2(-0.7917, -0.6110), float2(-0.6537, 0.6888), float2(0.5083, 0.7814), float2(0.7318, -0.5087),
		float2(0.7244, 0.5189), float2(-0.7317, 0.4795), float2(-0.3756, 0.7855), float2(-0.5471, -0.6464), float2(0.5293, -0.6273),
		float2(-0.6527, -0.4653), float2(-0.4643, 0.6024), float2(0.6804, 0.2112), float2(0.6484, -0.2535), float2(-0.2722, -0.6407),
		float2(0.2511, 0.6229), float2(0.1963, -0.6371), float2(-0.6051, -0.2308), float2(0.4694, -0.4047), float2(-0.4889, 0.3646),
		float2(0.3918, 0.4634), float2(-0.5693, 0.1119), float2(-0.0932, 0.5681), float2(-0.2976, 0.4910), float2(-0.0261, -0.5613),
		float2(-0.3787, -0.4032), float2(0.4908, -0.0944), float2(0.1178, 0.4492), float2(0.4275, 0.1153), float2(-0.1540, -0.3980),
		float2(0.2681, 0.2593), float2(-0.3683, -0.0541), float2(0.0670, -0.3640), float2(-0.3140, 0.1832), float2(-0.2590, -0.2272),
		float2(0.2365, -0.2267), float2(-0.1224, 0.2919), float2(0.2235, 0.0031), float2(0.0647, 0.1745), float2(-0.1601, 0.0322)
	};
	#elif LENS_SHAPE == 5
	const float2 offset[140]=
	{
		float2(-2.0800, 0.3960), float2(-1.9880, 0.5320), float2(-0.3530, 2.0260), float2(-2.0000, 0.2280), float2(-0.4950, 1.9410),
		float2(-1.1220, -1.6280), float2(-1.8520, 0.6600), float2(-0.9790, -1.6810), float2(-0.1900, 1.9360), float2(-1.9210, 0.0590),
		float2(-0.6300, 1.8130), float2(-1.2020, -1.4590), float2(-1.7160, 0.7890), float2(1.6110, 0.9510), float2(1.2420, -1.3950),
		float2(1.2420, -1.3950), float2(-0.7660, 1.6850), float2(-0.0260, 1.8470), float2(-1.8410, -0.1100), float2(1.6560, 0.8060),
		float2(-0.7940, -1.6570), float2(-1.5810, 0.9170), float2(-1.2820, -1.2900), float2(-0.9020, 1.5570), float2(1.4480, 1.0410),
		float2(-1.4450, 1.0450), float2(-1.7610, -0.2780), float2(1.0570, -1.4190), float2(-1.0380, 1.4290), float2(-1.3620, -1.1220),
		float2(0.1380, 1.7570), float2(-1.7360, 0.3010), float2(1.2760, -1.2120), float2(-1.3090, 1.1730), float2(-1.1730, 1.3010),
		float2(-0.6090, -1.6330), float2(-1.6810, -0.4470), float2(1.6220, 0.6220), float2(-1.4410, -0.9530), float2(-0.2890, 1.6990),
		float2(-1.6010, -0.6160), float2(-1.5210, -0.7840), float2(1.2840, 1.1300), float2(0.3020, 1.6680), float2(0.8720, -1.4430),
		float2(-1.5890, 0.5570), float2(1.3110, -1.0280), float2(-0.4240, -1.6090), float2(1.1200, 1.2200), float2(1.5870, 0.4390),
		float2(0.4650, 1.5780), float2(-0.5890, 1.5140), float2(0.9560, 1.3090), float2(-0.8820, -1.3590), float2(0.6870, -1.4660),
		float2(0.6290, 1.4880), float2(0.7930, 1.3990), float2(-0.2390, -1.5850), float2(1.3450, -0.8450), float2(1.5530, 0.2550),
		float2(0.5010, -1.4900), float2(-0.0540, -1.5620), float2(-1.5150, -0.3800), float2(0.3160, -1.5140), float2(0.1310, -1.5380),
		float2(1.3800, -0.6610), float2(1.5180, 0.0720), float2(-1.5150, -0.0330), float2(0.0240, 1.5140), float2(-0.8370, 1.2560),
		float2(1.2940, 0.7760), float2(-1.2020, -0.9110), float2(-1.2750, 0.7980), float2(1.4140, -0.4780), float2(1.4830, -0.1110),
		float2(0.9540, -1.1350), float2(1.4490, -0.2950), float2(-1.4440, 0.2940), float2(-0.9020, -1.0720), float2(0.3240, 1.3530),
		float2(-0.5890, -1.2580), float2(-0.9940, 0.9640), float2(-0.2630, -1.3590), float2(-0.2890, 1.3530), float2(1.2870, 0.4930),
		float2(0.9370, 1.0060), float2(0.6490, -1.2080), float2(1.0550, -0.8340), float2(0.6370, 1.1680), float2(-1.2020, -0.5650),
		float2(-0.5890, 1.1680), float2(-1.1760, 0.4940), float2(1.1470, -0.5370), float2(-1.2020, -0.2180), float2(1.2110, 0.1540),
		float2(0.0240, -1.2110), float2(-1.2020, 0.1280), float2(1.1920, -0.1730), float2(0.0240, 1.1680), float2(0.3370, -1.1090),
		float2(-0.9020, -0.7260), float2(0.9370, 0.6600), float2(0.6360, -0.8890), float2(-0.5890, -0.9110), float2(-0.2890, -1.0450),
		float2(-0.8620, 0.6460), float2(0.3240, 1.0060), float2(-0.5940, 0.8640), float2(-0.2890, 1.0060), float2(0.6370, 0.8210),
		float2(0.8140, -0.6390), float2(0.9300, -0.3530), float2(0.9370, 0.3130), float2(-0.9020, -0.3800), float2(-0.9020, 0.3130),
		float2(0.9370, -0.0330), float2(0.0240, -0.9110), float2(-0.9020, -0.0330), float2(0.0240, 0.8210), float2(-0.5890, -0.5650),
		float2(0.3240, -0.7260), float2(0.6370, 0.4750), float2(-0.2890, -0.7260), float2(0.5670, -0.5320), float2(-0.5370, 0.5380),
		float2(0.3240, 0.6600), float2(-0.2890, 0.6600), float2(0.6370, -0.2180), float2(0.6370, 0.1280), float2(-0.5890, -0.2180),
		float2(-0.5890, 0.1280), float2(0.0240, -0.5650), float2(0.3240, -0.3800), float2(-0.2890, -0.3800), float2(0.0240, 0.4750),
		float2(0.3240, 0.3130), float2(-0.2890, 0.3130), float2(0.3240, -0.0330), float2(-0.2890, -0.0330), float2(0.0240, -0.2180)
	};
	#elif LENS_SHAPE == 6
	const float2 offset[50]=
	{
		float2(0.3352, -0.9877), float2(0.9918, -0.2832), float2(0.1996, 0.9920), float2(-0.8944, 0.4718), float2(-0.3110, -0.9516),
		float2(0.0764, -0.9923), float2(-0.9710, -0.1303), float2(-0.8969, -0.3560), float2(-0.5777, -0.7729), float2(0.9613, -0.0164),
		float2(0.6815, -0.6777), float2(0.8972, 0.3399), float2(-0.1479, 0.9470), float2(-0.4174, 0.8380), float2(-0.9086, 0.1088),
		float2(0.7267, 0.5351), float2(-0.6134, 0.6420), float2(-0.6877, -0.5608), float2(0.3220, 0.8111), float2(0.5236, 0.6822),
		float2(-0.7889, 0.2839), float2(0.7214, -0.3678), float2(0.3381, -0.7239), float2(0.0769, -0.7788), float2(-0.1471, -0.7462),
		float2(-0.3966, -0.6355), float2(-0.7005, -0.2638), float2(0.4884, -0.5611), float2(-0.0945, 0.7351), float2(0.7150, -0.1253),
		float2(-0.7181, -0.0473), float2(-0.5709, 0.4305), float2(0.6804, 0.2112), float2(-0.5309, -0.4169), float2(0.5091, -0.3468),
		float2(-0.2505, 0.5610), float2(0.3766, 0.4767), float2(0.1687, 0.5832), float2(0.0750, -0.5489), float2(0.3015, -0.4372),
		float2(-0.3559, 0.3726), float2(0.4808, -0.1105), float2(-0.4477, 0.1356), float2(-0.2970, -0.3568), float2(0.4142, 0.1102),
		float2(-0.4143, -0.0943), float2(-0.0642, -0.3830), float2(-0.0120, 0.3514), float2(0.1999, 0.2665), float2(0.1975, -0.1599)
	};
	#elif LENS_SHAPE == 7
	const float2 offset[75]=
	{
		float2(-0.9998, 0.3277), float2(-0.9481, -0.3650), float2(-0.3493, 0.9513), float2(0.9931, 0.1942), float2(0.2254, -0.9840),
		float2(0.4552, 0.8793), float2(-0.4656, -0.8720), float2(-0.9649, 0.1537), float2(-0.8648, 0.4480), float2(0.1183, 0.9591),
		float2(0.9389, -0.1992), float2(-0.0859, 0.9478), float2(-0.0315, -0.9358), float2(-0.9267, -0.0319), float2(0.7880, -0.4879),
		float2(0.8603, 0.3180), float2(0.9135, 0.0223), float2(-0.2448, -0.8713), float2(0.2813, 0.8593), float2(-0.8627, -0.2079),
		float2(-0.5308, -0.7023), float2(-0.7347, -0.4844), float2(-0.5471, 0.6732), float2(0.4149, -0.7590), float2(0.7188, 0.4800),
		float2(-0.6609, 0.5372), float2(0.5739, -0.5979), float2(-0.7810, 0.2755), float2(0.5502, 0.6021), float2(0.3829, 0.7091),
		float2(0.1411, -0.7930), float2(-0.2894, 0.7427), float2(-0.7765, 0.0806), float2(-0.1079, 0.7718), float2(0.7145, -0.2694),
		float2(-0.6813, -0.2516), float2(-0.3643, -0.6206), float2(0.6804, 0.2112), float2(0.7091, -0.0681), float2(-0.1856, -0.6766),
		float2(-0.3935, 0.5687), float2(-0.5545, 0.3982), float2(0.5210, -0.4298), float2(0.3909, -0.5492), float2(-0.4663, -0.4751),
		float2(-0.0099, -0.6513), float2(-0.6443, -0.0637), float2(0.0373, 0.6460), float2(-0.6042, 0.1466), float2(0.1760, -0.5918),
		float2(0.4282, 0.4315), float2(0.5382, -0.2519), float2(0.2557, 0.5200), float2(-0.3582, 0.3932), float2(0.5147, -0.0558),
		float2(-0.4516, 0.2441), float2(-0.0922, 0.5015), float2(0.3659, -0.3270), float2(0.4594, 0.1274), float2(-0.2659, -0.3839),
		float2(0.0171, -0.4527), float2(0.1982, -0.3952), float2(-0.4048, -0.1608), float2(-0.4192, 0.0705), float2(-0.1797, 0.3452),
		float2(0.2816, 0.2571), float2(0.1057, 0.3275), float2(-0.2560, 0.1485), float2(0.2796, -0.0968), float2(-0.1308, -0.2603),
		float2(0.0624, -0.2820), float2(-0.2282, -0.0423), float2(0.1799, 0.0622), float2(0.0962, -0.0916), float2(-0.0342, 0.0506)
	};
	#endif

	#ifndef ADAPTIVE_QUALITY
	const int dofTaps = 5 * BokehQuality;
	#endif
	const float BokehBrightnessThreshold = (EInteriorFactor) ? bbtINT : lerp(bbtNIGHT, bbtDAY, ENightDayFactor);
	const float BokehBrightnessMultiplier = (EInteriorFactor) ? bbmINT : lerp(bbmNIGHT, bbmDAY, ENightDayFactor);
	const float NearBlurCurve = (EInteriorFactor) ? NearBlurCurveINT : NearBlurCurveEXT;
	const float3 BokehAddedLight = (EInteriorFactor) ? balINT : lerp(balNIGHT, balDAY, ENightDayFactor);


	float4 res=0.0;
	
	float2 coord=IN.txcoord.xy;

	float4 origcolor=tex2D(SamplerColor, coord.xy);
	
	float centerDepth=origcolor.w;

	#ifdef BOKEH_IGNORES_SKY
	bool ignoreSky = 0;
	if (centerDepth > 9.0) {
		centerDepth -= 10.0;
		ignoreSky = 1;
	}
	#endif

	float2 pixelSize=ScreenSize.y;
	pixelSize.y*=ScreenSize.z;
	
	float blurAmount=abs(centerDepth * 2.0 - 1.0);

	#ifdef CLIPPING
	clip(blurAmount - ClipThreshold);
	#endif
	
	#ifdef ADAPTIVE_QUALITY
	const int dofTaps = ceil(5 * BokehQuality * smoothstep(0.0, 1.0, blurAmount + QualityThreshold));
	#endif

	float discRadius=blurAmount * BokehRadiusMultiplier;

	#ifdef AUTO_FOCUS
	discRadius*=(centerDepth < 0.5) ? (1.0 / max(NearBlurCurve, 1.0)) : 1.0;
	#endif

	float brightBias = smoothstep(0.0, BokehRadiusMultiplier, discRadius);
	
	#ifdef NOISE
	#ifdef TIMED_NOISE
	float2 noise=tex2D(SamplerNoise, coord.xy*16) * dot(coord.xy, 1.0) * 65535 * Timer.x;
	#else
	float2 noise=tex2D(SamplerNoise, coord.xy*16) * dot(coord.xy, 1.0) * 65535;
	#endif
	noise = frac(noise)*2-1;
	noise *= NoiseAmount * 0.001;
	#endif


	res.xyz=origcolor.xyz;
	res.w=dot(res.xyz, 0.3333);
	#ifdef ALTERNATE_DOF_WEIGHT
	float centerluma = res.w;
	#endif
	#ifdef BOKEH_IGNORES_SKY
	res.w=(ignoreSky) ? 0.0 : max((res.w - BokehBrightnessThreshold) * BokehBrightnessMultiplier, 0.0);
	#else
	res.w=max((res.w - BokehBrightnessThreshold) * BokehBrightnessMultiplier, 0.0);
	#endif
	res.xyz*=1.0 + res.w*blurAmount*BokehCenter;
	res.w=1.0;

	float curvestep=0.0;

		
	for(int i=0; i < dofTaps; i++)
	{
		#ifdef NOISE
		float2 coordLow=coord.xy + noise + offset[i] * pixelSize.xy * discRadius;
		#else
		float2 coordLow=coord.xy + offset[i] * pixelSize.xy * discRadius;
		#endif

		float4 tap=tex2D(SamplerColor, coordLow.xy);

		#ifdef NOISE
		tap.rgb = lerp(origcolor.rgb, tap.rgb, brightBias);
		#endif
		
		curvestep += 0.2;
		
		float luma=dot(tap.rgb, 0.3333);
		
		#ifdef BOKEH_IGNORES_SKY
		float brightMultiplier=(ignoreSky || tap.w > 9.0) ? 0.0 : max((luma - BokehBrightnessThreshold) * BokehBrightnessMultiplier, 0.0);
		#else
		float brightMultiplier=max((luma - BokehBrightnessThreshold) * BokehBrightnessMultiplier, 0.0);
		#endif
		
		#if ALTERNATE_DOF_WEIGHT == 1
		tap.w = smoothstep(0.0, centerluma, luma);
		#elif ALTERNATE_DOF_WEIGHT == 2
		tap.w = (luma >= centerluma) ? 1.0 : saturate(luma);
		#elif ALTERNATE_DOF_WEIGHT == 3
		tap.w = (luma >= centerluma) ? 1.0 : saturate(centerluma - luma);
		#elif ALTERNATE_DOF_WEIGHT == 4
		tap.w = (tap.w < centerDepth) ? abs(tap.w * 2.0 - 1.0) : (luma >= centerluma) ? 1.0 : saturate(luma);
		#elif ALTERNATE_DOF_WEIGHT == 5
		tap.w = min(abs(tap.w * 2.0 - 1.0), 1.0) * luma;
		#else
		tap.w = (tap.w >= centerDepth) ? 1.0 : abs(tap.w * 2.0 - 1.0);
		#endif

		tap.w *= 1.0 + sign(brightMultiplier) * (BokehBias - floor(curvestep) * BokehCurve);
		tap.rgb*=1.0 + brightMultiplier*brightBias;
		tap.rgb+=BokehAddedLight*sign(brightMultiplier)*brightBias;
		res.rgb+=tap.rgb * tap.w;
		res.w+=tap.w;
	}
	

	res.rgb /= res.w;
		
	res.w=centerDepth;

	#ifdef VISUALIZE_FOCUS
	res.rgb = brightBias;
	//Alternatively, you can visualize depth.
	//res.rgb = centerDepth;
	#endif

	return res;
}

//Chromatic
float4 PS_ProcessPass3(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{	
	const float NearBlurCurve = (EInteriorFactor) ? NearBlurCurveINT : NearBlurCurveEXT;
	float2 coord=IN.txcoord.xy;
	
	float2 pixelSize=ScreenSize.y;
	pixelSize.y*=ScreenSize.z;
	
	float4 origcolor=tex2D(SamplerColor, coord.xy);
	float depth=origcolor.w;
	#ifdef BOKEH_IGNORES_SKY
	if (depth > 9.0) depth -= 10.0;
	#endif

	float blurAmount=abs(depth * 2.0 - 1.0);

	#ifdef CLIPPING
	clip(blurAmount - ClipThreshold);
	#endif


	float discRadius=blurAmount * ChromaticRadiusMultiplier;
	
	#ifdef AUTO_FOCUS
		discRadius*=(depth < 0.5) ? (1.0 / max(NearBlurCurve, 1.0)) : 1.0;
	#endif
	
	float4 res=origcolor;
	
	float3 distortion=float3(-1.0, 0.0, 1.0);
	distortion*=discRadius;
	float2 lens = abs(coord.xy * 2 - 1);

	origcolor=tex2D(SamplerColor, coord.xy + pixelSize.xy*lens*distortion.x);
	origcolor.w=smoothstep(0.0, depth, origcolor.w);
	res.x=lerp(res.x, origcolor.x, origcolor.w * ChromaticAberrationAmount);
	
	origcolor=tex2D(SamplerColor, coord.xy + pixelSize.xy*lens*distortion.z);
	origcolor.w=smoothstep(0.0, depth, origcolor.w);
	res.z=lerp(res.z, origcolor.z, origcolor.w * ChromaticAberrationAmount);

	return res;
}


//Gaussian Blur, 1st pass.
#ifdef GAUSS_BLUR
float4 PS_ProcessPass4(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	const float NearBlurCurve = (EInteriorFactor) ? NearBlurCurveINT : NearBlurCurveEXT;
	float2 coord=IN.txcoord.xy;
	
	float2 pixelSize=ScreenSize.y;
	pixelSize.y*=ScreenSize.z;
	
	float4 origcolor=tex2D(SamplerColor, coord.xy);
	float depth=origcolor.w;
	#ifdef BOKEH_IGNORES_SKY
	if (depth > 9.0) depth -= 10.0;
	#endif
	float blurAmount=abs(depth*2.0 - 1.0);
	#ifdef CLIPPING
	clip(blurAmount - ClipThreshold);
	#endif
	
	#ifdef AUTO_FOCUS
	blurAmount*=(depth < 0.5) ? (1.0 / max(NearBlurCurve, 1.0)) : 1.0;
	#endif
	blurAmount=smoothstep(0.15, 1.0, blurAmount);

	
	float weight[5] = {0.2270270270, 0.1945945946, 0.1216216216, 0.0540540541, 
		0.0162162162};
	
	float4 res=origcolor * weight[0];
	
	for(int i=1; i < 5; i++)
	{
		res+=tex2D(SamplerColor, coord.xy + float2(i*pixelSize.x*blurAmount, 0)) * weight[i];
		res+=tex2D(SamplerColor, coord.xy - float2(i*pixelSize.x*blurAmount, 0)) * weight[i];
	}
	
	
	res.w=depth;
	
	return res;
}


//Gaussian Blur, 2nd pass.
float4 PS_ProcessPass5(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	const float NearBlurCurve = (EInteriorFactor) ? NearBlurCurveINT : NearBlurCurveEXT;
	const float GaussContrastMultiplier = (EInteriorFactor) ? GaussContrastMultiplierINT : lerp(GaussContrastMultiplierNIGHT, GaussContrastMultiplierDAY, ENightDayFactor);
	float2 coord=IN.txcoord.xy;
	
	float2 pixelSize=ScreenSize.y;
	pixelSize.y*=ScreenSize.z;
	
	
	float4 origcolor=tex2D(SamplerColor, coord.xy);
	float depth=origcolor.w;
	#ifdef BOKEH_IGNORES_SKY
	if (depth > 9.0) depth -= 10.0;
	#endif
	float blurAmount=abs(depth*2.0 - 1.0);
	#ifdef CLIPPING
	clip(blurAmount - ClipThreshold);
	#endif
	
	#ifdef AUTO_FOCUS
	blurAmount*=(depth < 0.5) ? (1.0 / max(NearBlurCurve, 1.0)) : 1.0;
	#endif
	blurAmount=smoothstep(0.15, 1.0, blurAmount);

	
	float weight[5] = {0.2270270270, 0.1945945946, 0.1216216216, 0.0540540541, 
		0.0162162162};
	float4 res=origcolor * weight[0];

	for(int i=1; i < 5; i++)
	{
		res+=tex2D(SamplerColor, coord.xy + float2(0, i*pixelSize.y*blurAmount)) * weight[i];
		res+=tex2D(SamplerColor, coord.xy - float2(0, i*pixelSize.y*blurAmount)) * weight[i];
	}

	#ifdef GAUSS_BLUR_CONTRAST
	res *= 1.0 + blurAmount * lerp(-1.0, 1.0, dot(origcolor.rgb, 0.3333)) * GaussContrastMultiplier;
	#endif
	
	res.w=depth;
	
	return res;
}
#endif

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
technique PostProcess
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass1();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}

#ifdef BOKEH_FLICKER
technique PostProcess2
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPassFlicker();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}
#endif


#ifdef GAUSS_BEFORE_BOKEH

#ifdef BOKEH_FLICKER
technique PostProcess3
#else
technique PostProcess2
#endif
{

	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass4();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}


#ifdef BOKEH_FLICKER
technique PostProcess4
#else
technique PostProcess3
#endif
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass5();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}

#ifdef BOKEH_FLICKER
technique PostProcess5
#else
technique PostProcess4
#endif
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass2();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}

#ifdef BOKEH_FLICKER
technique PostProcess6
#else
technique PostProcess5
#endif
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass3();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}

#ifdef BOKEH_SECOND_PASS
#ifdef BOKEH_FLICKER
technique PostProcess7
#else
technique PostProcess6
#endif
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass2();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}
#endif

#else

#ifdef BOKEH_FLICKER
technique PostProcess3
#else
technique PostProcess2
#endif
{

	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass2();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}


#ifdef BOKEH_FLICKER
technique PostProcess4
#else
technique PostProcess3
#endif
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass3();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}

#ifdef GAUSS_BLUR
#ifdef BOKEH_FLICKER
technique PostProcess5
#else
technique PostProcess4
#endif
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass4();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}

#ifdef BOKEH_FLICKER
technique PostProcess6
#else
technique PostProcess5
#endif
{
	pass P0
	{

		VertexShader = compile vs_3_0 VS_PostProcess();
		PixelShader  = compile ps_3_0 PS_ProcessPass5();

		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		AlphaBlendEnable=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}
#endif
#endif