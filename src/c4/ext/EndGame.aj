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
    after(C4Dialog c4Dialog, Player player) : this(c4Dialog) && args(place)&& execution(void c4Dialog.makeMove(Place)){
        if(!c4Dialog.board.isGameOver()){
            proceed();
        }else if(c4Dialog.board.isWonBy(c4Dialog.player)){
            c4Dialog.showMessage(c4Dialog.player.name + " won");
            c4Dialog.repaint();
        }else{
            c4Dialog.showMessage("Its a tie ");
            c4Dialog.repaint();

        }

    }
    after(C4Dialog c4Dialog): this(c4Dialog) && execution(void C4Dialog.makeMove(..)){
        if(c4Dialog.board.isWonBy(c4Dialog.player)){
            c4Dialog.showMessage(c4Dialog.player.name + " won");
        }

    }
    void around(C4Dialog dialog): target(dialog)
            && execution(void C4Dialog.playButtonClicked(ActionEvent)){

        if(dialog.board.isGameOver()) {
            dialog.startNewGame();
        }

        else {
            proceed(dialog);
        }

    }
}