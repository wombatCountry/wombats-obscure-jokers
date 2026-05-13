SMODS.Joker {
	key = 'dorphis',
    atlas = "WombatsObscure",
    pos = {x = 2, y = 0},
    rarity = 1,
    cost = 2,
    pools = {
        Meme = true
    },
    blueprint_compat = false,
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
    key = 'vegeta',
    atlas = "WombatsObscure",
    pos = {x = 5, y = 0},
    rarity = 1,
    cost = 3,
    pools = {
        Meme = true
    },
    blueprint_compat = false,
    config = { extra = {chips = 0, chip_gain = 15, chip_loss = 20}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.chip_gain, center.ability.extra.chip_loss}}
    end,
    calculate = function(self,card,context)
        if context.joker_main and card.ability.extra.chips ~= 0 then
            return {
                card = card,
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end

        if context.remove_playing_cards then
            local cards = 0
            for i, v in ipairs(context.removed) do
                cards = cards + 1
            end
            card.ability.extra.chips = card.ability.extra.chips + cards*card.ability.extra.chip_gain
            return {
                message = 'Upgraded!',
                colour = G.C.CHIPS
            }
        end

        if context.playing_card_added then
            card.ability.extra.chips = card.ability.extra.chips - #context.cards*card.ability.extra.chip_loss
            return {
                message = 'Drat!',
                colour = G.C.CHIPS
            }
        end
    end
}

SMODS.Joker {
    key = 'couscous',
    atlas = "WombatsObscure",
    pos = {x = 6, y = 0},
    rarity = 1,
    cost = 3,
    pools = {
        Meme = true
    },
    blueprint_compat = false,
    config = { extra = {chips = 0, chip_gain = 20, chip_loss = 40}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.chip_gain, center.ability.extra.chip_loss}}
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            return {
                card = card,
                message = "Couscous Madame!",
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            SMODS.destroy_cards(card, nil, nil, true)
                            SMODS.add_card{ set = "Joker"}
                            return true 
                        end
                    }))
                end
            }
        end
    end
}

SMODS.Joker {
    key = 'jimbunculus',
    atlas = "WombatsObscure",
    pos = {x = 7, y = 0},
    rarity = 1,
    cost = 4,
    pools = {
        Meme = true
    },
    blueprint_compat = true,
    config = { extra = {Xchips = 2}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xchips}}
    end,
    calculate = function(self,card,context)
        if context.joker_main and G.GAME.hands[context.scoring_name].played == 1 then
            genderAtBirth = math.random(0,3)
            if genderAtBirth == 2 then
                return {
                    card = card,
                    Xchip_mod = card.ability.extra.Xchips,
                    message = "It's A Boy!",
                    colour = G.C.CHIPS
                }
            else
                return {
                    card = card,
                    Xchip_mod = card.ability.extra.Xchips,
                    message = "It's A Girl!",
                    colour = G.C.MULT
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'mall',
    atlas = "WombatsObscure",
    pos = {x = 8, y = 0},
    rarity = 3,
    cost = 8,
    pools = {
        Meme = true
    },
    blueprint_compat = false,
    config = { extra = {odds = 2}},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_splash
        return {vars = { (G.GAME.probabilities.normal or 1), center.ability.extra.odds}}
    end,
    --shoutout somethingcom515 on Discord for halping with this one
    add_to_deck = function (self, card, from_debuff)
        G.GAME.discount_percent = G.GAME.discount_percent + 50
    end,

    remove_from_deck = function (self, card, from_debuff)
        G.GAME.discount_percent = G.GAME.discount_percent - 50
    end,
    
    calculate = function(self,card,context)
        
        if context.ending_shop then
            if pseudorandom('mall') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    card = card,
                    message = "Water Always Comes Out On Top!",
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                SMODS.destroy_cards(card, nil, nil, true)
                                SMODS.add_card{ set = "Joker", key = "j_splash"}
                                return true 
                            end
                        }))
                    end
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'brandon',
    atlas = "WombatsObscure",
    pos = {x = 9, y = 0},
    rarity = 1,
    cost = 4,
    pools = {
        Meme = true
    },
    blueprint_compat = true,
    config = { extra = {chips = 100, payout = 5}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.payout}}
    end,
    calculate = function(self,card,context)
        if context.joker_main and #context.full_hand == 2 then
            ease_dollars(card.ability.extra.payout)
            return {
                card = card,
                chip_mod = card.ability.extra.chips,
                message = 'What is this?',
                colour = G.C.CHIPS
            }
        end
        
    end
}

