using System;

namespace DiceOnAYacht
{
    class Program
    {
        static void Main()
        {
            Console.WriteLine(@"Hello!{0}Welcome to Dice on A Yacht!{0}{0}Let's start...{0}", Environment.NewLine);
            string playAgain = "Yes";
            while (playAgain.ToLower() == "y" || playAgain.ToLower() == "yes")
            {
                var gm = new GameMethods();
                var diceRolls = gm.RollDice();
                Console.WriteLine(@"Your dice rolls are: {0}", string.Join(", ", diceRolls));
                Console.ReadLine();
                var category = gm.GetSuggestion(diceRolls);
                Console.WriteLine(@"The best category for the highest score is: {0}", category);
                Console.ReadLine();
                var score = gm.GetScore(category, diceRolls);
                Console.WriteLine(@"Your score is: {0}!{1}", score, Environment.NewLine);
                Console.WriteLine("Would you like to play again? (y/n)");
                playAgain = Console.ReadLine();
            }
            Console.WriteLine("Thank you for playing!");
            Console.ReadLine();

        }
    }
}
