#!/usr/bin/env python
__author__ = 'William'

import numpy
import matplotlib.pylab as plt

transform = numpy.load('RTTF_OUT.numpy')
print transform

transforms_per_second = 30
transform_spread = 1.0 / transforms_per_second

plt.plot(transform)
plt.show()