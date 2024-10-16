//
// Adds a surrounding, glowing effect around the sphere by sampling Perlin 
// noise from a cube map, simulating an atmosphere or halo effect.
//

uniform float time;
varying vec2 vUv;
varying vec3 vPosition;
uniform vec2 pixels;
float PI = 3.141592653589793238;

varying vec3 vLayer0;
varying vec3 vLayer1;
varying vec3 vLayer2;
varying vec3 eyeVector;
varying vec3 vNormal;

mat2 rotate(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c);
}

// float Fresnel(vec3 eyeVector, vec3 worldNormal) {
//     return pow( 1.0 + dot( eyeVector, worldNormal), 3.0 );
// }

void main() {
    vNormal = normal;

    vec4 worldPosition = modelMatrix * vec4(position, 1.0);
    eyeVector = normalize(worldPosition.xyz - cameraPosition);

    float t = time * 0.002;

    mat2 rot = rotate(t);

    vec3 p0 = position;
    p0.yz = rot * p0.yz;
    vLayer0 = p0;

    mat2 rot1 = rotate(t + 10.);
    vec3 p1 = position;
    p1.xz = rot1 * p1.xz;
    vLayer1 = p1;

    mat2 rot2 = rotate(t + 30.);
    vec3 p2 = position;
    p2.xy = rot2 * p2.xy;
    vLayer2 = p2;

    vUv = uv;
    vPosition = position;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}