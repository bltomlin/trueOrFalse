mRANDOM=4096
responses=( "Perfect!" "Awesome!" "You are a genius!" "Wow!" "Wonderful!" )
score=10
count=0
date=$(date +%F)

# authenticates user

echo -e "Welcome to the True or False Game!\n"
  user_data=$(curl -s http://0.0.0.0:8000/download/file.txt)
  user=$( echo "$user_data" | sed 's/.*"username": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')
  password=$( echo "$user_data" | sed 's/.*"password": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')
  curl http://0.0.0.0:8000/login -u "${user,,}:$password" -sc cookie.txt &>/dev/null
  
# prints menu  
  
menu() {
    echo "0. Exit"
    echo "1. Play a game"
    echo "2. Display scores"
    echo "3. Reset scores"
    echo "Enter an option:"
    read -r option
}

play() {
  while true;
  
  # pulls cookie and parses question and answer
  
  do
    final_score=$(("$score" * "$count"))
    response=$( curl http://0.0.0.0:8000/game -sb cookie.txt)
    question=$( echo "$response" | sed 's/.*"question": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')
    answer=$( echo "$response" | sed 's/.*"answer": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')
    
    # logic for verifying correctness
    
    echo "$question"
    echo "True or False?" && read -r answer_user
      if [ "$answer" == "$answer_user" ]; then
        ((count++))
        indx=$((RANDOM%5))
        echo "${responses[$indx]}"
      else
        echo "Wrong answer, sorry!"
        echo "$name you have $count correct answer(s)."
        echo "Your score is $(( "$score" * "$count" )) points."
        printf "User: %s, Score: %d, Date: %s\n" "$name" "$final_score" "$date" >> scores.txt
        count=0
        break;
      fi
  done
}

# infinite loop menu and options until '0' or exit

while true;
do
  menu
  case $option in
  
      0 | 'quit')
          echo "See you later!"
          break;
          ;;
       
      # starts the game
      
      1)
        echo "What is your name?" && read -r name
        play;;
        
      # prints player scores   
        
      2)
        FILE=`find . -name 'scores.txt' -print -quit`
        if [ -n "$FILE" ]; then
            echo "Player scores"
            cat scores.txt
        else
            echo "File not found or no scores in it!"
        fi
        ;;
        
      # Reset the scores 
       
      3)
        FILE=`find . -name 'scores.txt' -print -quit`
        if [ -n "$FILE" ]; then
            rm . scores.txt
            echo "File deleted successfully!"
        else
            echo "File not found or no scores in it!"
        fi
        ;;
        
      # all other input  
        
      *)
        echo -e "Invalid option!\n";;
  esac
done
