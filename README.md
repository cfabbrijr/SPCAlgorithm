# SPCAlgorithm - Single Pixel Cam Algorithm
### Repo with algorithms from my Master´s Thesis about Compressive Sensing Multispectral Image Recovering using a Single Pixel Camera, presented at Universidade de São Paulo, Escola Politécnica - POLI, Engenharia Elétrica, July 2020.

The files contained are:

1. example_original_stuart_code.m          -- The original code from Stuart Gibson, @2013.

1. exemplo_stuart_original                 -- The original code - only the file´s name is in brazilian portuguese.

1. codigodmd_l1eqpd.m                      -- Code with the l1eqpd solver from the *l1-magic* package.

1. codigodmd_l1eqpd_LenaRosto.m            -- Code with the l1eqpd solver from the *l1-magic* package and the Lena image.

1. codigodmd_l1eqpdvazio.m                 -- Code with the l1eqpd solver from the *l1-magic* package with some tweaks.

1. codigodmd_l1qclogbarrier.m              -- Code with the l1qclogbarrier solver from the *l1-magic* package.

1. codigodmd_l1qclogbarrier_LenaRosto.m    -- Code with the l1qclogbarrier solver from the *l1-magic* package and the Lena image.


The original Stuart Gibson code could be obtained at: 
https://www.mathworks.com/matlabcentral/fileexchange/41792-simple-compressed-sensing-example?focused=3783702&tab=function

### Compressive Sensing history and explanation

Compressive Sensing or Compressed Sampling is a new theory that defies the known sampling theorem from Claude Shannon.
It states that we can recover information from an image or a signl based on it´s information content and not it´s resolution or it´s frequency content.

Emanuel Candès, Terence Tao and Justin Romberg wrote the first articles back in 2006.[2] 
David Donoho also wrote some previous papers around the theme in 2006.[3]

In 2005 Candès and Romberg released a set of algorithms they use to experiment with the technique, and called "*l1*magic.[4]

Stuart Gibson wrote it´s understanding from one of this algorithms in 2011. Link is above.[1]

I use the Matlab software program to program the algorithm, but could use others softwares as Octave or Scilab.

### Single Pixel Cam - Reasons for it´s development

Our smartphones have more than one camera and the manufacturers advertise as a key feature, the amount of pixels that you can get using the camera.
This Megapixels phones explore one specific coincidence:  the silicon sensors present in the camera operates at the visible light spectrum! That´s why as 
we manufacture billions of smartphones we lower the cost of such silicon sensors. It´s a bandwagon effect.

But if you have to deal with phenomena that happens in frequencies other than the visible, as Infrared (IR) or Ultraviolet (UV), your $400 phone or camera will cost 
$50.000 !! Just because the cost of each an one of those specials sensors for that off mainstream frequencies.

The Single Pixel Cam uses only one sensor together linear programmimg algorithm to sense and sample an image and  posteriorly recover the image. See figure 1 below.

 !(single pixel cam)
Fig.1 – Single pixel cam diagram . Adapted from [6].



* [1] https://www.mathworks.com/matlabcentral/fileexchange/41792-simple-compressed-sensing-example?focused=3783702&tab=function
* [2]	E. Candès, J. Romberg, T. Tao, “Robust Uncertainty Principles: exact signal reconstruction from highly incomplete frequency information”, in IEEE trans. Inform. Theory, 52(2, pp 489-509, February 2006.
* [3]	D.L. Donoho, “Compressed Sensing” in IEEE Trans. Inform. Theory v.52, pp 1289-1306, September 2006.
* [4]	E. Candès, J. Romberg, l1magic, 2005- Available in https://statweb.stanford.edu/candes/l1magic/ . Access on July 2018.


Carlos Fabbri Jr

Created at march, 01, 2020.

