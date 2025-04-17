	-- ::::::::::::::::::::::::: MODULES/ITEMS/CONTAINERS.LUA :::::::::::::::::::::::::
	-- COPIA Y PEGALO DEBAJO DE setContainerProperties('paperbag') LINEA 60 (APROX)
	setContainerProperties('radahn_pitillera', {
		slots = 10,
		maxWeight = 1000,
		whitelist = { 'radahn_cigar_custom', 'radahn_cigar_premium', 'radahn_cigar', "radahn_puro" }
	})
	
	
	-------------------------------- CAJAS DE TABACO ------------------------------------
	--- HAY QUE COPIAR Y PEGAR LOS OBJETOS EN DATA/ITEMS.LUA
	-------------------------------- CAJAS DE TABACO ------------------------------------
	["radahn_estancia"] = {
		label = 'Estancia',
		weight = 50,
		consume = 0.05,
		stack = false,
		close = true,
		description = 'Cigarros de estancia: tan finos que hasta el humo dice "con permiso" al salir.',
		server = {
			export = "radahn_smoke.cigarbox",
		}
	},
	["radahn_redwood"] = {
		label = 'Redwood',
		weight = 50,
		consume = 0.05,
		stack = false,
		close = true,
		description = 'Cigarros redwood: recomendados por 9 de cada 10 vaqueros fantasmas.',
		server = {
			export = "radahn_smoke.cigarbox",
		}
	},
	["radahn_redwood_light"] = {
		label = 'Redwood light',
		weight = 50,
		consume = 0.05,
		stack = false,
		close = true,
		description = 'Redwood light: para cuando quieres arruinar tus pulmones… pero con clase.',
		server = {
			export = "radahn_smoke.cigarbox",
		},
	},
	["radahn_premium"] = {
		label = 'Premium',
		weight = 50,
		consume = 0.05,
		stack = false,
		close = true,
		description = 'Cigarros premium: porque si vas a morir, que sea con estilo.',
		server = {
			export = "radahn_smoke.cigarbox",
		},
	},

	------------------ PAPEL DE FUMAR ----------------
	["radahn_paper"] = {
		label = 'Papel de liar',
		weight = 50,
		stack = false,
		close = true,
		description = 'Papel de liar, porque armarte el cigarro es el foreplay del vicio.',
	},
	
	---------------- TABACO -------------------
	["radahn_tabacco"] = {
		label = 'Tabaco',
		weight = 500,
		consume = 0.02,
		stack = false,
		close = true,
		description = 'Una caja de tabaco que te invita a convertirte en un maestro del arte de liar. Ideal para quienes disfrutan del proceso tanto como del resultado, y para aquellos que creen que cada cigarro debe ser una obra de arte única.',
		server = {
			export = "radahn_smoke.craftCigar",
		},
		client = {
			label = "Liando cigarro...",
			anim = { dict = "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", clip = "idle_a" },
			prop = {
				model = "p_cs_papers_02",
				bone = 28422,
				pos = { x = -0.05, y = 0.0, z = 0.0 },
				rot = { x = 0.0, y = 0.0, z = 0.0 }
			},

			usetime = 10000,
		}
	},	
	--------------- CIGARROS ------------------
	["radahn_cigar"] = {
		label = 'Cigarro',
		weight = 10,
		consume = 1,
		stack = false,
		close = true,
		description = 'El clásico de todos los días. Perfecto para quienes buscan una experiencia sin sorpresas, como el café de oficina: siempre igual, pero necesario.',
		server = {
			export = "radahn_smoke.usecigar",
		},
		client = {
			label = "Encendiendo cigarro...",
			anim = { dict = "amb@world_human_smoking@male@male_a@enter", clip = "enter" },
			prop = {
				model = "ng_proc_cigarette01a",
				bone = 28422,
				pos = { x = 0.0, y = 0.0, z = 0.0 },
				rot = { x = 0.0, y = 0.0, z = 0.0 }
			},
			usetime = 14000,
		}
	},
	["radahn_cigar_premium"] = {
		label = 'Cigarro premium',
		weight = 10,
		consume = 1,
		stack = false,
		close = true,
		description = 'Tan exclusivo que viene con su propio aura de sofisticación. Ideal para impresionar en reuniones donde nadie sabe realmente de cigarros.',
		server = {
			export = "radahn_smoke.usecigar",
		},
		client = {
			label = "Encendiendo cigarro...",
			anim = { dict = "amb@world_human_smoking@male@male_a@enter", clip = "enter" },
			prop = {
				model = "prop_cigar_03",
				bone = 28422,
				pos = { x = -0.05, y = 0.0, z = 0.0 },
				rot = { x = 0.0, y = 0.0, z = 0.0 }
			},
			usetime = 14000,
		}
	},
	["radahn_cigar_custom"] = {
		label = 'Cigarro liado',
		weight = 10,
		consume = 1,
		stack = false,
		close = true,
		description = 'Hecho a mano con amor y quizás con lo que había a mano. Perfecto para quienes disfrutan de lo artesanal y no temen a lo inesperado.',
		server = {
			export = "radahn_smoke.usecigar",
		},
		client = {
			label = "Encendiendo cigarro...",
			anim = { dict = "amb@world_human_smoking@male@male_a@enter", clip = "enter" },
			prop = {
				model = "p_cs_joint_01",
				bone = 28422,
				pos = { x = 0.0, y = 0.0, z = 0.0 },
				rot = { x = 0.0, y = 0.0, z = 0.0 }
			},
			usetime = 14000,
		}
	},
	["radahn_puro"] = {
		label = 'Puro cubano',
		weight = 10,
		consume = 1,
		stack = false,
		close = true,
		description = 'Dicen que lo consiguió su primo, que trabaja en El Laguito. O en el mercado de la esquina. O en ambos. Autenticidad garantizada por la palabra de un primo..',
		server = {
			export = "radahn_smoke.usecigar",
		},
		client = {
			label = "Encendiendo puro...",
			anim = { dict = "amb@world_human_smoking@male@male_a@enter", clip = "enter" },
			prop = {
				model = "prop_cigar_02",
				bone = 28422,
				pos = { x = 0.02, y = 0.0, z = 0.0 },
				rot = { x = 0.0, y = 180.0, z = 0.0 }
			},
			usetime = 14000,
		}
	},
	----------------------- ENCENDEDORES ---------------------------
	["radahn_exec_lighter"] = {
		label = 'Encendedor ejecutivo',
		weight = 70,
		stack = false,
		close = true,
		description = 'Para el ejecutivo que necesita encender un cigarro entre reuniones o una fogata en medio de una junta. Ideal para quienes llevan el fuego del liderazgo en el bolsillo..',
	},

	["radahn_gas_lighter"] = {
		label = 'Encendedor de gasolina',
		weight = 120,
		stack = false,
		close = true,
		description = 'No solo enciende cigarros, también puede prender fogatas, barbacoas y, si te descuidas, la casa entera. Úsalo con precaución y un extintor cerca.',
	},
	["radahn_lux_lighter"] = {
		label = 'Encendedor de lujo',
		weight = 70,
		stack = false,
		close = true,
		description = 'Un encendedor tan elegante que podría encender tu puro y tu cuenta bancaria al mismo tiempo. Porque el buen gusto también se enciende.',
	},
	["radahn_plastic_lighter"] = {
		label = 'Encendedor de plástico',
		weight = 50,
		stack = false,
		close = true,
		description = 'El clásico de los clásicos. Perfecto para encender lo que sea y luego desaparecer misteriosamente en el sofá o en el bolsillo de otro.',
	},
		-- PITILLERA, DESTINADA A TRANSPORTAR CIGARROS
	['radahn_pitillera'] = {
		label = 'Pitillera',
		weight = 50,
		stack = false,
		close = true,
		description = "La pitillera que te hace sentir como un espía internacional, aunque solo vayas al bar de la esquina. Ideal para quienes creen que el cigarro sabe mejor cuando se sirve en una caja de lujo, aun que sea mentira."
	}