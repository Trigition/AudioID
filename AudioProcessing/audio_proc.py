#!/usr/bin/env python
__author__ = 'William'

import wave
import struct
import numpy as np
import matplotlib.pylab as plt


class Audio_Factory():
    def __init__(self, file_path, range_columns):
        """Constructor for an Audio Factory"""
        # Load file statistics
        self.file_path = 'AudioFiles/' + file_path
        self.sound_file = wave.open(self.file_path)
        self.file_size = self.sound_file.getnframes()
        self.sample_rate = self.sound_file.getframerate()
        self.sample_width = self.sound_file.getsampwidth()
        self.sample_duration = self.file_size / float(self.sample_rate)
        # Open sound file using file attributes
        print "Opening:", self.file_path, " with: "
        print "Size:\t", self.file_size
        print "Sample Rate:\t", self.sample_rate
        print "Sample Width\t", self.sample_width
        print "Sample Duration\t", self.sample_duration
        self.sound_data = self.sound_file.readframes(self.file_size)
        self.sound_file.close()
        # Interpret file data into useful information
        unpack_fmt = '%dh' % (self.file_size * 2)
        print unpack_fmt
        self.sound_data = struct.unpack(unpack_fmt, self.sound_data)
        # Perform Fourier Analysis
        self.fouriers_per_second = 24 # Frames per second
        self.fourier_spread = 1.0 / self.fouriers_per_second
        self.fourier_width = self.fourier_spread
        self.fourier_width_index = self.fourier_width * float(self.sample_rate)

        process_length = self.sample_duration - 1
        self.total_transforms = int(round(process_length * self.fouriers_per_second))
        self.fourier_spacing = self.fourier_width * float(self.sample_rate)

        self.last_point = int(round(process_length * float(self.sample_rate) + self.fourier_width_index)) - 1
        self.frequency = self.sample_rate / self.fourier_width_index * np.arange(self.fourier_width_index)

        self.fft_bands = 12
        self.x_axis = range(0, range_columns)
        self.fft_averages = []

        # Print updates
        print "Duration:", self.sample_duration
        print "For fourier width of:", self.fourier_width, ", need:", self.fourier_width_index, "samples each FFT"
        print "Transformations per second:", self.fouriers_per_second
        print "Total fouriers:", self.total_transforms * self.fourier_spread
        print "Spacing:", self.fourier_spacing
        print "Total transformations:", self.total_transforms

        notes = self.create_note_dict()
        for key in notes.keys():
            freq = notes[key]
            index = self.frequency_to_index(frequency=freq)
            print "Index:", freq, "Index:", index

    def get_bandwidth(self):
        return (2.0 / self.fourier_width_index) * (self.sample_rate / 2.0)

    def frequency_to_index(self, frequency):
        if frequency < self.get_bandwidth() / 2:
            return 0 # Frequency is outside of bounds
        if frequency > ((self.sample_rate / 2) - (self.get_bandwidth() / 2)):
            return self.fourier_width_index - 1
        
        fraction = float(frequency) / float(self.sample_rate)
        index = round(self.fourier_width_index * fraction)
        # print index
        return index

    def average_fft_bands(self, fft_array, range):
        del self.fft_averages[:]
        for band in range:
            average = 0.0
            if band == 0:
                low_freq = 0
            else:
                low_freq = int(int(self.sample_rate / 2) / float(2 ** (self.fft_bands - band)))
            high_freq = int((self.sample_rate / 2) / float(2 ** ((self.fft_bands - 1) - band)))
            # print low_freq, high_freq
            low_bound = int(self.frequency_to_index(low_freq))
            high_bound = int(self.frequency_to_index(high_freq))
            # print "Range:", low_bound, high_bound
            for j in range(low_bound, high_bound):
                average += fft_array[j]
            average /= (high_bound - low_bound + 1)
            self.fft_averages.append(average)

    def fft_process_audio(self):
        data_out = open("data_out", "w")
        for offset in range(0, self.total_transforms):
            start = int(offset * self.fourier_width_index)
            end = int((offset * self.fourier_width_index) + self.fourier_width_index - 1)

            process_range = self.sound_data[start:end]
            # Actually perform Fourier Time Transform
            fft_data = abs(np.fft.fft(process_range))
            fft_data *= ((2 ** 0.5) / self.fourier_width_index)
            # Plot
            plt.ylim(0, 1000)
            self.average_fft_bands(fft_data, self.x_axis)
            # IODO IMPLEMENT NEURAL OUTPUT
            # print self.fft_averages
            data_out.write(str(self.fft_averages))
            data_out.write("\n")
            y_axis = self.fft_averages
            width = 0.35
            p1 = plt.bar(self.x_axis, y_axis, width, color='r')
            # Print plot to file
            output = str('./AudioFiles/frame_%05d' % offset) + '.png'
            plt.savefig(output, dpi=300)
            plt.close()

    @staticmethod
    def create_note_dict():
        # All Notes are specified in Hertz
        # Notation:
        # [Note][Sharp(S)/Flat(F)]_[Equal Note]_[Octave]
        notes = {
            'C_3': 261.63,
            'CS_DF_3': 277.18,
            'D_3': 293.66,
            'EF_DS_3': 311.13,
            'E_3': 329.63,
            'F_3': 349.23,
            'FS_GF_3': 369.99,
            'G_3': 392.00,
            'AF_GS_3': 415.30,
            'A_3': 440.00,
            'BF_AS_3': 466.16,
            'B_3': 493.88,
            # Begin 4th Octave
            'C_4': 261.63,
            'CS_DF_4': 277.18,
            'D_4': 293.66,
            'EF_DS_4': 311.13,
            'E_4': 329.63,
            'F_4': 349.23,
            'FS_GF_4': 369.99,
            'G_4': 392.00,
            'AF_GS_4': 415.30,
            'A_4': 440.00,
            'BF_AS_4': 466.16,
            'B_4': 493.88
        }
        return notes
