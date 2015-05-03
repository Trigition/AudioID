#!/usr/bin/env python
__author__ = 'William'

from audio_proc import Audio_Factory

test = Audio_Factory('test.wav', 24)
test.process_audio()
