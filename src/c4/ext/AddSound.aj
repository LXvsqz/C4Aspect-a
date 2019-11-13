package c4.ext;
//import java.awt.Color;
import java.io.IOException;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;
import c4.base.C4Dialog;


public privileged aspect AddSound {

    private static final String SOUND_DIR = "/sound/";

    before(C4Dialog dialog) : execution(* C4Dialog.makeMove(int)) && this(dialog){ //play different sound for each player
        if (dialog.player.name().equals("Blue")) {
            playAudio("bloop_x.wav");
        }else {
            playAudio("click.wav");
        }
        proceed();
    }
    after(C4Dialog dialog) : execution(* C4Dialog.makeMove(int)) && this(c4Dialog){
        if(dialog.board.isWonBy(dialog.player)){ //play different sound if winner
            playAudio("clapping.wav");
            dialog.showMessage(dialog.player.name() + " Won The Game!");

        }
    }

    public static void playAudio(String filename){ //from base code
        try {
            AudioInputStream audioIn = AudioSystem.getAudioInputStream(
                    AddSound.class.getResource(SOUND_DIR + filename));
            Clip clip = AudioSystem.getClip();
            clip.open(audioIn);
            clip.start();
        } catch (UnsupportedAudioFileException
                | IOException | LineUnavailableException e) {
            e.printStackTrace();
        }
    }
}