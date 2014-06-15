

/**
 * @author PDXIII
 * @deprecated we use now the package interaction
 *
 */
public class BoundingBox {



	public ArrayList<Point> points;
	public Point center;

	PApplet pa;

	BoundingBox(PApplet _pa) {
		pa = _pa;
		points = new ArrayList<Point>();

	}

	public void display() {
		pa.fill(100,255,255);
		for (int i = 0; i < points.size(); i++) {
			Point point = (Point) points.get(i);
			pa.ellipse(point.getX(), point.getY(),3,3);
		}
	}

	public void addCenter(PVector _cntr){
		center = new Point(_cntr.x, _cntr.y);
	}

	void addPoint(Point point) {
		points.add(point);
	}

	Point getPoint(int index) {
		return (Point) points.get(index);
	}

	public void translate(PVector _v) {
		PVector v = _v;

		for (int i = 0; i < points.size(); i++) {
			Point point = (Point) points.get(i);
			point.translate(v.x, v.y);
		}
	}

	public void rotate(float angle) {
		for (int i = 0; i < points.size(); i++) {
			Point point = (Point) points.get(i);
			point.rotate(angle);
			//center.rotate(angle);
		}
	}

	public int length() {
		return points.size();
	}

	/**
	* Checks whether a point is inside a polygon.
	*/
	boolean contains(float x, float y) {
		boolean inside = false;

		for (int i = 0, j = this.length()-1; i < this.length(); j = i++) {
			Point pi = this.getPoint(i);
			Point pj = this.getPoint(j);
			if ((((pi.getY() <= y) && (y < pj.getY())) ||
					((pj.getY() <= y) && (y < pi.getY()))) &&
					(x < (pj.getX() - pi.getX()) * (y - pi.getY()) / (pj.getY() - pi.getY()) + pi.getX())) {
				inside = !inside;
			}
		}
		return inside;
	}

	/**
	* Checks whether a point is inside a polygon.
	*/
	boolean contains(Point point) {
		return contains(point.x, point.y);
	}
}
