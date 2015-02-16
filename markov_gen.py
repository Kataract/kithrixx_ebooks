#!/usr/bin/env python

from pymarkovchain import MarkovChain

mc = MarkovChain('./kithrixx_ebooks')

ebooks_fh = open('./ebooks.txt', 'w')

for i in range(15):
	ebooks_fh.write(mc.generateString() + '\n')
