import ca.uqac.inf957.chess.agent.*;
import ca.uqac.inf957.chess.piece.*;
import ca.uqac.inf957.chess.*;

public aspect pieceMove {
	
   pointcut PlayerMakeMove(Player p, Move mv) : 
 		target(p)
 		&& execution(boolean Player.move(Move))
 && args(mv);
   
   
     pointcut KingMove(King p, Move mv) : 
 		target(p) 
 		&& execution( boolean King.isMoveLegal(Move))
        && args(mv); 

 	pointcut QueenMove(Queen q, Move mv) : 
 		target(q) 
 		&& execution( boolean Queen.isMoveLegal(Move))
 		&& args(mv); 
 	
 	pointcut KnightMove(Knight k, Move mv) : 
 		target(k) 
 		&& execution( boolean Knight.isMoveLegal(Move))
 		&& args(mv); 
 	
 	pointcut PawnMove(Pawn p, Move mv) : 
 		target(p) 
 		&& execution( boolean Pawn.isMoveLegal(Move))
 		&& args(mv); 
 	
 	pointcut BishopMove(Bishop b, Move mv) : 
 		target(b) 
 		&& execution( boolean Bishop.isMoveLegal(Move))
 		&& args(mv); 
 	
 	pointcut RookMove(Rook r, Move mv) : 
 		target(r) 
 		&& execution( boolean Rook.isMoveLegal(Move))
 && args(mv); 
  
     
 	
 	boolean around(Player p, Move mv) : PlayerMakeMove(p,mv){
 		if((mv.xI >= Board.SIZE || mv.xI < 0) || (mv.yI >= Board.SIZE || mv.yI < 0))
 		{
 			System.out.println("Déplacement impossible");
 			return false;
 		} 		
 		if(p.getPlayGround().getGrid()[mv.xI][mv.yI].isOccupied())
 		{
 			if(p.getPlayGround().getGrid()[mv.xI][mv.yI].getPiece().getPlayer()==p.getColor())
 			{	
 						if(p.getPlayGround().getGrid()[mv.xI][mv.yI].getPiece().isMoveLegal(mv))
 						{ 													
 							if(p.getPlayGround().getGrid()[mv.xI][mv.yI].getPiece().isPlacable(p, mv))
 							{
 								p.getPlayGround().movePiece(mv);					
 								return true;
 							}
 						} 						
 			}			
 		}		
 		System.out.println("Déplacement impossible");
 		return false;
 }
 	
 	boolean around(Pawn p, Move mv) : PawnMove(p,mv){
 		if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0))
			return false;	
		int movX=mv.xF-mv.xI;
		int movY=mv.yF-mv.yI;	
		if((movX==0) || (movX==1) || (movX==-1)) {	
			if(p.getPlayer()==Player.BLACK) 
			{		
				if(movY == -1)
				{
					return true;
				}		
			}else if (p.getPlayer()==Player.WHITE)			
			{
				if(movY == 1)
				{
					return true;
				}				
			}
		}
		return false;
 	}
 	
boolean around(King p, Move mv) : KingMove(p,mv){
	if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0)) return false;
	boolean mvLigneDroite = (Math.abs(mv.getxF() - mv.getxI()) == 1 && Math.abs(mv.getyF() - mv.getyI()) == 0) || (Math.abs(mv.getxF() - mv.getxI()) == 0 && Math.abs(mv.getyF() - mv.getyI()) == 1);
	boolean mvDiagonal = Math.abs(mv.getxF() - mv.getxI()) == 1 && Math.abs(mv.getyF() - mv.getyI()) == 1;
	
	if( mvLigneDroite )return true;
	if(mvDiagonal) return true;
	return false;
}


boolean around(Queen q, Move mv)	: QueenMove(q,mv)
{
	if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0)) return false;
	
	int movX=Math.abs(mv.xF-mv.xI);
	int movY=Math.abs(mv.yF-mv.yI);		
	
	if ((movX!=0 && movY==0) || (movX==0 && movY!=0)) return true;
	
	if(movY!=0) return (movX/movY)==1;  
	return false;
	
}

