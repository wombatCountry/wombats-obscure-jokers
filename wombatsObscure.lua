SMODS.current_mod.optional_features = function()
    return {
        retrigger_joker = true
    }
end

config = SMODS.current_mod.config

SMODS.Atlas {
	key = "WombatsObscure",
	path = "WombatsObscure.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "decks",
	path = "decks.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
    key = "modicon",
    path = "modicon.png",
    px = 34,
    py = 34,
}

SMODS.current_mod.config_tab = function()
	return {n = G.UIT.ROOT, config = {
		align = 'cm',
		padding = 0.1,
		colour = G.C.BLACK,
		r = 0.1,
		minw = 5,
		minh = 1,
	}, nodes = {
		{n = G.UIT.R,
		config = {
			align = 'tm',
		},
		nodes = {
			{n = G.UIT.T, config = {
				text = localize('womsobsc_config_restart'),
				colour = G.C.RED,
				scale = 0.3
			}},
		}},
		{n = G.UIT.R,
			nodes = {
				--https://github.com/Trif3ctal/Lucky-Rabbit/blob/8ccebcd33e24c28512f9fe300d50703bac391567/main.lua#L30
				create_toggle {
					label = localize('womsobsc_config_13'),
					ref_table = config,
					ref_value = "thirteen_jokers"
				},
				create_toggle {
					label = localize('womsobsc_config_dorphis'),
					ref_table = config,
					ref_value = "dorphis"
				}
			}}
	}}
end

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
assert(SMODS.load_file('content/pools.lua', SMODS.current_mod.id))()

assert(SMODS.load_file('content/jokers/meme.lua', SMODS.current_mod.id))()
assert(SMODS.load_file('content/jokers/music.lua', SMODS.current_mod.id))()
assert(SMODS.load_file('content/jokers/misc.lua', SMODS.current_mod.id))()

assert(SMODS.load_file('content/decks.lua', SMODS.current_mod.id))()