package c4.ext;

import c4.base.BoardPanel;
import c4.base.*;

import java.awt.*;

public privileged aspect EndGame{
    //int counter=0;
    ColorPlayer Blue = new ColorPlayer("Blue", Color.BLUE );
    ColorPlayer Red = new ColorPlayer("Red", Color.RED );
    pointcut test(C4Dialog dialog): this(dialog) && execution(void C4Dialog.makeMove(int));

    void around(C4Dialog dialog, int n): args(n) && test(dialog){
        if (!dialog.board.isGameOver()) {
            dialog.board.dropInSlot(n,dialog.player);
            if (dialog.board.isFull()) {
                dialog.showMessage("tie" + dialog.player.name());

            } else if (dialog.board.isWonBy(dialog.player)) {
                dialog.showMessage("won" + dialog.player.name());
            }
        }
        dialog.repaint();
        if (dialog.player.name().equals("Blue")) {
            dialog.player = Red;
            dialog.showMessage("Red turn");
        }
        //if player is red change to blue
        else if (dialog.player.name().equals("Red")) {
            dialog.player = Blue;
            dialog.showMessage("Blue turn");
        }
        /*if(counter%2==0){
            dialog.player = Red;
            dialog.showMessage("Red turn");
        }
        if(counter%2==1){
            dialog.player= Blue;
            dialog.showMessage("Blue turn");
        }
        counter++;*/

    }


}