boolean around(Knight p, Move mv) : KnightMove(p,mv){
		
		if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0)) return false;
			
		
		int movX=Math.abs(mv.xF-mv.xI);
		int movY=Math.abs(mv.yF-mv.yI);	
		
		
		if((movX == 2 && movY == 1) || (movX == 1 && movY == 2)) return true;
		
		return false;
}

boolean around(Bishop b, Move mv)	: BishopMove(b, mv){
if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0))
		return false;

	int movX=Math.abs(mv.xF-mv.xI);
	int movY=Math.abs(mv.yF-mv.yI);		
	
	if ((movX!=0 && movY!=0)) return (movX/movY)==1;
	
	return false;

}	

boolean around(Rook r, Move mv)	: RookMove(r, mv){
if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0)) return false;
	
	
	int movX=Math.abs(mv.xF-mv.xI);
	int movY=Math.abs(mv.yF-mv.yI);		
	
	if ((movX!=0 && movY==0) || (movX==0 && movY!=0)) return true;
		
	return false;
	
} 
 	
public abstract boolean Piece.isPlacable(Player p, Move mv);


public boolean Queen.isPlacable(Player p,Move mv){
	
	if(p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied())
	{
		if(p.getPlayGround().getGrid()[mv.xF][mv.yF].getPiece().getPlayer() == this.getPlayer())
		{
			return false;			
		}	
	}
	

	if((mv.xF-mv.xI)==0 || (mv.yF-mv.yI)==0)
	{
		if(mv.xF > mv.xI) {			
			for(int i = mv.xI+1;i<mv.xF;i++) {				
				if(p.getPlayGround().getGrid()[i][mv.yF].isOccupied()) {					
					return false;					
				}				
			}
		}
		
		if(mv.xF < mv.xI) {			
			for(int i = mv.xI-1;i>mv.xF;i--) {				
				if(p.getPlayGround().getGrid()[i][mv.yF].isOccupied()) {					
					return false;					
				}				
			}
		}
		
		if(mv.yF > mv.yI) {
			for(int i = mv.yI+1;i<mv.yF;i++) {			
				if(p.getPlayGround().getGrid()[mv.xF][i].isOccupied()) {					
					return false;					
				}			
			}
		}
		
		if(mv.yF < mv.yI) {			
			for(int i = mv.yI-1;i>mv.yF;i--) {			
				if(p.getPlayGround().getGrid()[mv.xF][i].isOccupied()) {					
					return false;					
				}				
			}
		}
		return true;
		
	}else
	{
		if(mv.xF > mv.xI && mv.yF > mv.yI) {		
			for(int i = mv.xI+1,j = mv.yI+1;i<mv.xF;i++, j++) {				
				if(p.getPlayGround().getGrid()[i][j].isOccupied()) {					
					return false;					
				}				
			}
		}
		
		if(mv.xF < mv.xI && mv.yF > mv.yI) {			
			for(int i = mv.xI-1,j=mv.yF+1;i>mv.xF;i--,j++) {		
				if(p.getPlayGround().getGrid()[i][j].isOccupied()) {
					return false;					
				}				
			}
		}
		
		if(mv.xF > mv.xI && mv.yF < mv.yI) {			
			for(int i = mv.yI+1,j=mv.yI-1;i<mv.xF;i++,j--) {				
				if(p.getPlayGround().getGrid()[i][j].isOccupied()) {					
					return false;					
				}				
			}
		}
		
		if(mv.xF < mv.xI && mv.yF < mv.yI) {
			for(int i = mv.xI-1,j=mv.yI-1;i>mv.xF;i--,j--) {				
				if(p.getPlayGround().getGrid()[i][j].isOccupied()) {					
					return false;					
				}				
			}
		}
		return true;		
}
}


