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
 * [player, "TXA"] call kat_pharma_fnc_treatmentAdvanced_TXALocal;
 *
 * Public: No
 */

params ["_target", "_item", "_medic"];

[_target, _item] call ace_medical_treatment_fnc_addToTriageCard;
[_target, "activity", LSTRING(push_log), [[_medic] call ace_common_fnc_getName, "TXA"]] call ace_medical_treatment_fnc_addToLog;
[_target, "TXA", 5, 120, 0, 0, 0] call ace_medical_status_fnc_addMedicationAdjustment;

[{
    private _target = _this select 0;
    _target setVariable [QGVAR(TXA), 1, true];
}, [_target], 180] call CBA_fnc_waitAndExecute;

[{
    params ["_args", "_idPFH"];
    _args params ["_target"];

    private _openWounds = _target getVariable [VAR_OPEN_WOUNDS, []];
    private _count = [_target, "TXA"] call ace_medical_status_fnc_getMedicationCount;
    private _alive = alive _target;

    if ((!_alive) || (_count == 0) || (_openWounds isEqualTo [])) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    {
        _x params ["_id", "_bodyPart", "_amount"];

        if ((_id != 20) && (_amount > 0)) exitWith {
            private _part = ALL_BODY_PARTS select _bodyPart;
            ["ace_medical_treatment_bandageLocal", [_target, _part, "PackingBandage"], _target] call CBA_fnc_targetEvent;
        };

    } forEach _openWounds;

}, 6, [_target]] call CBA_fnc_addPerFrameHandler;

true