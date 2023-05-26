# Homework 1
# Name: Mitchell Rimerman

# Homework Functions
def max_two(x, y):
    """
    Returns the maximum value of two numbers
    
    Input:
        x and y, numbers to which the find the max
        
    Output:
        max: the maximum of the two numbers
    """
    if x >= y:
        return x
    else:
        return y

def max_three(x, y, z):
    """
    Returns the maximum value of three numbers

    Input:
        x, y, z, numbers to which the find the max

    Output:
        max: the maximum of the three numbers
    """
    max1 = max_two(x,y)
    return max_two(max1,z)
    

def min_three(x, y, z):
    """
    Returns the minimum value of three numbers
    
    Input:
        x, y, x, numbers to which to find the min
        
    Output:
        min: the minomum of the three numbers
    """
    maximum = max_three(x,y,z)
    if x == maximum:
        medium = max_two(y,z)
        if y == medium:
            return z
        else:
            return y
    elif y == maximum:
        medium = max_two(x,z)
        if x == medium:
            return z
        else:
            return x
    else:
        medium = max_two(x,y)
        if x == medium:
            return y
        else:
            return x
    

def reverse(word):
    """
    Returns a string in reverse order
    
    Input:
        word, a string which to make backwords
        
    Output:
        drow, a string that in the reverse order of word
    """
    return word[::-1]

def is_palindrome(word):
    """
    Returns a true or false based on if the input is a palindrome or not
    
    Input:
        word, a string which to check if it is a palindrome
        
    Output:
        True, if word is a palindrome
        False, if word is not a palindrome
    """
    word = word.replace(" ","")
    word = word.lower()
    if word == reverse(word):
        return True
    else:
        return False

def string_length(word):
    """
    Returns the length of a string
    
    Input:
        word, a string on which to calculate length
        
    Output:
        length, an integer length of the string
    """
    length = 0
    for i in word:
        length += 1
    return length

def alg_test(x, n):
    """
    Prints the results of each of the following equivalent functions: 
        f_1(x)=3.95x(1-x), f_2(x)=3.95x-3.95x^2, f_3(x)=3.95(x-x^2),
    for each iteration of x as specified by the input.
    The resulting f(x) becomes the new input for all three functions
    
    Input:
        x, a float in [0,1], the original input for all the functions
        n, an integer of the number of additional times to use the output of 
            the functions as an additional input
            
    Output:
        The function will not return anything.
        Instead the following is printed to the screen:
            the outputs for all three functions for each time that each 
            function was used
    """
    answer1 = x
    answer2 = x
    answer3 = x
    iteration = 1
    
    for i in range(n+1):
        answer1b = 3.95 * answer1 * (1 - answer1)
        answer2b = 3.95 * answer2 - 3.95 * (answer2**2)
        answer3b = 3.95 * (answer3 - answer3**2)
        print(f'{iteration:03}. f_1({answer1:.3f})=3.95({answer1:.3f})(1-{answer1:.3f})={answer1b:.3f}, f_2({answer2:.3f})=3.95({answer2:.3f})-3.95({answer2:.3f}^2)={answer2b:.3f}, f_3({answer3:.3f})=3.95({answer3:.3f}-{answer3:.3f}^2)={answer3b:.3f}')
        answer1 = answer1b
        answer2 = answer2b
        answer3 = answer3b
        iteration += 1
    pass

question_6_answer = """
For the first approximately 46 iterations, the three functions give the same 
output up to three decimal points, but after 46, the numbers begin to deviate
between the three functions. This is a demonstration of floating point errors
which add up as the numbers are reimputted into the function. By the time that
the loop is run 101 times, the three answers outputted are entirely different
with three decimal places due to that error compounding, even though the
functions should be outputting the same value as they are equivalent.
"""

def happy(x):
    """
    Returns a boolean of T or F if the inputted integer is a happy number

    Input:
        x, any positive integer, to check if it is happy
    Output:
        String: Happy if the input is happy, Unhappy if the input is not

    Notes: Any positive integer will either get to 1 or get stuck in the
            loop: 4 -> 16 -> 37 -> 58 -> 89 -> 145 -> 42 -> 20 -> 4.
            (https://mathworld.wolfram.com/HappyNumber.html)
            The only numbers less than 10 that won't fall into the loop are 
            1 and 7 (7 -> 49 -> 97 -> 130 -> 10 -> 1), by direct calculation.
            Every positive number will eventually reach the loop and get to 
            4 (or will hit another single digit that will eventually reach the
            loop) OR will eventually get to 7 (which leads to 1) or 1. Thus, 
            in the while loop we only need to go until the output <10.
    """
    while x >= 10:
        #getting the number of digits in the number
        length = 0
        x1 = x
        while x1 >= 1:
            x1 = x1/10
            length += 1

        #isolating each digit and summing their squares
        sum = 0       
        for i in range(length):
            digit = x%10
            sum += digit**2
            x = x//10
        x = sum
 
    if x != 1 and x != 7:
        return "Unhappy"
    else:
        return "Happy"

    

if __name__=='__main__':
    # Below are some sample test statements 
    print(f'Test max_two(-1,1)==1: {max_two(-1,1)==1}')
    print(f'Test max_three(-1,0,1)==1: {max_three(-1,0,1)==1}')
    print(f'Test min_three(-1,0,1)==-1: {min_three(-1,0,1)==-1}')
    print(f'Test reverse("word")=="drow": {reverse("word")=="drow"}')
    print(f'Test is_palindrome("abc")==False: {is_palindrome("abc")==False}')
    print(f'Test string_length("abc")==3: {string_length("abc")==3}')
    
    print('Run alg_test and comment on results')
    alg_test(.9, 100)
    print(question_6_answer)
    
    print(f'Test happy(219)==Happy: {happy(219)=="Happy"}')
    print(f'Test happy(223)==Unhappy: {happy(223)=="Unhappy"}')