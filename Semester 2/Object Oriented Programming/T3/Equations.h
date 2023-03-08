#pragma once
#include <string>

class Equation {
private:
	double coef_a;
	double coef_b;
	double coef_c;
public:
	Equation(double coef_a1, double coef_b1, double coef_c1);
	const double& get_a()const;
	const double& get_b()const;
	const double& get_c() const;
};