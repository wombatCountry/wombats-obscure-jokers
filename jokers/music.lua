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
    blueprint_compat = true,
    config = { extra = {odds1 = 3, odds2 = 10}},
    loc_vars = function(self,info_queue,center)
        return {vars = { (G.GAME.probabilities.normal or 1), center.ability.extra.odds1, center.ability.extra.odds2}}
    end,
    calculate = function(self,card,context)
        if context.using_consumeable and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
    blueprint_compat = false,
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
    blueprint_compat = false,
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue + 1] = { key = 'tag_negative', set = 'Tag' } -- got a variant of this line from vanilla remade https://github.com/nh6574/VanillaRemade/blob/50d78c3990bc165ae05aeb1372d28a047580c506/src/jokers.lua#L2660
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
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