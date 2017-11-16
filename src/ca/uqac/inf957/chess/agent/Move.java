package ca.uqac.inf957.chess.agent;

public class Move {
    public int xI, xF, yI, yF;

    public Move(int x0, int y0, int x1, int y1) {
	this.xI = x0;
	this.xF = x1;
	this.yI = y0;
	this.yF = y1;
    }

    public String toString() {
	return (char) ('a' + xI) + "" + yI + (char) ('a' + xF) + "" + yF;
    }

	public int getxI() {
		return xI;
	}

	public void setxI(int xI) {
		this.xI = xI;
	}

	public int getxF() {
		return xF;
	}

	public void setxF(int xF) {
		this.xF = xF;
	}

	public int getyI() {
		return yI;
	}

	public void setyI(int yI) {
		this.yI = yI;
	}

	public int getyF() {
		return yF;
	}

	public void setyF(int yF) {
		this.yF = yF;
	}
}
