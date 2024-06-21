namespace Question8;

internal class Income
{
    public DateTime? Date { get; set; }
    public float? BilledPrice { get; set; }

    public override string ToString()
    {
        return $"{Date?.ToString("yyyy/MM/dd")} - R${BilledPrice:.00}";
    }
}

internal static class Program
{
    private static readonly Income[] YearlyIncome = new Income[]
    {
        new()
        {
            Date = new DateTime(2024, 1, 15),
            BilledPrice = 200.25f
        },
        new()
        {
            Date = new DateTime(2024, 1, 20),
            BilledPrice = null
        },
        new()
        {
            Date = new DateTime(2024, 1, 16),
            BilledPrice = 224.1f
        }
    };

    public static void Main(string[] _)
    {
        var lowestIncome = new Income
        {
            BilledPrice = float.MaxValue
        };
        var biggestIncome = new Income
        {
            BilledPrice = float.MinValue
        };
        var totalIncome = 0.0f;

        var validIncomes = new List<Income>();
        foreach (var income in YearlyIncome)
        {
            if (income.Date?.DayOfWeek is null or DayOfWeek.Saturday or DayOfWeek.Sunday)
                continue;

            /*
             * TODO: check if day is holiday in country if it is then continue;
             * if (income.Date?.IsHoliday())
             *  continue;
             */

            if (income.BilledPrice is null)
                continue;

            // IMPORTANT: all checks should be made before the code can reach the following lines
            if (income.BilledPrice <= lowestIncome.BilledPrice)
                lowestIncome = income;
            if (income.BilledPrice >= biggestIncome.BilledPrice)
                biggestIncome = income;

            totalIncome += income.BilledPrice.Value;
            validIncomes.Add(income);
        }

        var mean = totalIncome / validIncomes.Count;
        var daysWhereIncomeWasBiggerThanTheYearlyMean = validIncomes.Count(income => income.BilledPrice > mean);

        Console.WriteLine($"Biggest Income: {biggestIncome}");
        Console.WriteLine($"Lowest Income: {lowestIncome}");
        Console.WriteLine($"Total Income: {totalIncome:.00}");
        Console.WriteLine($"Yearly Income Mean: R${mean:.00}");
        Console.WriteLine(
            $"Days where income was bigger than the yearly mean: {daysWhereIncomeWasBiggerThanTheYearlyMean}"
        );
    }
}