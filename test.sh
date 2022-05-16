files=(ast helper lexer parser rules shunting stack tabular tokens)

compile ()
{
    nim c test/test_${1}.nim
}

run ()
{
    echo -e "\n---------- ${1} ----------"
    ./test/test_${1}
}

remove ()
{
    rm ./test/test_${1}

}

# Compile All
for file in ${files[@]} 
do
    compile $file
done

clear

# Run All
for file in ${files[@]}
do
    run $file
done

# Remove all
for file in ${files[@]}
do
    remove $file
done