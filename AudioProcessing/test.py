#!/usr/bin/python2.7

import numpy as np
from matplotlib import pyplot as plt
import scipy.io.wavfile as wav
from numpy.lib import stride_tricks

#This is a quick implemntation of showing spectrum analysis
#Source: http://www.frank-zalkow.de/en/code-snippets/create-audio-spectrograms-with-python.html

def fourier_transform(audioSig, encodingSize):
    print "performing fourier transform"
    overlapFreq = 0.5
    print "Creation of window with Numpy"
    window = np.hanning
    print "Creation of window is completing"

    frame = window(encodingSize)
    hopSize = int(encodingSize - np.floor(overlapFreq * encodingSize))

    ###Process for samples from Audio Signal
    #Pad our samples with zeros for processing sanitation
    samples = np.append(np.zeros(np.floor(encodingSize/2.0)), audioSig)
    
    #Ensure our transform will fit our encoding size
    columns = np.ceil( (len(samples) - encodingSize) / float(hopSize)) + 1

    #Pad our samples with zeros for processing sanitation
    samples = np.append(samples, np.zeros(frameSize))
    
    frames = stride_tricks.as_strided(samples, shape=(columns, frameSize), strides=(samples.strides[0]*hopSize, samples.strides[0])).copy()
    frames *= win
            
    return np.fft.rfft(frames)

""" scale frequency axis logarithmically """    
def logscale_spec(spec, sr=44100, factor=20.):
    print "performing log scaling of waveform"
    timebins, freqbins = np.shape(spec)

    scale = np.linspace(0, 1, freqbins) ** factor
    scale *= (freqbins-1)/max(scale)
    scale = np.unique(np.round(scale))
                        
    # create spectrogram with new freq bins
    print "creating spectrogram"
    newspec = np.complex128(np.zeros([timebins, len(scale)]))
    for i in range(0, len(scale)):
        if i == len(scale)-1:
            newspec[:,i] = np.sum(spec[:,scale[i]:], axis=1)
        else:        
            newspec[:,i] = np.sum(spec[:,scale[i]:scale[i+1]], axis=1)
                                                                                            
        # list center freq of bins
        allfreqs = np.abs(np.fft.fftfreq(freqbins*2, 1./sr)[:freqbins+1])
        freqs = []
        for i in range(0, len(scale)):
            if i == len(scale)-1:
                freqs += [np.mean(allfreqs[scale[i]:])]
            else:
                freqs += [np.mean(allfreqs[scale[i]:scale[i+1]])]                                                                                                                                                            
    return newspec, freqs

""" plot spectrogram"""
def plotstft(audiopath, binsize=2**10, plotpath=None, colormap="jet"):
    print "Performing analysis for creation of spectrogram"
    samplerate, samples = wav.read(audiopath)
    print "Waveform analyzed"
    s = fourier_transform(samples, binsize)
    print "Performed Fourier Analysis"                                                                                                                                                                                
    sshow, freq = logscale_spec(s, factor=1.0, sr=samplerate)
    ims = 20.*np.log10(np.abs(sshow)/10e-6) # amplitude to decibel
                                                                                                                                                                                                
    timebins, freqbins = np.shape(ims)
                                                                                                                                                                                                        
    plt.figure(figsize=(15, 7.5))
    plt.imshow(np.transpose(ims), origin="lower", aspect="auto", cmap=colormap, interpolation="none")
    plt.colorbar()

    plt.xlabel("time (s)")
    plt.ylabel("frequency (hz)")
    plt.xlim([0, timebins-1])
    plt.ylim([0, freqbins])

    xlocs = np.float32(np.linspace(0, timebins-1, 5))
    plt.xticks(xlocs, ["%.02f" % l for l in ((xlocs*len(samples)/timebins)+(0.5*binsize))/samplerate])
    ylocs = np.int16(np.round(np.linspace(0, freqbins-1, 10)))
    plt.yticks(ylocs, ["%.02f" % freq[i] for i in ylocs])
                                                                                                                                                                                                                                                        
    if plotpath:
        plt.savefig(plotpath, bbox_inches="tight")
    else:
        plt.show()
    plt.clf()

plotstft("test.wav")
