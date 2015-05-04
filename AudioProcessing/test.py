#!/usr/bin/env python

import numpy as np
import struct
import wave
import os
import matplotlib.pylab as plt
import glob
from math import log10

genres = ['Classical', 'Dub-a-Wub Step', 'Reggae']

for genre in genres:
    directory = os.chdir('./AudioSamples/' + genre + '/')
    sample_files = glob.glob('*.wav')
    print "Found Files: ", sample_files

    centroid = []
    for sample in sample_files:
        print "Processing file:", sample
        audio_file = wave.open(sample)
        samples_resolution = audio_file.getframerate()
        number_samples = audio_file.getnframes() / 100
        duration = float(number_samples) / float(samples_resolution)

        print samples_resolution
        print number_samples
        print duration

        sound_data = audio_file.readframes(number_samples)
        unpack_format = '%dh' % (number_samples * audio_file.getnchannels())
        sound_data = struct.unpack(unpack_format, sound_data)

        sound_data = np.fft.fft(sound_data)
        half = len(sound_data) / 2
        sound_data = sound_data[:half]
        sound_data = abs(sound_data)
        centroid.append(sound_data)
    os.chdir('../../')
    fileout = open('../Centroids/' + genre + '.csv', 'w')
    for row in centroid:
        first = True
        for entry in row:
            print entry, int(entry)
            if not first:
                fileout.write(',')
            first = False
            fileout.write(str(int(entry)))
        fileout.write('\n')
    fileout.close()
    # plt.plot(sound_data)
    # plt.show()