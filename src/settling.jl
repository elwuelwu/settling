module settling
using Dictionaries
using Statistics
using Random
using IterTools

# payments = Dictionary(["Arttu", "Dani", "Elias", "Eva", "Janita", "Jessica", "Julia", "Miro", "Olli"], [100.37, 78.57, 98.57, 78.57, 50, 114.57, 237.69, 78.57, 50])
payments = Dictionary()
for _ in 1:10
    insert!(payments, randstring(10), rand(1:10000))
end

owes = payments .- mean(payments)
inds = [a for a in keys(payments)]

#display(owes)
actions = []
amounts_of_actions = Dictionary(keys(payments), zeros(length(payments)))
partition = Set()
picked = []
#owesleft = copy(owes)
while length(setdiff(inds, picked)) > 1
    for subset in subsets(setdiff(inds, picked))
        if length(subset) < 2; continue; end
        if sum(getindices(owes, subset)) < 0.001
            push!(partition, subset)
            union!(picked, subset)
            print(subset)
            break
        end
    end
    if sum(getindices(owes, setdiff(inds, picked))) < 5
        union!(picked, setdiff(inds, picked))
        break
    end
end
#display(picked)
display(partition)

while true
    payer = findmin(owes)
    payee = findmax(owes)
    if abs(payer[1]) > abs(payee[1]); owes[payer[2]] += owes[payee[2]]; action = (payer[2], payee[2], owes[payee[2]]); owes[payee[2]] = 0;
    else owes[payee[2]] += owes[payer[2]]; action = (payer[2], payee[2], -owes[payer[2]]);  owes[payer[2]] = 0;
    end
    #display(owes)
    amounts_of_actions[payer[2]] += 1
    push!(actions, action)
    if sum(map(abs, owes)) < 1; break
    end
end

#display(actions)
#print(maximum(amounts_of_actions))
end # module
