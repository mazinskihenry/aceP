#include "script_component.hpp"

/*["ACE Pharmacy", "Minor Wounds",
    {
        params ["_modulePos", "_objectPos"];
    		private _patient = _objectPos;

			if (_objectPos isKindOf "Man") exitWith {
    			private _limb1 = selectRandom["leftarm","rightarm","leftleg","rightleg"];

    			[_patient, selectRandom[0.3,0.4,0.5], "body", "stab"] call ace_medical_fnc_addDamageToUnit;
    			[_patient, selectRandom[0.3,0.4,0.5], _limb1, "stab"] call ace_medical_fnc_addDamageToUnit;

    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;

    			[_patient, _patient, _limb1, "", objNull, "ACE_tourniquet"] call ace_medical_treatment_fnc_tourniquet;

    			_patient setVariable ["ace_medical_bloodVolume", selectRandom[5.2,5.3,5.4,5.5], true];
			};
        //[_modulePos, _objectPos] call FUNC(zeusMinorWounds);    
    },
    "\A3\ui_f\data\map\vehicleicons\iconManVirtual_ca.paa"
] call zen_custom_modules_fnc_register;

["ACE Pharmacy", "2 - Moderate Wounds",
    {
        params ["_modulePos", "_objectPos"];
    		private _patient = _objectPos;

			if (_objectPos isKindOf "Man") exitWith {
    			private _limb1 = selectRandom["leftarm","rightarm","leftleg","rightleg"];
    			private _limb2 = selectRandom["leftarm","rightarm","leftleg","rightleg"];  
    			private _limb3 = selectRandom[1,2];
    			private _random = selectRandom["shell","bullet","bullet"];


    			if (_limb3 == 2) then {
        			_limb3 = selectRandom["leftarm","rightarm","leftleg","rightleg"];  
            		[_patient, selectRandom[1.3,1.4,1.5], _limb2, "bullet"] call ace_medical_fnc_addDamageToUnit;
    				[_patient, _patient, _limb3, "", objNull, "ACE_tourniquet"] call ace_medical_treatment_fnc_tourniquet;
    			};  			

    			[_patient, selectRandom[1.2,1.3,1.4,1.9], "body", "bullet"] call ace_medical_fnc_addDamageToUnit;
    			[_patient, selectRandom[0.8,0.9,1], _limb1, "bullet"] call ace_medical_fnc_addDamageToUnit;
    			[_patient, selectRandom[0.5,0.6,0.7,0.8,0.9,1], _limb2, _random] call ace_medical_fnc_addDamageToUnit;
    			[_patient, selectRandom[0.8,0.9,1], _limb2, "bullet"] call ace_medical_fnc_addDamageToUnit;
        		[_patient, selectRandom[1.3,1.4,1.5], _limb2, "bullet"] call ace_medical_fnc_addDamageToUnit;

    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;

    			[_patient, _patient, _limb1, "", objNull, "ACE_tourniquet"] call ace_medical_treatment_fnc_tourniquet;
    			[_patient, _patient, _limb2, "", objNull, "ACE_tourniquet"] call ace_medical_treatment_fnc_tourniquet;

    			_patient setVariable ["ace_medical_bloodVolume", selectRandom[5.1,5.0,4.8,4.6,4.5,4.4], true];
			};
        //[_modulePos, _objectPos] call FUNC(zeusMinorWounds);    
    },
    "\A3\ui_f\data\map\vehicleicons\iconManVirtual_ca.paa"
] call zen_custom_modules_fnc_register;

["ACE Pharmacy", "3 - Major Wounds",
    {
        params ["_modulePos", "_objectPos"];
    		private _patient = _objectPos;

			if (_objectPos isKindOf "Man") exitWith {
    			private _limb1 = selectRandom["leftarm","rightarm","leftleg","rightleg"];
    			private _limb2 = selectRandom["leftarm","rightarm","leftleg","rightleg"];  
    			private _limb3 = selectRandom["leftarm","rightarm","leftleg","rightleg"];
    			private _limb4 = selectRandom[1,2];
    			private _random = selectRandom["shell","grenade","bullet"];

    			if (_limb4 == 2) then {
        			_limb4 = selectRandom["leftarm","rightarm","leftleg","rightleg"];  
            		[_patient, selectRandom[1.3,1.4,1.5], _limb4, "shell"] call ace_medical_fnc_addDamageToUnit;
    				[_patient, _patient, _limb4, "", objNull, "ACE_tourniquet"] call ace_medical_treatment_fnc_tourniquet;
    			};	

    			[_patient, selectRandom[1.2,1.3,1.4,1.9], "body", "bullet"] call ace_medical_fnc_addDamageToUnit;
    			[_patient, selectRandom[2.0,2.2,2.4,2.6], _limb1, "bullet"] call ace_medical_fnc_addDamageToUnit;
    			[_patient, selectRandom[0.2,0.3,0.4], _limb2, _random] call ace_medical_fnc_addDamageToUnit;
        		[_patient, selectRandom[2.0,2.2,2.4,2.6], _limb2, "bullet"] call ace_medical_fnc_addDamageToUnit;
    			[_patient, selectRandom[2.5,2.7,2.9], _limb3, "bullet"] call ace_medical_fnc_addDamageToUnit;
        		[_patient, selectRandom[2.0,2.2,2.4,2.6], _limb3, "bullet"] call ace_medical_fnc_addDamageToUnit;

    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "body", "QuikClot"] call ace_medical_treatment_fnc_bandage;

    			[_patient, _patient, "head", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "head", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "head", "QuikClot"] call ace_medical_treatment_fnc_bandage;
    			[_patient, _patient, "head", "QuikClot"] call ace_medical_treatment_fnc_bandage;

    			[_patient, _patient, _limb1, "", objNull, "ACE_tourniquet"] call ace_medical_treatment_fnc_tourniquet;
    			[_patient, _patient, _limb2, "", objNull, "ACE_tourniquet"] call ace_medical_treatment_fnc_tourniquet;
    			[_patient, _patient, _limb3, "", objNull, "ACE_tourniquet"] call ace_medical_treatment_fnc_tourniquet;

    			_patient setVariable ["ace_medical_bloodVolume", selectRandom[4.5,4.4,4.3,4.0,3.5], true];
			};
        //[_modulePos, _objectPos] call FUNC(zeusMinorWounds);    
    },
    "\A3\ui_f\data\map\vehicleicons\iconManVirtual_ca.paa"
] call zen_custom_modules_fnc_register;

["ACE Pharmacy", "4 - Sedate",
    {
        params ["_modulePos", "_objectPos"];
    		private _patient = _objectPos;

			if (_objectPos isKindOf "Man") exitWith {
    			_objectPos setVariable [QEGVAR(circulation,sedated), true, true];
    			[_objectPos, true] call ace_medical_fnc_setUnconscious;
			};
        //[_modulePos, _objectPos] call FUNC(zeusMinorWounds);    
    },
    "\A3\ui_f\data\map\vehicleicons\iconManVirtual_ca.paa"
] call zen_custom_modules_fnc_register;

["ACE Pharmacy", "5 - Fracture",
    {
        params ["_modulePos", "_objectPos"];
    		private _patient = _objectPos;

			if (_objectPos isKindOf "Man") exitWith {
				private _activeFracture = GET_FRACTURES(_patient);
				private _fractureArray = selectRandom[2,3,4,5];

				_activeFracture set [_fractureArray, 1];

				_objectPos setVariable [VAR_FRACTURES, _activeFracture, true];
			};
        //[_modulePos, _objectPos] call FUNC(zeusMinorWounds);    
    },
    "\A3\ui_f\data\map\vehicleicons\iconManVirtual_ca.paa"
] call zen_custom_modules_fnc_register; */