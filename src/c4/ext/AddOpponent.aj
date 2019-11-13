package c4.ext;

import java.awt.Color;
import c4.base.ColorPlayer;
import c4.base.C4Dialog;
import c4.base.BoardPanel;

public privileged aspect AddOpponent{

    private BoardPanel C4Dialog.name;
    ColorPlayer Blue = new ColorPlayer("Blue", Color.BLUE );
    ColorPlayer Red = new ColorPlayer("Red", Color.RED );

    after(C4Dialog c4Dialog) returning(BoardPanel panel): this(c4Dialog) &&
            call(BoardPanel.new(..)){ c4Dialog.name = panel;}

    //The advice is declared checking for makeMove execution
    before(C4Dialog c4Dialog): this(c4Dialog) && execution(void C4Dialog.makeMove(..))
            {
                //if player is blue change to red

                if (c4Dialog.player.name().equals("Blue")) {
                    c4Dialog.player = Red;
                    c4Dialog.showMessage("red turn");
                }
                //if player is red change to blue
                else if (c4Dialog.player.name().equals("Red")) {
                    c4Dialog.player = Blue;
                    c4Dialog.showMessage("Blue turn");
                }
                c4Dialog.name.setDropColor(c4Dialog.player.color());
            }
}