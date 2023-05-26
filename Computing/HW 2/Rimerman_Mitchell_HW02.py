# Homework 2
# Name: Mitchell Rimerman

# Homework Functions
def has_duplicate(input_list):
    """
    Checks whether a list has any duplicate items
    
    Parameters
    ----------
    input_list: a list to check for duplicates

    Returns
    -------
    Boolean: True if there are any duplicates,
             False if there are no duplicates
    """
    for item in input_list:
        if input_list.count(item) > 1:
            return True
    return False
        

def remove_duplicate(input_list):
    """
    Removes duplicates from a list
    
    Parameters
    ----------
    input_list: a list to which to remove duplicates

    Returns
    -------
    simple_list: input_list with duplicates removed
    """
    if has_duplicate(input_list) == False:
        return input_list
    else:
        simple_list = []
        [simple_list.append(item) for item in input_list if item not in simple_list]
        return simple_list
        
    
def invert_dict(input_dictionary):
    """
    Switches the keys and values for a dictionary, where the new value is
    an ordered list of keys that shared that value
        
    Parameters
    ----------
    input_dictionary: a dictionary to which to swich keys and values

    Returns
    -------
    invert_dict: a dictionary, inverted from input_dictionary
    """
    invert_dict = {}
    for k,v in input_dictionary.items():
        if v in invert_dict.keys():
            invert_dict.get(v).append(k)
        else:
            invert_dict[v]=[k]
    return invert_dict
    

def cipher_dict(n):
    """
    Proves a dictionary for a Caesar Cipher with left shift n

    Parameters
    ----------
    n: int, the amount of left shift per letter in the Caesar Cipher

    Returns
    -------
    dict: a dictionary for the Cipher, with keys being original letters,
            and values being the new shifted letters

    """
    alphabet="abcdefghijklmnopqrstuvwxyz"
    return {alphabet[letter]:alphabet[(letter-n)%26] for letter in range(26)}
    
    
def caesar_cipher(input_text):
    """
    Encrypts a string according to a Caesar Cipher with a left shift of 3
    
    Parameters
    ----------
    input_text: a string which to encrypt

    Returns
    -------
    new_string: the encrypted input_text using the Caesar Cipher
    """
    cipher = cipher_dict(3)
    new_string = ""

    for letter in input_text.lower():
        if letter in cipher.keys():
            new_string += cipher[letter]
        else:
            new_string += letter
    return new_string


def make_dictionary(file_name):
    """
    Creates a dictionary for a file with keys being letters and values being
    the set of words in the file that start with that letter
    
    Parameters
    ----------
    file_name: a text file with one word per line

    Returns
    -------
    dict: a dictionary of letters and their corresponding words
    """
    dict_file = open(file_name, 'r')
    file_list = dict_file.read().splitlines()
    print(file_list)
    letter_file_list = [item[0] for item in file_list]
    return {letter:set(item for item in file_list if item[0]==letter)for letter in letter_file_list}


def anagrams(file_name):
    """
    Finds the largest set of anagrams in a text file with one word per line
    
    Parameters
    ----------
    file_name: a text file with one word per line

    Returns
    -------
    largest_anagrams: the largest set of words that are anagrams of each other
                        from file_name
    """
    anagrams_file_list = open(file_name,'r').read().splitlines()
    file_sorted = sorted(anagrams_file_list, key=len)
    sorted_ordered = ["".join(sorted(item)) for item in file_sorted]

    checked=set()
    largest_anagrams=set()
    for item in sorted_ordered:
        temp_anagrams={file_sorted[sorted_ordered.index(item)]}
        if item not in checked:
            i=0
            for word in sorted_ordered:
                if len(word)==len(item):
                    if word==item:
                        temp_anagrams.add(file_sorted[i])
                    elif len(word)>len(item):
                        break
                i += 1
                checked.add(item)
        if len(temp_anagrams)>len(largest_anagrams):
            largest_anagrams = temp_anagrams
    
    return largest_anagrams
    


if __name__=='__main__':
    # Below are some sample test statements
    print(f'Test has_duplicate([1,0,1]==True: {has_duplicate([1,0,1])==True}')
    print(f'Test remove_duplicate([1,0,1]==[1,0]: {remove_duplicate([1,0,1])==[1,0]}')
    input_dict, output_dict = {1:2,2:2,3:1}, {2:[1,2],1:[3]}
    print(f'Test invert_dict({input_dict})=={output_dict}: {invert_dict(input_dict)==output_dict}')
    print(f'Test caesar_cipher("hello world!")=="ebiil tloia!": {caesar_cipher("hello world!")=="ebiil tloia!"}')
    output_dict = {'h':{'hi','his'},'t':{'tar','this'}, 'a':{'art'}, 'r':{'rat'}}
    print(f'Test make_dictionary("test.txt")=={output_dict}: {make_dictionary("test.txt")==output_dict}')
    print(f'Test anagrams("test.txt")=={"art","rat","tar"}: {anagrams("test.txt")=={"art","rat","tar"}}')
    
    