#!/usr/bin/env python

import wave
import struct
import matplotlib.pyplot as plt
import numpy as np

filename = './AudioFiles/New Avengers.wav'

sound_file = wave.open(filename)
channels = sound_file.getnchannels()
audio_width = sound_file.getsampwidth()
n_frames = sound_file.getnframes()
frame_rate = sound_file.getframerate()

# Read in Audio Signal and close file

duration = n_frames / frame_rate
audio_signal = sound_file.readframes(n_frames)
sound_file.close()

# Convert Audio Signal to usable Data

print "Unpacking Data"
unpack_format = '%dh' % (n_frames * channels)
audio_data = struct.unpack(unpack_format, audio_signal)
print "Data Unpacked"
print "Transforming Audio Data to NP Array"
audio_data = np.array(audio_data, dtype='h')
print "Performing RFFT Transform"
fourier_trans = np.fft.rfft(audio_data)
print "Performed RFFT Transform"
fourier_trans.dump('RTTF_OUT.numpy')
# Plot Audio Data
"""
plt.figure(1)
plt.title('Yolo')
plt.plot(raw_data)
plt.show()"""
# Plot FFT Data
"""
plt.figure(1)
plt.title('FFT')
plt.plot(fourier_trans)
plt.show()"""