public boolean King.isPlacable(Player p,Move mv){

	if(!p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied())
	{
		return true;
	}else if(p.getPlayGround().getGrid()[mv.xF][mv.yF].getPiece().getPlayer() != this.getPlayer()){
		return true;
	}else {
		return false;
}
}
public boolean Rook.isPlacable(Player p,Move mv){

	if(p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied())
	{
		if(p.getPlayGround().getGrid()[mv.xF][mv.yF].getPiece().getPlayer() == this.getPlayer())
		{

			return false;
			
		}
		
		
	}
		
		
		
		
	if(mv.xF > mv.xI) {
		
		
		for(int i = mv.xI+1;i<mv.xF;i++) {
			
			if(p.getPlayGround().getGrid()[i][mv.yF].isOccupied()) {
	
				return false;
				
			}
			
		}

	}
	
	if(mv.xF < mv.xI) {
		
		
		for(int i = mv.xI-1;i>mv.xF;i--) {
			
			if(p.getPlayGround().getGrid()[i][mv.yF].isOccupied()) {
		
				return false;
				
			}
			
		}

	}
	
	if(mv.yF > mv.yI) {
		
		
		for(int i = mv.yI+1;i<mv.yF;i++) {
			
			if(p.getPlayGround().getGrid()[mv.xF][i].isOccupied()) {

				return false;
				
			}
			
		}

	}
	
	if(mv.yF < mv.yI) {		
		for(int i = mv.yI-1;i>mv.yF;i--) {			
			if(p.getPlayGround().getGrid()[mv.xF][i].isOccupied()) {	
				return false;				
			}			
		}

	}
return true;
}
public boolean Pawn.isPlacable(Player p,Move mv){
	int movX=mv.xF-mv.xI;
	
	if(movX==0 && !p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied()) {
		return true;
	}else if(movX!=0 && p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied()) { 
		if(p.getPlayGround().getGrid()[mv.xF][mv.yF].getPiece().getPlayer() != this.getPlayer())
		{	
			return true;
		}else
		{
			return false;
		}
	}else {
		return false;
}
}


public boolean Bishop.isPlacable(Player p,Move mv){
	if(p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied())
	{
		if(p.getPlayGround().getGrid()[mv.xF][mv.yF].getPiece().getPlayer() == this.getPlayer())
		{
			return false;		
		}		
	}		
	if(mv.xF > mv.xI && mv.yF > mv.yI) {		
		for(int i = mv.xI+1,j = mv.yI+1;i<mv.xF;i++, j++) {			
			if(p.getPlayGround().getGrid()[i][j].isOccupied()) {				
				return false;				
			}		
		}
	}
	
	if(mv.xF < mv.xI && mv.yF > mv.yI) {		
		for(int i = mv.xI-1,j=mv.yF+1;i>mv.xF;i--,j++) {			
			if(p.getPlayGround().getGrid()[i][j].isOccupied()) {				
				return false	;			
			}			
		}
	}
	
	if(mv.xF > mv.xI && mv.yF < mv.yI) {		
		for(int i = mv.yI+1,j=mv.yI-1;i<mv.xF;i++,j--) {			
			if(p.getPlayGround().getGrid()[i][j].isOccupied()) {				
				return false;				
			}			
		}
	}
	
	if(mv.xF < mv.xI && mv.yF < mv.yI) {		
		for(int i = mv.xI-1,j=mv.yI-1;i>mv.xF;i--,j--) {			
			if(p.getPlayGround().getGrid()[i][j].isOccupied()) {				
				return false;				
			}			
		}
	}
return true;
}

public boolean Knight.isPlacable(Player p,Move mv){
	if(!p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied())
	{
		return true;
	}else if(p.getPlayGround().getGrid()[mv.xF][mv.yF].getPiece().getPlayer() != this.getPlayer()){
		return true;
	}else {
		return false;
}
}

} 