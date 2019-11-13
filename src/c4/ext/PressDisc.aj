package c4.ext;
import c4.base.*;
import java.awt.event.MouseAdapter;
import java.awt.*;
import java.awt.event.MouseEvent;


public privileged aspect PressDisc {

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

        //Add listener for when mouse is released
        panel.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseReleased(MouseEvent e){
                //check if game is still active
                if(!(panel.board.isGameOver())){
                    Graphics g = panel.getGraphics();
                    int matrix_position = panel.locateSlot(e.getX(), e.getY());
                    panel.drawChecker(g, panel.dropColor, matrix_position, -1, 0);
                }
            }
        });
    }
}