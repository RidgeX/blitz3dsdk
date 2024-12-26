
#ifndef WAVEFORM_H
#define WAVEFORM_H

struct waveform{
	void *samples;
	int length;	//in samples
	int hertz; //sample rate
	int channels; //1 or 2
	int bits; //8 or 16
	int capacity;
};

waveform *LoadWaveform(const char *path);
waveform *ConvertWaveform( waveform *src,int channels,int bits );

#endif
