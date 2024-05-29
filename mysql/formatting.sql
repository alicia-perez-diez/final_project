USE final_project;

-- Desactiva el modo de actualización segura temporalmente
SET SQL_SAFE_UPDATES = 0;

-- FORMATEO DE LA TABLA ACCIDENT

-- Este código transforma los COUNTYNAME y CITYNAME para que después de la primera letra sea en minúscula en la tabla accident
-- Actualiza todas las filas de las columnas COUNTYNAME y CITYNAME
UPDATE accident
SET 
    COUNTYNAME = TRIM(
        CONCAT(
            UPPER(LEFT(SUBSTRING_INDEX(SUBSTRING_INDEX(COUNTYNAME, ' (', 1), ' ', 1), 1)),
            LOWER(SUBSTRING(SUBSTRING_INDEX(SUBSTRING_INDEX(COUNTYNAME, ' (', 1), ' ', 1), 2)),
            IF(
                LOCATE(' ', SUBSTRING_INDEX(COUNTYNAME, ' (', 1)) > 0,
                CONCAT(
                    ' ', 
                    UPPER(LEFT(SUBSTRING_INDEX(SUBSTRING_INDEX(COUNTYNAME, ' (', 1), ' ', -1), 1)),
                    LOWER(SUBSTRING(SUBSTRING_INDEX(SUBSTRING_INDEX(COUNTYNAME, ' (', 1), ' ', -1), 2))
                ),
                ''
            )
        )
    ),
    CITYNAME = TRIM(
        CONCAT(
            UPPER(LEFT(SUBSTRING_INDEX(SUBSTRING_INDEX(CITYNAME, ' (', 1), ' ', 1), 1)),
            LOWER(SUBSTRING(SUBSTRING_INDEX(SUBSTRING_INDEX(CITYNAME, ' (', 1), ' ', 1), 2)),
            IF(
                LOCATE(' ', SUBSTRING_INDEX(CITYNAME, ' (', 1)) > 0,
                CONCAT(
                    ' ', 
                    UPPER(LEFT(SUBSTRING_INDEX(SUBSTRING_INDEX(CITYNAME, ' (', 1), ' ', -1), 1)),
                    LOWER(SUBSTRING(SUBSTRING_INDEX(SUBSTRING_INDEX(CITYNAME, ' (', 1), ' ', -1), 2))
                ),
                ''
            )
        )
    );

-- Cambia el nombre de la columna PERMVIT a PERSONS_IN_VEHICLES
ALTER TABLE accident 
CHANGE COLUMN PERMVIT PERSONS_IN_VEHICLES INT;

-- Cambia el nombre de la columna PERNOTMVIT a PERSONS_NOT_IN_VEHICLES
ALTER TABLE accident 
CHANGE COLUMN PERNOTMVIT PERSONS_NOT_IN_VEHICLES INT;

-- Cambia el nombre de la columna PVH_INVL a PARKED_VEHICLES
ALTER TABLE accident 
CHANGE COLUMN VE_TOTAL TOTAL_VEHICLES INT;

-- Cambia el nombre de la columna PVH_INVL a PARKED_VEHICLES
ALTER TABLE accident 
CHANGE COLUMN PVH_INVL PARKED_VEHICLES INT;

-- Cambia el nombre de la columna HARM_EV a HARMFUL_EVENT
ALTER TABLE accident 
CHANGE COLUMN HARM_EV HARMFUL_EVENT INT;

-- Cambia el nombre de la columna HARM_EVNAME a HARMFUL_EVENT_NAME
ALTER TABLE accident 
CHANGE COLUMN HARM_EVNAME HARMFUL_EVENT_NAME VARCHAR(250);

-- Agrupa y modifica los valores de la columna HARMFUL_EVENT_NAME de la tabla accident
-- Maneuver
UPDATE accident SET HARMFUL_EVENT_NAME = 'Maneuver' WHERE HARMFUL_EVENT_NAME IN ('Rollover/Overturn', 'Curb');

-- Fire
UPDATE accident SET HARMFUL_EVENT_NAME = 'Fire' WHERE HARMFUL_EVENT_NAME = 'Fire/Explosion';

-- Vehicle
UPDATE accident SET HARMFUL_EVENT_NAME = 'Vehicle' WHERE HARMFUL_EVENT_NAME IN (
    'Motor Vehicle In-Transport', 
    'Railway Vehicle', 
    'Non-Motorist on Personal Conveyance', 
    'Working Motor Vehicle', 
    'Road Vehicle on Rails'
);

-- Parked vehicle
UPDATE accident SET HARMFUL_EVENT_NAME = 'Parked vehicle' WHERE HARMFUL_EVENT_NAME = 'Parked Motor Vehicle';

-- Animal
UPDATE accident SET HARMFUL_EVENT_NAME = 'Animal' WHERE HARMFUL_EVENT_NAME IN (
    'Live Animal', 
    'Ridden Animal or Animal Drawn Conveyance'
);

-- Nature barriers
UPDATE accident SET HARMFUL_EVENT_NAME = 'Nature barriers' WHERE HARMFUL_EVENT_NAME IN (
    'Tree (Standing Only)', 
    'Embankment', 
    'Boulder', 
    'Ground', 
    'Shrubbery', 
    'Immersion or Partial Immersion', 
    'Snow Bank'
);

