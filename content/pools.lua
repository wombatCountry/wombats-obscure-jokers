SMODS.ObjectType {
    key = "Meme",
    default = "j_womsobsc_charming",
    cards = {
        ["j_mr_bones"] = true,
        ["j_green_joker"] = true,
    },
}

SMODS.ObjectType {
    key = "Music",
    default = "j_hit_the_road",
    cards = {
        ["j_photograph"] = true,
        ["j_runner"] = true,
        ["j_vampire"] = true,
        ["j_matador"] = true,
        ["j_hit_the_road"] = true,
        ["j_drivers_license"] = true,
    },
    inject = function(self)
        --https://github.com/Cdrvo/Revos-Vault/blob/b722dc4de7240c43cb51144ac24536ae7ac37475/main.lua#L717
        SMODS.ObjectType.inject(self)
        if config.thirteen_jokers == true then
            self:inject_card(G.P_CENTERS.j_joker)
            self:inject_card(G.P_CENTERS.j_ride_the_bus)
            self:inject_card(G.P_CENTERS.j_popcorn)
            self:inject_card(G.P_CENTERS.j_fortune_teller)
            self:inject_card(G.P_CENTERS.j_gros_michel)
            self:inject_card(G.P_CENTERS.j_riff_raff)
            self:inject_card(G.P_CENTERS.j_hack)
            self:inject_card(G.P_CENTERS.j_card_sharp)
            self:inject_card(G.P_CENTERS.j_hiker)
            self:inject_card(G.P_CENTERS.j_madness)
            self:inject_card(G.P_CENTERS.j_stuntman)
            self:inject_card(G.P_CENTERS.j_baseball)
        end
    end
}

--returns the key of a random joker in the meme pool
function get_meme_joker()
    local meme_folder = {}
    local output

    --https://github.com/Balatro-Potato-Patch/Wormhole/blob/b1c6df43d19fc8585895d8b7671a9a1f81ceed7c/content/Hedonia/deck.lua#L20
    for _, card in ipairs(G.P_CENTER_POOLS.Meme) do
        if not G.GAME.used_jokers[card.key] and not next(find_joker("Showman")) and card.unlocked and card.rarity ~= 4 then --i got this from the original game (functions/common_events.lua, line 1987)
            table.insert(meme_folder, card.key)
        end
    end

    if meme_folder == {} then
        return 'j_womsobsc_charming'
    end

    output = pseudorandom_element(meme_folder)

    return output
end

--returns the key of a random joker in the music pool
function get_music_joker()
    local collection = {}
    local output

    for _, card in ipairs(G.P_CENTER_POOLS.Music) do
        if not G.GAME.used_jokers[card.key] and not next(find_joker("Showman")) and card.unlocked and card.rarity ~= 4 then 
            table.insert(collection, card.key)
        end
    end

    if collection == {} then
        return 'j_hit_the_road'
    end

    output = pseudorandom_element(collection)

    return output
end