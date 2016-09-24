//
//  Shaders.metal
//  SwiftMetalTest
//
//  Created by Terje Urnes on 21.09.2016.
//  Followed tutorial by Ray Wenderlich, see README.md
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    packed_float3 position;
    packed_float4 color;
    packed_float2 texCoord;
};

struct VertexOut {
    float4 position [[ position ]];
    float4 color;
    float2 texCoord;
};

struct Light {
    packed_float3 color;
    float ambientIntensity;
};

struct Uniforms {
    float4x4 modelMatrix;
    float4x4 projectionMatrix;
    Light light;
};


vertex VertexOut basic_vertex(
        const device VertexIn* vertex_array [[ buffer(0) ]],
        const device Uniforms& uniforms     [[ buffer(1) ]],
        unsigned int vid [[ vertex_id ]]) {
    
    float4x4 mv_Matrix = uniforms.modelMatrix;
    float4x4 proj_Matrix = uniforms.projectionMatrix;
    
    VertexIn VertexIn = vertex_array[vid];
    VertexOut VertexOut;
    VertexOut.position = proj_Matrix * mv_Matrix * float4(VertexIn.position, 1);
    VertexOut.color = VertexIn.color;
    VertexOut.texCoord = VertexIn.texCoord;
    return VertexOut;
}

fragment float4 basic_fragment(
        VertexOut interpolated [[ stage_in ]],
        const device Uniforms& uniforms [[ buffer(1) ]],
        texture2d<float> tex2D [[ texture(0) ]],
        sampler sampler2D [[ sampler(0) ]]) {
    
    Light light = uniforms.light;
    float4 ambientColor = float4(light.color * light.ambientIntensity, 1.0);
    
    float4 color = interpolated.color * 0.3 + tex2D.sample(sampler2D, interpolated.texCoord) * 0.5;
    return color * ambientColor;
    //return half4(interpolated.color[0], interpolated.color[1], interpolated.color[2], interpolated.color[3]);
}