-- Urban or traffic elements
UPDATE accident SET HARMFUL_EVENT_NAME = 'Urban or traffic elements' WHERE HARMFUL_EVENT_NAME IN (
    'Building', 
    'Bridge Pier or Support', 
    'Wall', 
    'Fire Hydrant', 
    'Bridge Overhead Structure', 
    'Bridge Rail (Includes parapet)', 
    'Culvert', 
    'Fence', 
    'Mail Box', 
    'Utility Pole/Light Support', 
    'Guardrail Face', 
    'Concrete Traffic Barrier', 
    'Guardrail End', 
    'Cable Barrier', 
    'Other Traffic Barrier', 
    'Traffic Sign Support', 
    'Post, Pole or Other Supports', 
    'Traffic Signal Support'
);

-- Object
UPDATE accident SET HARMFUL_EVENT_NAME = 'Object' WHERE HARMFUL_EVENT_NAME IN (
    'Other Object (not fixed)', 
    'Other Fixed Object', 
    'Unknown Fixed Object', 
    'Unknown Object Not Fixed', 
    'Object That Had Fallen From Motor Vehicle In-Transport', 
    'Thrown or Falling Object', 
    'Cargo/Equipment Loss, Shift, or Damage [harmful]', 
    'Motor Vehicle In-Transport Strikes or is Struck by Cargo, Persons or Objects Set-in-Motion from/by Another Motor Vehicle In Transport'
);

-- Unknown
UPDATE accident SET HARMFUL_EVENT_NAME = 'Unknown' WHERE HARMFUL_EVENT_NAME IN (
    'Harmful Event, Details Not Reported', 
    'Reported as Unknown', 
    'Fell/Jumped from Vehicle'
);

-- Pavement irregularity
UPDATE accident SET HARMFUL_EVENT_NAME = 'Pavement irregularity' WHERE HARMFUL_EVENT_NAME IN (
    'Pavement Surface Irregularity (Ruts, Potholes, Grates, etc.)', 
    'Ditch'
);

-- Impact Attenuator
UPDATE accident SET HARMFUL_EVENT_NAME = 'Impact Attenuator' WHERE HARMFUL_EVENT_NAME = 'Impact Attenuator/Crash Cushion';

-- Non-collision
UPDATE accident SET HARMFUL_EVENT_NAME = 'Non-collision' WHERE HARMFUL_EVENT_NAME IN (
    'Other Non-Collision', 
    'Injured In Vehicle (Non-Collision)', 
    'Jackknife (harmful to this vehicle)'
);

-- FORMATEO DE LA TABLA PERSON

-- Elimina la columna DEATH_DA de la tabla person
ALTER TABLE person DROP COLUMN DEATH_DA;

-- Actualiza la columna INJ_SEVNAME en person con la función REGEXP_REPLACE() para reemplazar cualquier coincidencia de texto entre paréntesis con una cadena vacía.
-- La condición WHERE asegura que solo se actualicen las filas donde la columna contiene al menos un conjunto de paréntesis.
UPDATE person
SET INJ_SEVNAME = REGEXP_REPLACE(INJ_SEVNAME, '\\s*\\([^)]+\\)', '')
WHERE INJ_SEVNAME REGEXP '\\([^)]+\\)';

-- Quita el asterisco después de Died Prior to Crash* en la columna INJ_SEVNAME de la tabla person
UPDATE person
SET INJ_SEVNAME = REPLACE(INJ_SEVNAME, '*', '')
WHERE INJ_SEVNAME LIKE 'Died Prior to Crash%*';

-- Agrupa todos los géneros que no son Male y Female en Unknown en la columna SEXNAME de person
UPDATE person
SET SEXNAME = 
    CASE 
        WHEN SEXNAME IN ('Male', 'Female') THEN SEXNAME
        ELSE 'Unknown'
    END;

-- Sustituye las filas en las que aparece 'Other Passenger in passenger or cargo area, unknown whether or not enclosed' por Unknown en SEAT_POSNAME de person
UPDATE person
SET SEAT_POSNAME = 'Unknown'
WHERE SEAT_POSNAME = 'Other Passenger in passenger or cargo area, unknown whether or not enclosed';

-- Modifica y agrupa los valores de la columna PER_TYPNAME de la tabla person
UPDATE person
SET PER_TYPNAME = CASE PER_TYPNAME
    WHEN 'Driver of a Motor Vehicle In-Transport' THEN 'Driver'
    WHEN 'Passenger of a Motor Vehicle In-Transport' THEN 'Passenger'
    WHEN 'Occupant of a Motor Vehicle Not In- Transport' THEN 'Occupant parked vehicle'
    WHEN 'Person on a Personal Conveyance' THEN 'Driver'
    WHEN 'Unknown Occupant Type in a Motor Vehicle In- Transport' THEN 'Unknown'
    WHEN 'Unknown Type of Non-Motorist' THEN 'Unknown'
    WHEN 'Person In/On a Building' THEN 'Person in a building'
    WHEN 'Occupant of a Non-Motor Vehicle Transport Device' THEN 'Bicyclist or similar'
    WHEN 'Other Pedalcyclist' THEN 'Bicyclist or similar'
    ELSE PER_TYPNAME -- Mantener el valor original si no coincide con ninguno de los casos anteriores
END;

