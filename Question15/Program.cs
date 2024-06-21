namespace Question15;

public static class Program
{
    private const int Ground = 100;
    private const int Ceiling = 200;

    public static void Main(string[] _)
    {
        var oddNumbersSum = 0;
        for (var i = Ground; i <= Ceiling; i++)
            if (Mod(i, 2) != 0)
                oddNumbersSum += i;

        Console.WriteLine($"Sum of odd values between {Ground} and {Ceiling} is {oddNumbersSum}");
    }

    /// <returns>O resto da divisão entre dois números</returns>
    private static int Mod(int a, int b) => a % b;
}