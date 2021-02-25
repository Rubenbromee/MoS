const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );

const renderer = new THREE.WebGLRenderer();
renderer.setSize( window.innerWidth, window.innerHeight );
document.body.appendChild( renderer.domElement );

//code starts here
camera.position.z = 5;

//render loop
function animate() {
    requestAnimationFrame(animate);


    renderer.render(scene, camera);
}

animate();