-- Modifica y agrupa los valores de la columna SEAT_POSNAME de la tabla person
UPDATE person
SET SEAT_POSNAME = CASE SEAT_POSNAME
    WHEN 'Front Seat, Left Side' THEN 'Front left'
    WHEN 'Front Seat, Right Side' THEN 'Front right'
    WHEN 'Front Seat, Middle' THEN 'Front middle'
    WHEN 'Front Seat, Other' THEN 'Front'
    WHEN 'Front Seat, Unknown' THEN 'Front'
    WHEN 'Second Seat, Left Side' THEN 'Back left'
    WHEN 'Second Seat, Right Side' THEN 'Back right'
    WHEN 'Second Seat, Middle' THEN 'Back middle'
    WHEN 'Second Seat, Other' THEN 'Back'
    WHEN 'Second Seat, Unknown' THEN 'Back'
    WHEN 'Third Seat, Right Side' THEN 'Back right'
    WHEN 'Third Seat, Left Side' THEN 'Back left'
    WHEN 'Third Seat, Middle' THEN 'Back middle'
    WHEN 'Third Seat, Other' THEN 'Back'
    WHEN 'Third Seat, Unknown' THEN 'Back'
    WHEN 'Fourth Seat, Left Side' THEN 'Back left'
    WHEN 'Fourth Seat, Middle' THEN 'Back left'
    WHEN 'Fourth Seat, Other' THEN 'Back'
    WHEN 'Fourth Seat, Right Side' THEN 'Back right'
    WHEN 'Fourth Seat, Unknown' THEN 'Back'
    WHEN 'Not a Motor Vehicle Occupant' THEN 'Not regular vehicle'
    WHEN 'Riding on Exterior of Vehicle' THEN 'Not regular vehicle'
    WHEN 'Sleeper Section of Cab (Truck)' THEN 'Not regular vehicle'
    WHEN 'Trailing Unit' THEN 'Not regular vehicle'
    WHEN 'Other Passenger in enclosed passenger or cargo area' THEN 'Not regular vehicle'
    WHEN 'Other Passenger in unenclosed passenger or cargo area' THEN 'Not regular vehicle'
    WHEN 'Appended to a Motor Vehicle for Motion' THEN 'Not regular vehicle'
    WHEN 'Reported as Unknown' THEN 'Unknown'
    WHEN 'Not Reported' THEN 'Unknown'
    WHEN 'unknown' THEN 'Unknown'
    ELSE SEAT_POSNAME -- Mantiene el valor original si no coincide con ninguno de los casos anteriores
END;

-- Cambia el nombre de la columna SEXNAME a SEX de la tabla person
ALTER TABLE person 
CHANGE COLUMN SEXNAME SEX VARCHAR(10);

-- Cambia el nombre de la columna PER_TYP a TYPE_OF_PERSON_NUM de la tabla person
ALTER TABLE person 
CHANGE COLUMN TYPE_OF_PERSON_NUM TYPE_OF_PERSON INT;

-- Cambia el nombre de la columna PER_TYPNAME a TYPE_OF_PERSON de la tabla person
ALTER TABLE person 
CHANGE COLUMN TYPE_OF_PERSON TYPE_OF_PERSONNAME VARCHAR(100);

-- FORMATEO DE LA TABLA vehicle

-- Modifica la columna BODY_TYPNAME para quitar todos los comentarios entre paréntesis y elimina Unknown y Other al principio en la tabla vehicle
UPDATE vehicle
SET BODY_TYPNAME = 
    TRIM(
        REGEXP_REPLACE(
            REGEXP_REPLACE(
                BODY_TYPNAME, -- Elimina comentarios entre paréntesis
                '\\([^)]+\\)', -- Patrón para eliminar comentarios entre paréntesis
                ''
            ),
            '^Unknown\s*|^Other\s*', -- Elimina "Unknown" o "Other" al principio de la cadena con espacios opcionales
            '',
            1,
            0,
            'i'
        )
    );

-- Convierte la primera letra a mayúscula
UPDATE vehicle
SET BODY_TYPNAME = 
    TRIM(
        CONCAT(
            UPPER(SUBSTRING(BODY_TYPNAME, 1, 1)), -- Convierte la primera letra a mayúscula
            SUBSTRING(BODY_TYPNAME, 2) -- Mantiene el resto de la cadena
        )
    );

