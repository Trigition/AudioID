#!/usr/bin/env python

import pylab
from numpy import arange
from scipy.io import wavfile

files = 'AudioFiles/New Avengers.wav'
sample_frequency, snd = wavfile.read('test.wav')
print "File Data Type:", snd.dtype
# Convert Signal to floating point within range of snd.dtype
snd /= (2.**15)
# print snd.shape[0]
# print snd.shape[1]
duration = snd.shape[0] / sample_frequency
s1 = snd[:, 0]
time_array = arange(0, snd.shape[0], 1)
time_array /= sample_frequency
time_array *= 1000

