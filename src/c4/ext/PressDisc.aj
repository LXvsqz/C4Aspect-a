package c4.ext;


import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import c4.base.*;


public privileged aspect PressDisc {

    pointcut pressdisc(BoardPanel panel): (call(int BoardPanel.locateSlot(int,int))) && target(panel) &&! within(PressDisc);
        after(BoardPanel panel): pressdisc(panel){
            panel.addMouseListener(new MouseAdapter() { //mouse click
                @Override
                public void mousePressed(MouseEvent e) {
                    if (!(panel.board.isGameOver())){ //continue while game is not over

                        int position = panel.locateSlot(e.getX(), e.getY());
                        Graphics graphics = panel.getGraphics();
                        panel.drawChecker(graphics, panel.dropColor, position, -1, -1);
                        panel.drawChecker(graphics, panel.dropColor, position, -1, true);
                    }
                }
            });

        //differentiate between mouse click and mouse release
        panel.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseReleased(MouseEvent e){//check if the game is not over yet
                if(!(panel.board.isGameOver())){

                    int position = panel.locateSlot(e.getX(), e.getY());
                    Graphics graphics = panel.getGraphics();
                    panel.drawChecker(graphics, panel.dropColor, position, -1, 0);
                }
            }
        });
    }
}