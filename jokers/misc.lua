--[[ Broken Joker based on SCP 001 Lily's Proposal. After failing to make it always have an 
    eternal sticker, I realized that it was just a motivation-drainer that probably wasn't 
    even fun to play with, and I scrapped it in favor of focusing on the rest of the mod]]

SMODS.Joker {
    key = 'lily',
    atlas = "WombatsObscure",
    pos = {x = 3, y = 0},
    rarity = 3,
    cost = 8,
    config = { extra = {Xmult = 5, Xchips = 5, Negative = false}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xchips}}
    end,

    set_ability = function(self, card, initial, delay_sprites) --https://github.com/Balatro-Potato-Patch/Wormhole/blob/e013d44f0cd4b30facfdf21f70d3834fd62e00ff/content/thorn/joker.lua#L28
        card:set_eternal(true)
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                Xchip_mod = card.ability.extra.Xchips,
                colour = G.C.MULT,
                message = 'Beautiful!'
            }
        end
        
        if context.final_scoring_step and card.ability.extra.Negative then
            return {
                card = card,
                Xmult_mod = -1,
                colour = G.C.MULT,
                message = 'The End!'
            }
        end

        if context.end_of_round and G.GAME.blind.boss then
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
    blueprint_compat = true,
    config = { extra = {
        retriggers = 1,
        left = true
    }
    },
    add_to_deck = function(self,card,from_debuff)
        card.children.center:set_sprite_pos{x = 7, y = 1}--got this line from sarcpot https://github.com/SarcPot/sarcpot-mod/blob/9cc3117940a62021df34c2ddf216c2195c001d30/joker/strange_fluid#L15
    end,
    calculate = function(self,card,context)
        --I got a lot of help from metanite64, sushii64, and srockw on the balatro discord for this one
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card and #G.jokers.cards == 5 then  --thanks to cryptid https://github.com/SpectralPack/Cryptid/blob/2d513624d8e2557c65ee2ec909f69b26bfbe6bbf/items/misc_joker.lua#L1639
            if card.ability.extra.left and context.other_card == G.jokers.cards[1] then
                print('L')
                card.ability.extra.left = false
                return {
                    repetitions = card.ability.extra.retriggers,
                    message = 'Again!',
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
                print('R')
                card.ability.extra.left = true
                return {
                    repetitions = card.ability.extra.retriggers,
                    message = 'Again!',
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