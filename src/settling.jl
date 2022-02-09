module settling
using Dictionaries
using Statistics

payments = Dictionary(["Arttu", "Dani", "Elias", "Eva", "Janita", "Jessica", "Julia", "Miro", "Olli"], [100.37, 78.57, 98.57, 78.57, 50, 114.57, 237.69, 78.57, 50])
owes = payments .- mean(payments)

display(owes)
actions = []

while true
    payer = findmin(owes)
    payee = findmax(owes)
    if abs(payer[1]) > abs(payee[1]); owes[payer[2]] += owes[payee[2]]; action = (payer[2], payee[2], owes[payee[2]]); owes[payee[2]] = 0;
    else owes[payee[2]] += owes[payer[2]]; action = (payer[2], payee[2], -owes[payer[2]]);  owes[payer[2]] = 0;
    end
    display(owes)
    push!(actions, action)
    if sum(map(abs, owes)) < 1; break
    end
end

print(actions)
end # module
