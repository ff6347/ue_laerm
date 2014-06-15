import TUIO.*;


import java.util.List;


/**
 * This is the main Class of the Multitouch project by the-moron.net<br>
 * represented by fabiantheblind and PDXIII <br>
 * students at the University of Applied Sciences Potsdam (FHP) <br>
 * during the class of Till Nagel "Urbane Ebenen" (urban layers).<br>
 * the {@code code} is available here: <a
 * href="http://code.google.com/p/tmn-ue-learm/" target="blanc">Google Code</a><br>
 * or here: <a href="http://github.com/fabiantheblind/TMN_UE_Laerm.git"
 * target="blanc"> GitHub</a><br>
 *
 * @author PDXIII
 * @author fabianthelbind
 * @version 0.113
 *
 *
 */

	/**
	 *
	 */
	private static final long serialVersionUID = -1217858472488377688L;
	/**
	 * An List of TNObstacleObject
	 *
	 * @see Class TNObstacleObject Class
	 */
	List<TNObstacleObject> transObjects = new ArrayList<TNObstacleObject>();

	/**
	 * controls the amount of TNObstleOjects
	 */
	public int howManyObstacles = 9;

	/**
	 * The Tuio Client
	 */
//	public TuioClient tuioClient = new TuioClient();
TuioProcessing tuioClient;
	/**
	 * a ArrayList of tuio cursors
	 */
	public ArrayList<TuioCursor> tuioCursorList;
	/**
	 * An ArrayList of Particles
	 *
	 * @see Class Particle Class
	 */
	private ArrayList<Particle> ptclsList = new ArrayList<Particle>();

	/**
	 * our particle System
	 *
	 * @see Class ParticleSystem Class
	 */
	public ParticleSystem ps;
	/**
	 * An ArrayList of Paths
	 *
	 * @see Class Path Class
	 */
	public ArrayList<Path> pathsList = new ArrayList<Path>();
	/**
	 * number of particles
	 */
	int numPtcls = 1005;
	/**
	 * An ArrayList of {@link PSUtil#initPropertysList()} for all the Objects
	 *
	 * @see Class Property Class
	 */
	public ArrayList<Property> propertysList;
	/**
	 * standard radius for the particles<br>
	 * every particle can have his own force / radius / speed<br>
	 * they can be changed later<br>
	 * this is for the collision of particles<br>
	 */
	float ptclRadius = 2;
	/**
	 * a boolean for switching the path
	 */
	private boolean switchPath = false;
	/**
	 * the time switches with the color
	 *
	 */
	boolean DAY = true;
	/**
	 * display the debug Stuff if {@code true}
	 */
	boolean showDebug = false;
	/**
	 * display the paths if {@code true}
	 */
	boolean showDebugPath = false;
	private Overlay overlay;
    
         Debug debug;
         PSUtil psutil;
         XMLImporter xmlimporter;
         Style style;
	/*
	 * (non-Javadoc)
	 *
	 * @see processing.core.PApplet#setup()
	 */
	void setup() {
		colorMode(HSB, 360, 100, 100);
		// passing the PApplet thru to all static methods
		// make the Styling
		style = new Style(this);
		style.create();
		// this is for overlays and Stuff
//		debug.setPAppletDebug(this);
                debug = new Debug(this);
		// these are some methods that help with the ParticleSystem
//		PSUtil.setPApplet(this);
                psutil = new PSUtil(this);
		// this is for importing the Property of the objects from an .xml file
                
//		XMLImporter.setPAppelt(this);
                xmlimporter = new XMLImporter(this);
		
                propertysList = psutil.initPropertysList();
                
                println(propertysList);
//		background(0);
		size(displayWidth, displayHeight,OPENGL);

		// init TUIO
//		tuioClient.addTuioListener(this);
//		tuioClient.connect();
                tuioClient  = new TuioProcessing(this);

		// making ObstacleObjects
		Property property;
		for (int i = 0; i < howManyObstacles; i++) {
			property = propertysList.get(i);
			transObjects.add(new TNObstacleObject(this, 50 * i, 50 * i, 0, 0,property));
		}

		// end PDXIII TUIO Stuff

		// particle stuff

		psutil.makeSpaces(pathsList);
		// We are now making random Particles and storing them in an ArrayList ptclsList
		ptclsList = psutil.initParticles(numPtcls, ptclRadius, ptclsList);

		// add the Path ptclPoints ArrayList of Particles to the ptclsList


		for(Path path : pathsList){

			for(Particle ptcl :path.getPtclPoints() ){
				ptclsList.add(ptcl);

			}
		}

		// we need the particle system to interact with the TNObstacleObject
		ps = new ParticleSystem(this, new PVector(width / 2, height / 2),ptclsList);


		overlay = new Overlay(this);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see processing.core.PApplet#draw()
	 */
	public void draw() {
		smooth();

		DAY = style.switchTime(DAY);
		switchPath = style.switchPath(DAY,switchPath);
		style.theBackground();
//		overlay.display();
		// this is for the particles that make the paths
		// to get them back into their original position we have to reset them
		// in the function Path.resetPointPtcls() you can set
		// how fast and strong the want to get back
		psutil.resetPath( pathsList);
		// this is for switching every 300 frames the path to follow
		psutil.applyPaths(ptclsList, switchPath, pathsList);

		for (TNObstacleObject transformableObject : transObjects) {
			transformableObject.draw();
		}
		// pass all Objects over to the ParticleSystem
		ps.applyObstcles(transObjects, DAY);
		// Run the Particle System
		ps.run();


		// PDXIII TUIO Stuff
		tuioCursorList = new ArrayList<TuioCursor>(tuioClient.getTuioCursors());
		// //end PDXIII TUIO Stuff

		// DEBUGGING START press "d"
		if (showDebug) {
			debug.watchAParticle(ptclsList, ps);
//			Debug.watchARepellers(someRepellers);
//			PSUtil.displaySomeRepellers(someRepellers);

			if (showDebugPath) {
				debug.displayAllPaths(pathsList);
			}
			debug.drawFrameRate();
			debug.drawFrameCount();
		}
		// //just for adjustment
		// debug.drawGrid();
		debug.drawCursors(tuioCursorList);
		// Debug.drawCursorCount(tuioCursorList);
		debug.writeIMGs();
		// DEBUGGING END
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see TUIO.TuioListener#addTuioCursor(TUIO.TuioCursor)
	 */

	
	public void addTuioCursor(TuioCursor tcur) {
		// Hit test for all objects: first gets the hit, ordered by creation.
		// TODO Order by z-index, updated by last activation/usage
		for (TNObstacleObject ttObj : transObjects) {
			if (ttObj.isHit(tcur.getScreenX(width), tcur.getScreenY(height))) {
				ttObj.addTuioCursor(tcur);
				break;
			}
		}
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see TUIO.TuioListener#updateTuioCursor(TUIO.TuioCursor)
	 */

	
	public void updateTuioCursor(TuioCursor tcur) {
		for (TNObstacleObject ttObj : transObjects) {
			if (ttObj.isHit(tcur.getScreenX(width), tcur.getScreenY(height))) {
				ttObj.updateTuioCursor(tcur);

				break;
			}
		}
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see TUIO.TuioListener#removeTuioCursor(TUIO.TuioCursor)
	 */

	
	public void removeTuioCursor(TuioCursor tcur) {
		for (TNObstacleObject ttObj : transObjects) {
			// Pass trough remove-event to all objects, to allow fingerUp also
			// out of boundaries,
			// as objects decide themselves (via cursor-id) whether cursor
			// belongs to it.

			ttObj.removeTuioCursor(tcur);
		}
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see TUIO.TuioListener#addTuioObject(TUIO.TuioObject)
	 */

	public void addTuioObject(TuioObject arg0) {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see TUIO.TuioListener#refresh(TUIO.TuioTime)
	 */
	
	public void refresh(TuioTime arg0) {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see TUIO.TuioListener#removeTuioObject(TUIO.TuioObject)
	 */
	
	public void removeTuioObject(TuioObject arg0) {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see TUIO.TuioListener#updateTuioObject(TUIO.TuioObject)
	 */
	
	public void updateTuioObject(TuioObject arg0) {
		// TODO Auto-generated method stub

	}

	// TUIO methods end

	/*
	 * (non-Javadoc)
	 *
	 * @see processing.core.PApplet#keyPressed()
	 */
	public void keyPressed() {
		if (key == 'd') {
			// do something fancy
			if (showDebug == true) {
				showDebug = false;

			} else {
				showDebug = true;

			}
		}
		if (key == 'p') {
			// do something fancy
			if (showDebugPath == true) {
				showDebugPath = false;

			} else {
				showDebugPath = true;

			}
		}

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see processing.core.PApplet#keyReleased()
	 *
	 * @see Debug#saveFrame(float)
	 */
	public void keyReleased() {

		// not important for the main programm
		if (key == 's' || key == 'S') {

			// just for unique filenames when saving a frame as .jpg in the
			// folder data
			float time;
			time = millis();
			debug.saveFrame(time);
			println("wrote \"MyImg" + time + ".jpg\" to the folder bilder");

		}
		if (key == 'e' || key == 'E') {
			exit();
		}
		if (key == 'i' || key == 'I') {
			debug.writeImg = true;
		}
		if (key == 'o' || key == 'O') {
			debug.writeImg = false;
		}

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see processing.core.PApplet#mousePressed()
	 */
	public void mousePressed() {
//		// PSUtil.newPtkl(this, mouseX, mouseY, ptclsList, ptclRadius);
//
//		for (int i = 0; i < someRepellers.size(); i++) {
//			Repeller r = someRepellers.get(i);
//			r.clicked(mouseX, mouseY);
//		}
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see processing.core.PApplet#mouseReleased()
	 */
	public void mouseReleased() {
//
//		for (int i = 0; i < someRepellers.size(); i++) {
//			Repeller r = someRepellers.get(i);
//			r.stopDragging();
//		}
	}


