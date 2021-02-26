const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );

const renderer = new THREE.WebGLRenderer();
renderer.setSize( window.innerWidth, window.innerHeight );
document.body.appendChild( renderer.domElement );
import { all } from './r.js';
var fs = require('fs');

//code starts here
camera.position.z = 5;
scene1 = fs.readFile("jason.json");

const PORT=8080; 

fs.readFile('./index.html', function (err, html) {

    if (err) throw err;    

    http.createServer(function(request, response) {  
        response.writeHeader(200, {"Content-Type": "text/html"});  
        response.write(html);  
        response.end();  
    }).listen(PORT);
})

//render loop
function animate() {
    requestAnimationFrame(animate);


    renderer.render(scene, camera);
}

animate();