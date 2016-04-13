//++++++++++++++++++++++++++++++++++++++++++++
// ENBSeries effect file
// visit http://enbdev.com for updates
// Copyright (c) 2007-2011 Boris Vorontsov
//
// Using decompiled shader of TES Skyrim
//++++++++++++++++++++++++++++++++++++++++++++

//++++++++++++++++++++++++++++++++++++++++++++
// Additions and Tweaking by HD6 (HeliosDoubleSix) and Bronze316
// MOD by HD6: http://www.skyrimnexus.com/downloads/file.php?id=4142

// Project ENB (2013) - by Bronze316

// http://skyrim.nexusmods.com/mods/15983
// http://skyrim.nexusmods.com/mods/20781
// http://skyrim.nexusmods.com/mods/23812


// Optimized for Project Reality - Climates Of Tamriel - by jjc71

// http://skyrim.nexusmods.com/mods/17802


// these are typically denoted by 'HD6'
// given I have no shader writing experience,
// will undoubtedly be retarded to a seasoned professional, I welcome any advice!
// thanks Boris!
//++++++++++++++++++++++++++++++++++++++++++++

// CREDITS

// JawZ: Author of DN-IE code, redesigned file layout.			//
//																//
// HeliosDoubleSix/HD6: Author of initial						//
// Bloom Screen, Bloom Crisp, Bloom Defuzz,						//
// Bloom No Black, Color Tweaks and Vignette.					//
//																//
// MTichenor: Author of initial Vanilla Adaptation,				//
// Vanilla Bloom and Flip factor

#define POSTPROCESS					2	// Choose which post-processing effect to use 2.
#define APPLYGAMECOLORCORRECTION 	1	// This will deactivate the use of Vanilla post-processing and only use ENB own post-processing.
#define ENB_FLIPTECHNIQUE 			0	// This will turn every effect in here off + SSAO, Reflections, Skylighting, Detailed Shadows, Sun Rays, ImageBasedLighting and Rain.

//

#define FLIP_INT_EXT				0	// Flips the interior and exterior factor, so that interior settings affect exteriors and vice versa.
#define FLIP_NIGHT_DAY				0	// Flips the day and night factor, so that day settings affect nights and vice versa.

//

#define ENB_ADAPTATION			1	// Enables ENB dynamic Adaptation settings.
#define HD6_ADAPTATION			1	// Enables HD6 static Skyrim Adaptation settings.
#define VANILLA_ADAPTATION		0	// Enables Skyrim Adaptation settings.
#define VANILLA_BLOOM			0	// Enables Skyrim Bloom settings.

//

#define HD6_BLOOM				1	// 1,2. 1 = Bloom Crisp - alternate crisp bloom, no hazey mud. 2 = Bloom Screen alternate bloom (using screen mode).
#define HD6_BLOOM_NOBLACK		0	// Brightens the dark spots of bloom.
#define HD6_BLOOM_DEFUZZ		0	// HD6 attempt to remove some of the haze from the bloom.

//

#define HD6_COLOR_TWEAKS		1	// Enables a set of Contrast, Brightness and Saturation controls, with in-game adjustment.
#define HD6_COLORSAT			1	// Adjusts the RGB values seperately, Red, Green and Blue + Magenta, Cyan and Yellow color
#define HD6_BLOOM_DEBLUEIFY		1	// With this enabled you can adjust the coloization of the bloom. Same settings as "KOLORIZER" but affects only bloom.
#define PALETTE_MIXER			1	// Enable settings to adjust the enbpalette.bmp
#define HD6_VIGNETTE			1

//

#if (POSTPROCESS==1)

//EXTERIOR									Night, Day
float2	EContrastV1Ext				= float2( 1.0, 1.0 );	// Higher amounts make the dark areas darker while making the bright spot brighter.
float2	EColorSaturationV1Ext		= float2( 1.0, 1.0 );	// Adds more color to the screen.
float2	EToneMappingCurveV1Ext		= float2( 1.0, 1.0 );	// Increasing this darkens the image and makes the bright spots less intense, Explanation of Tonemapping - http://en.wikipedia.org/wiki/Tone_mapping
float2	EToneMappingOversatV1Ext	= float2( 1.0, 1.0 );	// Similar to EToneMappingCurve but more subtle and makes the bright spots less intense and less colorful.

//INTERIOR									Night, Day
float2	EContrastV1Int				= float2( 1.0, 1.0 );
float2	EColorSaturationV1Int		= float2( 1.0, 1.0 );
float2	EToneMappingCurveV1Int		= float2( 1.0, 1.0 );
float2	EToneMappingOversatV1Int	= float2( 1.0, 1.0 );
#endif

#if (POSTPROCESS==2) // Modifications and tweaks by Bronze316

//EXTERIOR									Night, Day
float2	EBrightnessV2Ext	= float2( 1.0, 1.0 );
float2	EIntensityContrastV2Ext	= float2( 1.475, 1.725 );
float2	EColorSaturationV2Ext	= float2( 1.697842, 1.985612 );
float2	EToneMappingCurveV2Ext	= float2( 16.0, 16.0 );
float2	EToneMappingOversatV2Ext= float2( 2716.6, 3648.6 );
float2	EBlacknessV2Ext		= float2( 0.000001, 0.000001 );

float2	EPostBrightnessV2Ext	= float2( 1.697842, 2.606116 );

//INTERIOR									Night, Day
float2	EBrightnessV2Int	= float2( 1.0, 1.0 );
float2	EIntensityContrastV2Int	= float2( 1.475, 1.475 );
float2	EColorSaturationV2Int	= float2( 1.697842, 1.697842 );
float2	EToneMappingCurveV2Int	= float2( 16.0, 16.0 );
float2	EToneMappingOversatV2Int= float2( 3056.2, 3056.2 );
float2	EBlacknessV2Int		= float2( 0.000001, 0.000001 );

float2	EPostBrightnessV2Int	= float2( 1.273382, 1.273382 );

#endif

#if (POSTPROCESS==3)

//EXTERIOR									Night, Day
float2	EToneMappingCurveV3Ext  	= float2( 4.0, 4.0 );	// Increasing this darkens the image, Explanation of Tonemapping - http://en.wikipedia.org/wiki/Tone_mapping
float2	EToneMapOversatV3Ext		= float2( 60.0, 60.0 );	// Increasing this darkens the image and makes the bright spots less intense, Explanation of Tonemapping - http://en.wikipedia.org/wiki/Tone_mapping

//INTERIOR									Night, Day
float2	EToneMappingCurveV3Int  	= float2( 4.0, 4.0 );
float2	EToneMapOversatV3Int		= float2( 60.0, 60.0 );
#endif

#if (POSTPROCESS==4)

//EXTERIOR									  Night, Day
float2	EBrightnessCurveV4Ext		= float2( 0.7, 0.7 );	// A sort of contrast setting
float2	EBrightMultiplierV4Ext		= float2( 0.45, 0.45 );	// A different kind of brightness setting
float2	EBrightToneMapCurveV4Ext	= float2( 0.5, 0.5 );	// Behaves in similar ways as EToneMappingCurve

//INTERIOR									  Night, Day
float2	EBrightnessCurveV4Int		= float2( 0.7, 0.7 );
float2	EBrightMultiplierV4Int		= float2( 0.45, 0.45 );
float2	EBrightToneMapCurveV4Int	= float2( 0.5, 0.5 );
#endif

