# Homework 3
# Name: Mitch Rimerman

import random

# Homework Functions
def birthday(N):
    """
    Simulates 5000 groups of N people and find the proportion of simulations
    where at least 2 people share a birthday

    Parameters
    ----------
    N : integer, number of people in the group

    Returns
    -------
    Proportion: floating point, proportion of simulations where at least 2 
    people share a birthday

    """
    counter = 0
    for i in range(5000):
        bday_set = {random.randrange(365) for i in range(N)}
        if len(bday_set) != N:
            counter += 1
    return counter/5000


def binary_search(x, input_list):
    """
    Binary Search algorithm that find the index of x in the increasing
    list, input_list, or the index where x would be if x is not an element
    of input_list

    Parameters
    ----------
    x : integer or floating point, the number to search for within input_list
    input_list : list, a list of increasing integers or floating points in which
                    to search for x or where x would be

    Returns
    -------
    integer, the index where x is located or where would be in input_list

    """
    list_size = len(input_list)
    div_index = list_size//2
    
    if x >= input_list[-1]:
        return list_size

    if x <= input_list[0]:
        return 0
    
    if x == input_list[div_index]:
        return div_index
    
    if x > input_list[div_index]:
        new_list=input_list[div_index:]
        return div_index + binary_search(x, new_list)
    
    if x < input_list[div_index]:
        new_list=input_list[:div_index]
        return binary_search(x, new_list)


def words_of_length(input_list):
    """
    Creates a dictionary from input_list whose keys are integers and 
    values are the set of words from input_list whose length are that 
    of its key

    Parameters
    ----------
    input_list: list of strings, for which to output the dictionary
    Returns
    -------
    dict: a dictionary where the keys are integers and the values are the 
    set of words from input_list whose length are that of its key

    """
    length_input_set = {len(item) for item in input_list}
    return {number:set(item for item in input_list if len(item)==number) for number in length_input_set}


def alternade(file_name):
    """
    Finds all the alternades (which are words in the file where alternating
    letters in the words produce two words that are both in the file) within 
    the file. 

    Parameters
    ----------
    file_name : a text file where each line is a word

    Returns
    -------
    alter_list : a list of strings, words within file_name that are alternades
                for file_name

    """
    alter_file = open(file_name, 'r')
    file_list = alter_file.read().splitlines()
    
    alter_list = []
    for word in file_list:
        left_word = word[::2]
        right_word = word[1::2]
        if left_word in file_list and right_word in file_list:
            alter_list.append(word)
    return alter_list


def checksum(file_name):
    """
    Converts all the letters in file_name to their index in the alphabet
    and sums all of those indeces together to get the total sum of letter
    indeces for file_name

    Parameters
    ----------
    file_name : a text file

    Returns
    -------
    total_sum : integer, the sum of all the indeces for all the letters
                in file_name

    """
    sum_file = open(file_name, 'r')
    letter_list = list(sum_file.read().lower())
    
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    sum_dict = {letter:i+1 for i,letter in enumerate(alphabet)}
    
    total_sum = 0
    for letter in letter_list:
        if letter in sum_dict.keys():
            total_sum += sum_dict[letter]
    return total_sum



if __name__=='__main__':
    # Below are some sample test statements
    print(f'Output from birthday is stochastic so answers will not be exact, but should be close')
    print(f'Test birthday(20) ~ 0.411: {birthday(20)}')
    print(f'Test birthday(23) ~ 0.507: {birthday(23)}')
    print(f'Test birthday(30) ~ 0.706: {birthday(30)}')
    print(f'Test binary_search(5,[1,2,4,5,7])==3: {binary_search(5,[1,2,4,5,7])==3}')
    output = {1:{"i"}, 3:{"aye","eye"}}
    print(f'Test words_of_length(["aye","eye","i"])== {output}: {words_of_length(["aye","eye","i"])== output}')
    print(f'Test alternade("test_03.txt")==["ftihlies]: {alternade("test_03.txt")==["ftihlies"]}')
    print(f'Test checksum("test_03.txt")==463: {checksum("test_03.txt")==463}')
