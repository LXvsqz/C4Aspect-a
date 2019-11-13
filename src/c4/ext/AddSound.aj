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

    /** feature enable: TRUE = Disabled, FALSE = Enabled */
    private static final String SOUND_DIR = "/sound/";

    //plays sound based on current player's turn
    before(C4Dialog c4Dialog) : execution(* C4Dialog.makeMove(int)) && this(c4Dialog){
        if (c4Dialog.player.name().equals("Blue")) {
            playAudio("bloop_x.wav");
        }else {
            playAudio("click.wav");
        }
       // if(c4Dialog.board.isWonBy(c4Dialog.player)){
         //   playAudio("clapping.wav");
        //}

    }
    after(C4Dialog c4Dialog) : execution(* C4Dialog.makeMove(int)) && this(c4Dialog){
        if(c4Dialog.board.isWonBy(c4Dialog.player)){
            playAudio("clapping.wav");
        }
    }

    public static void playAudio(String filename) {
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

    }//end of play audio

}//end of add sound