#if (POSTPROCESS==5)

//EXTERIOR									Night, Day
float2	EBrightnessV5Ext			= float2( 3.1, 1.5 );	// Adjust the brightness of the scene.
float2	EPostBrightnessV5Ext		= float2( 1.3, 1.3 );	// Brightness that is rendered after the saturation and contrast. Compensates for darkening caused by those methods.
float2	EIntensityContrastV5Ext		= float2( 3.475, 3.475 );	// Adjust the Contrast of the whole scene. Makes bright areas brighter and dark areas darker.
float2	EColorSaturationV5Ext		= float2( 3.3, 3.3 );	// Adjust the entire scene saturation. Adds more or less color if you increase or decrease the value
float2	EToneMappingCurveV5Ext		= float2( 8.0, 8.0 );	// A type of contrast that darkens everything, in simplest terms.

//INTERIOR									Night, Day
float2	EBrightnessV5Int			= float2( 3.1, 1.5 );
float2	EPostBrightnessV5Int		= float2( 1.3, 1.3 );
float2	EIntensityContrastV5Int		= float2( 3.475, 3.475 );
float2	EColorSaturationV5Int		= float2( 3.3, 3.3 );
float2	EToneMappingCurveV5Int		= float2( 8.0, 8.0 );
#endif

//

#if (ENB_ADAPTATION==1)

//EXTERIOR									Night, Day
	float2 EAdaptationMinExt 	= float2( 0.04, 0.08 ); // Determines the lowest amount the Adaptation will adjust the brightness.
	float2 EAdaptationMaxExt 	= float2( 0.06, 0.12 ); // Determines the highest amount the Adaptation will adjust the brightness.

//INTERIOR									Night, Day
	float2 EAdaptationMinInt	= float2( 0.04, 0.04 );
	float2 EAdaptationMaxInt	= float2( 0.06, 0.06 );
#endif

#if (HD6_ADAPTATION==1)

//EXTERIOR									Night, Day
	float2 EAdaptationStaticExt 	= float2( 0.5, 0.375 );	// Adjust Skyrim min or max setting, range 0 to 1
	float2 EAdaptationCompExt 	= float2( 1.0, 1.0 );	// Compensates for any loss in brightness.

//INTERIOR									Night, Day
	float2 EAdaptationStaticInt	= float2( 0.5, 0.5 );
	float2 EAdaptationCompInt 	= float2( 1.0, 1.0 );
#endif

#if (VANILLA_ADAPTATION==1)

//EXTERIOR									Night, Day
float2 fVanillaAdaptAmbientExt 		= float2( 0.36, -0.28 );	// Controls how much ambient luminosity there is from vanilla adaptation code.
float2 fVanillaAdaptChangeExt  		= float2( 0.0, 0.0 );	// Controls how much the brightness changes when looking up and down. Affects ambient too.

//INTERIOR									Night, Day
float2 fVanillaAdaptAmbientInt 		= float2( 0.36, 0.36 );
float2 fVanillaAdaptChangeInt  		= float2( 0.0, 0.0 );
#endif

#if (VANILLA_BLOOM==1)

//EXTERIOR									Night, Day
float2 fVanillaBloomExt			= float2( 1.0, 1.0 ); // Controls the intensity of vanilla bloom effect.
float2 fVanillaBloomConExt		= float2( 0.0, 0.0 ); // This clamps the vanilla bloom to bright spots and darkens the dark areas.

//INTERIOR									Night, Day
float2 fVanillaBloomInt			= float2( 1.0, 1.0 );
float2 fVanillaBloomConInt		= float2( 0.0, 0.0 );
#endif

//

#if (HD6_BLOOM==1)			// Bloom Crisp

//EXTERIOR							Night, Day
float2 bBrightnessExt		= float2( 1.0, 1.0 );	// Adjust bloom brightness.
float2 bContrastExt			= float2( 1.1, 1.0 );	// Adjust bloom contrast.
float2 bSaturationExt		= float2( 0.8, 0.7 );	// Adjust bloom saturation.
float2 bTriggerExt			= float2( 0.18, 0.0 );	// Darkens bloom and thus limits bloom to trigger.
float2 bLimiterExt			= float2( 0.7, 0.7 );	// Limits the amount of bloom.
float2 bAddCompensateExt	= float2( 0.12, 0.23 );	// Compensate scene brightness by adding regular Brightness on top of the bloom.
float2 bMultCompensateExt	= float2( 1.1, 1.4 );	// Compensate scene brightness by multiplying regular Brightness on top of the bloom.
float2 bBrtSpotStrengthExt	= float2( 1.0, 1.0 );	// Brightens only the super bright spots.
float2 bBrtSpotStrength2Ext	= float2( 1.0, 1.0 );	// Brightens only bright spots.
float2 bBlendOriginalExt	= float2( 0.7, 0.6 );	// Blends in some additional bloom
float2 bCompOriginalExt		= float2( 0.8, 0.7 );	// Compensate scene brightness caused by BlendOriginal, multiplies regular scene Brightness.

//INTERIOR							Night, Day
float2 bBrightnessInt		= float2( 1.0, 1.0 );
float2 bContrastInt			= float2( 1.1, 1.1 );
float2 bSaturationInt		= float2( 0.8, 0.8 );
float2 bTriggerInt			= float2( 0.18, 0.18 );
float2 bLimiterInt			= float2( 0.7, 0.7 );
float2 bAddCompensateInt	= float2( 0.12, 0.12 );
float2 bMultCompensateInt	= float2( 1.1, 1.1 );
float2 bBrtSpotStrengthInt	= float2( 1.0, 1.0 );
float2 bBrtSpotStrength2Int	= float2( 1.0, 1.0 );
float2 bBlendOriginalInt	= float2( 0.7, 0.7 );
float2 bCompOriginalInt		= float2( 0.8, 0.8 );
#endif

#if (HD6_BLOOM==2)			// Bloom Screen

//EXTERIOR					Night, Day
float2 BloomMultExt	= float2( 10.0, 10.0 );	// Increase the intensity of the bloom

//INTERIOR					Night, Day
float2 BloomMultInt	= float2( 10.0, 10.0 );
#endif

#if (HD6_BLOOM_NOBLACK==1)

//EXTERIOR						Night, Day
float2 BloomBlacknessExt = float2( 0.12, 0.12 ); // Controls the amount of vanilla bloom effect.
//INTERIOR
float2 BloomBlacknessInt = float2( 0.12, 0.12 );
#endif

#if (HD6_BLOOM_DEFUZZ==1)

//EXTERIOR						Night, Day
float2 DefuzzAlphaExt	= float2( 0.333, 0.333 );	// Adjust the bloom RGB Alpha channel.
float2 DefuzzSubExt		= float2( 0.3, 0.3 );	// Subtract the bloom intensity.
float2 DefuzzAddExt		= float2( 0.22, 0.22 );	// Add bloom intensity.

//INTERIOR						Night, Day
float2 DefuzzAlphaInt	= float2( 0.333, 0.333 );
float2 DefuzzSubInt		= float2( 0.3, 0.3 );
float2 DefuzzAddInt		= float2( 0.22, 0.22 );
#endif

//

#if (HD6_COLOR_TWEAKS==1)

