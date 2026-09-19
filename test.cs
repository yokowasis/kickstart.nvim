namespace TestApp;

public class Calculator
{
    public int Add(int a, int b)
    {
        return a + b;
    }

    public void PrintResult()
    {
        System.Console.WriteLine("Result: " + Add(1, 2));
    }
}
