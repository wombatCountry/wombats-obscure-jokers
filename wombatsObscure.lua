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
    config = { extra = {Xmult = 1, Xmult_gain = 1}},
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
            "Gains {C:chips}#2#{} chips when cards are destroyed",
            "Loses {C:chips}#3#{} chips when cards are added to your deck",
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
            local cards = 0
            for k, val in ipairs(context.removed) do
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
    config = { extra = {chips = 0, chip_gain = 20, chip_loss = 40}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.chip_gain, center.ability.extra.chip_loss}}
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            --I admit I took this code from the example joker mod
            G.E_MANAGER:add_event(Event({
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
            }))
            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, nil)
                card:add_to_deck()
                G.jokers:emplace(card)
                card:start_materialize()
                G.GAME.joker_buffer = 0
            
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

--[[ Broken Joker based on SCP 001 Lily's Proposal. After failing to make it work for a while 
    I realized that it was just a motivation-drainer that probably wasn't even fun to play 
    with, and I scrapped it in favor of focusing on the rest of the mod

SMODS.Joker {
    key = 'lily',
    loc_txt = {
        name= "The World Gone Beautiful",
        text = {
            "{X:mult,C:white}x#1#{} mult and {X:chips,C:white}x#2#{} chips.",
            "Values become negative after defeating the boss blind"
        }
    },
    atlas = "WombatsObscure",
    pos = {x = 3, y = 0},
    rarity = 3,
    cost = 8,
    config = { extra = {Xmult = 5, Xchips = 5}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xchips}}
    end,
    calculate = function(self,card,context)
        if context.added_to_deck then
            card.ability.eternal = true
        end
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                Xchip_mod = card.ability.extra.Xchips,
                message = 'Beautiful!',
                colour = G.C.MULT
            }
        end

        if context.end_of_round and G.GAME.blind.boss then

            if context.other_joker then
			return {
				G.E_MANAGER:add_event(Event({
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
                }))
			}
		    end
        end
    end
}
]]

SMODS.Joker {
    key = 'mall',
    loc_txt = {
        name= "Mall Wins For Now",
        text = {
            "Gain a coupon tag at the end of each round",
            "{C:green}#1# in #2#{} chance to self destruct",
            "and create a Splash at the end of each shop"
        }
    },
    atlas = "WombatsObscure",
    pos = {x = 8, y = 0},
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    config = { extra = {odds = 2}},
    loc_vars = function(self,info_queue,center)
        return {vars = { (G.GAME.probabilities.normal or 1), center.ability.extra.odds}}
    end,
    calculate = function(self,card,context)

        if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
            add_tag(Tag('tag_coupon'))
        end
        
        --[[    broken alt function: half off in  the shop. I couldn't get it to work, and after a while, 
                I decided the new tag ability is a little more mall-like (free samples as opposed to flash 
                sales) and it would mean I could wrap up the update and move on with this mod

        --shoutout somethingcom515 on Discord for halping with this one
        add_to_deck = function (self, card, from_debuff)
            G.GAME.discount_percent = G.GAME.discount_percent / 2
        end

        remove_from_deck = function (self, card, from_debuff)
            G.GAME.discount_percent = G.GAME.discount_percent * 2
        end]]

        if context.ending_shop then
            if pseudorandom('mall') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
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
                }))
                local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    card:start_materialize()
                    G.GAME.joker_buffer = 0
                
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
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.scoring_hand and context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 13 then
                context.other_card:flip() --yoinked this line from revo's vault
                assert(SMODS.modify_rank(context.other_card, -1))
                context.other_card:flip()
            end
            if context.other_card:get_id() == 11 then
                context.other_card:flip()
                assert(SMODS.modify_rank(context.other_card, 1))
                context.other_card:flip()
            end
        end
       --fun fact: the specific card I yoinked that line  from, Do A Barrel Roll, is one of the cards I redid the art for!
       --The Balatro modding community is a small world, y'know?
    end
}

SMODS.Joker {
    key = 'lilico',
    loc_txt = {
        name= "Lilico",
        text = {
            "{C:green}#1# in #2#{} chance to create a {C:tarot}tarot{}",
            "card when a consumable is used",
            "if not, {C:green}#1# in #3#{} chance to",
            "create a {C:spectral}spectral{} card instead"
        }
    },
    atlas = "WombatsObscure",
    pos = {x = 1, y = 1},
    rarity = 1,
    cost = 4,
    blueprint_compat = false,
    config = { extra = {odds1 = 3, odds2 = 10}},
    loc_vars = function(self,info_queue,center)
        return {vars = { (G.GAME.probabilities.normal or 1), center.ability.extra.odds1, center.ability.extra.odds2}}
    end,
    calculate = function(self,card,context)
        if context.using_consumeable and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            flag = true
            if pseudorandom('lilico') < G.GAME.probabilities.normal / card.ability.extra.odds1 then
                local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'lilico')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    G.GAME.consumeable_buffer = 0
                
                return {
                    card = card,
                    message = "When you tell it to!",
                }
            elseif pseudorandom('lilico') < G.GAME.probabilities.normal / card.ability.extra.odds2 then
                local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'lilico')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    G.GAME.consumeable_buffer = 0
                
                return {
                    card = card,
                    message = "I wanna go out with a bang!",
                }
            end
        end
    end
}