SMODS.Joker {
    key = 'femboy',
    atlas = "WombatsObscure",
    pos = {x = 0, y = 1},
    rarity = 2,
    cost = 6,
    pools = {
        Meme = true
    },
    blueprint_compat = false,
    calculate = function(self,card,context)
        --used this card a bunch https://github.com/nh6574/VanillaRemade/blob/abd75789ff9711a83ffbe4bfbfeb63c44a92b35b/src/jokers.lua#L2097
        if context.before and not context.blueprint then
            for i, scored_card in ipairs(context.scoring_hand) do
                if scored_card:get_id() == 13 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:flip() --yoinked this line from revo's vault https://github.com/Cdrvo/Revos-Vault/blob/b722dc4de7240c43cb51144ac24536ae7ac37475/items/Jokers/1_commons.lua#L364
                            assert(SMODS.modify_rank(scored_card, -1))
                            play_sound('timpani')
                            scored_card:flip()
                            return true 
                        end
                    }))
                end
                if scored_card:get_id() == 11 then
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            scored_card:flip()
                            assert(SMODS.modify_rank(scored_card, 1))
                            play_sound('timpani')
                            scored_card:flip()
                            return true 
                        end
                    }))
                end
            end
        end
       --fun fact: the specific card I yoinked that line from, Do A Barrel Roll, is one of the cards I redid the art for!
       --The Balatro modding community is a small world, y'know?
    end
}

SMODS.Joker {
    key = 'speen',
    atlas = "WombatsObscure",
    pos = {x = 4, y = 1},
    rarity = 1,
    cost = 5,
    pools = {
        Meme = true
    },
    blueprint_compat = false,
    config = { extra = {mult = 0, multMod = 0.2}},
    loc_vars = function(self,info_queue,center)
        return {vars = { center.ability.extra.mult, center.ability.extra.multMod}}
    end,
    calculate = function(self,card,context)
        if context.womobsc_card_flipped then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multMod
        end
        if context.joker_main then
            local temp = card.ability.extra.mult
            card.ability.extra.mult = 0
			return {
				mult_mod = temp,
				message = 'SPEEEEEN!',
                colour = G.C.MULT
			}
		end
    end
}

SMODS.Joker {
	key = "charming",
    atlas = "WombatsObscure",
    pos = {x = 2, y = 1},
    soul_pos = {x = 3, y = 1},
    rarity = 1,
    cost = 5,
    pools = {
        Meme = true
    },
    blueprint_compat = false,
    config = { extra = {odds = 10}},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return {vars = { (G.GAME.probabilities.normal or 1), center.ability.extra.odds}}
    end,
    calculate = function(self,card,context)
        --Got this from Vanilla Remade: https://github.com/nh6574/VanillaRemade/tree/main
        if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[2] then
            return {
                repetitions = 1,
                message = "So Charming!"
            }
        end
        if context.setting_blind then
            if pseudorandom('charming') < G.GAME.probabilities.normal / card.ability.extra.odds then
                -- Thanks to nh6574, bepisfever, and theastra_ in the Balatro Discord for the help with this next line!
                return {
                    card = card,
                    message = "Wow!",
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                SMODS.add_card{ set = "Joker", edition = "e_negative", key = "j_womsobsc_charming"}
                                return true 
                            end
                        }))
                    end
                }
            end
        end
    end
}

SMODS.Joker {
    key = "boratTepig",
    atlas = "WombatsObscure",
    pos = { x = 5, y = 1 },
    rarity = 3,
    cost = 8,
    pools = {
        Meme = true
    },
    blueprint_compat = true,
    config = { extra = {
        Xmult1 = 1.5,
        Xmult2 = 2.5
    }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult1, center.ability.extra.Xmult2}}
    end,
    calculate = function(self,card,context)
        if context.joker_main and next(context.poker_hands["Two Pair"]) then -- learned how to fix this line from, once again, revo's vault https://github.com/Cdrvo/Revos-Vault/blob/b722dc4de7240c43cb51144ac24536ae7ac37475/items/Jokers/3_rares.lua#L567
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult2,
                message = 'My Wife!',
            }
        elseif context.joker_main and next(context.poker_hands["Pair"]) then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult1,
                message = 'Wawa Wuwa!',
            }
        end
    end
}