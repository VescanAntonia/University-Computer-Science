#include "Equations.h"

Equation::Equation(double coef_a1, double coef_b1, double coef_c1): coef_a(coef_a1), coef_b(coef_b1), coef_c(coef_c1)
{
}

const double& Equation::get_a() const
{
	return this->coef_a;
}

const double& Equation::get_b() const
{
	return this->coef_b;
}

const double& Equation::get_c() const
{
	return this->coef_c;
}
