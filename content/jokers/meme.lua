if config.dorphis then
    SMODS.Joker {
        key = 'dorphis',
        atlas = "WombatsObscure",
        pos = {x = 2, y = 0},
        rarity = 1,
        cost = 2,
        pools = {
            ["Meme"] = true
        },
        attributes = {
            "xmult",
            "xchips"
        },
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
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
                    Xchips = card.ability.extra.Xchips,
                    Xmult = card.ability.extra.Xmult,
                    message = localize('womsobsc_dorphis'),
                }
            end
        end
    }
end

SMODS.Joker {
    key = 'vegeta',
    atlas = "WombatsObscure",
    pos = {x = 5, y = 0},
    rarity = 1,
    cost = 3,
    pools = {
        ["Meme"] = true
    },
    attributes = {
        "chips",
        "scaling"
    },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {chips = 0, chip_gain = 15, chip_loss = 20}},
    loc_vars = function(self,info_queue,center)
        if center.ability.extra.chips >= 0 then
            return {vars = {'+' .. center.ability.extra.chips, center.ability.extra.chip_gain, center.ability.extra.chip_loss}}
        else
            return {vars = {center.ability.extra.chips, center.ability.extra.chip_gain, center.ability.extra.chip_loss}}
        end
    end,
    calculate = function(self,card,context)
        if context.joker_main and card.ability.extra.chips ~= 0 then
            return {
                card = card,
                chips = card.ability.extra.chips
            }
        end

        if context.remove_playing_cards and not context.blueprint then
            local cards = 0
            for i, v in ipairs(context.removed) do
                cards = cards + 1
            end
            card.ability.extra.chips = card.ability.extra.chips + cards*card.ability.extra.chip_gain
            return {
                message = localize('k_upgrade_ex'),
            }
        end

        if context.playing_card_added and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips - #context.cards*card.ability.extra.chip_loss
            return {
                message = localize('womsobsc_drat'),
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
        ["Meme"] = true
    },
    attributes = {
        "generation"
    },
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    config = { extra = {chips = 0, chip_gain = 20, chip_loss = 40}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.chip_gain, center.ability.extra.chip_loss}}
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            return {
                card = card,
                message = localize('womsobsc_couscous'),
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            SMODS.destroy_cards(card, nil, nil, true)
                            SMODS.add_card{set = "Joker", key = get_meme_joker()}
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
        ["Meme"] = true
    },
    attributes = {
        "xchips",
        "hand_type"
    },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {Xchips = 2}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xchips}}
    end,
    calculate = function(self,card,context)
        if context.joker_main and G.GAME.hands[context.scoring_name].played == 1 then
            genderAtBirth = pseudorandom('fankid',0,3)
            if genderAtBirth == 2 then
                return {
                    card = card,
                    xchips = card.ability.extra.Xchips,
                    xchip_message = {message = localize('womsobsc_baby_b'), colour = G.C.BLUE}
                }
            else
                return {
                    card = card,
                    xchips = card.ability.extra.Xchips,
                    xchip_message = {message = localize('womsobsc_baby_g'), colour = G.C.RED}
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
        ["Meme"] = true
    },
    attributes = {
        "generation",
        "chance",
        "passive"
    },
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
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
                    message = localize('womsobsc_mall'),
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
        ["Meme"] = true
    },
    attributes = {
        "chips",
        "economy"
    },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {chips = 100, payout = 5}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.payout}}
    end,
    calculate = function(self,card,context)
        if context.joker_main and #context.full_hand == 2 then
            ease_dollars(card.ability.extra.payout)
            return {
                card = card,
                chips = card.ability.extra.chips,
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
        ["Meme"] = true
    },
    attributes = {
        "rank",
        "king",
        "jack"
    },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self,card,context)
        --used this card a bunch https://github.com/nh6574/VanillaRemade/blob/abd75789ff9711a83ffbe4bfbfeb63c44a92b35b/src/jokers.lua#L2097
        if context.before then
            for i, scored_card in ipairs(context.scoring_hand) do
                if scored_card:get_id() == 13 then
                    -- got the 3 event trick from here: https://github.com/nh6574/VanillaRemade/blob/ebf57c7441251ecafac257c2c1205a5cce05e5cf/src/tarots.lua#L697
                    G.E_MANAGER:add_event(Event({
                        delay = 1.2,
                        func = function()
                            scored_card:flip() --yoinked this line from revo's vault https://github.com/Cdrvo/Revos-Vault/blob/b722dc4de7240c43cb51144ac24536ae7ac37475/items/Jokers/1_commons.lua#L364
                            return true 
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        delay = 0.4,
                        func = function()
                            assert(SMODS.modify_rank(scored_card, -1))
                            play_sound('timpani')
                            return true 
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        delay = 1.2,
                        func = function()
                            scored_card:flip()
                            return true 
                        end
                    }))
                end
                if scored_card:get_id() == 11 then
                    G.E_MANAGER:add_event(Event({
                        delay = 1.2,
                        func = function()
                            scored_card:flip()
                            return true 
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        delay = 0.4,
                        func = function()
                            assert(SMODS.modify_rank(scored_card, 1))
                            play_sound('timpani')
                            return true 
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        delay = 1.2,
                        func = function()
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
        ["Meme"] = true
    },
    attributes = {
        "mult",
        "scaling"
    },
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {mult = 0, multMod = 0.3}},
    loc_vars = function(self,info_queue,center)
        return {vars = { center.ability.extra.mult, center.ability.extra.multMod}}
    end,
    calculate = function(self,card,context)
        if context.womobsc_card_flipped then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multMod
        end
        if context.joker_main then
			return {
				mult = card.ability.extra.mult,
                xchip_message = {message = localize('womsobsc_speen')}
			}
		end
        if context.end_of_round and not context.game_over then
            card.ability.extra.mult = 0
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
        ["Meme"] = true
    },
    attributes = {
        "retrigger",
        "chance",
        "generation"
    },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
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
                message = localize('womsobsc_charm'),
            }
        end
        if context.setting_blind and not context.blueprint then
            if pseudorandom('charming') < G.GAME.probabilities.normal / card.ability.extra.odds then
                -- Thanks to nh6574, bepisfever, and theastra_ in the Balatro Discord for the help with this next line!
                return {
                    card = card,
                    message = localize('womsobsc_wow'),
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
        ["Meme"] = true
    },
    attributes = {
        "hand_type",
        "xmult"
    },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
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
                xmult = card.ability.extra.Xmult2,
                xmult_message = {message = localize('womsobsc_wife')}
            }
        elseif context.joker_main and next(context.poker_hands["Pair"]) then
            return {
                card = card,
                xmult = card.ability.extra.Xmult1,
                xmult_message = {message = localize('womsobsc_wawa')}
            }
        end
    end
}