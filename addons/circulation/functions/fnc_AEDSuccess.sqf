#include "script_component.hpp"
/*
 * Author: Glowbal
 * Handles finishing performing CPR on the patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 1: ReviveObject <STRING> ()
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call ace_medical_treatment_fnc_cprSuccess
 *
 * Public: No
 */

params [
	["_medic",objNull,[objNull]],
	["_patient",objNull,[objNull]],
	["_reviveObject","CPR",[""]]
];

_patient setVariable [QACEGVAR(medical,CPR_provider), objNull, true];

if (GET_HEART_RATE(_patient) > 60) exitWith {
    _patient setVariable [VAR_HEART_RATE, 0, true];
    _patient setVariable [VAR_BLOOD_PRESS, [0, 0], true];
};

if (alive _patient && {_patient getVariable ["ace_medical_inCardiacArrest", false]}) then {
    [QACEGVAR(medical_treatment,cprLocal), [_medic, _patient, _defibType], _patient] call CBA_fnc_targetEvent;
};
