public class NumberUtility {

	//¹14 prime numbers ranging from 1 to N
	public static void PrimeNumbers(Integer number1) {
		List < Integer > PrimeList = new List < Integer > ();
		for (Integer i = 1; i <= number1; i++) {
			Integer num = 0;
			for (Integer j = 1; j <= number1; j++) { //iterating over divisors
				if (math.mod(i, j) == 0) { //I check if they are divided without a remainder
					num += 1;
				}
			}
			if (num == 2) { //if divisible by only two numbers I output to debug
				PrimeList.add(i);
			}
		}
		System.debug(PrimeList); //returns (2, 3, 5, 7) if number1=10
	}

	//¹15 Fibonacci numbers ranging from 1 to N
	public static void FibonacciNumbers(Integer number2) {
		List < Integer > FibonacciList = new List < Integer > ();
		Integer n0 = 1;
		Integer n1 = 1;
		Integer n2;
		FibonacciList.add(n0);
		FibonacciList.add(n1);
		for (Integer i = 1; i <= number2; i++) {
			n2 = n0 + n1;
			if (n2 <= number2) { //check if the number is out of range
				FibonacciList.add(n2);
				n0 = n1;
				n1 = n2;
			}
		}
		System.debug(FibonacciList); // returns 1,1,2,3,5,8,13,21 if number2=25
	}

	//¹16 checks a number for palindromicity
	public static void PalindromicityNumbers(Long number3) {
		Long rem,
		sum = 0,
		temp;
		temp = number3;
		while (number3 > 0) {
			rem = math.mod(number3, 10); //for getting remainder by dividing with 10    
			number3 = math.round(number3 / 10); //for getting quotient by dividing with 10    
			sum = sum * 10 + rem; //multiplying the sum with 10 and adding remainder 
		}
		if (temp == sum) { //checking whether the reversed number is equal to entered number    
			System.debug(true);
		} else {
			System.debug(false);
		}
	}

}