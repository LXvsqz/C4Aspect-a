package c4.ext;

import java.awt.Color;
import java.awt.Graphics;
import java.util.List;
import c4.model.Board.Place;
import c4.base.BoardPanel;
import c4.base.C4Dialog;
import c4.base.ColorPlayer;
import org.aspectj.lang.annotation.Around;

import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;

public privileged aspect EndGame{

    pointcut game_over(C4Dialog c4_dialog): //telling it where to go i believe?
             this(c4_dialog) && (call(void C4Dialog.makeMove(int)));
                    //|| (call(int Board.dropInSlot(int, Player)));


    //pointcut gameOver(C4Dialog c4Dialogg):
      //      this(c4Dialogg) && call(void board.dropInSlot(int));

    //------------------------------------------------------------------------////
     void around(C4Dialog c4_dialog, int n): args(n) && game_over(c4_dialog){ //telling it what to do
        //PLAYER WON GAME
         String x = "hello";
        c4_dialog.makeMove(n);
         c4_dialog.showMessage("Game is over, winner is ssssssss:");

         if(c4_dialog.board.isWonBy(c4_dialog.player)){
            c4_dialog.showMessage("Game is over, winner is :"+ c4_dialog.player.name() );
            AddSound.playAudio("click.wav");
        }
        //GAME IS A DRAW
        else {
            if(c4_dialog.board.isFull()){
                c4_dialog.showMessage("Tie Game!");
                AddSound.playAudio("click.wav");
            }
        }

    }

}