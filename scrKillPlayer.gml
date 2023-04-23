/*

script: YoYoYo Engine (GMS1) Sctipt - scrKillplayer (RANDOM DEATHSOUND VER);

version: 1.1.0 (bug fixed) 2023-4-23;

Author: TheMagicFlute;

feature: kills the player and play the random death sound;

usage: scrkillPlayer();

*/

//requirements: 3 sounds resource: musDeath1, musDeath2, musDeath3!

var mus, music; //define variables

mus = irandom_range(1,3);

if (mus)
{
    if (mus == 1)
    {
        music = musDeath1; // mus1
    }
    if (mus == 2)
    {
        music = musDeath2; // mus2
    }
    if (mus == 3)
    {
        music = musDeath3; // mus3
    }
}

if (mus) && (music)
{
    if (instance_exists(objPlayer) && (!global.noDeath && !global.debugNoDeath))
    {
        if (global.gameStarted) //normal death
        {
            global.deathSound = audio_play_sound(sndDeath,0,false);
            
            if (!global.muteMusic)  //play death music
            {
                audio_pause_sound(global.currentMusic);
                
                audio_play_sound(sndDeath, 1, false);
                
                global.gameOverMusic = audio_play_sound(music,1,false);
            }
            
            with (objPlayer)
            {
                instance_create(x,y,objBloodEmitter);
                instance_destroy();
            }
            
            instance_create(0,0,objGameOver);
            
            global.death += 1; //increment deaths
                
            scrSaveGame(false); //save death/time
        }
        else    //death in the difficulty select room, restart the room
        {
            with(objPlayer)
                instance_destroy();
                
            room_restart();
        }
    }
}