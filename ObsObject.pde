//package old;
//
//import interaction.TNTuioTransformableObject;
//
//import java.util.ArrayList;
//
//import TUIO.TuioCursor;
//
//import particleSystem.Property;
//import particleSystem.Repeller;
//import processing.core.PApplet;
//import processing.core.PVector;
//import util.Style;
//
//
///**
// * @author fabianmoronzirfas
// * @deprecated
// */
//public class ObsObject extends TNTuioTransformableObject {
//
//	
//	public String name;
//	public float height;
//	public float width;
//	public Property property;
//	public ArrayList <Repeller> internalRepellersList;
////	public PVector loc;
//
//	
//
//	TuioCursor tuioCursor1 = null;
//	TuioCursor tuioCursor2 = null;
//	private int fontSize;
//	
//	
//	float oldAngle;
//	float oldDist;
////
//	public float oldX;
//	public float oldY;
//	public PVector loc = new PVector();
//	
////	public ObsObject(PApplet p, float offsetX,float offsetY,float width,float height){
////		super(p, offsetX, offsetY, width, height);
////	}
//	
//	public ObsObject(PApplet p, float offsetX, float offsetY, float width, float height, Property property) {
//		super(p, offsetX, offsetY, width, height);
//		this.property = property;
//		this.fontSize = p.floor(height);
//
//	}
//	
////	public ObsObject(PApplet p, float offsetX, float offsetY,PVector loc, Property property) {
////		super(p, offsetY, offsetY, width, height); 
//////		this.offsetX= offsetX;
//////		 this.offsetY = offsetY;
////		super.p = p;
////		this.property = property;
////		this.name = property.name;
////		p.textFont(Style.MisoBold72);
////		this.height = 72;
////		this.width =  p.textWidth(this.name);
//////		this.loc = loc;
//		
//		
////	}
//
//
//	
//	private void myRepellers(int x, int y){
//		
//		
//
//		
//		
//	}
//
//	private int calcTheRepellers() {
//		// TODO Auto-generated method stub
//		float myWidth = super.width; 
//		float myHeight = super.height;
//		float myRepNum = myWidth / myHeight;
//		int i = PApplet.floor(myRepNum);
//		
//		return i;
//		
//		
//	}
//	
//	public void internalDraw() {
//		p.fill(color);
//		p.stroke(255, 150);
////		ArrayList <Repeller> internalRepellersList = new ArrayList<Repeller>();
////		int myRepNum = calcTheRepellers();
////		for (int i = 0; i < myRepNum; i++) {
//			
////			Repeller rep = new Repeller(p, new PVector(0+(i*super.height), 0), (p.pow(
////					10, 3)), super.height/2, property);
////			internalRepellersList.add(rep);
////			rep.setColor1(260, 50, 100, 90);
////			rep.display();
//		
////		}
//			
//
//		for (float i = 0; i <= width - 10; i += 10) {
//			for (float j = 0; j <= height - 10; j += 10) {
//				p.rect(i, j, 10, 10);
//			}
//		}
//
//		p.fill(360,50,100,20);
//		p.textFont(Style.MisoBold72);
//		p.rect(0, 0, p.textWidth(property.name), fontSize);
//		p.fill(0);
//		p.textSize(fontSize);
//		p.text(property.name, 0, 0+fontSize);
//		loc.set(0, 0, 0);
////		myRepellers(0,0);
//	}
//	
//	
////	public void internalDraw() {
//////		p.fill(color);
//////		p.stroke(0, 150);
////
//////		for (float i = 0; i <= width - 10; i += 10) {
//////			for (float j = 0; j <= height - 10; j += 10) {
//////				p.rect(i, j, 10, 10);
//////			}
//////		}
////
////		p.fill(Style.textColorWhite);
//////		p.rect(0, 0, 50, 20);
//////		p.fill(0);
////		p.textSize(height);
////		p.text(property.name, loc.x, loc.y);
////	}
//
//	/**
//	 * @return the name
//	 */
//	public synchronized String getName() {
//		return name;
//	}
//
//	/**
//	 * @return the height
//	 */
//	public synchronized float getHeight() {
//		return height;
//	}
//
//	/**
//	 * @return the width
//	 */
//	public synchronized float getWidth() {
//		return width;
//	}
//
//	/**
//	 * @return the property
//	 */
//	public synchronized Property getProperty() {
//		return property;
//	}
//
//	/**
//	 * @param name the name to set
//	 */
//	public synchronized void setName(String name) {
//		this.name = name;
//	}
//
//	/**
//	 * @param height the height to set
//	 */
//	public synchronized void setHeight(float height) {
//		this.height = height;
//	}
//
//	/**
//	 * @param width the width to set
//	 */
//	public synchronized void setWidth(float width) {
//		this.width = width;
//	}
//	
//
//	protected float getDistance(TuioCursor tuioCursor1, TuioCursor tuioCursor2) {
//		return PApplet.dist(tuioCursor1.getScreenX(p.width), tuioCursor1.getScreenY(p.height),
//				tuioCursor2.getScreenX(p.width), tuioCursor2.getScreenY(p.height));
//	}
//
//	protected float getAngleBetween(TuioCursor tuioCursor1, TuioCursor tuioCursor2) {
//		return getAngleBetween(tuioCursor1.getScreenX(p.width), tuioCursor1.getScreenY(p.height),
//				tuioCursor2.getScreenX(p.width), tuioCursor2.getScreenY(p.height));
//	}
//
//	public void addTuioCursor(TuioCursor tuioCursor) {
//		if (tuioCursor1 == null) {
//			tuioCursor1 = tuioCursor;
//
//			oldX = tuioCursor1.getScreenX(p.width);
//			oldY = tuioCursor1.getScreenY(p.height);
//
//		} else if (tuioCursor2 == null) {
//			tuioCursor2 = tuioCursor;
//
//			oldAngle = getAngleBetween(tuioCursor1, tuioCursor2);
//			oldDist = getDistance(tuioCursor1, tuioCursor2);
//		} else {
//			PApplet.println("Already 2 cursors in use for rotation. Omitting further ones.");
//		}
//	}
//
//	public void removeTuioCursor(TuioCursor tuioCursor) {
//		if (tuioCursor2 != null && tuioCursor2.getCursorID() == tuioCursor.getCursorID()) {
//			tuioCursor2 = null;
//		}
//
//		if (tuioCursor1 != null && tuioCursor1.getCursorID() == tuioCursor.getCursorID()) {
//			tuioCursor1 = null;
//			// If second still is on object, switch cursors
//			if (tuioCursor2 != null) {
//				tuioCursor1 = tuioCursor2;
//				tuioCursor2 = null;
//				// Shall not jump after switching, so a "new" oldPos is stored for diff calc.
//				oldX = tuioCursor1.getScreenX(p.width);
//				oldY = tuioCursor1.getScreenY(p.height);
//			}
//		}
//	}
//
//	public void updateTuioCursor(TuioCursor tcur) {
//		if (tuioCursor1 != null && tuioCursor2 != null) {
//			// Two fingers: rotate and scale
//
//			if (tuioCursor2.getCursorID() == tcur.getCursorID()) {
//				centerX = tuioCursor1.getScreenX(p.width) - offsetX;
//				centerY = tuioCursor1.getScreenY(p.height) - offsetY;
//			} else {
//				centerX = tuioCursor2.getScreenX(p.width) - offsetX;
//				centerY = tuioCursor2.getScreenY(p.height) - offsetY;
//			}
//
//			float newAngle = getAngleBetween(tuioCursor1, tuioCursor2);
//			float angle = newAngle - oldAngle;
//			oldAngle = newAngle;
//			rotate(angle);
//
//			float newDist = getDistance(tuioCursor1, tuioCursor2);
//			float newScale = newDist / oldDist;
//			oldDist = newDist;
//			scale(newScale);
//
//		} else if (tuioCursor1 != null) {
//			// One finger: move
//			float x = tuioCursor1.getScreenX(p.width);
//			float y = tuioCursor1.getScreenY(p.height);
//			float dx = x - oldX;
//			float dy = y - oldY;
//
//			addOffset(dx, dy);
//
//			oldX = x;
//			oldY = y;
//		}
//	}
//
//
//}
