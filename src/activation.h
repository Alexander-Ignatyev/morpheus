/*! \file activation.h
  \brief Activation functions
*/

#ifndef MORHEPUS_ACTIVATION_H
#define MORHEPUS_ACTIVATION_H


/*! \defgroup activation activation
  \brief Activation functions
  \{
*/

/*! Calculates sigmoid. */
void morpheus_sigmoid(int n, const double *x, double *y);

/*! Calculates derivatives of sigmoid. */
void morpheus_sigmoid_gradient(int n, const double *x, double *y);

/*! \} */

#endif  /* MORHEPUS_ACTIVATION_H */
