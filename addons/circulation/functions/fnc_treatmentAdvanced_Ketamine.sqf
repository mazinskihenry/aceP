#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Generic Medication Function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Item Classname <STRING>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_Generic;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if (local _patient) then {
    ["treatmentKetamine", [_patient, _medic, "Ketamine"]] call CBA_fnc_localEvent;
} else {
    ["treatmentKetamine", [_patient, _medic, "Ketamine"], _patient] call CBA_fnc_targetEvent;
};

true;