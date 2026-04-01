SMODS.Atlas {
	key = "WombatsObscure",
	path = "WombatsObscure.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
    key = "modicon",
    path = "modicon.png",
    px = 34,
    py = 34,
}

-- hook for flip function to make speen joker work
-- thanks to Somethingcom515 from the Balatro discord for this
local oldcardflip = Card.flip
function Card:flip()
    if G.STAGE == G.STAGES.RUN then
        SMODS.calculate_context({modprefix_card_flipped = true, card = self})
    end
    return oldcardflip(self)
end

-- Got this from axyraandas https://github.com/TonyKrZa/BerryLegendaries/blob/99849e468f6a0e28928fb222905ab677947ec6c0/main.lua#L9
assert(SMODS.load_file('jokers/meme.lua', SMODS.current_mod.id))()
assert(SMODS.load_file('jokers/music.lua', SMODS.current_mod.id))()

--[[ Broken Joker based on SCP 001 Lily's Proposal. After failing to make it always have an 
    eternal sticker, I realized that it was just a motivation-drainer that probably wasn't 
    even fun to play with, and I scrapped it in favor of focusing on the rest of the mod

SMODS.Joker {
    key = 'lily',
    loc_txt = {
        name= "The World Gone Beautiful",
        text = {
            "{X:mult,C:white}x#1#{} mult and {X:chips,C:white}x#2#{} chips.",
            "Values become negative after",
            "defeating the boss blind"
        }
    },
    atlas = "WombatsObscure",
    pos = {x = 3, y = 0},
    rarity = 3,
    cost = 8,
    config = { extra = {Xmult = 5, Xchips = 5, Negative = false}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xchips}}
    end,

    set_sprites = function(self,card,front)
        card:set_eternal(true)
    end,

    calculate = function(self,card,context)
        if context.joker_main and not card.ability.extra.Negative then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                Xchip_mod = card.ability.extra.Xchips,
                colour = G.C.MULT
            }
        elseif context.joker_main and card.ability.extra.Negative then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult * -1,
                Xchip_mod = card.ability.extra.Xchips * -1,
                colour = G.C.MULT
            }
        end

        if context.end_of_round and G.GAME.blind.boss then
            card.ability.extra.Negative = true
        end
    end
}]]