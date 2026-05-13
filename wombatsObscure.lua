SMODS.current_mod.optional_features = function()
    return {
        retrigger_joker = true
    }
end

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
        SMODS.calculate_context({womobsc_card_flipped = true, card = self})
    end
    return oldcardflip(self)
end

-- Got this from axyraandas https://github.com/TonyKrZa/BerryLegendaries/blob/99849e468f6a0e28928fb222905ab677947ec6c0/main.lua#L9
assert(SMODS.load_file('jokers/meme.lua', SMODS.current_mod.id))()
assert(SMODS.load_file('jokers/music.lua', SMODS.current_mod.id))()
assert(SMODS.load_file('jokers/misc.lua', SMODS.current_mod.id))()