package ca.uqac.inf957.chess.aspect;
import java.io.FileWriter;
import java.io.IOException;


import ca.uqac.inf957.chess.Board;
import ca.uqac.inf957.chess.agent.Move;
import ca.uqac.inf957.chess.agent.Player;

public aspect historique {	
	
	pointcut WriteHistorique(Board b, Move mv) : 
		target(b)
		&& execution(void Board.movePiece(Move))
		&& args(mv);
	
	after(Board b, Move mv):WriteHistorique( b, mv){
		FileWriter fileWriter;


				try {
					fileWriter = new FileWriter("Historique.txt",true);
					fileWriter.write("");
					String pieceStr = b.getGrid()[mv.xF][mv.yF].getPiece().getClass().getName();
					
					pieceStr=pieceStr.substring(pieceStr.indexOf("piece")+6);
					
					switch(b.getGrid()[mv.xF][mv.yF].getPiece().getPlayer()) 
					{
					
					case Player.BLACK :

						fileWriter.write("Black ->" +pieceStr+ " : " + mv.toString()+"\n");		
						fileWriter.flush();
						break;
					case Player.WHITE :
	
						fileWriter.write("White ->" +pieceStr+ " : " + mv.toString()+"\n");
						fileWriter.flush();
						break;
					
					}
					
					fileWriter.close();
				} catch (IOException e) {		
					e.printStackTrace();
				}
		
	}
}