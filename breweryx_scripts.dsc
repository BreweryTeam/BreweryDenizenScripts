# I'm going to be using separate script containers for events for readability.
breweryx_drink:
    type: world
    events:
        on brewery drink:
        # All available Context for this event. See: https://github.com/BreweryTeam/Depenizen/blob/master/src/main/java/com/denizenscript/depenizen/bukkit/events/breweryx/BreweryDrinkScriptEvent.java#L17
        - define denizenItemStack <context.item>
        - define breweryRecipe <context.recipe>
        - define denizenPlayer <context.player>
        # Do something
        - narrate "<[denizenPlayer].name> drank something!"
        - narrate "<[breweryRecipe].id> is this ID of this recipe!"
        - if <[breweryRecipe].alcohol> > 60:
            - determine passively cancelled
            - narrate "That drink has waaaay too much alcohol for you, don't drink that!"
        - else:
            - narrate "This drink was <[breweryRecipe].alcohol>% alcohol"
        # This script is designed to showcase what you can do with the BreweryRecipeTag object.
        # Skilled scripters can modify the ItemStack, do stuff to the player, etc.
        # See: https://github.com/BreweryTeam/Depenizen/blob/master/src/main/java/com/denizenscript/depenizen/bukkit/objects/breweryx/BreweryRecipeTag.java

breweryx_cauldron_ingredient_add:
    type: world
    events:
        on brewery ingredient add:
        # All available Context for this event. See: https://github.com/BreweryTeam/Depenizen/blob/master/src/main/java/com/denizenscript/depenizen/bukkit/events/breweryx/BreweryIngredientAddScriptEvent.java#L25
        - define denizenItemStack <context.item>
        - define denizenPlayer <context.player>
        - define cauldronLocation <context.location>
        - define isTakeItem <context.take_item>
        # Teleports a random online player to the cauldron.
        - narrate "You added <[denizenItemStack].material> to this cauldron!"
        - define onlinePlayers <server.online_players>
        - teleport <[onlinePlayers].get[<util.random.int[1].to[<[onlinePlayers]>.size]>]> <[cauldronLocation]>
        - if <[denizenItemStack].material> == <material[apple]>:
            - narrate "No apples are allowed in this cauldron!!!!"
            - determine cancelled
        - else if <[denizenItemStack].material> == <material[arrow]>:
            - determine passively take_item:false
            - narrate "It's free arrow day! Any arrows added to cauldrons won't be taken from your inventory!"

breweryx_modify_brew:
    type: world
    events:
        # See: https://github.com/BreweryTeam/Depenizen/blob/master/src/main/java/com/denizenscript/depenizen/bukkit/events/breweryx/BreweryModifyBrewScriptEvent.java
        on brewery brew modify:
        - narrate "A Brew has been modified/created! ID: <context.recipe.id>" targets:<server.online_players>

breweryx_chat_distort:
    type: world
    events:
        # See: https://github.com/BreweryTeam/Depenizen/blob/master/src/main/java/com/denizenscript/depenizen/bukkit/events/breweryx/BreweryModifyBrewScriptEvent.java
        on brewery chat distort:
        - define message <context.message>
        - define originalMessage <context.original_message>
        - define denizenPlayer <context.player>
        - if <[denizenPlayer].brewery_drunkenness> > 90:
            - determine passively cancelled
            - narrate "No more chat distortion for you :)"
            # Showcasing player extensions, see: https://github.com/BreweryTeam/Depenizen/blob/master/src/main/java/com/denizenscript/depenizen/bukkit/properties/breweryx/BreweryPlayerExtensions.java
            - narrate "Your drunkenness level is: <[denizenPlayer].brewery_drunkenness>%"
            - narrate "Your drunkenness quality is: <[denizenPlayer].brewery_quality>"
            - narrate "Your alcohol recovery rate is: <[denizenPlayer].brewery_alcoholrecovery>"