-- Modifica algunos de los valores de BODY_TYPNAME para mejorar la agrupación en vehicle
UPDATE vehicle
SET BODY_TYPNAME = 
    CASE
        WHEN BODY_TYPNAME = 'Or Unknown automobile type' THEN 'Utility vehicle'
        WHEN BODY_TYPNAME = 'Utility Vehicle, Unknown body type' THEN 'Utility vehicle'
        WHEN BODY_TYPNAME = '4-door sedan, hardtop' THEN 'Sedan'
        WHEN BODY_TYPNAME = 'Utility Vehicle,  body type' THEN 'Body type'
        WHEN BODY_TYPNAME = 'Vehicle type' THEN 'Body type'
        WHEN BODY_TYPNAME = '2-door sedan,hardtop,coupe' THEN '2-door sedan'
        WHEN BODY_TYPNAME = 'Farm equipment  than trucks' THEN 'Truck'
        WHEN BODY_TYPNAME = 'Van-Based Bus GVWR greater than 10,000 lbs.' THEN 'Van-Based Bus GVWR'
        WHEN BODY_TYPNAME = 'Sedan/Hardtop, number of doors' THEN 'Sedan/Hardtop'
        WHEN BODY_TYPNAME = 'Construction equipment other than trucks' THEN 'Truck'
        WHEN BODY_TYPNAME = 'Utility station wagon' THEN 'Station Wagon'
        WHEN BODY_TYPNAME = 'Construction equipment trucks' THEN 'Truck'
        WHEN BODY_TYPNAME = 'Low Speed Vehicle  / Neighborhood Electric Vehicle' THEN 'Low Speed Vehicle'
        WHEN BODY_TYPNAME = 'Body type' THEN 'Utility vehicle'
        WHEN BODY_TYPNAME = '4-door sedan' THEN 'Sedan'
        WHEN BODY_TYPNAME = 'Light Pickup' THEN 'Pickup'
        WHEN BODY_TYPNAME = 'Single-unit straight truck or Cab-Chassis' THEN 'Truck'
        WHEN BODY_TYPNAME = '5-door/4-door hatchback' THEN 'Utility vehicle'
        WHEN BODY_TYPNAME = '4-door sedan' THEN 'Sedan'
        WHEN BODY_TYPNAME = '2-door sedan' THEN 'Sedan'
        WHEN BODY_TYPNAME = '3-door/2-door hatchback' THEN 'Utility vehicle'
        WHEN BODY_TYPNAME = 'Medium/heavy Pickup' THEN 'Pickup'
        WHEN BODY_TYPNAME = 'Two Wheel Motorcycle' THEN 'Motorcycle'
        WHEN BODY_TYPNAME = 'Farm equipment other than trucks' THEN 'Truck'
        WHEN BODY_TYPNAME = 'Large Van-Includes van-based buses' THEN 'Van'
        WHEN BODY_TYPNAME = 'Off-road Motorcycle' THEN 'Motorcycle'
        WHEN BODY_TYPNAME = 'ATV/ATC [All-Terrain Cycle]' THEN 'All-Terrain Cycle'
        WHEN BODY_TYPNAME = 'Medium/Heavy Vehicle Based Motor Home' THEN 'Motor home'
        WHEN BODY_TYPNAME = 'Three-wheel Motorcycle' THEN 'Motorcycle'
		WHEN BODY_TYPNAME = 'Three Wheel Motorcycle Type' THEN 'Motorcycle'
        WHEN BODY_TYPNAME = 'Light vehicle type' THEN 'Utility vehicle'
        WHEN BODY_TYPNAME = 'Van type' THEN 'Van'
        WHEN BODY_TYPNAME = 'Step van' THEN 'Van'
        WHEN BODY_TYPNAME = 'Van-Based Bus GVWR' THEN 'Bus'
        WHEN BODY_TYPNAME = 'Medium/heavy truck type' THEN 'Truck'
        WHEN BODY_TYPNAME = 'Transit Bus' THEN 'Bus'
        WHEN BODY_TYPNAME = 'Truck type' THEN 'Truck'
        WHEN BODY_TYPNAME = 'Sedan/Hardtop' THEN 'Sedan'
        WHEN BODY_TYPNAME = '2-door sedan' THEN 'Sedan'
        WHEN BODY_TYPNAME = 'Sedan/Hardtop, number of doors unknown' THEN 'Sedan'
        WHEN BODY_TYPNAME = 'Unenclosed Three Wheel Motorcycle / Unenclosed Autocycle' THEN 'Motorcycle'
        WHEN BODY_TYPNAME = 'Cross Country/Intercity Bus' THEN 'Bus'
        WHEN BODY_TYPNAME = 'Light conventional truck type' THEN 'Truck'
        WHEN BODY_TYPNAME = 'Light truck type' THEN 'Truck'
        WHEN BODY_TYPNAME = 'Bus Type' THEN 'Bus'
        WHEN BODY_TYPNAME = 'Auto-based pickup' THEN 'Pickup'
        WHEN BODY_TYPNAME = 'L3-door coupe' THEN 'Coupe'
        WHEN BODY_TYPNAME = '3-door coupe' THEN 'Coupe'
        WHEN BODY_TYPNAME = 'Light Vehicle Based Motor Home [chassis mounted]' THEN 'Motor home'
        WHEN BODY_TYPNAME = 'Auto-based panel' THEN 'Solar electric'
        ELSE BODY_TYPNAME -- Mantener otros valores sin cambios
    END;
    
-- Modifica algunos de los valores de VPICMAKENAME para mejorar la agrupación en vehicle
        
UPDATE vehicle
SET VPICMAKENAME = 
    CASE 
        WHEN VPICMAKENAME = 'Volvo Truck' THEN 'Volvo'
        WHEN VPICMAKENAME = 'Other' THEN 'Unknown'
        WHEN VPICMAKENAME = 'Not Reported' THEN 'Unknown'
        WHEN VPICMAKENAME = 'Sprinter (Dodge or Freightliner)' THEN 'Unknown'
        WHEN VPICMAKENAME = 'Other' THEN 'Unknown'
        WHEN VPICMAKENAME = 'SPECIAL CONSTRUCTION MOTORCYCLES' THEN 'Unknown'
        WHEN VPICMAKENAME = 'SZHEJIANG XINGYUE VEHICLE CO' THEN 'Szhejiang Xingyue'
        WHEN VPICMAKENAME = 'Chongqing Zongshen Automotive Industry Co., Ltd.' THEN 'Chongqing Zongshen'
        WHEN VPICMAKENAME = 'ZHEJIANG RIYA MOTORCYCLE CO' THEN 'Zhejiang Riya'
        WHEN VPICMAKENAME = 'NINGBO SANJIANG DYKON MOTORCYCLE CO., LTD.' THEN 'Ningbo Sanjiang'
        WHEN VPICMAKENAME = 'DAELIM MOTOR CO., LTD' THEN 'Daelim Motor'
        WHEN VPICMAKENAME = 'ZheJiang Lingtian Motorcycle Co Ltd' THEN 'Zhejiang Lingtian'
        WHEN VPICMAKENAME = 'Hisun Motors Corp., USA' THEN 'Hisun Motors'
        WHEN VPICMAKENAME = 'BMC Motorcycle Co.' THEN 'BMC Motorcycle'
        WHEN VPICMAKENAME = 'Shandong Liangzi Power Co. Ltd.' THEN 'Shandong Liangzi Power'
        WHEN VPICMAKENAME = 'Fleetwood RV, Inc.' THEN 'Fleetwood RV'
        WHEN VPICMAKENAME = 'Rosenbauer Motors,LLC' THEN 'Rosenbauer Motors'
        WHEN VPICMAKENAME = 'E-Z-Go Division of Textron' THEN 'EZGO'
        WHEN VPICMAKENAME = 'Rosenbauer Motors,LLC' THEN 'Rosenbauer Motors'
        WHEN VPICMAKENAME = 'Taizhou City Kaitong Motorcycle Manufacture Co.,Ltd' THEN 'Taizhou City Kaitong Motorcycle Manufacture'
        WHEN VPICMAKENAME = 'ZHEJIANG JMSTAR SHENKE MOTORCYCLE CO' THEN 'Zhejiang Jmstar Shenke'
        WHEN VPICMAKENAME = 'YONGKANG EAGLE MOTOR CO., LTD' THEN 'Yongkang Eagle Motor'
        WHEN VPICMAKENAME = 'ZHEJIANG TAIZHOU WANGYE POWER CO' THEN 'Zhejiang Taizhou Wangye'
        WHEN VPICMAKENAME = 'Rosenbauer Motors,LLC' THEN 'Rosenbauer Motors'
        ELSE VPICMAKENAME -- Mantener otros valores sin cambios
	END;

