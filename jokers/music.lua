SMODS.Joker {
    key = 'limbo',
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

SMODS.Joker {
    key = 'lilico',
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
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'lilico')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                        return true 
                    end
                }))
            elseif pseudorandom('lilico') < G.GAME.probabilities.normal / card.ability.extra.odds2 then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'lilico')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                        return true 
                    end
                }))
            end
        end
    end
}

SMODS.Joker {
    key = 'last_man',
    atlas = "WombatsObscure",
    pos = {x = 0, y = 2},
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    config = { extra = {odds = 2, chips = 0}},
    loc_vars = function(self,info_queue,center)
        return {vars = { (G.GAME.probabilities.normal or 1), center.ability.extra.odds, center.ability.extra.chips}}
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.individual and context.other_card:is_suit('Hearts', nil, true) then
            if pseudorandom('last_man') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local chips = 0
                chips = chips + context.other_card.base.nominal --https://github.com/Balatro-Potato-Patch/Wormhole/blob/3927685d67f9755f5d42187bcc086faeb20cd10a/content/Hedonia/jokers.lua#L189
                chips = chips + context.other_card.ability.perma_bonus
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        card.ability.extra.chips = card.ability.extra.chips + chips
                        return true
                    end
                }))
                SMODS.destroy_cards(context.other_card)
            end
        end
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips
            }
        end
    end
}

SMODS.Joker {
    key = 'every',
    atlas = "WombatsObscure",
    pos = {x = 1, y = 2},
    rarity = 1,
    cost = 5,
    blueprint_compat = false,
    config = { extra = {chips = 0, chip_gain = 5}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.chip_gain}}
    end,
    calculate = function(self,card,context)
        if context.before and not context.blueprint then
            local count = 0
            for i, scored_card in ipairs(context.scoring_hand) do
                if next(SMODS.get_enhancements(scored_card)) and not scored_card.debuff then --https://github.com/nh6574/VanillaRemade/blob/806b348263aa3eab4a09388a394f4e6b4bb1d16e/src/jokers.lua#L1859
                    count = count + 1
                end
            end
            if count > 0 then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain * count
                return {
                    message = 'Upgraded!',
                    color = G.C.CHIPS
                }
            end
        end
        if context.joker_main then
            local all_diamonds = true
            for i, played_card in ipairs(G.play) do
                if not played_card:is_suit('Diamonds', nil, true) then
                    all_diamonds = false
                    break
                end
            end

            if all_diamonds then
                return {
                    chip_mod = card.ability.extra.chips,
                    message = '+' .. card.ability.extra.chips,
                    colour = G.C.CHIPS
			    }
            end
        end
    end
}

SMODS.Joker {
    key = 'swords',
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
                return {
                    message = 'Upgraded!',
				    colour = G.C.MULT,
                    card = self,
                    func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                            return true 
                        end
                    }))
                end
                }

            end
        end
        if context.end_of_round and context.game_over == false then
            card.ability.extra.Xmult = 1
        end
    end
}

SMODS.Joker {
    key = 'ends',
    atlas = "WombatsObscure",
    pos = {x = 9, y = 1},
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    config = { extra = {odds = 3}},
    loc_vars = function(self,info_queue,center)
        return {vars = { (G.GAME.probabilities.normal or 1), center.ability.extra.odds}}
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.hand and context.individual and not context.end_of_round and context.other_card:is_suit('Clubs', nil, true) and not context.other_card.edition --[[shoutout borb43 on the discord]] then
                    context.other_card:set_edition(SMODS.poll_edition{key = "woms-obsc_ends", guaranteed = true}, true) --got this from vanilla remade https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/spectrals.lua#L268
            return {
                message = "Upgraded!"
            }
        end
        if context.cardarea == G.play and context.individual and pseudorandom('ends') < G.GAME.probabilities.normal / card.ability.extra.odds and context.other_card:is_suit('Clubs', nil, true) and context.other_card.edition then
            SMODS.destroy_cards(context.other_card)
            return {
                message = "Everything Ends!",
            }
        end
    end
}