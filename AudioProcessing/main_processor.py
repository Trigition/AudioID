#!/usr/bin/env python
__author__ = 'William'

from audio_proc import Audio_Factory

test = Audio_Factory('New Avengers.wav', 24)
test.fft_process_audio()