-- Modifica la columna GVWR_FROMNAME para que los que no estén determinados sean Unknown y del resto se queda tan solo con los kg
UPDATE vehicle
SET GVWR_FROMNAME = 
  CASE 
    WHEN GVWR_FROMNAME LIKE '%Reported as Unknown%' THEN 'Unknown'
    WHEN GVWR_FROMNAME LIKE '%Not Reported%' THEN 'Unknown'
    ELSE SUBSTRING_INDEX(SUBSTRING_INDEX(GVWR_FROMNAME, '(', -1), ')', 1)
  END;

-- Modifica la columna BUS_USENAME para que los que no estén determinados sean Unknown y simplifica Private Use
UPDATE vehicle
SET BUS_USENAME = 
  CASE 
    WHEN BUS_USENAME LIKE '%Reported as Unknown%' THEN 'Unknown'
    WHEN BUS_USENAME LIKE '%Not Reported%' THEN 'Unknown'
    WHEN BUS_USENAME LIKE '%Modified for Personal/Private Use%' THEN 'Private Use'
    ELSE BUS_USENAME -- Mantener otros valores sin cambios
  END;

-- Modifica la columna SPEC_USENAME para que los que no estén determinados sean Unknown y simplifica otros valores
UPDATE vehicle
SET SPEC_USENAME = 
  CASE 
    WHEN SPEC_USENAME LIKE '%Reported as Unknown%' THEN 'Unknown'
    WHEN SPEC_USENAME LIKE '%Vehicle Used as Other Bus%' THEN 'Bus'
    WHEN SPEC_USENAME LIKE '%Vehicle Used for School Transport%' THEN 'Bus'
    WHEN SPEC_USENAME LIKE '%Rental Truck over 10,000 lbs.%' THEN 'Truck'
    WHEN SPEC_USENAME LIKE '%Towing  Incident Response%' THEN 'Unknown'
    WHEN SPEC_USENAME LIKE '%Other Incident Response%' THEN 'Unknown'
    WHEN SPEC_USENAME LIKE '%Non-Transport Emergency Services Vehicle%' THEN 'No Special Use Noted'
    WHEN SPEC_USENAME LIKE '%Motor Vehicle Used for Electronic Ride-hailing%' THEN 'Electronic Ride-hailing'
    ELSE SPEC_USENAME -- Mantener otros valores sin cambios
  END;

-- Modifica la columna EMER_USENAME para que los que no estén determinados sean Unknown y simplifica otros valores
UPDATE vehicle
SET EMER_USENAME = 
  CASE 
    WHEN EMER_USENAME LIKE '%Not Applicable%' THEN 'None'
    WHEN EMER_USENAME LIKE '%Emergency Operation, Emergency Warning Equipment in Use%' THEN 'Emergency Warning Equipment in Use'
    WHEN EMER_USENAME LIKE '%Emergency Operation, Emergency Warning Equipment in Use Unknown%' THEN 'Emergency Warning Equipment in Use Unknown'
    WHEN EMER_USENAME LIKE '%Reported as Unknown%' THEN 'Unknown'
    WHEN EMER_USENAME LIKE '%Emergency Operation, Emergency Warning Equipment Not in Use%' THEN 'Emergency Warning Equipment Not in Use'
    WHEN EMER_USENAME LIKE '%Non-Emergency, Non-Transport%' THEN 'None'
    WHEN EMER_USENAME LIKE '%Non-Emergency Transport%' THEN 'None'
    WHEN EMER_USENAME LIKE '%Not Reported%' THEN 'Unknown'
    ELSE EMER_USENAME -- Mantener otros valores sin cambios
  END;

