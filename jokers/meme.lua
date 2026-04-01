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
    loc_txt = {
        name= "The Vegeta",
        text = {
            "Gains {C:chips}#2#{} chips when cards are destroyed",
            "Loses {C:chips}#3#{} chips when cards are added to your deck",
            "{C:inactive}(Currently +{C:chips}#1#{C:inactive} chips)"
        }
    },
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
        if context.joker_main then
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
    loc_txt = {
        name= "Couscous Madame",
        text = {
            "When blind is selected,",
            "self destruct and create",
            "a random joker"
        }
    },
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
            SMODS.destroy_cards(card, nil, nil, true)
            SMODS.add_card{ set = "Joker"}
            return {
                card = card,
                message = "Couscous Madame!",
            }
        end
    end
}

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
    loc_txt = {
        name= "Mall Wins For Now",
        text = {
            "While owned, half off in shop.",
            "{C:green}#1# in #2#{} chance to self destruct",
            "and create a Splash at the end of each shop"
        }
    },
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
                SMODS.destroy_cards(card, nil, nil, true)
                SMODS.add_card{ set = "Joker", key = "j_splash"}
                
                return {
                    card = card,
                    message = "Water Always Comes Out On Top!",
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'brandon',
    loc_txt = {
        name= "Gambling City",
        text = {
            "{C:chips}+#1#{} chips and earn {C:money}$#2#{}",
            "if played hand contains exactly 2 cards"
        }
    },
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
    loc_txt = {
        name= "Peak Gambler Performance",
        text = {
            "All scoring Jacks go up 1 rank",
            "All scoring Kings go down 1 rank"
        }
    },
    atlas = "WombatsObscure",
    pos = {x = 0, y = 1},
    rarity = 2,
    cost = 6,
    pools = {
        Meme = true
    },
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.scoring_hand and context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 13 then
                context.other_card:flip() --yoinked this line from revo's vault https://github.com/Cdrvo/Revos-Vault/blob/b722dc4de7240c43cb51144ac24536ae7ac37475/items/Jokers/1_commons.lua#L364
                assert(SMODS.modify_rank(context.other_card, -1))
                context.other_card:flip()
            end
            if context.other_card:get_id() == 11 then
                context.other_card:flip()
                assert(SMODS.modify_rank(context.other_card, 1))
                context.other_card:flip()
            end
        end
       --fun fact: the specific card I yoinked that line from, Do A Barrel Roll, is one of the cards I redid the art for!
       --The Balatro modding community is a small world, y'know?
    end
}

SMODS.Joker {
    key = 'speen',
    loc_txt = {
        name= "Power Of SPEEN",
        text = {
            "gains +{C:mult}#2#{} Mult when any card is flipped","resets at the end of the hand",
            "{C:inactive}(Currently +{C:mult}#1#{C:inactive} mult)"
        }
    },
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
        if context.modprefix_card_flipped then
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
	loc_txt = {
		name = 'Limited 3d',
		text = {
			"Retrigger second card in played hand.","{C:green}#1# in #2#{} chance to create a negative","duplicate at the start of each round"
		}
	},
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
                SMODS.add_card{ set = "Joker", edition = "e_negative", key = "j_woms-obsc_charming"}
                return {
                    card = card,
                    message = "Wow!",
                }
            end
        end
    end
}

SMODS.Joker {
    key = "borat_tepig",
    loc_txt = {
        name = 'Bikes Do So Much!',
        text = {
            "{X:mult,C:white}x#1#{} mult if scoring hand contains a pair.", "{X:mult,C:white}x#2#{} mult if scoring hand contains two pair"
        }
    },
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