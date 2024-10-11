<template>
  <div>
    <canvas ref="canvas"></canvas>
    <main>
        <header>
            <h1><em>CONTACT US</em></h1>
            <p>Reach out by phone, text, or email. Air Actual is standing by to help you with service inquiries, customer service, or just general questions.</p>
        </header>
        <section class="two-column">
            <div class="column">
                <h3>Call us</h3>
                    <p>7 a.m.–5 p.m. (PT), Monday–Friday<br>
                        <a href="tel:+19252898382">+1-925-289-8382</a>
                    </p>
            </div>
            <div class="column">
                <h3>Email us</h3>
                    <p>Inquiries by email<br>
                        <a href="mailto:jeremy@airactual.com?subject=Inquiry">jeremy@airactual.com</a>
                    </p>
            </div>
        </section>
    </main>
  </div>
</template>

<script>
import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls';

export default {
    mounted() {
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );

        const renderer = new THREE.WebGLRenderer();
        renderer.setSize( window.innerWidth, window.innerHeight );
        renderer.setAnimationLoop( animate );
        document.body.appendChild( renderer.domElement );
        
        const geometry = new THREE.SphereGeometry( 1, 30, 30 );
        const material = new THREE.MeshBasicMaterial( { color: 0x000000 } );
        const cube = new THREE.Mesh( geometry, material );
        scene.add( cube );

        // Add edges geometry with white line material
        const edges = new THREE.EdgesGeometry( geometry );
        const edgesMaterial = new THREE.LineBasicMaterial( { color: 0xffffff } ); // White edges
        const lineSegments = new THREE.LineSegments( edges, edgesMaterial );
        scene.add( lineSegments );
        
        camera.position.z = 5;

        // Handle window resize
        
        window.addEventListener('resize', () => {
            const width = window.innerWidth;
            const height = window.innerHeight;
            
            camera.aspect = width / height;
            camera.updateProjectionMatrix();
            
            renderer.setSize(width, height);
        });

        function animate() {
            
            cube.rotation.x += 0.001;
            cube.rotation.y += 0.001;
            lineSegments.rotation.x += 0.001;
            lineSegments.rotation.y += 0.001;
            
            renderer.render( scene, camera );
        }

    }
    }
</script>

<style></style>