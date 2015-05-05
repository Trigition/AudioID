#!/usr/bin/env python
__author__ = 'William'
# Modified from: https://github.com/n00bsys0p/python-visualiser/blob/master/plotvals.py

import wave
import struct
import sys
import numpy as np


# Fancy Terminal Updates
def update_progress(progress):
    sys.stdout.write('\r[{0}] {1}%'.format('#'*(progress/10), progress))
    sys.stdout.flush()

filename = sys.argv[1]

wave_file = wave.open(filename, 'r')
data_size = wave_file.getnframes()
sample_rate = wave_file.getframerate()
sample_width = wave_file.getsampwidth()
duration = data_size / float(sample_rate)

# Read in sample data
sound_data = wave_file.readframes(data_size)

# Determine how many channels there are to determine how much data needs analysis
channels = wave_file.getnchannels()

# Close the file, as we don't need it any more
wave_file.close()

# Unpack the binary data into an array
unpack_fmt = '%dh' % (data_size * channels)
sound_data = struct.unpack(unpack_fmt, sound_data)

# Process many samples
fouriers_per_second = 24 # Frames per second
fourier_spread = 1.0/fouriers_per_second
fourier_width = fourier_spread
fourier_width_index = fourier_width * float(sample_rate)

if len(sys.argv) < 3:
    length_to_process = int(duration)-1
else:
    length_to_process = float(sys.argv[2])


total_transforms = int(round(length_to_process * fouriers_per_second))
fourier_spacing = round(fourier_spread * float(sample_rate))
"""print "Duration: %s" % duration
print "For Fourier width of "+str(fourier_width)+" need "+str(fourier_width_index)+" samples each FFT"
print "Doing "+str(fouriers_per_second)+" Fouriers per second"
print "Total " + str(total_transforms * fourier_spread)
print "Spacing: "+str(fourier_spacing)
print "Total transforms "+str(total_transforms)"""
print "Processing:", filename[14:]
print "Duration:", duration, "# of Transforms:", total_transforms

lastpoint = int(round(length_to_process*float(sample_rate)+fourier_width_index))-1

sample_size = fourier_width_index
freq = sample_rate / sample_size * np.arange(sample_size)

x_axis = range(0, 12)


def getBandWidth():
    return (2.0/sample_size) * (sample_rate / 2.0)


def freqToIndex(f):
    # If f (frequency is lower than the bandwidth of spectrum[0]
    if f < getBandWidth()/2:
        return 0
    if f > (sample_rate / 2) - (getBandWidth() / 2):
        return sample_size -1
    fraction = float(f) / float(sample_rate)
    index = round(sample_size * fraction)
    return index

fft_averages = []


def average_fft_bands(fft_array):
    num_bands = 12  # The number of frequency bands (12 = 1 octave)
    del fft_averages[:]
    for band in range(0, num_bands):
        avg = 0.0

        if band == 0:
            lowFreq = int(0)
        else:
            lowFreq = int(int(sample_rate / 2) / float(2 ** (num_bands - band)))
        hiFreq = int((sample_rate / 2) / float(2 ** ((num_bands-1) - band)))
        lowBound = int(freqToIndex(lowFreq))
        hiBound = int(freqToIndex(hiFreq))
        for j in range(lowBound, hiBound):
            avg += fft_array[j]

        avg /= (hiBound - lowBound + 1)
        fft_averages.append(avg)

all_average = []

for offset in range(0, total_transforms):
    start = int(offset * sample_size)
    end = int((offset * sample_size) + sample_size -1)

    # print "Processing sample %i of %i (%d seconds)" % (offset + 1, total_transforms, end/float(sample_rate))
    progress = int((offset + 1.0) * 100 / total_transforms)
    update_progress(progress)
    sample_range = sound_data[start:end]
    ## FFT the data
    fft_data = abs(np.fft.fft(sample_range))
    # Normalise the data a second time, to make numbers sensible
    fft_data *= ((2**.5)/sample_size)
    average_fft_bands(fft_data)
    all_average.append(fft_averages)

print ''
# centroid = [x / total_transforms for x in centroid]  # Average Centroid
centroid_out = open('centroid.txt', 'w')
c_number = len(all_average[0])
centroid = []
for i in range(0, c_number):
    centroid.append(sum(row[i] for row in all_average))

"""for time_vector in all_average:
    # print time_vector
    centroid = [x + y for x, y in zip(centroid, time_vector)]
"""
first = True
# print centroid
for member in centroid:
    if not first:
        centroid_out.write(',')
    first = False
    centroid_out.write(str(int(member)))
centroid_out.close()