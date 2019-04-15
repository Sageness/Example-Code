using System;
using System.Linq;

namespace DiceOnAYacht
{
    internal class GameMethods
    {
        /// <summary>
        /// List of scoring categories.
        /// </summary>
        public enum Category
        {
            Ones,
            Twos,
            Threes,
            Fours,
            Fives,
            Sixes,
            Sevens,
            Eights,
            ThreeOfAKind,
            FourOfAKind,
            FullHouse,
            SmallStraight,
            LargeStraght,
            AllDifferent,
            Chance,
            AllSame
        }

        /// <summary>
        /// Based on the category found in GetSuggestions, this function will return the appropriate score for the random "Dice Rolls"
        /// </summary>
        /// <param name="category"></param>
        /// <param name="diceRolls"></param>
        /// <returns></returns>
        public int GetScore(Category category, int[] diceRolls)
        {
            //Casting enum to int to seperate category types. Add 1 because enums start at [0]
            var intCategory = (int) category + 1;
            var score = 0;

            //Categories Ones - Eights are just the sum of like numbers. Just add them up here and return the value.
            //Note: I know I was only supposed to do two of the Ones-Eights, but this was the easiest method I could think of and it solves all eight.
            if (intCategory < 9)
            {
                score += diceRolls.Where(t => t == intCategory).Sum(t => intCategory);
            }

                //Handles the other categories
            else
            {

                int validator = 0;
                switch (category)
                {

                    case Category.ThreeOfAKind:
                        //If there are three similar dice, score equals the sum of all dice.
                        var isThreeOfAKind = false;
                        for (var i = 1; i <= 6; i++)
                        {
                            var count = 0;
                            foreach (var t in diceRolls)
                            {
                                if (t == i)
                                    count++;

                                if (count == 3)
                                    isThreeOfAKind = true;
                            }
                        }

                        score = isThreeOfAKind ? diceRolls.Sum() : 0;
                        break;

                    case Category.FourOfAKind:
                        //If there are four similar dice, score equals the sum of all dice.
                        bool isFourOfAKind = false;
                        for (var i = 1; i <= 6; i++)
                        {
                            var count = 0;
                            foreach (var t in diceRolls)
                            {
                                if (t == i)
                                    count++;

                                if (count > 3)
                                    isFourOfAKind = true;
                            }
                        }

                        score = isFourOfAKind ? 25 : 0;
                        break;

                    case Category.FullHouse:
                        //If all dice rolls are in XXYYY, score = 25.
                        bool isFullHouse = false;
                        Array.Sort(diceRolls);

                        if ((diceRolls[0] == diceRolls[1]) //Check XX
                            && (diceRolls[2] == diceRolls[3]) && (diceRolls[3] == diceRolls[4])) //Check YYY
                        {
                            isFullHouse = true;
                        }

                        score = isFullHouse ? 25 : 0;
                        break;

                    case Category.SmallStraight:
                        //If there are four die in sequence, the score is 30.

                        //Sort from smallest to largest
                        Array.Sort(diceRolls);
                        validator = 0;

                        for (int i = 0; i < diceRolls.Length - 1; i++)
                        {
                            //If the current element is equal to the next element, increment validator.
                            if (diceRolls[i] + 1 == diceRolls[i + 1])
                            {
                                validator = validator + 1;
                            }
                        }

                        //Since validator starts at 0, the value 3 means there were 4 matchs, signaling a straight.
                        score = validator == 3 ? 30 : 0;
                        validator = 0; //cleanup
                        break;

                    case Category.LargeStraght:
                        //If there are five die in sequence, the score is 40.
                        Array.Sort(diceRolls);
                        bool isLargeStraight = diceRolls.Zip(diceRolls.Skip(1), (a, b) => (a + 1) == b).All(x => x);
                        score = isLargeStraight ? 40 : 0;
                        break;

                    case Category.AllDifferent:
                        //If all dice rolls are unique, then score 40.
                        bool isUnique = diceRolls.Distinct().Count() == diceRolls.Count();
                        score = isUnique ? 40 : 0;
                        break;

                    case Category.AllSame:
                        //If all dice rolls are the same, return 50.
                        bool allSame = false;
                        for (int i = 1; i < diceRolls.Length; i++)
                        {
                            allSame = diceRolls[0] == diceRolls[i];
                        }
                        score = allSame ? 50 : 0;
                        break;
                }
            }
            return score;
        }

        /// <summary>
        /// Gets preferred category based on diceRoll
        /// </summary>
        /// <param name="array"></param>
        /// <returns></returns>
        public Category GetSuggestion(int[] array)
        {
            //Get all enum values and set default best category to Ones.
            var categoryTypes = Enum.GetValues(typeof (Category));
            var bestCategory = Category.Ones;
            int highScore = 0;
            //Loop through all categories and return the combination with the highest score.
            foreach (Category category in categoryTypes)
            {
                int score = GetScore(category, array);

                if (score > highScore)
                {
                    highScore = score;
                    bestCategory = category;
                }
            }

            return bestCategory;
        }

        /// <summary>
        /// Randomizer for the "dice roll" of an 8-sided die. 
        /// </summary>
        /// <returns>Array of five random integers.</returns>
        public int[] RollDice()
        {
            const int min = 1;
            const int max = 8;
            var diceRolls = new int[5];
            var randNum = new Random();
            for (var i = 0; i < diceRolls.Length; i++)
            {
                diceRolls[i] = randNum.Next(min, max);
            }
            return diceRolls;
        }

    }
}
