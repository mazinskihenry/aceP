#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Begins Ketamine Treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "RightArm", "Ketamine", objNull, "kat_ketamine"] call kat_pharma_fnc_treatmentAdvanced_Ketamine;
 *
 * Public: No
 */

params ["_patient", "_medic", "_usedItem"];

[_patient, _usedItem] call ace_medical_treatment_fnc_addToTriageCard;
//[_patient, "activity", LSTRING(push_log), [[_medic] call ace_common_fnc_getName, _usedItem]] call ace_medical_treatment_fnc_addToLog;

//[QGVAR(medicationLocal), [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
//[_patient, true] call FUNC(effectKetamine);

[_patient, true] remoteExec ["acep_circulation_fnc_effectKetamine", _patient];

/*GVAR(ppKetamineBlur) = ppEffectCreate ["RadialBlur", 110];
GVAR(ppKetamineWet) = ppEffectCreate ["WetDistortion",310];
GVAR(ppKetamineColor) = ppEffectCreate ["ColorInversion",2510];

GVAR(ppKetamineBlur) ppEffectEnable true;
GVAR(ppKetamineWet) ppEffectEnable true;
GVAR(ppKetamineColor) ppEffectEnable true;

GVAR(ppKetamineBlur) ppEffectAdjust [0.05,0.04,0.12,0.16];
GVAR(ppKetamineWet) ppEffectAdjust [4.73,0.51,0.2,1,1,1,1,0.05,0.01,0.05,0.01,0.1,0.1,0.2,0.2];
GVAR(ppKetamineColor) ppEffectAdjust [0.46,0.58,0.5];

GVAR(ppKetamineBlur) ppEffectCommit 1;
GVAR(ppKetamineWet) ppEffectCommit 3;
GVAR(ppKetamineColor) ppEffectCommit 5;

[{
	GVAR(ppKetamineBlur) ppEffectEnable false;
	GVAR(ppKetamineWet) ppEffectEnable false;
	GVAR(ppKetamineColor) ppEffectEnable false;
},[_patient], 10] call CBA_fnc_waitAndExecute;*/