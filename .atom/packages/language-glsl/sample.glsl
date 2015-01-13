#ifndef HELLO_WORLD
#define HELLO_WORLD vec3(0.0, 0.0, 0.0)
#else
#define LOREM_IPSUM
#endif

#pragma GENERIC_PRAGMA

#pragma glslify: noise = require(glsl-noise)
#pragma glslify: random = require(glsl-random)
#pragma glslify: export(x)

void main() {
  vec3 a = noise(gl_FragColor.xy);
  vec3 b = y.xyz;

  a.xyz = gl_FragColor.xyz;
}
