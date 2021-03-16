public class NumberUtility {

    //¹14 prime numbers ranging from 1 to N
    public static List<Integer> primeNumbers(Integer number1) {
        List<Integer> primeList = new List<Integer> ();
        for (Integer i = 1; i <= number1; i++) {
            Integer num = 0;
            for (Integer j = 1; j <= number1; j++) { //iterating over divisors
                if (math.mod(i, j) == 0) { //I check if they are divided without a remainder
                    num += 1;
                }
            }
            if (num == 2) { //if divisible by only two numbers I output to debug
                primeList.add(i);
            }
        }
        return primeList; //returns (2, 3, 5, 7) if number1=10
    }

    //¹15 Fibonacci numbers ranging from 1 to N
    public static List<Integer> fibonacciNumbers(Integer number2) {
        List<Integer> fibonacciList = new List<Integer> ();
        Integer n0 = 1;
        Integer n1 = 1;
        Integer n2;
        fibonacciList.add(n0);
        fibonacciList.add(n1);
        for (Integer i = 1; i <= number2; i++) {
            n2 = n0 + n1;
            if (n2 <= number2) { //check if the number is out of range
                fibonacciList.add(n2);
                n0 = n1;
                n1 = n2;
            }
        }
        return fibonacciList; // returns 1,1,2,3,5,8,13,21 if number2=25
    }

    //¹16 checks a number for palindromicity
    public static Boolean palindromicityNumbers(Long number3) {
        Long rem = 0;
        Long sum = 0;
        Long temp;
        temp = number3;
        Boolean check;
        while (number3 > 0) {
            rem = math.mod(number3, 10); //for getting remainder by dividing with 10    
            number3 = math.round(number3 / 10); //for getting quotient by dividing with 10    
            sum = sum * 10 + rem; //multiplying the sum with 10 and adding remainder 
        }
        if (temp == sum) { //checking whether the reversed number is equal to entered number    
            check = true;
        } else {
            check = false;
        }
        return check;
    }

}