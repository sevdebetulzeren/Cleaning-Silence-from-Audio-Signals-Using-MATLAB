# Cleaning-Silence-from-Audio-Signals-Using-MATLAB
Removing empty frames from the audio recording and eliminating silences

Silence Removal from Audio Signals using MATLAB
This MATLAB script is designed to automatically detect and remove silent segments (pauses) from an audio recording (in .m4a format). It processes the audio to isolate segments containing speech or sound and concatenates them.
This process implements a simple form of Voice Activity Detection (VAD) by using fundamental audio features, primarily Energy and (though calculated but not used for filtering) Zero Crossing Rate (ZCR).

Project Aim
The main goal is to analyze an audio file, discard low-energy (silent) segments, and create a more compact audio file by joining the remaining active segments.

How It Works
The script follows these logical steps:
Audio Loading: The 'Kayıt.m4a' file is read using audioread. If the audio is stereo, it is converted to mono.

Parameter Definition:
nf = 30 ms: The duration of each analysis frame.
n_over = 14 ms: The duration of the overlap between consecutive frames. This prevents abrupt cuts or loss of information at frame boundaries.

Framing: The audio signal is divided into short segments (frames) based on the defined duration and overlap. A hamming window is applied to each frame to reduce edge effects (spectral leakage).

Feature Extraction: Two key features are calculated for each frame:

Energy (energies): The sum of the squared amplitudes within the frame. High energy typically indicates the presence of sound, while low energy indicates silence.

Zero Crossing Rate (zero_crossing): The number of times the signal's sign changes (crossing the zero axis). This is often used to distinguish between voiced speech and unvoiced noise.

Silence Detection:
The calculated energy values are normalized to a range between 0 and 1.
An energy_threshold = 0.02 (2%) is set. % The threshold of the recorded audio can vary.
Frames with energy below this threshold are classified as "silent," and those above it are classified as "active sound."

Signal Reconstruction:
An empty signal named reconstructed_signal is initialized.
The script iterates through all frames.
If a frame's energy is higher than the threshold (i.e., it is "active"), the original (non-windowed) segment corresponding to that frame is appended to the reconstructed_signal.

Visualization and Playback:
A 4-panel figure is plotted to analyze the results:
Original Signal
Silence-Removed (Reconstructed) Signal
Frame-based Energy
Frame-based Zero Crossing Rate

Finally, the sound function plays the silence-removed reconstructed_signal.
