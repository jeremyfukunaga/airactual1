<template>
  <div>
    <canvas ref="canvas"></canvas>
    <main>
        <header>
            <h1><em>ELEVATE YOUR VIEW WITH DRONE & GIS SERVICES</em></h1>
            <p>Welcome to Air Actual. We deliver unmatched aerial imagery and precise geospatial data, empowering you to make informed decisions from a higher perspective.</p>
            <div>
                <a href="" class="button">Learn More</a>
            </div>
        </header>
        <section>
            <h2>Our Services</h2>
        </section>
        <section>
            <h2>Drone Construction Services</h2>
        </section>
        <section>
            <h2>Our Services</h2>
        </section>
    </main>
  </div>
</template>

<script>
import * as THREE from 'three';
// import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls';
import GUI from 'lil-gui';  // Import lil.gui
import '@/assets/css/main.css';

// Import the images
import heightmap1 from '@/assets/heightmap1.png';
import heightmap2 from '@/assets/heightmap2.jpg';

export default {
    mounted() {
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

        const renderer = new THREE.WebGLRenderer();
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setAnimationLoop(animate);
        document.body.appendChild(renderer.domElement);
        
        const geometry = new THREE.SphereGeometry(100, 100, 50);

        const material = new THREE.MeshBasicMaterial({
            color: 0xffffff, // White color
            wireframe: true, // Enable wireframe if you want to see edges
            opacity: 0.1, // Set the opacity to 50%
            transparent: true // Enable transparency for the material
        });

        const sphere = new THREE.Mesh(geometry, material);
        scene.add(sphere);


        // Add OrbitControls
        // const controls = new OrbitControls(camera, renderer.domElement);
        // controls.enableDamping = true;  // Enable smooth movement (damping)
        // controls.dampingFactor = 0.05;  // Damping factor for smoother movements
        // controls.minDistance = 1;       // Minimum zoom distance
        // controls.maxDistance = 500;     // Maximum zoom distance

        camera.position.set( 50, 15, 0); // Move the camera up and back
        camera.lookAt(0, 0, 0); // Make sure the camera is looking at the scene's center

        // Add lighting
        const ambientLight = new THREE.AmbientLight(0xffffff, 0.5); // Soft light
        scene.add(ambientLight);

        const directionalLight = new THREE.DirectionalLight(0xffffff, 10); // Strong directional light
        directionalLight.position.set(10, 10, 10);
        scene.add(directionalLight);

        // Sliders object for lil-gui
        const sliders = {
            widthSeg: 100,
            heightSeg: 100,
            horTexture: 1,
            vertTexture: 1,
            dispScale: 10,
            heightMap: heightmap1,  // Default map
        };

        // Array of available maps (dropdown options)
        const availableMaps = {
            "Map 1": heightmap1,
            "Map 2": heightmap2,
        };

        // Create a GUI
        const gui = new GUI();

        // Move the GUI to the top-right corner
        gui.domElement.style.position = 'absolute';
        gui.domElement.style.top = '100px';   // Adjust the `top` position
        gui.domElement.style.right = '25px';  // Adjust the `right` position

        gui.add(sliders, 'widthSeg', 1, 200).name('Width Segments').onChange(createGround);
        gui.add(sliders, 'heightSeg', 1, 200).name('Height Segments').onChange(createGround);
        gui.add(sliders, 'horTexture', 1, 10).name('Horizontal Texture').onChange(createGround);
        gui.add(sliders, 'vertTexture', 1, 10).name('Vertical Texture').onChange(createGround);
        gui.add(sliders, 'dispScale', 0, 20).name('Displacement Scale').onChange(createGround);

        // Add a dropdown menu for the heightMap selection
        gui.add(sliders, 'heightMap', availableMaps).name('Select Height Map').onChange(createGround);

        let groundMesh;

        function createGround() {
            // If the ground mesh already exists, remove it before creating a new one
            if (groundMesh) {
                scene.remove(groundMesh);
            }

            // PLANE (x, z, width(x) segments, height(z) segments)
            const groundGeo = new THREE.PlaneGeometry(100, 100, sliders.widthSeg, sliders.heightSeg);

            // Use the imported image directly for the displacement map
            const disMap = new THREE.TextureLoader().load(sliders.heightMap);

            // horizontal vertical texture can repeat an object surface
            disMap.wrapS = disMap.wrapT = THREE.RepeatWrapping;
            disMap.repeat.set(sliders.horTexture, sliders.vertTexture); // # horizontal & vertical textures

            const groundMat = new THREE.MeshStandardMaterial({
                color: 0xffffff, // Set a light color to see it properly
                wireframe: true, // Disable wireframe to see the actual surface
                displacementMap: disMap, // affects position of mesh vertices, white = highest, black = lowest
                displacementScale: sliders.dispScale, // how much disMap affects mesh (def = 1)
            });

            groundMesh = new THREE.Mesh(groundGeo, groundMat);
            scene.add(groundMesh);
            groundMesh.rotation.x = -Math.PI / 2;
            groundMesh.position.y = 0.0;
            groundMesh.position.z = 0.0;
        }

        createGround(); // Call the function to create the ground initially


        // Handle window resize
        
        window.addEventListener('resize', () => {
            const width = window.innerWidth;
            const height = window.innerHeight;
            
            camera.aspect = width / height;
            camera.updateProjectionMatrix();
            
            renderer.setSize(width, height);
        });

        function animate() {
            if (groundMesh) {
                groundMesh.rotation.z += 0.001; // Rotate the ground slowly
            }

            sphere.rotation.y += 0.0005;


            // controls.update(); // Update the controls in the animation loop

            renderer.render(scene, camera);

        }

    }
    }
</script>

<style></style>