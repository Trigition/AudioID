#!/usr/bin/env python
__author__ = 'William'

from audio_proc import Audio_Factory

test = Audio_Factory('test.wav', 1024)
test.process_audio()