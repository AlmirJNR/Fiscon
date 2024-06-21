namespace Question10;

internal static class Program
{
    public static void Main(string[] _)
    {
        Console.WriteLine(Calculate(1, 2));
        Console.WriteLine(Calculate(8, 2));
        Console.WriteLine(Calculate(24, 5));
    }

    private static (int sum, int product) Calculate(int value1, int value2)
    {
        var sum = value1 + value2;
        var product = value1 * value2;
        return (sum, product);
    }
}