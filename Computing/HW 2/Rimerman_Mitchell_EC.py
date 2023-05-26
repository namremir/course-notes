#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Homework 2 Extra Credit
# Name: Mitchell Rimerman

def make_change(cash, denominations=[100,50,25,10,5,1]):
    """
    Calculates the number of different ways to make change for 'cash' cents,
    using US coin denominations of $1 coins, 50c coins, quarters, dimes,
    nickels, and pennies (using recursion). The default list is used for
    standard US coins.

    Parameters
    ----------
    cash : integer, amount of money of which to make change
    denominations : list, optional
        The different coins to use in order to make change, from highest
        to lowest. The default is [100,50,25,10,5,1], used for standard US coins.

    Returns
    -------
    n: integer, the number of different ways to make change

    """
    if cash < 0:
        return 0

    if len(denominations) > 1:
        new_denominations = denominations.copy()
        new_denominations.remove(new_denominations[0])
    
    if len(denominations) == 1:
        return 1
    
    return make_change(cash - denominations[0],denominations) + make_change(cash, new_denominations) 