-- Modifica la columna IMPACT1NAME para que los que no estén determinados sean Unknown y agrupa otros valores
UPDATE vehicle
SET IMPACT1NAME = 
  CASE 
    WHEN IMPACT1NAME IN ('Right-Front Side', '1 Clock Point') THEN 'Right-Front'
    WHEN IMPACT1NAME IN ('Right-Back Side', '5 Clock Point') THEN 'Right-Back'
    WHEN IMPACT1NAME IN ('Right', '2 Clock Point', '3 Clock Point', '4 Clock Point') THEN 'Right'
    WHEN IMPACT1NAME IN ('Left-Back Side', '7 Clock Point') THEN 'Left-Back'
    WHEN IMPACT1NAME IN ('Left-Front Side', '11 Clock Point') THEN 'Left-Front'
    WHEN IMPACT1NAME IN ('Left', '8 Clock Point', '9 Clock Point', '10 Clock Point') THEN 'Left'
    WHEN IMPACT1NAME = '12 Clock Point' THEN 'Front'
    WHEN IMPACT1NAME = '6 Clock Point' THEN 'Back'
    WHEN IMPACT1NAME IN ('Not Reported', 'Reported as Unknown') THEN 'Unknown'
    WHEN IMPACT1NAME IN ('Cargo/Vehicle Parts Set-In-Motion', 'Other Objects or Person Set-In-Motion', 'Object Set in Motion, Unknown if Cargo/Vehicle Parts or Other') THEN 'Vehicle, Objects or Person Set-in-motion'
    ELSE IMPACT1NAME -- Mantener los valores existentes para Non-Collision, Undercarriage, Top y otros que puedan estar no mencionados
  END;

-- Agrupa y modifica los valores de la columna VSURCONDNAME de la tabla vehicle
-- Ice
UPDATE vehicle SET VSURCONDNAME = 'Ice' WHERE VSURCONDNAME = 'Ice/Frost';

-- Non-Trafficway
UPDATE vehicle SET VSURCONDNAME = 'Non-Trafficway' WHERE VSURCONDNAME = 'Non-Trafficway or Driveway Access';

-- Unknown
UPDATE vehicle SET VSURCONDNAME = 'Unknown' WHERE VSURCONDNAME IN ('Reported as Unknown', 'Other', 'Not Reported');

-- Water
UPDATE vehicle SET VSURCONDNAME = 'Water' WHERE VSURCONDNAME = 'Water (Standing or Moving)';

-- Mud, Dirt or Gravel
UPDATE vehicle SET VSURCONDNAME = 'Mud, Dirt or Gravel' WHERE VSURCONDNAME IN ('Slush', 'Sand');

-- Los valores que no cambian se dejan tal cual:
-- Dry, Wet, Snow, Mud, Dirt or Gravel, Oil

-- Agrupa y modifica los valores de la columna L_COMPLNAME de la tabla vehicle
UPDATE vehicle 
SET L_COMPLNAME = 'Unknown' 
WHERE L_COMPLNAME = 'Unknown If CDL and/or CDL endorsement required for this vehicle';

-- Agrupa y modifica los valores de la columna SPEEDRELNAME de la tabla vehicle
-- Yes
UPDATE vehicle 
SET SPEEDRELNAME = 'Yes' 
WHERE SPEEDRELNAME IN ('Yes, Too Fast for Conditions', 'Yes, Exceeded Speed Limit', 'Yes, Specifics Unknown', 'Yes, Racing');

-- Unknown
UPDATE vehicle 
SET SPEEDRELNAME = 'Unknown' 
WHERE SPEEDRELNAME IN ('Reported as Unknown', 'No Driver Present/Unknown if Driver Present');

-- Los valores que no cambian se dejan tal cual:
-- No

-- Quita la letra, el número y el guion del principio de la frase en ACC_TYPENAME en vehicle
UPDATE vehicle
SET ACC_TYPENAME = TRIM(SUBSTRING_INDEX(ACC_TYPENAME, '-', -1));

-- Elimina la columna M_HARM y M_HARMNAME de vehicle
ALTER TABLE vehicle DROP COLUMN M_HARM;
ALTER TABLE vehicle DROP COLUMN M_HARMNAME;

-- Cambia el nombre de la columna BODY_TYP a VEHICLE_TYPE de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN BODY_TYP VEHICLE_TYPE INT;

-- Cambia el nombre de la columna BODY_TYPNAME a VEHICLE_TYPENAME de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN BODY_TYPNAME VEHICLE_TYPENAME VARCHAR(100);

-- Cambia el nombre de la columna VPICMAKE a VEHICLE_MANUFACTURER de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN VPICMAKE VEHICLE_MANUFACTURER INT;

-- Cambia el nombre de la columna VPICMAKENAME a VEHICLE_MANUFACTURERNAME de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN VPICMAKENAME VEHICLE_MANUFACTURERNAME VARCHAR(100);

-- Cambia el nombre de la columna VPICMODEL a VEHICLE_MODEL de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN VPICMODEL VEHICLE_MODEL INT;

-- Cambia el nombre de la columna VPICMODELNAME a VEHICLE_MODELNAME de la tabla vehicle
ALTER TABLE vehicle
CHANGE COLUMN VPICMODELNAME VEHICLE_MODELNAME VARCHAR(150);

-- Cambia el nombre de la columna VPICBODYCLASS a VEHICLE_CLASS de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN VPICBODYCLASS VEHICLE_CLASS INT;

-- Cambia el nombre de la columna VPICBODYCLASSNAME a VEHICLE_CLASSNAME de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN VPICBODYCLASSNAME VEHICLE_CLASSNAME VARCHAR(300);

-- Cambia el nombre de la columna GVWR_FROM a VEHICLE_WEIGHT de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN GVWR_FROM VEHICLE_WEIGHT INT;

-- Cambia el nombre de la columna GVWR_FROMNAME a VEHICLE_WEIGHTNAME de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN GVWR_FROMNAME VEHICLE_WEIGHTNAME VARCHAR(300);

-- Cambia el nombre de la columna VSURCOND a ROAD_CONDITION de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN VSURCOND ROAD_CONDITION INT;

