# -*- coding: utf-8 -*-
# Homework 0
# Name: Mitchell Rimerman
# Please remember to rename your file using your First and Last names to read Last_First_HW0 1.py
# The goal of this homework is to answer some simple background questions and submit to Canvas.


# Imports
import sys

# Extra Functions
def return_hello(extra = 'World!'):
    return f'Hello {extra}'

def print_hello(extra = 'World!'):
    print(f'Hello {extra}')

def test_function(function, input, output, test_name = 'Test'):
    """
    This is a simple function written to test other functions where it is expected that,
    given a specific input, the function should have a specific output. This is called unit testing.

    For additional resources check:
    - https://docs.python.org/3/library/unittest.html
    - https://realpython.com/python-testing/

    Inputs:

    Outputs:
    """
    try:
        if function(*input)==output:
            print(f'{test_name}: Passed')
        else:
            print(f'{test_name}: Failed - Wrong Answer')
    except:
        print(f'{test_name}: Failed - {sys.exc_info()[0]}')
        
# Homework Functions

def q1():
    """
    Do you have any conflicts for office hours? A preferred time? 

    """
    reply = "I am taking MATH 503 Wednesdays 6:30-9, so that would be my only potential conflict. \nBest times for me for office hours would be Mondays-Thursdays 4-6pm."
    """
    Your Answer Here
    """
    print(f'Q1 Answer:\n{reply}')

def q2():
    """
    On a scale from 1 to 10 with 1 being not at all proficient to 10 being very 
    proficient how proficient are you with:
    a. Python
    b. R
    c. Other (please list)

    """
    programming_proficiencies = {
        'python':3,
        'r':8,
        'c++': 4,
        }
    print('\nQ2 Answer:\n')
    for language, skill_level in programming_proficiencies.items():
        print(f'   {language}: {skill_level}')
        
def q3():
    """
    Do you have any applications of interest (e.g. finance, data science, statistics, …)?

    """
    areas_of_interest = ['Data Science', 'Quantum Computing', 'Cryptography']
    print('\nQ3 Areas of interest include:\n')
    for area in areas_of_interest:
        print('  ', area)

###################### MAIN FUNCTION ###########################
def main():
    # Your HW questions
    q1()
    q2()
    q3()
    
    print('\nTest Functions:\n')
    # Example of unit tests
    test_function(return_hello, [''], 'Hello ', test_name = 'return_test')
    test_function(print_hello, [''], None, test_name = 'print_test')

if __name__=='__main__':
    main()
