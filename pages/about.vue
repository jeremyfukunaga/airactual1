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
    </main>
  </div>
</template>

<script>
import * as THREE from 'three';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader'; // Ensure this import
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls'; // Import OrbitControls
export default {
    mounted() {
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );

        const renderer = new THREE.WebGLRenderer();
        renderer.setSize( window.innerWidth, window.innerHeight );
        renderer.setAnimationLoop( animate );
        document.body.appendChild( renderer.domElement );
        
        camera.position.z = 5;

        const controls = new OrbitControls(camera, renderer.domElement); // Initialize OrbitControls
        controls.enableDamping = true; // Optional: Enable damping (smooth movement)
        controls.dampingFactor = 0.05; // Optional: Damping factor
        controls.enableZoom = true; // Enable zoom functionality

        const loader = new GLTFLoader();
        let gltfModel = null; // Define variable to store the GLTF model


        loader.load(
            '../models/building1/scene.gltf', // Replace with the actual path to your model
            function (gltf) {
                gltfModel = gltf.scene;
                // Set the position of the loaded GLTF model
                gltf.scene.position.set(0, -1, 0); // Example: Set x to 10, y to 0, and z to 0
                // Set the scale of the loaded GLTF model
                gltf.scene.scale.set(0.02, 0.02, 0.02); // Example: Scale x, y, and z by a factor of 2
                scene.add(gltfModel);
            },
            function (xhr) {
                console.log((xhr.loaded / xhr.total * 100) + '% loaded');
            },
            function (error) {
                console.error('An error happened', error);
            }
        );

        // Handle window resize
        
        window.addEventListener('resize', () => {
            const width = window.innerWidth;
            const height = window.innerHeight;
            
            camera.aspect = width / height;
            camera.updateProjectionMatrix();
            
            renderer.setSize(width, height);
        });

        function animate() {
            // Update controls
            controls.update();

            // Animate the rotation of the GLTF model if it's loaded
            if (gltfModel) {
                gltfModel.rotation.y += 0.001; // Rotate the model on the y-axis
            }
            
            renderer.render( scene, camera );
        }

    }
    }
</script>

<style></style>