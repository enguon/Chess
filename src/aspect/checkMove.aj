import ca.uqac.inf957.chess.agent.*;
import ca.uqac.inf957.chess.piece.*;
import ca.uqac.inf957.chess.*;

public aspect checkMove {

//     pointcut greeting() : execution(* Hello.sayHello(..));
	
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
 		//Réécriture de la méthode boolean Player.move(Move)
 		if((mv.xI >= Board.SIZE || mv.xI < 0) || (mv.yI >= Board.SIZE || mv.yI < 0))
 		{
 			System.out.println("Illegal Move");
 			return false;
 		} 		
 		if(p.getPlayGround().getGrid()[mv.xI][mv.yI].isOccupied())
 		{
 			if(p.getPlayGround().getGrid()[mv.xI][mv.yI].getPiece().getPlayer()==p.getColor())
 			{	
 						if(p.getPlayGround().getGrid()[mv.xI][mv.yI].getPiece().isMoveLegal(mv))
 						{ 													
// 							if(p.getPlayGround().getGrid()[mv.xI][mv.yI].getPiece().isPathFree(p, mv))
// 							{
 								p.getPlayGround().movePiece(mv);					
 								return true;
// 							}
 						} 						
 			}			
 		}		
 		System.out.println("Illegal Move");
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
	
	boolean mvLigneDroite = (Math.abs(mv.getxF() - mv.getxI()) == 1 && Math.abs(mv.getyF() - mv.getyI()) == 0) || (Math.abs(mv.getxF() - mv.getxI()) == 0 && Math.abs(mv.getyF() - mv.getyI()) == 1);
	boolean mvDiagonal = Math.abs(mv.getxF() - mv.getxI()) == 1 && Math.abs(mv.getyF() - mv.getyI()) == 1;
	
	if( mvLigneDroite )return true;
	if(mvDiagonal) return true;
	return false;
}


boolean around(Queen q, Move mv)	: QueenMove(q,mv)
{
	if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0))
		return false;
	
	int movX=Math.abs(mv.xF-mv.xI);
	int movY=Math.abs(mv.yF-mv.yI);		
	
	if ((movX!=0 && movY==0) || (movX==0 && movY!=0)) return true;
	
	if(movY!=0) return (movX/movY)==1;  
	return false;
	
}

boolean around(Knight p, Move mv) : KnightMove(p,mv){
		//Réécriture de la méthode boolean Knight.isMoveLegal(Move)
		
		/*
		 * 
		 * Renvoie "true" si le mouvement correspond au mouvement d'un Cavalier, false sinon
		 * 
		 */
		
//		if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0))
//			return false;
		
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
 	
} 