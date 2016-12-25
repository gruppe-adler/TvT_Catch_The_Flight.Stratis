_allegiance = param [0, sideUnknown];

_allegiance



switch (_allegiance) do {
    case resistance: {

        _title = localize "str_GRAD_INDEP_H_title";
        _content = localize "str_GRAD_INDEP_H_story";
        _condition = localize "str_GRAD_INDEP_H_condition";
    };
    case opfor: {
        _title = localize "str_GRAD_OPFOR_H_title";
        _content = localize "str_GRAD_OPFOR_H_story";
        _condition = localize "str_GRAD_OPFOR_H_condition";        
    };
    default {};
};
