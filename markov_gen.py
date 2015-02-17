#!/usr/bin/env python

import argparse
from pymarkovchain import MarkovChain

mc = MarkovChain('./kithrixx_ebooks')
parser = argparse.ArgumentParser()
parser.add_argument("reps", help="number of strings generated", type=int)
args = parser.parse_args()

ebooks_fh = open('./ebooks.txt', 'w')

for i in range(args.reps):
	ebooks_fh.write(mc.generateString() + '\n')
