//most recent

package c4.ext;

import c4.base.BoardPanel;
import c4.base.*;
import c4.*;
import c4.model.Player;

import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public privileged aspect EndGame {
    void around(C4Dialog dialog): this(dialog) && execution(void C4Dialog.newButtonClicked(..)){

        if(dialog.board.isGameOver() ) { //clear the board
            dialog.startNewGame();
        } else { //keep going
            proceed(dialog);
        }
    }
    after(C4Dialog dialog, Player player) : this(dialog) && args(place)&& execution(void c4Dialog.makeMove(Place)){
        if(!dialog.board.isGameOver()){ //continue while game is not over
            proceed();
        }else if(dialog.board.isWonBy(player)){ //display player that wins
            dialog.showMessage(player.name + " Won The Game");
            dialog.repaint(); //display
        }else{
            dialog.showMessage("TIE GAME. TRY AGAIN"); //need to fix new button in this instance
            dialog.repaint();
        }
    }
}