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
VAR strength = 1  


VAR visited_beach_start = false
VAR visited_beach_path = false
VAR visited_shells = false
VAR visited_cove = false
VAR visited_cave_exploration = false
VAR creature = 0


VAR coconuts_qty = 3
VAR have_coconuts = false


VAR have_Amulet = false
VAR wear_Amulet = false


-> beach_start

== beach_start ==
{visited_beach_start: You find yourself once again at the beach, the waves rolling gently. | You wake up on a quiet beach, the waves rolling gently. The salty air fills your lungs as you take in the scenery.}
~ advance_time()
~ visited_beach_start = true
It's { Time }


+ [Stroll down the beach] -> beach_path
+ {Time == "sunset."} [Enjoy the sunset] -> sunset
+ [Look around for anything interesting] -> discovery
+ [Rest and wait] -> beach_start

-> DONE

== beach_path ==
{visited_beach_path: You find yourself walking the familiar shoreline again. | You walk further down the beach, your feet sinking into the warm sand.}
~ advance_time()
~ visited_beach_path = true
It's { Time }

* {Time == "noon."} [Pick up some seashells] -> shells
+ {Time != "sunset." && Time != "evening."} [Swim in the sea] -> swimming
+ {have_coconuts && coconuts_qty != 0} [Enjoy a coconut] -> eat_coconut
+ [Explore deeper down the beach] -> creature_encounter
+ [Move back to where you started] -> beach_start
+ [Venture towards the rocky cove] -> cove

== shells ==
{visited_shells: You've already picked up some shells, but you look around again. | You pick up some shells, admiring their delicate patterns.}
~ advance_time()
~ visited_shells = true
It's { Time }


+ [Examine the shells closely] -> shell_discovery
+ [Move back up the beach] -> beach_path


== swimming ==
{Time == "sunset": It is dangerous to swim at night. | You dive into the water, enjoying the coolness. The ocean is peaceful, and you feel a sense of freedom.}
~ advance_time()
It's { Time }

+ {Time != "sunset."} [Swim again] -> swimming
+ [Go back to shore] -> beach_path

== creature_encounter ==
{&While exploring further, you spots a small crab scuttling across the sand. Curious, you crouch down to observe it. The crab pauses, as if noticing them, before darting into a small hole in the sand. |Further down the beach, you notice a disturbance near the waterline. Upon closer inspection, you see a small sea turtle digging in the sand, creating a nest. The turtle appears calm, undisturbed by the world around it. |As you walk along the beach, you come across a cluster of coconuts lying under a palm tree. Some are cracked open, revealing fresh coconut water and soft white flesh.}

It's { Time }

~ creature ++

+ {creature >= 1} [Try to interact with the crab] -> crab_reacts
+ {creature >= 2} [Observe the turtle quietly] -> turtle_watching
+ {creature >= 3} [Gather coconuts from nearby trees] -> coconuts
+ [Explore more] -> creature_encounter
+ [Move back towards the beach] -> beach_path

== turtle_watching ==
The turtle continues nesting, undisturbed.
+ [Stay longer and watch] -> creature_encounter
+ [Walk away silently] -> beach_path

== crab_reacts ==
The crab pinches your finger lightly and scuttles away!
+ [Laugh and let it go] -> creature_encounter

== coconuts ==
You collect a few coconuts. They might come in handy.
~ have_coconuts = true

+ [Keep exploring] -> creature_encounter
+ [Return to the beach] -> beach_path

== cove ==
{visited_cove: You've been here before, but the mystery still intrigues you. | You carefully make your way into a hidden rocky cove. The sound of waves echoes against the stone walls.}
~ visited_cove = true
+ [Investigate the cave] -> cave_exploration
+ [Check the tide pools] -> tide_pools
+ [Return to the main beach] -> beach_path

== tide_pools ==
You discover vibrant starfish and tiny shrimp in the tide pools.
+ [Touch the octopus] -> octopus_reaction
+ [Keep observing quietly] -> cove

== octopus_reaction ==
The octopus squirts ink and darts away!
+ [Laugh and move on] -> cove
+ [Try to find it again] -> tide_pools

== cave_exploration ==
{visited_cave_exploration: You recall the eerie feeling from before. | The cave is dark, but you notice strange rock formations ahead.}
~ visited_cave_exploration = true
+ [Go deeper inside] -> deeper_cave
+ [Turn back] -> cove

== deeper_cave ==
{strength < 2: The passage is blocked by a heavy rock. You aren't strong enough to move it. | Inside, you find ancient carvings on the wall, and a rusty chest.}
+ {strength >= 2} [Try to open the chest] -> chest_opened
+ [Study the carvings] -> hidden_meaning
+ [Leave the cave] -> cove

== hidden_meaning ==
The carvings tell a story of an ancient civilization.
+ [Take notes and leave] -> cove
+ [Try to decipher them further] -> cave_exploration

== chest_opened ==
Inside, you find an old amulet.

* {not have_Amulet} [Take the amulet] 
    ~ have_Amulet = true
    -> chest_opened
* {not wear_Amulet && have_Amulet} [Wear the amulet] 
    ~ wear_Amulet = true
    -> chest_opened
+ [Leave it] -> cove

== shell_discovery ==
You find one shell with a spiral pattern unlike any you've seen before.
+ [Take it] -> beach_path
+ [Leave it] -> beach_start

== discovery ==
While looking around, you notice something shiny partially buried in the sand.
+ [Dig it up] -> buried_treasure
+ [Ignore it] -> beach_start

== buried_treasure ==
You uncover an old bottle with a rolled-up parchment inside.
+ [Open it] -> message_in_a_bottle
+ [Leave it buried] -> beach_start

== message_in_a_bottle ==
The parchment reveals a faded map.
+ [Study the map] -> treasure_hunt
+ [Toss the bottle back into the sea] -> beach_start

== treasure_hunt ==
Using the map, you start searching along the coastline.
+ [Follow the clues] -> secret_discovery
+ [Give up and enjoy the beach] -> beach_start

== secret_discovery ==
You uncover a small locked chest.
+ {strength >= 2} [Pry it open] -> chest_opened
+ {strength < 2} [You're not strong enough to open it (find something to eat)] -> beach_start

== sunset ==
The day winds down, and the sun paints the sky in brilliant colors.
~ advance_time()
It's { Time }

+ [Back to the beach] -> beach_start
+ [Watch the stars] -> stargazing

== stargazing ==
The stars slowly appear.
+ [Look for constellations] -> constellations
+ [Relax and enjoy the moment] -> beach_start

== constellations ==
You spot Orion’s Belt and a few other recognizable patterns.
+ [Make a wish] -> wish_made
+ [Head back] -> beach_start

== wish_made ==
You feel hopeful as you make your wish.
+ [End the night peacefully] -> beach_start

== eat_coconut ==
The coconut has freshed your throat. You feel power growing in your body.
~ killing_coconuts()
+ [Return to the beach] -> beach_path














== function killing_coconuts ==
    {
        - coconuts_qty > 0:
            ~ coconuts_qty --
            ~ strength ++
        
        - coconuts_qty <= 0:
            ~ have_coconuts = false
    }

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
    

    
    
    
    
    
    
    
    
    
    