//EXTERIOR							 Red, Green, Blue
float3 ctRGBExtDay   		= float3( 1.0, 1.0, 1.0 );	// RGB balance Day
float3 ctRGBExtNight 		= float3( 1.0, 1.0, 1.0 );	// RGB balance Night

//									Night, Day
float2 ctPreBrightnessExt 	= float2( 1.00, 1.00 );	// Brightness applied before Contrast
float2 ctPostBrightnessExt	= float2( 1.00, 1.00 );	// Brightness applied after Contrast
float2 ctContrastExt 		= float2( 1.175, 1.3825 );	// Contrast
float2 ctSaturationExt		= float2( 1.00, 1.00 );	// Saturation
float2 ctDarkenExt		= float2( 0.0, 0.0 );	// Saturation

//INTERIOR							 Red, Green, Blue
float3 ctRGBIntDay   		= float3( 1.0, 1.0, 1.0 );	// RGB balance Day
float3 ctRGBIntNight 		= float3( 1.0, 1.0, 1.0 );	// RGB balance Night

//									Night, Day
float2 ctPreBrightnessInt 	= float2( 1.00, 1.00 );	// Brightness applied before Contrast
float2 ctPostBrightnessInt	= float2( 1.00, 1.00 );	// Brightness applied after Contrast
float2 ctContrastInt 		= float2( 1.24, 1.24 );	// Contrast
float2 ctSaturationInt		= float2( 1.00, 1.00 );	// Saturation
float2 ctDarkenInt		= float2( 0.0, 0.0 );	// Saturation
#endif

#if (HD6_COLORSAT==1)

//EXTERIOR						 Red, Green, Blue
float3 RGBSatExtDay 	= float3( 1.05, 1, 1.025 );
float3 RGBSatExtNight 	= float3( 1.125, 0.9375, 0.9375 );

//INTERIOR						 Red, Green, Blue
float3 RGBSatIntDay 	= float3( 0.9875, 0.9375, 1.075 );
float3 RGBSatIntNight 	= float3( 0.9875, 0.9375, 1.075 );
#endif

#if (HD6_BLOOM_DEBLUEIFY==1)

//EXTERIOR						 Red, Green, Blue
float3 DebluifyExtDay 	= float3( 1.254, 1.254, 1.254 );
float3 DebluifyExtNight = float3( 1.254, 1.254, 1.254 );

//INTERIOR						 Red, Green, Blue
float3 DebluifyIntDay 	= float3( 1.254, 1.254, 1.254 );
float3 DebluifyIntNight = float3( 1.254, 1.254, 1.254 );
#endif

#if (PALETTE_MIXER==1)

//EXTERIOR							Night, Day
float2 palmixExt 		= float2( 1.05, 1.05 );
float2 PaletteMinExt 		= float2( 1.05, 1.05 );
float2 PaletteMaxExt 		= float2( 1.05, 1.05 );

//INTERIOR							Night, Day
float2 palmixInt		= float2( 1.05, 1.05 );
float2 PaletteMinInt 		= float2( 1.05, 1.05 );
float2 PaletteMaxInt 		= float2( 1.05, 1.05 );
#endif

//

#if (HD6_VIGNETTE==1)

//EXTERIOR							Night, Day
float2 VignetteRoundExt		= float2( 0.4, 0.4 ); // Determines how round the vignette should be.
float2 VignetteSquareTopExt	= float2( 0, 0 ); // Determines how square the vignette should be. Adjusts the top of the screen
float2 VignetteSquareBotExt	= float2( 0.1, 0.1 ); // Determines how square the vignette should be. Adjusts the bottom of the screen
float2 VignetteSatExt		= float2( 0.85, 0.85 ); // Determines how saturated the vignette should be.
float2 VignetteContrastExt	= float2( 1.5, 1.5 ); // Determines how much contrast the vignette should have.
float2 VignetteStrengthExt	= float2( 0.85, 0.85 ); // Determines how strong the vignette should be depending on time of day.

//INTERIOR							Night, Day
float2 VignetteRoundInt		= float2( 0.4, 0.4 );
float2 VignetteSquareTopInt	= float2( 0, 0 );
float2 VignetteSquareBotInt	= float2( 0.1, 0.1 );
float2 VignetteSatInt		= float2( 0.85, 0.85 );
float2 VignetteContrastInt	= float2( 1.5, 1.5 );
float2 VignetteStrengthInt	= float2( 0.85, 0.85 );
#endif

//

//keyboard controlled temporary variables (in some versions exists in the config file). Press and hold key 1,2,3...8 together with PageUp or PageDown to modify. By default all set to 1.0
float4	tempF1; 		 // 1,2,3,4
float4	tempF2; 		 // 5,6,7,8
float4	tempF3; 		 // 9,0
float4	Timer; 			 // x=generic timer in range 0..1, period of 16777216 ms (4.6 hours), w=frame time elapsed (in seconds)
float4	ScreenSize; 	 // x=Width, y=1/Width, z=ScreenScaleY, w=1/ScreenScaleY
float	ENightDayFactor; // changes in range 0..1, 0 means that night time, 1 - day time
float	EInteriorFactor; // changes 0 or 1. 0 means that exterior, 1 - interior
float	EBloomAmount; 	 // enb version of bloom applied, ignored if original post processing used


texture2D texs0;//color
texture2D texs1;//bloom skyrim
texture2D texs2;//adaptation skyrim
texture2D texs3;//bloom enb
texture2D texs4;//adaptation enb
texture2D texs7;//palette enb

