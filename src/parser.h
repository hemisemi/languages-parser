#pragma once

namespace hsm{
namespace lang{

class grammar;

class parser{
public:
	parser(lang::grammar *grammar);

	lang::grammar *grammar() const;

private:
	lang::grammar *_g;
};

}
}
