#!/usr/bin/env python

from pymarkovchain import MarkovChain

ebooks_fh = open('./out.txt', 'r')
content = ebooks_fh.read()

mc = MarkovChain('./kithrixx_ebooks')

mc.generateDatabase(content)
