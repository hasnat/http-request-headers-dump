README.md


echo "Let's try to create a type writer text rapidly" | sed 's/./&\n/g' | while read p; do r=$(seq 1 3 5| shuf | head -1); echo {\\k$r}$p; done | tr -d '\n' | sed 's/}{/} {/g'