#include "script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for occluding local
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Item classname <STRING>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *`
 * Example:
 * [player, "Accuvac"] call kat_airway_fnc_treatmentAdvanced_accuvacLocal;
 *
 * Public: No
 */

params ["_medic", "_target", "_item"];

if ([_target] call ace_medical_status_fnc_hasStableVitals) then {
    ["ace_medical_WakeUp", _target] call CBA_fnc_localEvent;
};

[_target, _item] call ace_medical_treatment_fnc_addToTriageCard;
[_target, "activity", LSTRING(use_log), [[_medic] call ace_common_fnc_getName, "Carbonate"]] call ace_medical_treatment_fnc_addToLog;

true
