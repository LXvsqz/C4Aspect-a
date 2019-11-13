package c4.ext;
import c4.base.C4Dialog;
import c4.base.BoardPanel;
import java.awt.Color;
import c4.base.ColorPlayer;

public privileged aspect AddOpponent {

    private BoardPanel C4Dialog.name;

    ColorPlayer Blue = new ColorPlayer("Blue", Color.BLUE); //predefined human players created
    ColorPlayer Red = new ColorPlayer("Red", Color.RED);

    after(C4Dialog dialog) returning(BoardPanel panel): this(c4Dialog) && call(BoardPanel.new(..)){
        dialog.name = panel;
    }

    after(C4Dialog dialog): this(dialog) && execution(void C4Dialog.makeMove(..))
            {
                //if player is blue change to red simultaneously
                if (dialog.player.name().equals("Blue")) {
                    dialog.player = Red;
                }
                //if player is red change to blue simultaneously
                else if (dialog.player.name().equals("Red")) {
                    dialog.player = Blue;
                }
                dialog.showMessage(dialog.player.name() + "Turn"); //display message for unique player tyurn
                dialog.name.setDropColor(dialog.player.color()); //set color
            }
}