-- Cambia el nombre de la columna VSURCONDNAME a ROAD_CONDITIONNAME de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN VSURCONDNAME ROAD_CONDITIONNAME VARCHAR(50);

-- Cambia el nombre de la columna DR_PRES a DRIVERS_PRESENCE de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN DR_PRES DRIVERS_PRESENCE INT;

-- Cambia el nombre de la columna DR_PRESNAME a DRIVERS_PRESENCENAME de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN DR_PRESNAME DRIVERS_PRESENCENAME VARCHAR(100);

-- Cambia el nombre de la columna L_COMPL a LICENSE_COMPLIANCE de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN L_COMPL LICENSE_COMPLIANCE INT;

-- Cambia el nombre de la columna L_COMPLNAME a LICENSE_COMPLIANCENAME de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN L_COMPLNAME LICENSE_COMPLIANCENAME VARCHAR(200);

-- Cambia el nombre de la columna L_RESTRI a LICENSE_RESTRICTION de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN L_RESTRI LICENSE_RESTRICTION INT;

-- Cambia el nombre de la columna L_RESTRINAME a LICENSE_RESTRICTIONNAME de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN L_RESTRINAME LICENSE_RESTRICTIONNAME VARCHAR(200);

-- Cambia el nombre de la columna PREV_ACC a PREVIOUS_ACCIDENT de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN PREV_ACC PREVIOUS_ACCIDENT INT;

-- Cambia el nombre de la columna PREV_SUS1 a PREVIOUS_SUSPENSION de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN PREV_SUS1 PREVIOUS_SUSPENSION INT;

-- Cambia el nombre de la columna PREV_DWI a PREVIOUS_DRIVING_WHILE_INTOXIDATED de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN PREV_DWI PREVIOUS_DRIVING_WHILE_INTOXIDATED INT;

-- Cambia el nombre de la columna PREV_SPD a PREVIOUS_SPEED_CONVICT de la tabla vehicle
ALTER TABLE vehicle 
CHANGE COLUMN PREV_SPD PREVIOUS_SPEED_CONVICT INT;

-- FORMATEO DE LA TABLA distract

-- Modifica los valores de la columna BODY_TYPNAME para agruparlos y formatearlos en la tabla distract
UPDATE distract
SET DRDISTRACTNAME = CASE DRDISTRACTNAME
    WHEN 'Not Reported' THEN 'Unknown'
    WHEN 'No Driver Present/Unknown if Driver present' THEN 'Unknown'
    WHEN 'Not Distracted' THEN 'Not Distracted'
    WHEN 'Other Mobile Phone Related' THEN 'Mobile'
    WHEN 'While Using or Reaching for Device/Object Brought into Vehicle' THEN 'Distraction'
    WHEN 'Distraction (Distracted), Details Unknown' THEN 'Distraction'
    WHEN 'While Manipulating Mobile Phone' THEN 'Mobile'
    WHEN 'Distracted by Outside Person, Object or Event' THEN 'Distraction'
    WHEN 'Eating or Drinking' THEN 'Eating/Drinking'
    WHEN 'Reported as Unknown if Distracted' THEN 'Unknown'
    WHEN 'By Other Occupant(s)' THEN 'Distraction'
    WHEN 'Other Distraction [Specify:]' THEN 'Distraction'
    WHEN 'Adjusting Audio Or Climate Controls' THEN 'Distraction'
    WHEN 'While Talking or Listening to Mobile Phone' THEN 'Mobile'
    WHEN 'While Using Other Component/Controls Integral to Vehicle' THEN 'Distraction'
    WHEN 'Inattention (Inattentive), Details Unknown' THEN 'Distraction'
    WHEN 'By a Moving Object in Vehicle' THEN 'Distraction'
    WHEN 'Careless/Inattentive' THEN 'Distraction'
    WHEN 'Smoking Related' THEN 'Smoking'
    WHEN 'Lost in Thought / Day dreaming' THEN 'Distraction'
    WHEN 'Distraction/Inattention' THEN 'Distraction'
    WHEN 'Distraction/Careless' THEN 'Distraction'
    ELSE DRDISTRACTNAME -- Mantener el valor original si no coincide con ninguno de los casos anteriores
END;

-- FORMATEO DE LA TABLA drugs

-- Modifica los valores de la columna DRUGRESNAME para agruparlos y formatearlos en la tabla drugs

