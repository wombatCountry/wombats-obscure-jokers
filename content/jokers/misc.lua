SMODS.Joker {
    key = 'lily',
    atlas = "WombatsObscure",
    pos = {x = 3, y = 0},
    rarity = 3,
    cost = 8,
    attributes = {
        "Xmult",
        "Xchips",
        "boss_blind"
    },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = { extra = {Xmult = 5, Xchips = 5, Negative = false}},
    loc_vars = function(self,info_queue,center)
        if center.ability.extra.Negative == false then
            return {vars = {center.ability.extra.Xmult, center.ability.extra.Xchips, 'positive'}}
        else
            return {vars = {center.ability.extra.Xmult, center.ability.extra.Xchips, 'negative'}}
        end
    end,
    set_ability = function(self, card, initial, delay_sprites) --https://github.com/Balatro-Potato-Patch/Wormhole/blob/e013d44f0cd4b30facfdf21f70d3834fd62e00ff/content/thorn/joker.lua#L28
        card:set_eternal(true)
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                xmult = card.ability.extra.Xmult,
                xchips = card.ability.extra.Xchips,
            }
        end
        
        if context.final_scoring_step and card.ability.extra.Negative and not context.blueprint then
            return {
                card = card,
                Xmult = -1,
            }
        end

        if context.end_of_round and context.beat_boss then
            card.ability.extra.Negative = true
        end
    end
}

SMODS.Joker {
    key = "cradle",
    atlas = "WombatsObscure",
    pos = {x = 6, y = 1},
    rarity = 2,
    cost = 6,
    attributes = {
        "joker",
        "retrigger"
    },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {
            retriggers = 1,
            left = true
        }
    },
    loc_vars = function(self,info_queue,center)
        if not center.ability.extra.left then
            return {vars = {"Rightmost"}}
        else
            return {vars = {"Leftmost"}}
        end
    end,
    add_to_deck = function(self,card,from_debuff)
        card.children.center:set_sprite_pos{x = 7, y = 1}--got this line from sarcpot https://github.com/SarcPot/sarcpot-mod/blob/9cc3117940a62021df34c2ddf216c2195c001d30/joker/strange_fluid#L15
    end,
    calculate = function(self,card,context)
        --I got a lot of help from metanite64, sushii64, and srockw on the balatro discord for this one
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card and #G.jokers.cards == 5 then  --thanks to cryptid https://github.com/SpectralPack/Cryptid/blob/2d513624d8e2557c65ee2ec909f69b26bfbe6bbf/items/misc_joker.lua#L1639
            
            if context.blueprint then
                if card.ability.extra.left and context.other_card == G.jokers.cards[1] then
                    return {
                        repetitions = card.ability.extra.retriggers,
                        message = localize('k_again_ex'),
                        card = card,
                    }
                elseif card.ability.extra.left == false and context.other_card == G.jokers.cards[5] then
                    return {
                        repetitions = card.ability.extra.retriggers,
                        message = localize('k_again_ex'),
                        card = card,
                    }
                end
            end
        
            if card.ability.extra.left and context.other_card == G.jokers.cards[1] then
                card.ability.extra.left = false
                return {
                    repetitions = card.ability.extra.retriggers,
                    message = localize('k_again_ex'),
                    card = card,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                card.children.center:set_sprite_pos{x = 8, y = 1}
                                return true 
                            end
                        }))
                    end
                }
            elseif card.ability.extra.left == false and context.other_card == G.jokers.cards[5] then
                card.ability.extra.left = true
                return {
                    repetitions = card.ability.extra.retriggers,
                    message = localize('k_again_ex'),
                    card = card,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                card.children.center:set_sprite_pos{x = 7, y = 1}
                                return true 
                            end
                        }))
                    end
                }
            end
        end
    end
}