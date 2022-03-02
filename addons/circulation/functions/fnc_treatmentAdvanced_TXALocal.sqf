#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Begins TXA bandaging process
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Medication <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "TXA"] call aceP_circulation_fnc_treatmentAdvanced_TXALocal;
 *
 * Public: No
 */

params ["_target", "_item"];

[_target, _item] call ace_medical_treatment_fnc_addToTriageCard;
[_target, "activity", LSTRING(push_log), [[_medic] call ace_common_fnc_getName, "TXA"]] call ace_medical_treatment_fnc_addToLog;
[_target, "TXA", 5, 120, 0, 0, 0] call ace_medical_status_fnc_addMedicationAdjustment;

[{
    params ["_args", "_idPFH"];
    _args params ["_target"];

    private _stitchableWounds = _target call ace_medical_treatment_fnc_getStitchableWounds;
    private _count = [_target, "TXA"] call ace_medical_status_fnc_getMedicationCount;

    private _alive = alive _target;

    if ((! _alive) || (_count == 0) || (_stitchableWounds isEqualTo [])) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler; 
    };

    private _bandagedWounds = GET_BANDAGED_WOUNDS(_target);
    private _stitchedWounds = GET_STITCHED_WOUNDS(_target);

    private _treatedWound = _bandagedWounds deleteAt (_bandagedWounds find (_stitchableWounds select 0));
    _treatedWound params ["_treatedID", "_treatedBodyPartN", "_treatedAmountOf"];

    private _woundIndex = _stitchedWounds findIf {
        _x params ["_classID", "_bodyPartN"];

        _classID == _treatedID && {_bodyPartN == _treatedBodyPartN}
    };

    if (_woundIndex == -1) then {
        _stitchedWounds pushBack _treatedWound;
    } else {
        private _wound = _stitchedWounds select _woundIndex;
        _wound set [2, (_wound select 2) + _treatedAmountOf];
    };

    _target setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];
    _target setVariable [VAR_STITCHED_WOUNDS, _stitchedWounds, true];

}, 8, [_target]] call CBA_fnc_addPerFrameHandler;

true