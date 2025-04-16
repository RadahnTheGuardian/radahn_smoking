Config = {}

Config.Actions = true -- Si se activan las acciones al usar el objeto del estilo /me


Config.Cigarrets = {
    ["radahn_cigar"] = true,
    ["radahn_cigar_premium"] = true,
    ["radahn_cigar_custom"] = true
}
Config.Lighters = {
    ["radahn_exec_lighter"] = 1.0,
    ["radahn_gas_lighter"] = 0.1,
    ["radahn_lux_lighter"] = 1.0,
    ["radahn_plastic_lighter"] = 5,
}
Config.Models = {
    ["radahn_cigar"] = "ng_proc_cigarette01a",
    ["radahn_cigar_premium"] = "prop_cigar_03",
    ["radahn_cigar_custom"] = "p_cs_joint_01",
    ["radahn_puro"] = "prop_cigar_02"
}
Config.Animations = {
    male = {
        -- [1] = {
        --     dict = "amb@world_human_aa_smoke@male@idle_a",
        --     anim = "idle_b",
        -- },
        [1] = {
            dict = "amb@world_human_aa_smoke@male@idle_a",
            anim = "idle_c",
        },
    },
    female = {
        [1] = {
            dict = "amb@world_human_smoking@female@idle_a",
            anim = "idle_b",
        },
    }
}
Config.Positions = {
    ["radahn_cigar"] = {
        x = 0.0,
        y = 0.0,
        z = 0.0,
        rot = vector3(0.0, 0.0, 0.0),
        ptfx = vector3(-0.075, 0.0, 0.0),

    },
    ["radahn_puro"] = {
        x = 0.02,
        y = 0.0,
        z = 0.0,
        rot = vector3(0.0, 180.0, 0.0),
        ptfx = vector3(0.08, 0.0, 0.0),
    },

    ["radahn_cigar_premium"] = {
        x = 0.02,
        y = 0.0,
        z = 0.0,
        rot = vector3(-186.000000, -179.000000, 0.000000),
        ptfx = vector3(0.12, 0.0, 0.0),
    },
    ["radahn_cigar_custom"] = {
        x = 0.0,
        y = 0.0,
        z = 0.0,
        rot = vector3(0.0, 0.0, 0.0),
        ptfx = vector3(-0.09, 0.0, 0.0),
    }
}
Config.MounthPositions = {
    ["radahn_puro"] = {
        x = -0.010000,
        y = 0.110000,
        z = 0.0,
        rot = vec3(-90.000000, -102.000000, 0.000000),
        ptfx = vector3(-0.075, 0.0, 0.0),
    },
    ["radahn_cigar"] = {
        x = -0.010000,
        y = 0.120000,
        z = 0.000000,
        rot = vector3(76.000000, -80.000000,0.000000),
    },
    ["radahn_cigar_premium"] = {
        x = 0.00000,
        y = 0.080000,
        z = 0.000000,
        rot = vec3(-89.000000, -104.000000, 0.000000),
    },
    ["radahn_cigar_custom"] = {
        x = -0.010000,
        y = 0.120000,
        z = 0.000000,
        rot = vector3(76.000000, -80.000000,0.000000),
    }
}