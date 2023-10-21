#include "script_component.hpp"
/*
 * Author: Glowbal
 * Edit: Tomcat --> added heal of airway damage
 * Local callback for fully healing a patient. 
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_medical_treatment_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_unit"];
TRACE_1("fullHealLocal",_unit);

if (!alive _unit) exitWith {};

// check if on fire, then put out the fire before healing
if ((["ace_fire"] call ACEFUNC(common,isModLoaded)) && {[_unit] call ACEFUNC(fire,isBurning)}) then {
    _unit setVariable [QACEGVAR(fire,intensity), 0, true];
};

private _state = [_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState;
TRACE_1("start",_state);

// Treatment conditions would normally limit full heal to non-unconscious units
// However, this may be called externally (through Zeus)
if (_unit getVariable [QACEGVAR(medical,inCardiacArrest), false]) then {
    TRACE_1("Exiting cardiac arrest",_unit);
    [QACEGVAR(medical,CPRSucceeded), _unit] call CBA_fnc_localEvent;
    _state = [_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState;
    TRACE_1("after CPRSucceeded",_state);
};

_unit setVariable [QACEGVAR(medical,pain), 0, true];
_unit setVariable [QACEGVAR(medical,bloodVolume), 6.0, true];

// Tourniquets
{
    if (_x != 0) then {
        [_unit, "ACE_tourniquet"] call ACEFUNC(common,addToInventory);
    };
} forEach (_unit getVariable [QACEGVAR(medical,tourniquets), [0,0,0,0,0,0]]);
_unit setVariable [QACEGVAR(medical,tourniquets), [0,0,0,0,0,0], true];
_unit setVariable [QACEGVAR(medical_treatment,occludedMedications), nil, true];

private _openWounds = _unit getVariable [VAR_OPEN_WOUNDS, []];
diag_log _openWounds;

// Wounds and Injuries
_unit setVariable [VAR_OPEN_WOUNDS, createHashMap, true];
_unit setVariable [VAR_BANDAGED_WOUNDS, createHashMap, true];
_unit setVariable [VAR_STITCHED_WOUNDS, createHashMap, true];
_unit setVariable [QACEGVAR(medical,isLimping), false, true];
_unit setVariable [QACEGVAR(medical,fractures), [0,0,0,0,0,0], true];
_unit setVariable [QGVAR(fractures), [0,0,0,0,0,0], true];
_unit setVariable [QGVAR(debridement), [0,0,0,0,0,0], true];

private _openWounds = _unit getVariable [VAR_OPEN_WOUNDS, []];
diag_log _openWounds;

// Update wound bleeding
[_unit] call ACEFUNC(medical_status,updateWoundBloodLoss);
[_unit] call ACEFUNC(medical_status,updateInternalBleeding);

// Vitals
_unit setVariable [QACEGVAR(medical,heartRate), 80, true];
_unit setVariable [QACEGVAR(medical,bloodPressure), [80, 120], true];
_unit setVariable [QACEGVAR(medical,peripheralResistance), 100, true];
_unit setVariable [QGVAR(alphaAction), 1, true];

// IV
_unit setVariable [QGVAR(IV), [0,0,0,0,0,0], true];
_unit setVariable [QGVAR(IVpfh), [0,0,0,0,0,0], true];

// AED
_unit setVariable [QGVAR(AEDvehicle), false, true];
_unit setVariable [QGVAR(X), false, true];
_unit setVariable [QGVAR(use), false, true];
_unit setVariable [QGVAR(returnedAED), true, true];
_unit setVariable [QGVAR(CPRcount), 2, true];
_unit setVariable [QGVAR(AEDvehicle), "", true];
_unit setVariable [QGVAR(vehicleTrue), false, true];

// Damage storage
_unit setVariable [QACEGVAR(medical,bodyPartDamage), [0,0,0,0,0,0], true];
// wakeup needs to be done after achieving stable vitals, but before manually reseting unconc var
if (_unit getVariable ["ACE_isUnconscious", false]) then {
    if (!([_unit] call FUNC(hasStableVitals))) then { ERROR_2("fullheal [unit %1][state %2] did not restore stable vitals",_unit,_state); };
    TRACE_1("Waking up",_unit);
    [QACEGVAR(medical,WakeUp), _unit] call CBA_fnc_localEvent;
    _state = [_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState;
    TRACE_1("after WakeUp",_state);
    if (_unit getVariable ["ACE_isUnconscious", false]) then { ERROR_2("fullheal [unit %1][state %2] failed to wake up patient",_unit,_state); };
};

// Generic medical admin
// _unit setVariable [VAR_CRDC_ARRST, false, true]; // this should be set by statemachine transition
// _unit setVariable [VAR_UNCON, false, true]; // this should be set by statemachine transition
_unit setVariable [QACEGVAR(medical,hemorrhage), 0, true];
_unit setVariable [QACEGVAR(medical,inPain), false, true];
_unit setVariable [QACEGVAR(medical,painSuppress), 0, true];

// Medication
_unit setVariable [QACEGVAR(medical,medications), [], true];

// Reset triage card since medication is reset
_unit setVariable [QACEGVAR(medical,triageCard), [], true];

[_unit] call ACEFUNC(medical_engine,updateDamageEffects);

// Reset damage
_unit setDamage 0;

[QACEGVAR(medical,FullHeal), _unit] call CBA_fnc_localEvent;
_state = [_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState;
TRACE_1("after FullHeal",_state);
