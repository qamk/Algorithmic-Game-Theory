%Valuations for each advertiser
valuations = [1000000, 555710, 470400];
%click-through rates
ctr = [1, 0.55071, 0.4704];

%matrix of payoffs
payoffs = rand(6, 3);

for i = 1:3 
    for j = 1:3
        if i ~= j %avoid comparing a player with themself
            switch i %looking at player i
                case 1 %first player
                    bid = valuations(2)-1;
                    %calculate everyone's utility, populate the first row
                    payoffs(1, :) = calc_utility(bid,i,valuations,ctr);
                    
                    bid = valuations(3)-1;
                    %calculate everyone's utility, populate the second row
                    payoffs(2, :) = calc_utility(bid,i, valuations, ctr);
                case 2 %second player
                    bid = valuations(3)-1;
                    %calculate everyone's utility, populate the third row
                    payoffs(3, :) = calc_utility(bid,i, valuations, ctr);
                case 3 %third player
                    %calculate everyone's utility, populate the fourth row
                    payoffs(4, :) = calc_utility(bid,i, valuations, ctr);
            end
        end
    end
end

%Utility for p1, p2, p3
soc_opt_utility = [-1,-1,-1];
soc_opt_utility(1) = ctr(1) * (valuations(1) - valuations(2)); 
soc_opt_utility(2) = ctr(2) * (valuations(2) - valuations(3));
soc_opt_utility(3) = ctr(3) * valuations(3);

%populating the fifth row 
payoffs(5, :) = soc_opt_utility;

p3_p2_p1_utility = [-1, -1, -1];
p3_p2_p1_utility(1) = ctr(1) * (valuations(3) - (valuations(3)-1));
p3_p2_p1_utility(1) = ctr(3) * (valuations(3) - (valuations(3)-2));
p3_p2_p1_utility(1) = ctr(1) * valuations(3);

%populate the sixth row
payoffs(6, :) = soc_opt_utility;

%determine which utility is best 
player_max_utility = max(payoffs);

for n = 1:3
    [max_row max_col] = find(payoffs==player_max_utility(n),1);
    switch max_row
        case 1
            disp('Allocation: P2 -- Slot 1, P1 -- Slot 2, P3 -- Slot 3');
            soc_welfare = ctr(1) * valuations(2) + ctr(2) * valuations(1) + ctr(3) * valuations(3);
        case 2
            disp('Allocation: P2 -- Slot 1, P3 -- Slot 2, P1 -- Slot 3');
            soc_welfare = ctr(1) * valuations(2) + ctr(2) * valuations(3) + ctr(3) * valuations(1);
        case 3
            disp('Allocation: P1 -- Slot 1, P3 -- Slot 2, P2 -- Slot 3');
            soc_welfare = (ctr(1) * valuations(1)) + (ctr(2) * valuations(3)) + (ctr(3) * valuations(2));
        case 4
            disp('Allocation: P3 -- Slot 1, P1 -- Slot 2, P2 -- Slot 3');
            soc_welfare = ctr(1) * valuations(3) + ctr(2) * valuations(1) + ctr(3) * valuations(2);
        %case 5
            %disp('Allocation: P1 -- Slot 1, P2 -- Slot 2, P3 -- Slot 3');
            %soc_welfare = ctr(1) * valuations(1) + ctr(2) * valuations(2) + ctr(3) * valuations(3);
        case 6
            disp('Allocation: P3 -- Slot 1, P2 -- Slot 2, P1 -- Slot 3');
            soc_welfare = ctr(1) * valuations(3) + ctr(2) * valuations(2) + ctr(3) * valuations(1);
    end
end

price_of_anarchy = round(soc_welfare / 1527311.214,5);

disp(price_of_anarchy);

%Calculates the utility of each slot allocation
function utilities = calc_utility(bid,player, valuations, ctr)  
    utilities = [-1 -1 -1];
    final_bid = valuations;
    final_bid(player) = bid;
    %calculate each utility, put it in the vector
        if player ~=3
            if final_bid(1) > final_bid(2) && final_bid(2) > final_bid(3) %p1, p2, p3
               u1 = round(ctr(1) * (valuations(1) - final_bid(2)),0); %utility of the first player
               u2 = round(ctr(2) * (valuations(2) - final_bid(3)),0);
               u3 = round(ctr(3) * valuations(3),0);
            elseif final_bid(1) > final_bid(2) && final_bid(3) > final_bid(2) %p1, p3, p2
                u1 = round(ctr(1) * (valuations(1) - final_bid(3)),0);
                u3 = round(ctr(2) * (valuations(3) - final_bid(2)),0);
                u2 = round(ctr(3) * valuations(2),0);
            elseif final_bid(2) > final_bid(1) && final_bid(1) > final_bid(3) %p2, p1, p3
                u2 = round(ctr(1) * (valuations(2) - final_bid(1)),0);
                u1 = round(ctr(2) * (valuations(1) - final_bid(3)),0);
                u3 = round(ctr(3) * valuations(3),0);
            elseif final_bid(2) > final_bid(1) && final_bid(3) > final_bid(1) %p2, p3, p1
                u2 = round(ctr(1) * (valuations(2) - final_bid(3)),0);
                u3 = round(ctr(2) * (valuations(3) - final_bid(1)),0);
                u1 = round(ctr(3) * valuations(1),0);
            %else %p3, p2, p1
             %   u3 = ctr(1) * (valuation(3) - final_bid(2));
              %  u2 = ctr(2) * (valuation(2) - final_bid(1));
               % u1 = ctr(3) * valuation(1);
            end
        end
            %p3, p1, p2
    if player == 3     
        final_bid(1) = valuations(3)-1;
        final_bid(2) = valuations(3)-2;
        u3 = round(ctr(1) * (valuations(3) - final_bid(1)),0);
        u1 = round(ctr(2) * (valuations(1) - final_bid(2)),0);
        u2 = round(ctr(3) * valuations(2),0);
    end
        utilities(1) = u1;
        utilities(2) = u2;
        utilities(3) = u3;
end 
