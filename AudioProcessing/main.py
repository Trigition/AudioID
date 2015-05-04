#!/usr/bin/env python
__author__ = 'William'

import os
import glob

genres = ['Classical', 'Dub-a-Wub-Step', 'Reggae']

for genre in genres:
    os.chdir('./AudioSamples/' + genre + '/')
    list_of_files = glob.glob('*.wav')
    os.chdir('../../')
    for sample in list_of_files:
        os.system('generate_centroid.py ' + './AudioSamples/' + genre + '/' + sample)
    os.rename('centroid.txt', '../Centroids/' + genre + '.txt')