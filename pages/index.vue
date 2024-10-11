<template>
  <div>
    <canvas ref="canvas"></canvas>
    <main>
        <header>
            <h1 class="text-red text-4xl mb-38 font-exo leading-none"><em>ELEVATE YOUR VIEW WITH DRONE & GIS SERVICES</em></h1>
            <p>Welcome to Air Actual. Delivering unmatched aerial imagery and precise geospatial data, empowering you to make informed decisions from a higher perspective.</p>
            <div>
                <a href="" class="button">Learn More</a>
            </div>
        </header>
        <section>
            <h2>Services</h2><br>
            <h3>📸 Aerial Photography & Videography</h3>
            <p>
                Capture breathtaking aerial views with high-resolution images and 4K video. Whether it's for real estate, events, or promotional content, our drone services provide a unique vantage point that sets your visuals apart.<br><br>
            </p>

            <h3>🌐 360-Degree Panoramas</h3>
            <p>
                Immerse your audience in a complete visual experience with our 360-degree panoramic photography. Perfect for virtual tours, property showcases, and more, these immersive images bring your space to life.<br><br>
            </p>

            <h3>🗺️ Photogrammetry & Mapping</h3>
            <p>
                Transform aerial images into detailed 2D maps and 3D models with our photogrammetry services. Ideal for construction, land surveying, and environmental monitoring, our precision mapping helps you see the big picture in incredible detail.<br><br>
            </p>
            
            <h3>🌍 GIS Integration</h3>
            <p>
                Leverage the power of GIS to analyze and visualize geospatial data. Our GIS services offer comprehensive solutions for urban planning, environmental management, and infrastructure development. We turn complex data into actionable insights.<br><br>
            </p>
            
            <h3>🛠️ Inspections & Surveys</h3>
            <p>
                Conduct safe and efficient inspections of hard-to-reach areas. Our drone inspections are perfect for infrastructure, agriculture, and environmental monitoring, providing you with real-time data and high-quality imagery.<br><br>
            </p>
            
            <h3>🏗️ Construction Services</h3>
            <p>
                Track your construction project's progress with regular drone imaging. Our weekly or monthly services provide aerial videos, stills, and data, helping you monitor timelines and budgets while enhancing marketing and showcasing project management.<br><br>
            </p>

        </section>

      <blockquote>
        <p>Thanks for watching!</p>
      </blockquote>

    </main>
  </div>
</template>

<script>
import * as THREE from 'three';
// import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls';
// import { EffectComposer } from 'three/examples/jsm/postprocessing/EffectComposer';
// import { RenderPass } from 'three/examples/jsm/postprocessing/RenderPass';
// import { UnrealBloomPass } from 'three/examples/jsm/postprocessing/UnrealBloomPass';


import { getFresnelMat } from "~/assets/getFresnelMat.js";

// import jeremyImg from "~/assets/jeremy.png";
import earthbumpImg from "~/assets/earthbump.jpg";
import earthcloudmapImg from "~/assets/earthcloudmap.jpg";
import earthhirescloudsImg from "~/assets/earthhiresclouds.jpg";
import earthlightsImg from "~/assets/earthlights.jpg";
import earthmapImg from "~/assets/earthmap.jpg";
import earthspecImg from "~/assets/earthspec.jpg";
import moonbumpImg from "~/assets/moonbump.jpg";
import moonmapImg from "~/assets/moonmap.jpg";
import fragment from "~/assets/js/shaders/fragment.glsl";
import fragmentSun from "~/assets/js/shadersSun/fragment.glsl";
import fragmentAround from "~/assets/js/shadersAround/fragment.glsl";
import vertex from "~/assets/js/shaders/vertex.glsl";
import vertexSun from "~/assets/js/shadersSun/vertex.glsl";
import vertexAround from "~/assets/js/shadersAround/vertex.glsl";
import atmosphereVertexShader from "~/assets/js/shadersAtmosphere/atmosphereVertex.glsl";
import atmosphereFragmentShader from "~/assets/js/shadersAtmosphere/atmosphereFragment.glsl";

