SMODS.Atlas {
	key = "WombatsObscure",
	path = "WombatsObscure.png",
	px = 71,
	py = 95
}

SMODS.Joker {
	key = 'dorphis',
	loc_txt = {
		name = 'The Dorphis',
		text = {
			"{X:mult,C:white}x#1#{} Mult, {X:chips,C:white}x#2#{} Chips"
		}
	},
    atlas = "WombatsObscure",
    pos = {x = 2, y = 0},
    rarity = 1,
    cost = 2,
    config = { extra = {
        Xmult = 1,
        Xchips = 1
    }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xchips}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                Xchip_mod = card.ability.extra.Xchips,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'Heck Yeah!',
            }
        end
    end
}

SMODS.Joker {
    key = 'swords',
    loc_txt = {
        name= "Swords",
        text = {
            "Spades held in hand or in",
            "played hand add {X:mult,C:white}x#2#{} mult",
            "Resets at the end of the round",
            "{C:inactive}(Currently {X:mult,C:white}x#1#{C:inactive} mult)"
        }
    },
    atlas = "WombatsObscure",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    rarity = 4,
    cost = 20,
    config = { extra = {Xmult = 1, Xmult_gain = 0.75}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_gain}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end

        if ( context.cardarea == G.hand or context.cardarea == G.play ) and context.individual and not context.end_of_round then
            if context.other_card:is_suit('Spades', nil, true) then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                return {
                    message = 'Upgraded!',
				    colour = G.C.MULT,
                    card = card
                }

            end
        end
        if context.end_of_round and context.game_over == false then
            card.ability.extra.Xmult = 1
        end
    end
}

SMODS.Joker {
    key = 'limbo',
    loc_txt = {
        name= "Limbo",
        text = {
            "Each joker gives +{C:chips}#1#{} chips",
            "Creates a {C:attention}negative tag{}",
            "after {C:attention}#3# shop rerolls",
            "{C:inactive}(Currently {C:attention}#2#/#3#{}{C:inactive})"
        }
    },
    atlas = "WombatsObscure",
    pos = {x = 4, y = 0},
    rarity = 1,
    cost = 5,
    config = { extra = {chips = 10, cooldown = 0, max_cooldown = 5}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.cooldown, center.ability.extra.max_cooldown}}
    end,
    calculate = function(self,card,context)
        if context.other_joker then
			return {
				chip_mod = card.ability.extra.chips,
				message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS
			}
		end
        if context.reroll_shop then
            card.ability.extra.cooldown = card.ability.extra.cooldown + 1
            if card.ability.extra.cooldown < card.ability.extra.max_cooldown then
                return {
                    message = 'Close The World!'
                }
            else if card.ability.extra.cooldown == card.ability.extra.max_cooldown then
                card.ability.extra.cooldown = 0
                add_tag(Tag('tag_negative'))
                return {
                    message = 'Open The Next!'
                }
            end
            end
        end
    end
}

SMODS.Joker {
    key = 'vegeta',
    loc_txt = {
        name= "The Vegeta",
        text = {
            "Gains +{C:chips}#2#{} chips when cards are destroyed",
            "Loses +{C:chips}#3#{} chips when cards are added to your deck",
            "{C:inactive}(Currently +{C:chips}#1#{C:inactive} chips)"
        }
    },
    atlas = "WombatsObscure",
    pos = {x = 5, y = 0},
    rarity = 1,
    cost = 3,
    config = { extra = {chips = 0, chip_gain = 15, chip_loss = 20}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.chip_gain, center.ability.extra.chip_loss}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end

        if context.remove_playing_cards then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
            return {
                message = 'Upgraded!',
                colour = G.C.CHIPS
            }
        end

        if context.playing_card_added then
            card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_loss
            return {
                message = 'Drat!',
                colour = G.C.CHIPS
            }
        end
    end
}

--[[SMODS.Joker {
    key = 'couscous',
    loc_txt = {
        name= "Couscous Madame",
        text = {
            "When blind is selected, self destruct and create a random joker"
        }
    },
    atlas = "WombatsObscure",
    pos = {x = 6, y = 0},
    rarity = 1,
    cost = 3,
    config = { extra = {chips = 0, chip_gain = 20, chip_loss = 40}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.chip_gain, center.ability.extra.chip_loss}}
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            --create random joker out of any joker
        end
    end
}]]

SMODS.Joker {
    key = 'jimbunculus',
    loc_txt = {
        name= "Jimbunculus",
        text = {
            "{X:chips,C:white}x#1#{} chips when a poker hand",
            "is played for the first time this run"
        }
    },
    atlas = "WombatsObscure",
    pos = {x = 7, y = 0},
    rarity = 1,
    cost = 4,
    config = { extra = {Xchips = 2}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xchips}}
    end,
    calculate = function(self,card,context)
        if context.joker_main and G.GAME.hands[context.scoring_name].played == 1 then
            return {
                card = card,
                Xchip_mod = card.ability.extra.Xchips,
                message = "It's A Boy!",
                colour = G.C.CHIPS
            }
        end
    end
}

--[[SMODS.Joker {
    key = 'lily',
    loc_txt = {
        name= "The World Gone Beautiful",
        text = {
            "{X:mult,C:white}x#1#{} mult and {X:chips,C:white}x#2#{} chips. Destroy all jokers after boss blind"
        }
    },
    atlas = "WombatsObscure",
    pos = {x = 3, y = 0},
    rarity = 3,
    cost = 0,
    config = { extra = {Xmult = 5, Xchips = 5}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xchips}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                Xchip_mod = card.ability.extra.Xchips,
                message = 'Beautiful!',
                colour = G.C.MULT
            }
        end

        if context.end_of_round and context.other_joker then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                blockable = false,
                func = function()
                    G.jokers:remove_card(card)
                    card:remove()
                    card = nil
                    return true;
                end
            }))
        end
    end
}]]