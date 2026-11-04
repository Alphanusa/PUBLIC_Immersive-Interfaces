#version 460
#extension GL_ARB_separate_shader_objects : require
// 460 (not vanilla's 330): interfaces.glsl reads gl_BaseVertex to find the quad corner,
// required since 26.3 shares one GUI vertex buffer between all vertex formats.

#include <minecraft:dynamictransforms.glsl>
#include <minecraft:globals.glsl>
#include <minecraft:projection.glsl>
#include <minecraft:interfaces.glsl>

layout(location = 0) in vec3 Position;
layout(location = 1) in vec2 UV0;
layout(location = 2) in vec4 Color;

layout(location = 0) out vec2 texCoord0;
layout(location = 1) out vec4 vertexColor;

uniform sampler2D Sampler0;

void main() {
    Data data = interfaces(ProjMat, GameTime, Sampler0, Position, UV0);

    texCoord0 = data.uv0;
    vertexColor = Color; // 1.21
    gl_Position = ProjMat * ModelViewMat * vec4(data.position, 1.0);
}
