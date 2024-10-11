<template>
  <div>
    <canvas ref="canvas"></canvas>
    <main>
        <header>
            <h1><em>DRONE CONSTRUCTION SERVICES</em></h1>
            <p>Top-quality imaging and aerial data using advanced drone technology, helping construction companies improve resource management, decision-making, site progress tracking, safety, and cost savings.</p>
            <div>
                <a href="" class="button">Learn More</a>
            </div>
        </header>
        <section class="full-width">
            <h2>Drone Construction Services</h2>
            <table>
                <tbody>
                    <tr>
                        <td style="width: 50%;">
                            <h3>Drones on Your Job Site</h3>
                            <p>
                                We offer top-tier imaging and aerial data collection using advanced drone technology. Our services enable construction companies to optimize resources, make informed decisions, track site progress, and enhance workplace safety. Stay ahead in the industry by leveraging the latest in aerial data collection to save time and money.<br><br>
                            </p>
                        </td>
                        <td style="width: 50%;">
                            <div class="sketchfab-embed-wrapper">
                                <iframe width="100%" height="400" src="https://www.youtube.com/embed/mVCz41y0-7c?si=UHOOz2E7jqF86ag7" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </section>

        <section class="full-width">
            <table>
                <tbody>
                    <tr>
                        <td style="width: 50%;">
                            <h3>Drone 3D Modeling</h3>
                            <p>
                                While traditional flat maps are useful, our 3D modeling technology takes your project’s visualization to the next level. Overlay current progress with initial blueprints or perform volumetric measurements to achieve your goals. Our detailed and accurate site models are tailored to your project’s specific requirements, enhancing planning and execution.<br><br>
                            </p>
                        </td>
                        <td style="width: 50%; vertical-align: top;">
                            <div style="display: flex; flex-direction: column; align-items: center;">
                                <img src="~/assets/litchi_waypoint_mission.png" alt="" style="width: 100%; height: auto; margin-bottom: 20px;" />
                                <div class="sketchfab-embed-wrapper" style="width: 100%;">
                                    <iframe title="Berkeley Commons South" frameborder="0" allowfullscreen mozallowfullscreen="true" webkitallowfullscreen="true" allow="autoplay; fullscreen; xr-spatial-tracking" xr-spatial-tracking execution-while-out-of-viewport execution-while-not-rendered web-share style="width: 100%; height: 260px;" src="https://sketchfab.com/models/79336fac1adf431fb165942740755ec0/embed"></iframe>
                                </div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </section>

        <section class="full-width">
            <table>
                <tbody>
                    <tr>
                        <td style="width: 50%;">
                            <h3>Drone Construction Progression</h3>
                            <p>
                                Regular drone imaging and data capture allow you to track your construction project’s progress over time. Whether weekly or monthly, our services include aerial videos, stills, and data points from consistent locations, helping you monitor timelines and budgets. This visual documentation enhances marketing efforts and demonstrates effective project management.<br><br>
                            </p>
                        </td>
                        <td style="width: 50%; vertical-align: top;">
                            <div style="display: flex; flex-direction: column; align-items: center;">
                                <img src="~/assets/litchi_waypoint_mission.png" alt="" style="width: 100%; height: auto; margin-bottom: 20px;" />
                                <iframe width="100%" height="200" src="https://www.youtube.com/embed/GUqO0v2T4d8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </section>

        <section class="full-width">
            <table>
                <tbody>
                    <tr>
                        <td style="width: 50%;">
                            <h3>Drone Site Modeling</h3>
                            <p>
                                From start to finish, Air Actual’s aerial modeling services offer comprehensive views of your site’s progress and final outcome. Our detailed drone-based data collection serves as a compelling marketing tool and supports project planning. Collaborating with licensed surveyors, we ensure data accuracy and compliance, saving you time and money while enhancing safety.<br><br>
                            </p>
                        </td>
                        <td style="width: 50%;"><iframe width="400" height="400" src="/qgis_webmap/index.html" title="Qgis Webmap"></iframe>
                        </td>
                    </tr>
                </tbody>
            </table>
        </section>

        <section class="full-width">
            <table>
                <tbody>
                    <tr>
                        <td>
                            <h3>Track the Progress of Your Construction Sites</h3>
                            <p>
                                By using georeferenced orthophotos and 3D data, you and your investors can see the exact status of your project. View the current state of your site for real-time updates, improving on-site management and virtual inspections. Use the slider to compare images taken over six months apart, showcasing changes effectively.
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <iframe class="slider" width="100%" src="/before_after_slider/index.html" title="Before/After Slider"></iframe>
                        </td>
                    </tr>
                </tbody>
            </table>
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
        
        const geometry = new THREE.BoxGeometry( 1, 1, 1 );
        const material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );
        const cube = new THREE.Mesh( geometry, material );
        scene.add( cube );
        
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
            
            cube.rotation.x += 0.01;
            cube.rotation.y += 0.01;
            
            renderer.render( scene, camera );
        }

    }
    }
</script>

<style></style>