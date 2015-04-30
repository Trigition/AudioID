#!/usr/bin/env python
__author__ = 'William'

from scipy.io import wavfile as wav
import numpy as np
from math import ceil, log10
from pylab import *

class Audio_Factory():
    def __init__(self, file_path, binary_size):
        """Constructor for an Audio Factory"""
        self.file_path = file_path
        self.sample_rate, self.samples = wav.read(file_path)
        self.bin_size = binary_size
        self.transform = None
        self.right_transform = None
        self.left_transform = None
        self.num_unique_points = None
        # print self.samples

    def process_audio(self):
        # Pad Audio Signal with zeros
        samples = np.append(np.zeros(np.floor(self.bin_size/2.0)), self.samples)
        # Obtain Frames for each time sample
        frames = lib.stride_tricks.as_strided()
        print samples

    def take_real_fourier(self):
        """Create fourier transform arrays of each channel"""
        print "Taking Real Fourier Time Transform of:", self.file_path
        left_transform = np.fft.rfft(self.get_left_channel())
        right_transform = np.fft.rfft(self.get_right_channel())
        print "Took transforms of left and right channels"

        # Normalize and standardize waveform
        print "Normalizing channels"
        self.num_unique_points = ceil((len(self.samples) + 1) / 2.0)
        # Ensure that transform is same duration of audio file
        left_transform = left_transform[0:self.num_unique_points]
        right_transform = right_transform[0:self.num_unique_points]
        # Find the power(dB) of each transform
        # Do it for Left Channel
        print "Finding power (dB) values of left and right channels"
        left_transform = abs(left_transform)
        left_transform /= float(self.num_unique_points)
        left_transform = left_transform ** 2 # Transform units are now in dB (Power)
        # Do it for Right Channel
        right_transform = abs(right_transform)
        right_transform /= float(self.num_unique_points)
        right_transform = right_transform ** 2 # Transform units are now in dB (Power)

        # Multiply by 2
        odd = self.num_unique_points % 2
        left_transform[1:len(self.num_unique_points) - odd] = left_transform[1:len(self.num_unique_points) - odd] * 2
        right_transform[1:len(self.num_unique_points) - odd] = right_transform[1:len(self.num_unique_points) - odd] * 2

        # Set values to object instance
        self.right_transform = right_transform
        self.left_transform = left_transform
        print "Successfully performed transform on:", self.file_path

    def plot_transforms(self):
        """Plots the Fourier Transform to a plot (Debugging)"""
        print "Creating plot"


    def get_right_channel(self):
        """Returns the right channel samples"""
        return self.samples[:, 0]

    def get_left_channel(self):
        """Returns the left channel samples"""
        return self.samples[0,:]