export default {
    mounted() {
        const scene = new THREE.Scene();
        const scene1 = new THREE.Scene(); // Second scene for reflection capture
        const camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );

        const renderer = new THREE.WebGLRenderer({ antialias: true });
        renderer.setSize( window.innerWidth, window.innerHeight );
        renderer.setAnimationLoop( animate );
        renderer.outputColorSpace = THREE.LinearSRGBColorSpace;
        document.body.appendChild( renderer.domElement );

        // // Initialize the render target and effect composer
        // const composer = new EffectComposer(renderer);
        
        // // Add the render pass (which renders the scene)
        // const renderPass = new RenderPass(scene, camera);
        // composer.addPass(renderPass);

        // // Add the Unreal Bloom pass
        // const bloomPass = new UnrealBloomPass(
        //     new THREE.Vector2(window.innerWidth, window.innerHeight),
        //     1.5,  // Strength of bloom
        //     0.4,  // Radius
        //     0.85  // Threshold
        // );
        // composer.addPass(bloomPass);
        
        camera.position.z = 5;

        // Earth

        const earthGroup = new THREE.Group();
        earthGroup.rotation.z = -23.4 * Math.PI / 180;
        scene.add(earthGroup);
        
        // new OrbitControls(camera, renderer.domElement);

        const detail = 12;
        const loader = new THREE.TextureLoader();
        const geometry = new THREE.IcosahedronGeometry(1, detail);
        const material = new THREE.MeshPhongMaterial({
            map: loader.load(earthmapImg),
            specularMap: loader.load(earthspecImg),
            bumpMap: loader.load(earthbumpImg),
            bumpScale: 0.04,
        });
        // material.map.colorSpace = THREE.SRGBColorSpace;
        const earthMesh = new THREE.Mesh(geometry, material);
        earthGroup.add(earthMesh);
        
        const lightsMat = new THREE.MeshBasicMaterial({
            map: loader.load(earthlightsImg),
            blending: THREE.AdditiveBlending,
        });
        const lightsMesh = new THREE.Mesh(geometry, lightsMat);
        earthGroup.add(lightsMesh);
        
        const cloudsMat = new THREE.MeshStandardMaterial({
            map: loader.load(earthcloudmapImg),
            transparent: true,
            opacity: 0.8,
            blending: THREE.AdditiveBlending,
            alphaMap: loader.load(earthhirescloudsImg),
            alphaTest: 0.1,
        });
            
        const cloudsMesh = new THREE.Mesh(geometry, cloudsMat);
        cloudsMesh.scale.setScalar(1.003);
        earthGroup.add(cloudsMesh);
            
        const fresnelMat = getFresnelMat();
        const glowMesh = new THREE.Mesh(geometry, fresnelMat);
        glowMesh.scale.setScalar(1.01);
        earthGroup.add(glowMesh);


        // Moon
        
        const moonTexture = new THREE.TextureLoader().load(moonmapImg);
        moonTexture.colorSpace = THREE.SRGBColorSpace; // Added SRGBColorspace
        const bumpTexture = new THREE.TextureLoader().load(moonbumpImg);
        bumpTexture.colorSpace = THREE.SRGBColorSpace; // Added SRGBColorspace
        
        const moon = new THREE.Mesh(
            new THREE.SphereGeometry(1, 32, 32),
            new THREE.MeshStandardMaterial({
                map: moonTexture,
                bumpMap: bumpTexture,
            })
        );
        
        // Tilt the moon by adjusting its rotation
        moon.rotation.z = -6.7 * Math.PI / 180;
        
        scene.add(moon);


        // Sun

        // Create a group for the sun and its related elements
        const sunGroup = new THREE.Group();
        
        // Cube camera for reflective material
        const cubeRenderTarget = new THREE.WebGLCubeRenderTarget(256, {
        format: THREE.RGBFormat,
        generateMipmaps: true,
        minFilter: THREE.LinearMipMapLinearFilter,
        encoding: THREE.sRGBEncoding,
        });
        const cubeCamera = new THREE.CubeCamera(0.1, 10, cubeRenderTarget);

        // Material for the sun (inner sphere)
        const materialSun = new THREE.ShaderMaterial({
        vertexShader: vertexSun,
        fragmentShader: fragmentSun,
        uniforms: {
            time: { value: 0 },
            uPerlin: { value: null },
            resolution: { value: new THREE.Vector4() },
        },
        side: THREE.DoubleSide,
        });

        // Sphere geometry
        const geometrySun = new THREE.SphereGeometry(1.5, 30, 30);

        // Mesh for the sun and surrounding effect
        const sun = new THREE.Mesh(geometrySun, materialSun);

        // Add the meshes to the scene
        sunGroup.add(sun);

        // Create an atmosphere mesh with a custom shader material
        const atmosphere = new THREE.Mesh(
        new THREE.SphereGeometry(1.8, 30, 30),
        new THREE.ShaderMaterial({
            vertexShader: atmosphereVertexShader,
            fragmentShader: atmosphereFragmentShader,
            blending: THREE.AdditiveBlending,
            side: THREE.BackSide
        })
        )

        // Scale the atmosphere slightly larger than the globe
        atmosphere.scale.set(1.1, 1.1, 1.1)

        // Add the atmosphere to the scene
        sunGroup.add(atmosphere)

        // Sphere for perlin noise (reflection capture)
        const materialPerlin = new THREE.ShaderMaterial({
        vertexShader: vertex,
        fragmentShader: fragment,
        uniforms: {
            time: { value: 0 },
            resolution: { value: new THREE.Vector4() },
        },
        side: THREE.DoubleSide,
        });
        const perlinSphere = new THREE.Mesh(geometry, materialPerlin);
        scene1.add(perlinSphere);

        // Add the sunGroup to the scene
        scene.add(sunGroup);

        let time = 0;

        //Earth and Moon positions

        earthGroup.position.z = -4;
        earthGroup.position.x = 1.5;
        earthGroup.position.y = 0.5;
        
        moon.position.z = 5;
        moon.position.setX(-2);
        moon.position.setY(1);

        sunGroup.position.set(-1.3, 0, 15);  // Adjust this position as needed

        // Sun
        
        const sunLight = new THREE.DirectionalLight(0xffffff, 2.0);
        sunLight.position.set(-2, 0.5, 1.5);
            
        scene.add(sunLight);

        // Create a spotlight near the moon
        const moonSpotLight = new THREE.SpotLight(0xffffff, 50); // Adjust the intensity
        moonSpotLight.position.set(-10, 5, 10); // Position the spotlight close to the moon
        moonSpotLight.target = moon; // Focus the spotlight on the moon
        moonSpotLight.angle = Math.PI / 20; // Control the spread of the light
        moonSpotLight.penumbra = 0;
		moonSpotLight.decay = 0.0;
		moonSpotLight.distance = 11;
        moonSpotLight.focus = 1;

        scene.add(moonSpotLight);


        // Create a spotlight helper
        const spotLightHelper = new THREE.SpotLightHelper(moonSpotLight);

        // Add the helper to the scene
        scene.add(spotLightHelper);


        
        // Create geometry and material for stars

        const starGeometry = new THREE.BufferGeometry();
        const starMaterial = new THREE.PointsMaterial({
            color: 0xffffff,
            size: 1.5, // Adjust size as needed
        });
        
        // Function to generate random points inside a sphere

        function randomSpherePoint(radius = 1000) {
            const theta = 2 * Math.PI * Math.random();
            const phi = Math.acos(2 * Math.random() - 1);
            const r = radius * Math.cbrt(Math.random()); // Cubic root for uniform distribution
            
            const x = r * Math.sin(phi) * Math.cos(theta);
            const y = r * Math.sin(phi) * Math.sin(theta);
            const z = r * Math.cos(phi);
            
            return new THREE.Vector3(x, y, z);
        }
        
        // Generate star vertices

        const starVertices = [];
        const numStars = 10000;
        const sphereRadius = 2000; // Radius of the sphere
        
        for (let i = 0; i < numStars; i++) {
            const starPosition = randomSpherePoint(sphereRadius);
            starVertices.push(starPosition.x, starPosition.y, starPosition.z);
        }
        
        // Set geometry attributes

        starGeometry.setAttribute(
            'position',
            new THREE.Float32BufferAttribute(starVertices, 3)
        );
        
        // Create Points object and add to scene

        const stars = new THREE.Points(starGeometry, starMaterial);
        scene.add(stars);

        // Handle window resize
        
        window.addEventListener('resize', () => {
            const width = window.innerWidth;
            const height = window.innerHeight;
            
            camera.aspect = width / height;
            camera.updateProjectionMatrix();
            
            renderer.setSize(width, height);
        });
        
        // Scroll Animation
        
        function moveCamera() {
            const t = document.body.getBoundingClientRect().top;
            
            // moon.rotation.x += 0.05;
            // moon.rotation.y += 0.075;
            // moon.rotation.z += 0.05;
            
            camera.position.z = t * -0.01;
            camera.position.x = t * -0.0002;
            camera.rotation.y = t * -0.0002;
        }
        
        document.body.onscroll = moveCamera;
        moveCamera();

        function animate() {
            // requestAnimationFrame(animate);
            
            earthMesh.rotation.y += 0.001;
            lightsMesh.rotation.y += 0.001;
            cloudsMesh.rotation.y += 0.0012;
            glowMesh.rotation.y += 0.001;
            stars.rotation.y -= 0.0001;
            moon.rotation.y += 0.001;

            time += 0.05;
            materialSun.uniforms.time.value = time;
            materialPerlin.uniforms.time.value = time;

            // Update cube camera to capture the reflection texture
            cubeCamera.update(renderer, scene1);
            materialSun.uniforms.uPerlin.value = cubeRenderTarget.texture;
            
            // jeremy.rotation.x += 0.01;
            // jeremy.rotation.y += 0.01;
            
            renderer.render( scene, camera );
            // composer.render(); // Use composer.render() instead of renderer.render()

        }
        
        // animate();
    }
    }
</script>

<style></style>