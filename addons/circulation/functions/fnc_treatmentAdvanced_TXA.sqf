#include "script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for occluding
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_accuvac;
 *
 * Public: Yes
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];

if (local _patient) then {
    ["treatmentTXA", [_patient, _bodyPart]] call CBA_fnc_localEvent;
} else {
    ["treatmentTXA", [_patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
};

true;