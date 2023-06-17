#include <stdio.h>
#include <math.h>
#include "portaudio.h"

#define SAMPLE_RATE (44100)
#define PA_SAMPLE_TYPE paFloat32
#define FRAMES_PER_BUFFER (64)

typedef float SAMPLE;

// コールバック関数
static int ioCallback ( 
    const void *inputBuffer 
,   void *outputBuffer
,   unsigned long framesPerBuffer
,   const PaStreamCallbackTimeInfo* timeInfo
,   PaStreamCallbackFlags statusFlags
,   void *userData 
) {
    SAMPLE *out = (SAMPLE*)outputBuffer;
    const SAMPLE *in = (const SAMPLE*)inputBuffer;
    unsigned int i;
    /* Prevent unused variable warnings. */
    (void) timeInfo;
    (void) statusFlags;
    (void) userData;
    
    if( inputBuffer == NULL) {
        for( i=0; i<framesPerBuffer; i++ ) {
            *out++ = 0;
            *out++ = 0;
        }
    }
    else {
        for( i=0; i<framesPerBuffer; i++ ) {
            *out++ = *in;
            *out++ = *in++;
        }
    }
    return paContinue;
}


int main(void) {
    PaStreamParameters inputParameters, outputParameters;
    PaStream *stream;
    PaError err;

    err = Pa_Initialize();
    if( err != paNoError ) {
        Pa_Terminate();
        return 1;
    }
    
    /* デフォルトインプットデバイス */
    inputParameters.device = Pa_GetDefaultInputDevice();
    if (inputParameters.device == paNoDevice) {
        printf("Error: No default input device.\n");
        Pa_Terminate();
        return 1;
    }
    inputParameters.channelCount = 1; /* モノラルインプット */
    inputParameters.sampleFormat = PA_SAMPLE_TYPE;
    inputParameters.suggestedLatency = Pa_GetDeviceInfo( inputParameters.device )->defaultLowInputLatency;
    inputParameters.hostApiSpecificStreamInfo = NULL;
    
    /* デフォルトアウトプットデバイス */
    outputParameters.device = Pa_GetDefaultOutputDevice();
    if (outputParameters.device == paNoDevice) {
        printf("Error: No default output device.\n");
        Pa_Terminate();
        return 1;
    }
    outputParameters.channelCount = 2; /* ステレオアウトプット */
    outputParameters.sampleFormat = PA_SAMPLE_TYPE;
    outputParameters.suggestedLatency = Pa_GetDeviceInfo( outputParameters.device )->defaultLowOutputLatency;
    outputParameters.hostApiSpecificStreamInfo = NULL;

    err = Pa_OpenStream(
        &stream
    ,   &inputParameters
    ,   &outputParameters
    ,   SAMPLE_RATE
    ,   FRAMES_PER_BUFFER
    ,   0
    ,   ioCallback
    ,   NULL 
    );
    if( err != paNoError ) {
        Pa_Terminate();
        return 1;
    }
    err = Pa_StartStream( stream );
    if( err != paNoError ) {
        Pa_Terminate();
        return 1;
    }
    
    printf("Hit ENTER to stop program.\n");
    getchar();

    err = Pa_StopStream( stream );
    if( err != paNoError ) {
        Pa_Terminate();
        return 1;
    }
    err = Pa_CloseStream( stream );
    if( err != paNoError ) {
        Pa_Terminate();
        return 1;
    }
    printf("Finished\n");
    Pa_Terminate();
    return 0;
}
