#!/usr/bin/env python
__author__ = 'William'

import os
import glob
from generate_centroid_spectrogram import plotstft

genres = ['Classical', 'Dub-a-Wub-Step', 'Reggae']

"""Generate Vector Centroids"""
print "\nGenerating Centroids..."
for genre in genres:
    os.chdir('./AudioSamples/' + genre + '/')
    list_of_files = glob.glob('*.wav')
    os.chdir('../../')
    for sample in list_of_files:
        os.system('generate_centroid_vector.py ' + './AudioSamples/' + genre + '/' + sample + ' ' +
        '../Centroids/' + genre + '.txt')
    # os.rename('centroid.txt', '../Centroids/' + genre + '.txt')

"""Generate Test Vectors"""
print "\nGenerating Test Vectors"
os.chdir('./AudioSamples/Audio_Tests/')
list_of_files = glob.glob('*.wav')
os.chdir('../../')
for sample in list_of_files:
    os.system('generate_centroid_vector.py ' + './AudioSamples/Audio_Tests/' + sample + ' ' +
    '../Tests/' + sample[:-3] + 'txt')
"""Generate Spectrogram Centroids"""
"""for genre in genres:
    os.chdir('./AudioSamples/' + genre + '/')
    list_of_files = glob.glob('*.wav')
    os.chdir('../../')
    for sample in list_of_files:
        print "Processing:", sample
        plotstft(audiopath='./AudioSamples/' + genre + '/' + sample, plotpath='../Centroids/' + genre + '_' + sample + '.png')"""