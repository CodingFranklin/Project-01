/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than 16 passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

VAR time = -1 //  0 Morning, 1 Noon, 2 Night
VAR Time = "" 




-> seashore

== seashore ==
You are sitting on the beach. 
~ advance_time()
It's { Time }

+ [Stroll down the beach] -> beach2
+ {Time == "sunset"} [Enjoy the sunset] -> sunset
+ [Wait and take the scenery] -> seashore
-> DONE

== beach2 ==
~ advance_time() 
This is further down the beach. 
It's { Time }

* {Time == "noon."} [Pick up some seeshells] -> shells
+ {Time != "sunset." && Time != "evening."}[Swim in the sea] -> swimming
+ [Continue walking and see what else the beach holds] -> creature_encounter
+ [Move back up the beach] -> seashore

== shells ==
~ advance_time() 
You pick up the shells.
It's { Time }

+ [Move back up the beach] -> beach2

== swimming ==
{Time == "sunset.": It is dangerous to swim in the sea during night. |You jump into the water. The cool waves are refreshing, and you spot small fish darting around. You feels a sense of peace and freedom.} 
~ advance_time()
It's { Time }

+ {Time != "sunset."} [Swim again] -> swimming
+ [Go back up to the beach] -> beach2

== creature_encounter ==
{&While exploring further, you spots a small crab scuttling across the sand. Curious, you crouch down to observe it. The crab pauses, as if noticing them, before darting into a small hole in the sand. |Further down the beach, you notice a disturbance near the waterline. Upon closer inspection, you see a small sea turtle digging in the sand, creating a nest. The turtle appears calm, undisturbed by the world around it. |As you walk along the beach, you come across a cluster of coconuts lying under a palm tree. Some are cracked open, revealing fresh coconut water and soft white flesh.}
~ advance_time()
It's { Time }

+ [Hanging around] -> creature_encounter
+ [Stroll back to the seashell spot] -> seashore

== sunset ==
The day begins to wind down, and the sun sets over the horizon, painting the sky with brilliant colors. 
~ advance_time()
It's { Time }

+ [Back to the beach] -> seashore








== function advance_time ==

    ~ time = time + 1
    
    {
        - time > 3:
            ~ time = 0
    }    
    
    {
        - time == 0:
            ~ Time = "morning."
            
        - time == 1:
            ~ Time = "noon."
            
        - time == 2:
            ~ Time = "sunset."
            
        - time == 3:
            ~ Time = "evening."
    }
    
    
    
    
    
    
    
    
    
    
    
