//most recent

package c4.ext;

import c4.base.BoardPanel;
import c4.base.*;
import c4.*;

import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public privileged aspect EndGame {
    //int counter=0;
    //ColorPlayer Blue = new ColorPlayer("Blue", Color.BLUE );
    //ColorPlayer Red = new ColorPlayer("Red", Color.RED );
    pointcut test(C4Dialog dialog): this(dialog) && call(void C4Dialog.makeMove(int));




    /*if(counter%2==0){
        dialog.player = Red;
        dialog.showMessage("Red turn");
    }
    if(counter%2==1){
        dialog.player= Blue;
        dialog.showMessage("Blue turn");
    }
    counter++;*/

    after(C4Dialog c4Dialog): this(c4Dialog) && execution(void C4Dialog.makeMove(..))
            {
                //if player is blue change to red
                if (c4Dialog.player.name().equals("Blue")) {
                    c4Dialog.player = Red;
                    c4Dialog.showMessage("Red turn");
                }
                //if player is red change to blue
                else if (c4Dialog.player.name().equals("Red")) {
                    c4Dialog.player = Blue;
                    c4Dialog.showMessage("Blue turn");
                }
                c4Dialog.name.setDropColor(c4Dialog.player.color());
            }

    before(C4Dialog dialog): execution(* C4Dialog.makeMove(int)) && this(dialog){
        if (dialog.board.isWonBy(dialog.player)) {

            dialog.showMessage("won by" + dialog.player);
            //dialog.startNewGame();
            // dialog.board.dropInSlot(n,dialog.player);
            // if (dialog.board.isFull()) {
            //   dialog.showMessage("tie" + dialog.player.name());

            //} else if (dialog.board.isWonBy(dialog.player)) {
            //  dialog.showMessage("won" + dialog.player.name());

            //}
            dialog.repaint();
        }
    }

    pointcut press_disc(BoardPanel panel):
            (call(int BoardPanel.locateSlot(int,int))) && target(panel) &&! within(PressDisc);
    after(BoardPanel panel): press_disc(panel){

        //Add listener for when mouse is clicked
        panel.addMouseListener(new MouseAdapter(){
            @Override
            public void mousePressed(MouseEvent e){
                //Verify game is active
                if(!(panel.board.isGameOver())){
                    Graphics g = panel.getGraphics();
                    int position = panel.locateSlot(e.getX(), e.getY());
                    panel.drawChecker(g,panel.dropColor, position,-1,-1);
                    panel.drawChecker(g,panel.dropColor, position,-1,true);
                }
            }
        });

    }


