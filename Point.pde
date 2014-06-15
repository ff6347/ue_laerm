

/**
 * @author PDXIII
 * @deprecated we use now the package interaction
 */
public class Point extends PVector {

	public float tx;
	public float ty;

	public Point(float x, float y) {
		super(x, y);
	}

	public void translate(float tx, float ty) {
		this.tx += tx;
		this.ty += ty;
	}

	public void rotate(float theta) {

		float xr = PApplet.cos(theta) * x - PApplet.sin(theta) * y;
		float yr = PApplet.sin(theta) * x + PApplet.cos(theta) * y;

		x = xr;
		y = yr;
	}

	public float getX() {
		return x + tx;
	}

	public float getY() {
		return y + ty;
	}

}