sampler2D _s0 = sampler_state
{
	Texture   = <texs0>;
	MinFilter = POINT;//
	MagFilter = POINT;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s1 = sampler_state
{
	Texture   = <texs1>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s2 = sampler_state
{
	Texture   = <texs2>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s3 = sampler_state
{
	Texture   = <texs3>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s4 = sampler_state
{
	Texture   = <texs4>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D _s7 = sampler_state
{
	Texture   = <texs7>;
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
	float2 txcoord0 : TEXCOORD0;
};
struct VS_INPUT_POST
{
	float3 pos  : POSITION;
	float2 txcoord0 : TEXCOORD0;
};

VS_OUTPUT_POST VS_Quad(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	OUT.vpos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);

	OUT.txcoord0.xy=IN.txcoord0.xy;

	return OUT;
}


//skyrim shader specific externals, do not modify
float4	_c1 : register(c1);
float4	_c2 : register(c2);
float4	_c3 : register(c3);
float4	_c4 : register(c4);
float4	_c5 : register(c5);

float4 PS_D6EC7DD1(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float4 _oC0=0.0; //output
	float4 _c6=float4(0, 0, 0, 0);
	float4 _c7=float4(0.212500006, 0.715399981, 0.0720999986, 1.0);
	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	float4 r6;
	float4 r7;
	float4 r8;
	float4 r9;
	float4 r10;
	float4 r11;
	float4 _v0=0.0;
	_v0.xy=IN.txcoord0.xy;
 //color
	r1=tex2D(_s0, _v0.xy);
 //apply bloom
	float4	xcolorbloom=tex2D(_s3, _v0.xy);
 //my bypass
	r11=r1;
 //for future use without game color corrections
	_oC0.xyz=r1.xyz;


// Flip Code for DN-IE, now with interpolation
   float JKNightDayFactor=(0, 1, ENightDayFactor);
   float JKInteriorFactor=(0, 1, EInteriorFactor);
#if (FLIP_INT_EXT==1)
   JKInteriorFactor=(EInteriorFactor, 0, 1);
#endif
#if (FLIP_NIGHT_DAY==1)
   JKNightDayFactor=(ENightDayFactor, 0, 1);
#endif


#if (APPLYGAMECOLORCORRECTION==1)
	//apply original
    r0.x=1.0/_c2.y;
#if (VANILLA_ADAPTATION==1)
		float 	fVanillaAdaptAmbient = lerp(fVanillaAdaptAmbientExt.x, fVanillaAdaptAmbientExt.y, JKNightDayFactor);
		float 	fVanillaAdaptChange = lerp(fVanillaAdaptChangeExt.x, fVanillaAdaptChangeExt.y, JKNightDayFactor);
	if ( JKInteriorFactor ) {
		fVanillaAdaptAmbient = lerp(fVanillaAdaptAmbientInt.x, fVanillaAdaptAmbientInt.y, JKNightDayFactor);
		fVanillaAdaptChange = lerp(fVanillaAdaptChangeInt.x, fVanillaAdaptChangeInt.y, JKNightDayFactor);
	};

	r1=tex2D(_s2, _v0);
	r1.x = lerp( 0.2, r1.x, fVanillaAdaptAmbient );
	r1.y = lerp( r1.x, r1.y, fVanillaAdaptChange );
	r0.yz=r1.xy * _c1.y;
#endif
#if (VANILLA_ADAPTATION==0)
	r1.x = 0.1;
        r1.y = 0.1;
	r1.z = 0.1;// Bronze316 - I might need this
	r0.yz=r1.xy * _c1.y;

	// Bronze316 - vanilla adaptation works better this way

	
    r0.w=1.0/r0.y;
    r0.z=r0.w * r0.z;
    r1=tex2D(_s0, _v0);
    r1.xyz=r1 * _c1.y;
    r0.w=dot(_c7.xyz, r1.xyz);
    r1.w=r0.w * r0.z;
    r0.z=r0.z * r0.w + _c7.w;
    r0.z=1.0/r0.z;
    r0.x=r1.w * r0.x + _c7.w;
    r0.x=r0.x * r1.w;
    r0.x=r0.z * r0.x;
    if (r0.w<0) r0.x=_c6.x;
    r0.z=1.0/r0.w;
    r0.z=r0.z * r0.x;
    r0.x=saturate(-r0.x + _c2.x);
//    r2=tex2D(_s3, _v0);//enb bloom

#endif // APPLYGAMECOLORCORRECTION

#if (VANILLA_BLOOM==1)
		float 	fVanillaBloom = lerp(fVanillaBloomExt.x, fVanillaBloomExt.y, JKNightDayFactor);
		float 	fVanillaBloomCon = lerp(fVanillaBloomConExt.x, fVanillaBloomConExt.y, JKNightDayFactor);
	if ( JKInteriorFactor ) {
		fVanillaBloom = lerp(fVanillaBloomInt.x, fVanillaBloomInt.y, JKNightDayFactor);
		fVanillaBloomCon = lerp(fVanillaBloomConInt.x, fVanillaBloomConInt.y, JKNightDayFactor);
	};

	r2=tex2D(_s1, _v0) * fVanillaBloom - fVanillaBloomCon;
#endif
#if (VANILLA_BLOOM==0)
	r2=0.0;
#endif
    r2.xyz=r2 * _c1.y;
    r2.xyz=r0.x * r2;
    r1.xyz=r1 * r0.z + r2;
    r0.x=dot(r1.xyz, _c7.xyz);
    r1.w=_c7.w;
    r2=lerp(r0.x, r1, _c3.x);
    r1=r0.x * _c4 - r2;
    r1=_c4.w * r1 + r2;
    r1=_c3.w * r1 - r0.y; //khajiit night vision _c3.w
    r0=_c3.z * r1 + r0.y;
    r1=-r0 + _c5;
    _oC0=_c5.w * r1 + r0;
#endif

	float4 color=_oC0;
 //adaptation in time
	float4	Adaptation=tex2D(_s4, 0.0);
	float	grayadaptation=max(max(Adaptation.x, Adaptation.y), Adaptation.z);

#if (HD6_COLORSAT==1)

	float3 	RGBSat = lerp(RGBSatExtNight, RGBSatExtDay, JKNightDayFactor);
if ( JKInteriorFactor ) {
	RGBSat = lerp(RGBSatIntNight, RGBSatIntDay, JKNightDayFactor);
};

	float3 nsatn=RGBSat; // So it has less to different/no effect during day
	float3 oldcoln = color.xyz; // store old values
	color.xyz *= nsatn; // adjust saturation	

	// spread lost luminace over everything
	float3 greycn = float3(0.333,0.333,0.333); // screw perception

	color.xyz += (oldcoln.x-(oldcoln.x*nsatn.x)) * greycn.x;
	color.xyz += (oldcoln.y-(oldcoln.y*nsatn.y)) * greycn.y;
	color.xyz += (oldcoln.z-(oldcoln.z*nsatn.z)) * greycn.z;
#endif

#if (HD6_BLOOM_NOBLACK==1)

	float 	BloomBlackness = lerp(BloomBlacknessExt.x, BloomBlacknessExt.y, JKNightDayFactor);
if ( JKInteriorFactor ) {
	BloomBlackness = lerp(BloomBlacknessInt.x, BloomBlacknessInt.y, JKNightDayFactor);
};

	float lowestvalue=min(min(xcolorbloom.x,xcolorbloom.y),xcolorbloom.z);
	float3 lowestpossible=xcolorbloom.xyz-lowestvalue;
	xcolorbloom.xyz=max(xcolorbloom.xyz,lowestpossible+BloomBlackness);
#endif

#if (HD6_BLOOM_DEBLUEIFY==1)

	float3 	nsat = lerp(DebluifyExtNight, DebluifyExtDay, JKNightDayFactor);
if ( JKInteriorFactor ) {
	nsat = lerp(DebluifyIntNight, DebluifyIntDay, JKNightDayFactor);
};

 // store old values
	float3 oldcol=xcolorbloom.xyz;
 // adjust saturation
	xcolorbloom.xyz *= nsat;
 // spread lost luminace over everything
	float3 greyc = float3(0.333,0.333,0.333); // screw perception

	xcolorbloom.xyz += (oldcol.x-(oldcol.x*nsat.x)) * greyc.x;
	xcolorbloom.xyz += (oldcol.y-(oldcol.y*nsat.y)) * greyc.y;
	xcolorbloom.xyz += (oldcol.z-(oldcol.z*nsat.z)) * greyc.z;
#endif

#if (HD6_BLOOM_DEFUZZ==1)

	float 	DefuzzAlpha = lerp(DefuzzAlphaExt.x, DefuzzAlphaExt.y, JKNightDayFactor);
	float 	DefuzzSub = lerp(DefuzzSubExt.x, DefuzzSubExt.y, JKNightDayFactor);
	float 	DefuzzAdd = lerp(DefuzzAddExt.x, DefuzzAddExt.y, JKNightDayFactor);
if ( JKInteriorFactor ) {
	DefuzzAlpha = lerp(DefuzzAlphaInt.x, DefuzzAlphaInt.y, JKNightDayFactor);
	DefuzzSub = lerp(DefuzzSubInt.x, DefuzzSubInt.y, JKNightDayFactor);
	DefuzzAdd = lerp(DefuzzAddInt.x, DefuzzAddInt.y, JKNightDayFactor);
};

	float mavg=((xcolorbloom.x+xcolorbloom.y+xcolorbloom.z)*DefuzzAlpha);
	xcolorbloom.xyz-=(mavg*DefuzzSub);
	xcolorbloom.xyz+=(mavg*DefuzzAdd);
	xcolorbloom.xyz*(mavg*1.2);
#endif

#if (HD6_COLOR_TWEAKS==1)

float reduceNight = JKNightDayFactor;
	reduceNight = lerp( 1, reduceNight, JKNightDayFactor ); // Removes affect during night
float hbs = lerp( EBloomAmount/2, EBloomAmount, reduceNight);
	hbs = max(0,hbs);
	hbs = min(2,hbs);


	float3 ctRGB = lerp(ctRGBExtNight, ctRGBExtDay, JKNightDayFactor);
	float ctbrt1 = lerp(ctPreBrightnessExt.x,ctPreBrightnessExt.y,JKNightDayFactor);
	float ctbrt2 = lerp(ctPostBrightnessExt.x,ctPostBrightnessExt.y,JKNightDayFactor);
	float ctcon  = lerp(ctContrastExt.x,ctContrastExt.y,JKNightDayFactor);
	float ctsat  = lerp(ctSaturationExt.x,ctSaturationExt.y,JKNightDayFactor);
	ctbrt1 -= lerp(ctDarkenExt.x,ctDarkenExt.y,JKNightDayFactor);
if ( JKInteriorFactor ) {
	ctRGB = lerp(ctRGBIntNight, ctRGBIntDay, JKNightDayFactor);
	ctbrt1 = lerp(ctPreBrightnessInt.x,ctPreBrightnessInt.y,JKNightDayFactor);
	ctbrt2 = lerp(ctPostBrightnessInt.x,ctPostBrightnessInt.y,JKNightDayFactor);
	ctcon  = lerp(ctContrastInt.x,ctContrastInt.y,JKNightDayFactor);
	ctsat  = lerp(ctSaturationInt.x,ctSaturationInt.y,JKNightDayFactor);
	ctbrt1 -= lerp(ctDarkenInt.x,ctDarkenInt.y,JKNightDayFactor);
};

	float3 ctLumCoeff = float3(0.2125, 0.7154, 0.0721);				
	float3 ctAvgLumin = float3(0.5, 0.5, 0.5);
	float3 ctbrtColor = color.rgb * ctbrt1;

	float3 ctintensity = dot(ctbrtColor, ctLumCoeff);
	float3 ctsatColor = lerp(ctintensity, ctbrtColor, ctsat); 
	float3 cconColor = lerp(ctAvgLumin, ctsatColor, ctcon);

	color.xyz = cconColor * ctbrt2;
	float3 cbalance = ctRGB;
	color.xyz = cbalance.xyz * color.xyz;
#endif

#if (HD6_BLOOM==1)		// Bloom Crisp

	float brt = lerp(bBrightnessExt.x, bBrightnessExt.y, JKNightDayFactor);
	float con = lerp(bContrastExt.x, bContrastExt.y, JKNightDayFactor);
	float sat = lerp(bSaturationExt.x, bSaturationExt.y, JKNightDayFactor);
	float trig = lerp(bTriggerExt.x, bTriggerExt.y, JKNightDayFactor);
	float limit = lerp(bLimiterExt.x, bLimiterExt.y, JKNightDayFactor);
	float addcomp = lerp(bAddCompensateExt.x, bAddCompensateExt.y, JKNightDayFactor);
	float multcomp = lerp(bMultCompensateExt.x, bMultCompensateExt.y, JKNightDayFactor);
	float sbrightstr = lerp(bBrtSpotStrengthExt.x, bBrtSpotStrengthExt.y, JKNightDayFactor);
	float sbrightstr2 = lerp(bBrtSpotStrength2Ext.x, bBrtSpotStrength2Ext.y, JKNightDayFactor);
	float orgblend = lerp(bBlendOriginalExt.x, bBlendOriginalExt.y, JKNightDayFactor);
	float orgcomp = lerp(bCompOriginalExt.x, bCompOriginalExt.y, JKNightDayFactor);
if ( JKInteriorFactor ) {
	brt = lerp(bBrightnessInt.x, bBrightnessInt.y, JKNightDayFactor);
	con = lerp(bContrastInt.x, bContrastInt.y, JKNightDayFactor);
	sat = lerp(bSaturationInt.x, bSaturationInt.y, JKNightDayFactor);
	trig = lerp(bTriggerInt.x, bTriggerInt.y, JKNightDayFactor);
	limit = lerp(bLimiterInt.x, bLimiterInt.y, JKNightDayFactor);
	addcomp = lerp(bAddCompensateInt.x, bAddCompensateInt.y, JKNightDayFactor);
	multcomp = lerp(bMultCompensateInt.x, bMultCompensateInt.y, JKNightDayFactor);
	sbrightstr = lerp(bBrtSpotStrengthInt.x, bBrtSpotStrengthInt.y, JKNightDayFactor);
	sbrightstr2 = lerp(bBrtSpotStrength2Int.x, bBrtSpotStrength2Int.y, JKNightDayFactor);
	orgblend = lerp(bBlendOriginalInt.x, bBlendOriginalInt.y, JKNightDayFactor);
	orgcomp = lerp(bCompOriginalInt.x, bCompOriginalInt.y, JKNightDayFactor);
};

	float3 LumCoeff = float3( 0.2125, 0.7154, 0.0721 );
	float3 AvgLumin = float3( 0.5, 0.5, 0.5 );

	float3 brightbloom = ( xcolorbloom - trig); // darkens and thus limits what triggers a bloom, used in part to stop snow at night glowing blue
	brightbloom = max( brightbloom , 0);

	float3 superbright = xcolorbloom - limit; // crop it to only include superbright elemnts like sky and fire
	superbright = max( superbright , 0 ) ; // crop so dont go any lower than black
	superbright *= 0.6;

  // HD6 - Bloom - Brightness, Contrast, Saturation adjustment
	float3 brtColor = brightbloom * brt;
	float3 cintensity = dot( brtColor, LumCoeff );
	float3 satColor = lerp( cintensity, brtColor, sat ); 
	float3 conColor = lerp( AvgLumin, satColor, con );
	conColor -= 0.3;
	brightbloom = conColor;

  // These 2 should compensate so when even when no bloom exists it still matches brightness of scene without ENB
	color.xyz += addcomp; // regular color
	color.xyz *= multcomp; // regular color

  #if (HD6_BLOOM==1 && HD6_COLOR_TWEAKS==1)
  // Now Add bloom and compensate for any brightness changes that introduces
	color.xyz += (( superbright * hbs ) * sbrightstr);
	brightbloom -= ( superbright * 2 ); // removes superbright from brightbloom so I dont bloom the brightest area twice
	brightbloom = max( brightbloom , 0.0 );
	color.xyz += (( brightbloom * hbs ) * sbrightstr2);

  // Blend in some of the original bloom to bring back SOME of the hazy glow of the day, none at night
	color.xyz += (xcolorbloom.xyz * hbs) * orgblend;
	color.xyz *= orgcomp; // regular color

  #elif (HD6_BLOOM==1 && HD6_COLOR_TWEAKS==0)
  // Now Add bloom and compensate for any brightness changes that introduces
	color.xyz += (( superbright ) * sbrightstr);
	brightbloom -= ( superbright * 2 ); // removes superbright from brightbloom so I dont bloom the brightest area twice
	brightbloom = max( brightbloom , 0.0 );
	color.xyz += (( brightbloom ) * sbrightstr2);

  // Blend in some of the original bloom to bring back SOME of the hazy glow of the day, none at night
	color.xyz += (xcolorbloom.xyz) * orgblend;
	color.xyz *= orgcomp; // compensate for brightening caused by above bloom
  #endif

#elif (HD6_BLOOM==2)		// Bloom Screen

	float 	BloomMult = lerp(BloomMultExt.x, BloomMultExt.y, JKNightDayFactor);
if ( JKInteriorFactor ) {
	BloomMult = lerp(BloomMultInt.x, BloomMultInt.y, JKNightDayFactor);
};

	color+=((color/1)*EBloomAmount); // compensate if bloom disabled	
	xcolorbloom=max(xcolorbloom,0); // will cause color shift/desaturation also

	float tmult = BloomMult;
	color/=tmult; xcolorbloom/=tmult; // Screen mode wont work with floating point numbers / big numbers, so I reduce it first

	color.x = 1.0 - ((1.0 - color.x) * (1.0 - xcolorbloom.x));
	color.y = 1.0 - ((1.0 - color.y) * (1.0 - xcolorbloom.y));
	color.z = 1.0 - ((1.0 - color.z) * (1.0 - xcolorbloom.z));
	color*=tmult;

#elif (HD6_BLOOM==0)		// Enabled Bloom for enbseries.ini controls
	color.xyz+=xcolorbloom.xyz*EBloomAmount;
#endif

#if (HD6_VIGNETTE==1)	

		float3 	rovigpwr = lerp(VignetteRoundExt.x, VignetteRoundExt.y, JKNightDayFactor);
		float3 	sqtoppwr = lerp(VignetteSquareTopExt.x, VignetteSquareTopExt.y, JKNightDayFactor);
		float3 	sqbotpwr = lerp(VignetteSquareBotExt.x, VignetteSquareBotExt.y, JKNightDayFactor);
		float 	vsatstrength = lerp(VignetteSatExt.x, VignetteSatExt.y, JKNightDayFactor);
		float 	vignettepow = lerp(VignetteContrastExt.x, VignetteContrastExt.y, JKNightDayFactor);
		float 	vstrength = lerp(VignetteStrengthExt.x, VignetteStrengthExt.y, JKNightDayFactor);
	if ( JKInteriorFactor ) {
		rovigpwr = lerp(VignetteRoundInt.x, VignetteRoundInt.y, JKNightDayFactor);
		sqtoppwr = lerp(VignetteSquareTopInt.x, VignetteSquareTopInt.y, JKNightDayFactor);
		sqbotpwr = lerp(VignetteSquareBotInt.x, VignetteSquareBotInt.y, JKNightDayFactor);
		vsatstrength = lerp(VignetteSatInt.x, VignetteSatInt.y, JKNightDayFactor);
		vignettepow = lerp(VignetteContrastInt.x, VignetteContrastInt.y, JKNightDayFactor);
		vstrength = lerp(VignetteStrengthInt.x, VignetteStrengthInt.y, JKNightDayFactor);
	};

	float2 inTex = _v0;	
	float4 voriginal = r1;
	float4 vcolor = voriginal;
	vcolor.xyz=1;
	inTex -= 0.5; // Centers vignette
	inTex.y += 0.01; // Move it off center and up so it obscures sky less
	float vignette = 1.0 - dot( inTex, inTex );
	vcolor *= pow( vignette, vignettepow );

 // Round Vignette
	float4 rvigtex = vcolor;
	rvigtex.xyz = pow( vcolor, 1 );
	rvigtex.xyz = lerp(float3(0.5, 0.5, 0.5), rvigtex.xyz, 2.0); // Increase Contrast
	rvigtex.xyz = lerp(float3(1,1,1),rvigtex.xyz,rovigpwr); // Set strength of round vignette

 // Square Vignette (just top and bottom of screen)
	float4 vigtex = vcolor;
	vcolor.xyz = float3(1,1,1);
	float3 topv = min((inTex.y+0.5)*2,0.5) * 2; // Top vignette
	float3 botv = min(((0-inTex.y)+0.5)*2,0.5) * 2; // Bottom vignette

	topv= lerp(float3(1,1,1), topv, sqtoppwr.x);
	botv= lerp(float3(1,1,1), botv, sqbotpwr.y);
	vigtex.xyz = (topv)*(botv);

 // Add round and square together
	vigtex.xyz*=rvigtex.xyz; 
	vigtex.xyz = lerp(vigtex.xyz,float3(1,1,1),(1-vstrength)); // Alter Strength at night

	vigtex.xyz = min(vigtex.xyz,1);
	vigtex.xyz = max(vigtex.xyz,0);

 // Increase saturation where edges were darkenned
	float3 vtintensity = dot(color.xyz, float3(0.2125, 0.7154, 0.0721));
	color.xyz = lerp(vtintensity, color.xyz, ((((1-(vigtex.xyz*2))+2)-1)*vsatstrength)+1  );

	color.xyz *= (vigtex.xyz);
#endif

#if (HD6_ADAPTATION==1)

	float 	EAdaptationStatic = lerp(EAdaptationStaticExt.x, EAdaptationStaticExt.y, JKNightDayFactor);
	float 	EAdaptationComp = lerp(EAdaptationCompExt.x, EAdaptationCompExt.y, JKNightDayFactor);
if ( JKInteriorFactor ) {
	EAdaptationStatic = lerp(EAdaptationStaticInt.x, EAdaptationStaticInt.y, JKNightDayFactor);
	EAdaptationComp = lerp(EAdaptationCompInt.x, EAdaptationCompInt.y, JKNightDayFactor);
};

	float toobright = max(0,tex2D(_s2, _v0).xyz - EAdaptationStatic);
	color.xyz *= EAdaptationComp-(0.5 * toobright);
#endif

#if (ENB_ADAPTATION==1)

	float 	EAdaptationMin = lerp(EAdaptationMinExt.x, EAdaptationMinExt.y, JKNightDayFactor);
	float 	EAdaptationMax = lerp(EAdaptationMaxExt.x, EAdaptationMaxExt.y, JKNightDayFactor);
if ( JKInteriorFactor ) {
	EAdaptationMin = lerp(EAdaptationMinInt.x, EAdaptationMinInt.y, JKNightDayFactor);
	EAdaptationMax = lerp(EAdaptationMaxInt.x, EAdaptationMaxInt.y, JKNightDayFactor);
};

	grayadaptation=max(grayadaptation, 0.0);
	grayadaptation=min(grayadaptation, 50.0);
	color.xyz=color.xyz/(grayadaptation*EAdaptationMax+EAdaptationMin);
#endif

#if (PALETTE_MIXER==1)

	float 	palmix = lerp(palmixExt.x, palmixExt.y, JKNightDayFactor);
	float 	PaletteMin = lerp(PaletteMinExt.x, PaletteMinExt.y, JKNightDayFactor);
	float 	PaletteMax = lerp(PaletteMaxExt.x, PaletteMaxExt.y, JKNightDayFactor);
if ( JKInteriorFactor ) {
	palmix = lerp(palmixInt.x, palmixInt.y, JKNightDayFactor);
	PaletteMin = lerp(PaletteMinInt.x, PaletteMinInt.y, JKNightDayFactor);
	PaletteMax = lerp(PaletteMaxInt.x, PaletteMaxInt.y, JKNightDayFactor);
};

	color.xyz*=lerp( PaletteMin, PaletteMax, palmix);
#endif

#if (POSTPROCESS==1)

	float 	EContrastV1 = lerp(EContrastV1Int.x, EContrastV1Int.y, JKNightDayFactor);
	float 	EColorSaturationV1 = lerp(EColorSaturationV1Int.x, EColorSaturationV1Int.y, JKNightDayFactor);
	float 	EToneMappingCurveV1 = lerp(EToneMappingCurveV1Int.x, EToneMappingCurveV1Int.y, JKNightDayFactor);
	float 	EToneMappingOversaturationV1 = lerp(EToneMappingOversatV1Int.x, EToneMappingOversatV1Int.y, JKNightDayFactor);
if ( JKInteriorFactor ) {
	EContrastV1 = lerp(EContrastV1Ext.x, EContrastV1Ext.y, JKNightDayFactor);
	EColorSaturationV1 = lerp(EColorSaturationV1Ext.x, EColorSaturationV1Ext.y, JKNightDayFactor);
	EToneMappingCurveV1 = lerp(EToneMappingCurveV1Ext.x, EToneMappingCurveV1Ext.y, JKNightDayFactor);
	EToneMappingOversaturationV1 = lerp(EToneMappingOversatV1Ext.x, EToneMappingOversatV1Ext.y, JKNightDayFactor);
};

	float cgray=dot(color.xyz, float3(0.27, 0.67, 0.06));
	cgray=pow(cgray, EContrastV1);
	float3 poweredcolor=pow(color.xyz, EColorSaturationV1);
	float newgray=dot(poweredcolor.xyz, float3(0.27, 0.67, 0.06));
	color.xyz=poweredcolor.xyz*cgray/(newgray+0.0001);

	float3	luma=color.xyz;
	float	lumamax=EToneMappingOversaturationV1;
	color.xyz=(color.xyz * (1.0 + color.xyz/lumamax))/(color.xyz + EToneMappingCurveV1);
#endif

#if (POSTPROCESS==2)
	float 	EBrightnessV2 = lerp(EBrightnessV2Ext.x, EBrightnessV2Ext.y, JKNightDayFactor);
	float 	EIntensityContrastV2 = lerp(EIntensityContrastV2Ext.x, EIntensityContrastV2Ext.y, JKNightDayFactor);
	float 	EColorSaturationV2 = lerp(EColorSaturationV2Ext.x, EColorSaturationV2Ext.y, JKNightDayFactor);
	float 	EToneMappingCurveV2 = lerp(EToneMappingCurveV2Ext.x, EToneMappingCurveV2Ext.y, JKNightDayFactor);
	float 	EToneMappingOversaturationV2 = lerp(EToneMappingOversatV2Ext.x, EToneMappingOversatV2Ext.y, JKNightDayFactor);
	float 	EBlacknessV2 = lerp(EBlacknessV2Ext.x, EBlacknessV2Ext.y, JKNightDayFactor);
	float	EPostBrightnessV2 = lerp(EPostBrightnessV2Ext.x, EPostBrightnessV2Ext.y, JKNightDayFactor);
if ( JKInteriorFactor ) {
	EBrightnessV2 = lerp(EBrightnessV2Int.x, EBrightnessV2Int.y, JKNightDayFactor);
	EIntensityContrastV2 = lerp(EIntensityContrastV2Int.x, EIntensityContrastV2Int.y, JKNightDayFactor);
	EColorSaturationV2 = lerp(EColorSaturationV2Int.x, EColorSaturationV2Int.y, JKNightDayFactor);
	EToneMappingCurveV2 = lerp(EToneMappingCurveV2Int.x, EToneMappingCurveV2Int.y, JKNightDayFactor);
	EToneMappingOversaturationV2 = lerp(EToneMappingOversatV2Int.x, EToneMappingOversatV2Int.y, JKNightDayFactor);
	EBlacknessV2 = lerp(EBlacknessV2Int.x, EBlacknessV2Int.y, JKNightDayFactor);
	EPostBrightnessV2 = lerp(EPostBrightnessV2Int.x, EPostBrightnessV2Int.y, JKNightDayFactor);
};

	color.xyz*=(EBrightnessV2);
	color.xyz+=EBlacknessV2;
	float3 xncol=normalize(color.xyz);
	float3 scl=color.xyz/xncol.xyz;
	scl=pow(scl, EIntensityContrastV2);
	xncol.xyz=pow(xncol.xyz, EColorSaturationV2);
	color.xyz=scl*xncol.xyz;
	color.xyz*=EPostBrightnessV2;
	float	lumamax=EToneMappingOversaturationV2;
	color.xyz=(color.xyz * (1.0 + color.xyz/lumamax))/(color.xyz + EToneMappingCurveV2);
#endif

#if (POSTPROCESS==3)

	float 	EToneMappingOversaturationV3 = lerp(EToneMapOversatV3Int.x, EToneMapOversatV3Int.y, JKNightDayFactor);
	float 	EToneMappingCurveV3 = lerp(EToneMappingCurveV3Int.x, EToneMappingCurveV3Int.y, JKNightDayFactor);
if ( JKInteriorFactor ) {
	EToneMappingOversaturationV3 = lerp(EToneMapOversatV3Ext.x, EToneMapOversatV3Ext.y, JKNightDayFactor);
	EToneMappingCurveV3 = lerp(EToneMappingCurveV3Ext.x, EToneMappingCurveV3Ext.y, JKNightDayFactor);
};

	float	lumamax=EToneMappingOversaturationV3;
	color.xyz=(color.xyz * (1.0 + color.xyz/lumamax))/(color.xyz + EToneMappingCurveV3);
#endif

#if (POSTPROCESS==4)
	float	EBrightnessCurveV4 = lerp(EBrightnessCurveV4Ext.x, EBrightnessCurveV4Ext.y, JKNightDayFactor);
	float	EBrightnessMultiplierV4 = lerp(EBrightMultiplierV4Ext.x, EBrightMultiplierV4Ext.y, JKNightDayFactor);
	float	EBrightnessToneMappingCurveV4 = lerp(EBrightToneMapCurveV4Ext.x, EBrightToneMapCurveV4Ext.y, JKNightDayFactor);
if ( JKInteriorFactor ) {
	EBrightnessCurveV4 = lerp(EBrightnessCurveV4Int.x, EBrightnessCurveV4Int.y, JKNightDayFactor);
	EBrightnessMultiplierV4 = lerp(EBrightMultiplierV4Int.x, EBrightMultiplierV4Int.y, JKNightDayFactor);
	EBrightnessToneMappingCurveV4 = lerp(EBrightToneMapCurveV4Int.x, EBrightToneMapCurveV4Int.y, JKNightDayFactor);
};

	float Y = dot(color.xyz, float3(0.299, 0.587, 0.114)); //0.299 * R + 0.587 * G + 0.114 * B;
	float U = dot(color.xyz, float3(-0.14713, -0.28886, 0.436)); //-0.14713 * R - 0.28886 * G + 0.436 * B;
	float V = dot(color.xyz, float3(0.615, -0.51499, -0.10001)); //0.615 * R - 0.51499 * G - 0.10001 * B;
	Y=pow(Y, EBrightnessCurveV4);
	Y=Y*EBrightnessMultiplierV4;
	color.xyz=V * float3(1.13983, -0.58060, 0.0) + U * float3(0.0, -0.39465, 2.03211) + Y;

	color.xyz=max(color.xyz, 0.0);
	color.xyz=color.xyz/(color.xyz+EBrightnessToneMappingCurveV4);
#endif

#if (POSTPROCESS==5)

	float	EBrightnessV5 = lerp(EBrightnessV5Ext.x, EBrightnessV5Ext.y, JKNightDayFactor);
	float	EIntensityContrastV5 = lerp(EIntensityContrastV5Ext.x,EIntensityContrastV5Ext.y, JKNightDayFactor);
	float	EColorSaturationV5 = lerp(EColorSaturationV5Ext.x, EColorSaturationV5Ext.y, JKNightDayFactor);
	float	EPostBrightnessV5 = lerp(EPostBrightnessV5Ext.x, EPostBrightnessV5Ext.y, JKNightDayFactor);
	float	EToneMappingCurveV5 = lerp(EToneMappingCurveV5Ext.x, EToneMappingCurveV5Ext.y, JKNightDayFactor);
if ( JKInteriorFactor ) {
	EBrightnessV5 = lerp(EBrightnessV5Int.x, EBrightnessV5Int.y, JKNightDayFactor);
	EIntensityContrastV5 = lerp(EIntensityContrastV5Int.x,EIntensityContrastV5Int.y, JKNightDayFactor);
	EColorSaturationV5 = lerp(EColorSaturationV5Int.x, EColorSaturationV5Int.y, JKNightDayFactor);
	EPostBrightnessV5 = lerp(EPostBrightnessV5Int.x, EPostBrightnessV5Int.y, JKNightDayFactor);
	EToneMappingCurveV5 = lerp(EToneMappingCurveV5Int.x, EToneMappingCurveV5Int.y, JKNightDayFactor);
};

	color.xyz*=EBrightnessV5;
	float3 xncol=normalize(color.xyz);
	float3 scl=color.xyz/xncol.xyz;
	scl=pow(scl, EIntensityContrastV5);
	xncol.xyz=pow(xncol.xyz, EColorSaturationV5);
	color.xyz=scl*xncol.xyz;
	color.xyz*=EPostBrightnessV5;
	color.xyz=color.xyz/(color.xyz + EToneMappingCurveV5);
#endif

#ifdef E_CC_PALETTE

	color.rgb=saturate(color.rgb);
	float3	brightness=Adaptation.xyz; //tex2D(_s4, 0.5); //adaptation luminance
	brightness=(brightness/(brightness+1.0));//new version
	brightness=max(brightness.x, max(brightness.y, brightness.z));//new version

	float3	palette;
	float4	uvsrc=0.0;
	uvsrc.y=brightness.r;
	uvsrc.x=color.r;
	palette.r=tex2Dlod(_s7, uvsrc).r;
	uvsrc.x=color.g;
	uvsrc.y=brightness.g;
	palette.g=tex2Dlod(_s7, uvsrc).g;
	uvsrc.x=color.b;
	uvsrc.y=brightness.b;
	palette.b=tex2Dlod(_s7, uvsrc).b;	

 #if (PALETTE_MIXER==1)
	color.rgb=lerp( color.rgb, palette.rgb, palmix );
 #else
	color.rgb=palette.rgb;
 #endif
#endif

	_oC0.w=1.0;
	_oC0.xyz=color.xyz;
	return _oC0;
}


#if (ENB_FLIPTECHNIQUE==0)	//switch between vanilla and mine post processing
technique Shader_D6EC7DD1
#else
technique Shader_ORIGINALPOSTPROCESS
#endif
{
	pass p0
	{
		VertexShader  = compile vs_3_0 VS_Quad();
		PixelShader  = compile ps_3_0 PS_D6EC7DD1();

		ColorWriteEnable=ALPHA|RED|GREEN|BLUE;
		ZEnable=FALSE;
		ZWriteEnable=FALSE;
		CullMode=NONE;
		AlphaTestEnable=FALSE;
		AlphaBlendEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}

#if (ENB_FLIPTECHNIQUE==0)	//original shader of post processing
technique Shader_ORIGINALPOSTPROCESS
#else
technique Shader_D6EC7DD1
#endif
{
	pass p0
	{
		VertexShader  = compile vs_3_0 VS_Quad();
		PixelShader=
	asm
	{
// Parameters:
//   sampler2D Avg;
//   sampler2D Blend;
//   float4 Cinematic;
//   float4 ColorRange;
//   float4 Fade;
//   sampler2D Image;
//   float4 Param;
//   float4 Tint;
// Registers:
//   Name         Reg   Size
//   ------------ ----- ----
//   ColorRange   c1       1
//   Param        c2       1
//   Cinematic    c3       1
//   Tint         c4       1
//   Fade         c5       1
//   Image        s0       1
//   Blend        s1       1
//   Avg          s2       1
//s0 bloom result
//s1 color
//s2 is average color

    ps_3_0
    def c6, 0, 0, 0, 0
    //was c0 originally
    def c7, 0.212500006, 0.715399981, 0.0720999986, 1
    dcl_texcoord v0.xy
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    rcp r0.x, c2.y
    texld r1, v0, s2
    mul r0.yz, r1.xxyw, c1.y
    rcp r0.w, r0.y
    mul r0.z, r0.w, r0.z
    texld r1, v0, s1
    mul r1.xyz, r1, c1.y
    dp3 r0.w, c7, r1
    mul r1.w, r0.w, r0.z
    mad r0.z, r0.z, r0.w, c7.w
    rcp r0.z, r0.z
    mad r0.x, r1.w, r0.x, c7.w
    mul r0.x, r0.x, r1.w
    mul r0.x, r0.z, r0.x
    cmp r0.x, -r0.w, c6.x, r0.x
    rcp r0.z, r0.w
    mul r0.z, r0.z, r0.x
    add_sat r0.x, -r0.x, c2.x
    texld r2, v0, s0
    mul r2.xyz, r2, c1.y
    mul r2.xyz, r0.x, r2
    mad r1.xyz, r1, r0.z, r2
    dp3 r0.x, r1, c7
    mov r1.w, c7.w
    lrp r2, c3.x, r1, r0.x
    mad r1, r0.x, c4, -r2
    mad r1, c4.w, r1, r2
    mad r1, c3.w, r1, -r0.y
    mad r0, c3.z, r1, r0.y
    add r1, -r0, c5
    mad oC0, c5.w, r1, r0
	};
		ColorWriteEnable=ALPHA|RED|GREEN|BLUE;
		ZEnable=FALSE;
		ZWriteEnable=FALSE;
		CullMode=NONE;
		AlphaTestEnable=FALSE;
		AlphaBlendEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
    }
}