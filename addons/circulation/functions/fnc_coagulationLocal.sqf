#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Opens an IV/IO on a patient and changes the patient's flow variable
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Coagulation Value <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 10] call aceP_circulation_fnc_coagulationLocal;
 *
 * Public: No
 */

params ["_patient", "_value"];

private _factor = _patient getVariable [QGVAR(coagulationFactor), 10];
_final = (_factor + _value) min 30;
_patient setVariable [QGVAR(coagulationFactor), (_final), true];