UPDATE drugs
SET DRUGRESNAME = CASE
    WHEN DRUGRESNAME LIKE '%fentanyl%' THEN 'Opioid'
    WHEN DRUGRESNAME LIKE '%morphine%' THEN 'Opioid'
    WHEN DRUGRESNAME LIKE '%naltrexone%' THEN 'Opioid'
    WHEN DRUGRESNAME LIKE '%oxycodone%' THEN 'Opioid'
    WHEN DRUGRESNAME LIKE '%hydromorphone%' THEN 'Opioid'
    WHEN DRUGRESNAME LIKE '%tramadol%' THEN 'Opioid'
    WHEN DRUGRESNAME LIKE '%codeine%' THEN 'Opioid'
    WHEN DRUGRESNAME LIKE '%heroin%' THEN 'Opioid'
    WHEN DRUGRESNAME LIKE '%cannabinoid%' THEN 'Synthetic Cannabinoid'
    WHEN DRUGRESNAME LIKE '%barbital%' THEN 'Barbiturate'
    WHEN DRUGRESNAME LIKE '%phenobarbital%' THEN 'Barbiturate'
    WHEN DRUGRESNAME LIKE '%acetaminophen%' THEN 'OTC Analgesic'
    WHEN DRUGRESNAME LIKE '%ibuprofen%' THEN 'OTC Analgesic'
    WHEN DRUGRESNAME LIKE '%naproxen%' THEN 'OTC Analgesic'
    WHEN DRUGRESNAME LIKE '%aspirin%' THEN 'OTC Analgesic'
    WHEN DRUGRESNAME LIKE '%fluoxetine%' THEN 'Antidepressant'
    WHEN DRUGRESNAME LIKE '%citalopram%' THEN 'Antidepressant'
    WHEN DRUGRESNAME LIKE '%venlafaxine%' THEN 'Antidepressant'
    WHEN DRUGRESNAME LIKE '%paroxetine%' THEN 'Antidepressant'
    WHEN DRUGRESNAME LIKE '%bupropion%' THEN 'Antidepressant'
    WHEN DRUGRESNAME LIKE '%doxepin%' THEN 'Antidepressant'
    WHEN DRUGRESNAME LIKE '%mirtazapine%' THEN 'Antidepressant'
    WHEN DRUGRESNAME LIKE '%ketamine%' THEN 'Anesthetic'
    WHEN DRUGRESNAME LIKE '%lidocaine%' THEN 'Anesthetic'
    WHEN DRUGRESNAME LIKE '%etomidate%' THEN 'Anesthetic'
    WHEN DRUGRESNAME LIKE '%phenylephrine%' THEN 'Stimulant'
    WHEN DRUGRESNAME LIKE '%amphetamine%' THEN 'Stimulant'
    WHEN DRUGRESNAME LIKE '%caffeine%' THEN 'Stimulant'
    WHEN DRUGRESNAME LIKE '%nicotine%' THEN 'Stimulant'
    WHEN DRUGRESNAME LIKE '%methylphenidate%' THEN 'Stimulant'
    WHEN DRUGRESNAME LIKE '%diazepam%' THEN 'Depressant'
    WHEN DRUGRESNAME LIKE '%lorazepam%' THEN 'Depressant'
    WHEN DRUGRESNAME LIKE '%alprazolam%' THEN 'Depressant'
    WHEN DRUGRESNAME LIKE '%temazepam%' THEN 'Depressant'
    WHEN DRUGRESNAME LIKE '%clonazepam%' THEN 'Depressant'
    WHEN DRUGRESNAME LIKE '%haloperidol%' THEN 'Antipsychotic'
    WHEN DRUGRESNAME LIKE '%olanzapine%' THEN 'Antipsychotic'
    WHEN DRUGRESNAME LIKE '%quetiapine%' THEN 'Antipsychotic'
    WHEN DRUGRESNAME LIKE '%risperidone%' THEN 'Antipsychotic'
    ELSE 'Other'
END;

-- FORMATEO DE LA TABLA maneuver

-- Modifica los valores de la columna MANEUVERNAME para agruparlos y formatearlos en la tabla maneuver
UPDATE maneuver
SET MANEUVERNAME = CASE
    WHEN MANEUVERNAME LIKE 'Not Reported' THEN 'Unknown'
    WHEN MANEUVERNAME LIKE 'No Driver Present/Unknown if Driver present' THEN 'Unknown'
    WHEN MANEUVERNAME LIKE 'Reported as Unknown' THEN 'Unknown'
    WHEN MANEUVERNAME LIKE 'Driver Did Not Maneuver to Avoid' THEN 'No Maneuver'
    WHEN MANEUVERNAME LIKE 'Contact Motor Vehicle (In this crash)' THEN 'Contact Vehicle'
    WHEN MANEUVERNAME LIKE 'Phantom/Non-Contact Motor Vehicle' THEN 'Contact Vehicle'
    WHEN MANEUVERNAME LIKE 'Poor Road Conditions (Puddle, Ice, Pothole, etc.)' THEN 'Road Condition'
    WHEN MANEUVERNAME LIKE 'Live Animal' THEN 'Avoid Obstacle'
    WHEN MANEUVERNAME LIKE 'Pedestrian, Pedalcyclist or Other Non-Motorist' THEN 'Avoid Obstacle'
    WHEN MANEUVERNAME LIKE 'Object' THEN 'Avoid Obstacle'
    ELSE 'Other'
END;

-- FORMATEO DE LA TABLA weather

-- Modifica los valores de la columna WEATHERNAME para agruparlos y formatearlos en la tabla weather
UPDATE weather
SET WEATHERNAME = CASE
    WHEN WEATHERNAME LIKE 'Clear' THEN 'Clear'
    WHEN WEATHERNAME LIKE 'Cloudy' THEN 'Cloudy'
    WHEN WEATHERNAME LIKE 'Rain' THEN 'Rain'
    WHEN WEATHERNAME LIKE 'Blowing Snow' THEN 'Snow'
    WHEN WEATHERNAME LIKE 'Snow' THEN 'Snow'
    WHEN WEATHERNAME LIKE 'Freezing Rain or Drizzle' THEN 'Freezing'
    WHEN WEATHERNAME LIKE 'Sleet or Hail' THEN 'Freezing'
    WHEN WEATHERNAME LIKE 'Fog, Smog, Smoke' THEN 'Other'
    WHEN WEATHERNAME LIKE 'Reported as Unknown' THEN 'Unknown'
    WHEN WEATHERNAME LIKE 'Not Reported' THEN 'Unknown'
    WHEN WEATHERNAME LIKE 'Severe Crosswinds' THEN 'Windy'
    WHEN WEATHERNAME LIKE 'Blowing Sand, Soil, Dirt' THEN 'Windy'
    ELSE 'Other'
END;


-- Restaura el modo seguro de actualizaciones a su valor predeterminado.
SET SQL_SAFE_UPDATES = 1;