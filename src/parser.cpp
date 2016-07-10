#include "parser.h"

#include <hsm/lang/grammar/grammar.h>

namespace hsm{
namespace lang{

parser::parser(lang::grammar *g){
	_g = g;
}

lang::grammar *parser::grammar() const{
	return _g;
}

}
}
