local m = 1000
local trailtarget = "effects/bloodstream"
local sw = 10
local ew = 1
local lifetime = 7
local div = 1
local x = 2
local tws = 0.1
local te = true
local bl = 1
local hs = true

local whitelistmodel = { "models/zombie/fast.mdl", "models/zombie/zombie_soldier.mdl", "models/zombie/classic.mdl", "models/zombie/poison.mdl", "models/vortigaunt_doctor.mdl", "models/vortigaunt.mdl", "models/vortigaunt_slave.mdl" }

local blacklistmodel = { "models/pigeon.mdl", "models/seagull.mdl", "models/crow.mdl" }

local function bloodtouch( ent, data )
	if IsValid( ent ) and data.Speed > 20 and data.DeltaTime > 0.1 then
		local trace = {}

		trace.filter = { ent }

		data.HitNormal = data.HitNormal * -1 -- make it negative
		local start = data.HitPos + data.HitNormal
		local endpos = data.HitPos - data.HitNormal
		ent:EmitSound( "Flesh_Bloody.ImpactHard" )
		local effectdata = EffectData()
		effectdata:SetOrigin( start )
		util.Effect( "BloodImpact", effectdata )
		util.Decal( "Blood", start, endpos )
	end
end

concommand.Add( "disable_gib_trails", function( ply, cmd, args )
	if ply:IsSuperAdmin() then
		te = false
	end
end )

concommand.Add( "enable_gib_trails", function( ply, cmd, args )
	if ply:IsSuperAdmin() then
		te = true
	end
end )

concommand.Add( "enable_headshot_effect", function( ply, cmd, args )
	if ply:IsSuperAdmin() then
		hs = true
	end
end )

concommand.Add( "disable_headshot_effect", function( ply, cmd, args )
	if ply:IsSuperAdmin() then
		hs = false
	end
end )

function spawnmeat( pos, vec )
	local ent = ents.Create( "prop_physics" )
	ent:SetModel( "models/props_junk/Rock001a.mdl" )

	if ent:IsValid() then
		local dir = ( pos * x + VectorRand( m, x ) ) / div
		dir:Normalize()
		ent:SetMaterial( "models/flesh" )
		ent:SetPos( pos + Vector( -10, 0, 45 ) )
		ent:SetCollisionGroup( 1 )
		ent:AddCallback( "PhysicsCollide", bloodtouch )
		ent:Spawn()

		if te then
			util.SpriteTrail( ent, 0, Color( 102, 0, 0 ), false, sw, ew, lifetime, tws, trailtarget )
		end

		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial( "zombieflesh" )
			phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
			phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
			phys:SetMass( phys:GetMass() * bl )
		end

		SafeRemoveEntityDelayed( ent, 25 )
	end
end

function spawnmeatt( pos, vec )
	local ent = ents.Create( "prop_physics" )
	ent:SetModel( "models/props_junk/Rock001a.mdl" )

	if ent:IsValid() then
		local dir = ( pos * x + VectorRand( m, x ) ) / div
		dir:Normalize()
		ent:SetMaterial( "models/flesh" )
		ent:SetPos( pos + Vector( -10, 0, 45 ) )
		ent:SetCollisionGroup( 1 )
		ent:AddCallback( "PhysicsCollide", bloodtouch )
		ent:Spawn()
		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial( "zombieflesh" )
			phys:SetVelocityInstantaneous( vec )
			phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
			phys:SetMass( phys:GetMass() * bl )
		end

		SafeRemoveEntityDelayed( ent, 25 )
	end
end

function spawnmeat2( pos, vec )
	local ent = ents.Create( "prop_physics" )
	ent:SetModel( "models/props_junk/watermelon01_chunk01b.mdl" )

	if ent:IsValid() then
		local dir = ( pos * x + VectorRand( m, x ) ) / div
		dir:Normalize()
		ent:SetMaterial( "models/flesh" )
		ent:SetPos( pos + Vector( 0, 0, 55 ) )
		ent:SetCollisionGroup( 1 )
		ent:AddCallback( "PhysicsCollide", bloodtouch )
		ent:Spawn()

		if te then
			util.SpriteTrail( ent, 0, Color( 102, 0, 0 ), false, sw, ew, lifetime, tws, trailtarget )
		end

		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial( "zombieflesh" )
			phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
			phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
			phys:SetMass( phys:GetMass() * bl )
		end

		SafeRemoveEntityDelayed( ent, 25 )
	end
end

function spawnmeat3( pos, vec )
	local ent = ents.Create( "prop_physics" )
	ent:SetModel( "models/props_junk/watermelon01_chunk01a.mdl" )

	if ent:IsValid() then
		local dir = ( pos * x + VectorRand( m, x ) ) / div
		dir:Normalize()
		ent:SetMaterial( "models/flesh" )
		ent:SetPos( pos + Vector( 0, 0, 30 ) )
		ent:SetCollisionGroup( 1 )
		ent:AddCallback( "PhysicsCollide", bloodtouch )
		ent:Spawn()

		if te then
			util.SpriteTrail( ent, 0, Color( 102, 0, 0 ), false, sw, ew, lifetime, tws, trailtarget )
		end

		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial( "zombieflesh" )
			phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
			phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
			phys:SetMass( phys:GetMass() * bl )
		end

		SafeRemoveEntityDelayed( ent, 25 )
	end
end

function spawnmeat4( pos, vec )
	local ent = ents.Create( "prop_physics" )
	ent:SetModel( "models/gibs/hgibs_spine.mdl" )

	if ent:IsValid() then
		local dir = ( pos * x + VectorRand( m, x ) ) / div
		dir:Normalize()
		ent:SetMaterial( "models/flesh" )
		ent:SetPos( pos + Vector( 0, 0, 30 ) )
		ent:SetCollisionGroup( 1 )
		ent:AddCallback( "PhysicsCollide", bloodtouch )
		ent:Spawn()

		if te then
			util.SpriteTrail( ent, 0, Color( 102, 0, 0 ), false, sw, ew, lifetime, tws, trailtarget )
		end

		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial( "zombieflesh" )
			phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
			phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
			phys:SetMass( phys:GetMass() * bl )
		end

		SafeRemoveEntityDelayed( ent, 25 )
	end
end

function legs( pos, vec )
	local ent = ents.Create( "prop_ragdoll" )
	ent:SetModel( "models/gibs/fast_zombie_legs.mdl" )

	if ent:IsValid() then
		local dir = pos * x + VectorRand( m, x )
		dir:Normalize()
		ent:SetMaterial( "models/flesh" )
		ent:SetPos( pos )
		ent:SetCollisionGroup( 1 )
		ent:AddCallback( "PhysicsCollide", bloodtouch )
		ent:Spawn()

		if te then
			util.SpriteTrail( ent, 0, Color( 102, 0, 0 ), false, sw, ew, lifetime, tws, trailtarget )
		end

		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial( "zombieflesh" )
			phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
			phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
			phys:SetMass( phys:GetMass() * bl )
		end

		SafeRemoveEntityDelayed( ent, 25 )
	end
end

function legs2( pos, vec )
	local ent = ents.Create( "prop_ragdoll" )
	ent:SetModel( "models/gibs/fast_zombie_legs.mdl" )

	if ent:IsValid() then
		local dir = pos * x + VectorRand( m, x )
		dir:Normalize()
		ent:SetMaterial( "models/flesh" )
		ent:SetPos( pos )
		ent:SetCollisionGroup( 1 )
		ent:AddCallback( "PhysicsCollide", bloodtouch )
		ent:Spawn()
		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial( "zombieflesh" )
			phys:SetVelocityInstantaneous( vec )
			phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
			phys:SetMass( phys:GetMass() * bl )
		end

		SafeRemoveEntityDelayed( ent, 25 )
	end
end

function torso( pos, vec )
	local ent = ents.Create( "prop_ragdoll" )
	ent:SetModel( "models/gibs/fast_zombie_torso.mdl" )

	if ent:IsValid() then
		local dir = pos * x + VectorRand( m, x )
		dir:Normalize()
		ent:SetMaterial( "models/flesh" )
		ent:SetPos( pos + Vector( 0, 0, 15 ) )
		ent:SetCollisionGroup( 1 )
		ent:AddCallback( "PhysicsCollide", bloodtouch )
		ent:Spawn()
		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial( "zombieflesh" )
			phys:SetVelocityInstantaneous( vec )
			phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
			phys:SetMass( phys:GetMass() * bl )
		end

		SafeRemoveEntityDelayed( ent, 25 )
	end
end

function spawnskull( pos, vec )
	local ent = ents.Create( "prop_physics" )
	ent:SetModel( "models/gibs/hgibs.mdl" )

	if ent:IsValid() then
		local dir = ( pos * x + VectorRand( m, x ) ) / div
		dir:Normalize()
		ent:SetPos( pos )
		ent:SetCollisionGroup( 1 )
		ent:Spawn()

		if te then
			util.SpriteTrail( ent, 0, Color( 102, 0, 0 ), false, sw, ew, lifetime, tws, trailtarget )
		end

		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial( "zombieflesh" )
			phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
			phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
			phys:SetMass( phys:GetMass() * bl )
		end

		SafeRemoveEntityDelayed( ent, 25 )
	end
end

function spawnskull2( pos, vec )
	local ent = ents.Create( "prop_physics" )
	ent:SetModel( "models/gibs/hgibs.mdl" )

	if ent:IsValid() then
		local dir = ( pos * x + VectorRand( m, x ) ) / div
		dir:Normalize()
		ent:SetPos( pos )
		ent:SetCollisionGroup( 1 )
		ent:Spawn()
		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial( "zombieflesh" )
			phys:SetVelocityInstantaneous( vec )
		end

		SafeRemoveEntityDelayed( ent, 25 )
	end
end

function spawnflesh( pos, vec )
	local ent = ents.Create( "prop_physics" )
	ent:SetModel( "models/props_junk/Rock001a.mdl" )
	ent:SetModelScale( math.Rand( 0.2, 0.5 ), 0 )

	if ent:IsValid() then
		local dir = ( pos * x + VectorRand( m, x ) ) / div
		dir:Normalize()
		ent:SetMaterial( "models/flesh" )
		ent:SetPos( pos )
		ent:SetCollisionGroup( 1 )
		ent:AddCallback( "PhysicsCollide", bloodtouch )
		ent:Spawn()
		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial( "zombieflesh" )
			phys:SetVelocityInstantaneous( vec )
		end

		SafeRemoveEntityDelayed( ent, 25 )
	end
end

function spawnflesh2( pos, vec )
	local ent = ents.Create( "prop_physics" )
	ent:SetModel( "models/props_junk/Rock001a.mdl" )
	ent:SetModelScale( math.Rand( 0.05, 0.3 ), 0 )

	if ent:IsValid() then
		local dir = ( pos * x + VectorRand( m, x ) ) / div
		dir:Normalize()
		ent:SetMaterial( "models/flesh" )
		ent:SetPos( pos )
		ent:SetCollisionGroup( 1 )
		ent:AddCallback( "PhysicsCollide", bloodtouch )
		ent:Spawn()
		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial( "zombieflesh" )
			phys:SetVelocityInstantaneous( vec )
		end

		SafeRemoveEntityDelayed( ent, 25 )
	end
end

function spawnspine( pos, vec )
	local ent = ents.Create( "prop_physics" )
	ent:SetModel( "models/gibs/hgibs_spine.mdl" )

	if ent:IsValid() then
		local dir = ( pos * x + VectorRand( m, x ) ) / div
		dir:Normalize()
		ent:SetPos( pos + Vector( 0, 0, 35 ) )
		ent:SetCollisionGroup( 1 )
		ent:Spawn()
		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
			phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
		end

		SafeRemoveEntityDelayed( ent, 25 )
	end
end

hook.Add( "DoPlayerDeath", "gibcheck", function( ply, attacker, dmg )
	--Explosion
	if dmg:IsExplosionDamage() and ply:Alive() == false and ply:GetBloodColor() == 0 then
		timer.Create( "checkgibcooldown", 0.0005, 1, function()
			local ragdoll = ply:GetRagdollEntity()
			local vec = ply:GetVelocity()
			spawnspine( ply:GetPos(), vec )
			spawnspine( ply:GetPos(), vec )
			spawnskull( ply:EyePos(), vec )
			spawnmeat3( ply:GetPos(), vec )
			spawnmeat2( ply:GetPos(), vec )
			spawnmeat3( ply:GetPos(), vec )
			spawnmeat2( ply:GetPos(), vec )
			spawnmeat3( ply:GetPos(), vec )
			spawnmeat2( ply:GetPos(), vec )
			spawnmeat( ply:GetPos(), vec )
			spawnmeat( ply:GetPos(), vec )
			spawnmeat3( ply:GetPos(), vec )
			spawnmeat4( ply:GetPos(), vec )
			spawnmeat4( ply:GetPos(), vec )
			legs( ply:GetPos(), vec )

			for i = 1, 2 do
				if ragdoll:IsValid() then
					timer.Create( "checkcooldown", 0.01, 1, function()
						ragdoll:Remove()
					end )
				end
			end
		end )
	end

	--Headshot
	local vec = ply:GetVelocity()
	local plypos = ply:GetPos()

	if ply:LastHitGroup() == 1 and ply:Alive() == false and dmg:IsDamageType( 2 ) and ply:GetBloodColor() == 0 and hs == true then
		local pos = ply:EyePos()

		timer.Create( "headgonecheck", 0.005, 1, function()
			local ragdoll = ply:GetRagdollEntity()
			spawnskull2( pos, vec )

			for i = 1, 3 do
				spawnflesh( pos, vec + Vector( math.Rand( 25, 50 ), math.Rand( 25, 50 ), math.Rand( 25, 50 ) ) )
				spawnflesh( pos, vec + Vector( math.Rand( 25, 50 ), math.Rand( 25, 50 ), math.Rand( 25, 50 ) ) )
				spawnflesh( pos, vec + Vector( math.Rand( 25, 50 ), math.Rand( 25, 50 ), math.Rand( 25, 50 ) ) )
			end

			local headbone = ragdoll:LookupBone( "ValveBiped.Bip01_Head1" )

			if headbone then
				local ent = ents.Create( "prop_ragdoll" )
				ent:SetModel( ply:GetModel() )
				ent:ManipulateBoneScale( headbone, Vector( 0.001, 0.001, 0.001 ) )
				ent:SetPos( plypos )
				ent:SetAngles( ply:GetAngles() )
				ent:SetColor( ply:GetColor() )
				ent:SetCollisionGroup( 1 )
				ent:Spawn()
				SafeRemoveEntityDelayed( ent, 25 )
				local phys = ent:GetPhysicsObject()

				if phys:IsValid() then
					phys:SetVelocity( vec )
				end

				if ragdoll:IsValid() then
					timer.Create( "checkcooldown", 0.0005, 1, function()
						ragdoll:Remove()
					end )
				end
			end
		end )
	end

	--Prop Kill
	if ply:Alive() == false and dmg:IsDamageType( 1 ) and ply:GetBloodColor() == 0 then
		timer.Create( "checkcooldown001", 0.05, 1, function()
			legs2( ply:GetPos(), vec )
			torso( ply:GetPos(), vec )
			spawnmeatt( ply:GetPos(), vec )
			local ragdoll = ply:GetRagdollEntity()

			if ragdoll:IsValid() then
				timer.Create( "checkcooldown002", 0.0005, 1, function()
					ragdoll:Remove()
				end )
			end
		end )
	end
end )

--NPC / PLR
hook.Add( "EntityTakeDamage", "EntityDamageExample", function( target, dmg )
	if target:GetBloodColor() == 0 then
		spawnflesh2( dmg:GetDamagePosition(), Vector( 0, 0, 0 ) )
		sound.Play( "physics/body/body_medium_break" .. math.random( 2, 4 ) .. ".wav", dmg:GetDamagePosition(), 77, 100, 255 )
	end

	-- NPC
	--PROPKILL
	if target:IsNPC() and dmg:IsDamageType( 1 ) and target:GetBloodColor() == 0 then
		if target:Health() - dmg:GetDamage() < 1 then
			if not target:IsNextBot() then
				target:DropWeapon( nil, nil, Vector( 9999999, 9999999, 9999999 ) )
			end

			target:Remove()
			legs2( target:GetPos(), target:GetVelocity() )
			torso( target:GetPos(), target:GetVelocity() )
			spawnmeatt( target:GetPos(), target:GetVelocity() )
			target:Remove()
		end
	end

	--GIB
	if target:GetModel() and not table.KeyFromValue( blacklistmodel, tostring( target:GetModel() ) ) and target:IsNPC() and dmg:IsExplosionDamage() and target:GetBloodColor() == 0 or target:GetModel() and target:IsNPC() and dmg:IsExplosionDamage() and target:GetBloodColor() == 2 and table.KeyFromValue( whitelistmodel, tostring( target:GetModel() ) ) or target:GetModel() and target:IsNPC() and dmg:IsExplosionDamage() and target:GetBloodColor() == 5 and not table.KeyFromValue( whitelistmodel, tostring( target:GetModel() ) ) or target:GetModel() and target:IsNPC() and dmg:IsExplosionDamage() and target:GetBloodColor() == 1 and table.KeyFromValue( whitelistmodel, tostring( target:GetModel() ) ) then
		if target:Health() - dmg:GetDamage() < 1 then
			if not target:IsNextBot() then
				target:DropWeapon( nil, nil, Vector( 9999999, 9999999, 9999999 ) )
			end

			target:Remove()
			local ent = target
			local vec = ent:GetVelocity()
			spawnspine( ent:GetPos(), vec )
			spawnspine( ent:GetPos(), vec )
			spawnskull( ent:EyePos(), vec )
			spawnmeat3( ent:GetPos(), vec )
			spawnmeat2( ent:GetPos(), vec )
			spawnmeat3( ent:GetPos(), vec )
			spawnmeat2( ent:GetPos(), vec )
			spawnmeat3( ent:GetPos(), vec )
			spawnmeat2( ent:GetPos(), vec )
			spawnmeat( ent:GetPos(), vec )
			spawnmeat( ent:GetPos(), vec )
			spawnmeat3( ent:GetPos(), vec )
			spawnmeat4( ent:GetPos(), vec )
			spawnmeat4( ent:GetPos(), vec )
			legs( ent:GetPos(), vec )
			target:Remove()
		end
	end

	--HEADSHOT
	hook.Add( "ScaleNPCDamage", "NPCGIB", function( npc, hitgroup, dmginfo )
		local vec = npc:GetVelocity()
		local npcpos = npc:GetPos()
		local healthcur = npc:Health() - dmginfo:GetDamage()

		if healthcur < 1 and dmginfo:GetDamageType() == 2 and npc:GetBloodColor() == 0 and hitgroup == 1 and hs == true then
			local pos = npc:EyePos()

			if not npc:IsNextBot() then
				npc:DropWeapon( nil, nil, Vector( 9999999, 9999999, 9999999 ) )
			end

			npc:Remove()
			spawnskull2( pos, vec )

			for i = 1, 3 do
				spawnflesh( pos, vec + Vector( math.Rand( 25, 50 ), math.Rand( 25, 50 ), math.Rand( 25, 50 ) ) )
				spawnflesh( pos, vec + Vector( math.Rand( 25, 50 ), math.Rand( 25, 50 ), math.Rand( 25, 50 ) ) )
				spawnflesh( pos, vec + Vector( math.Rand( 25, 50 ), math.Rand( 25, 50 ), math.Rand( 25, 50 ) ) )
			end

			local headbone = npc:LookupBone( "ValveBiped.Bip01_Head1" )

			if headbone then
				local enty = ents.Create( "prop_ragdoll" )
				enty:SetModel( npc:GetModel() )
				enty:ManipulateBoneScale( headbone, Vector( 0.001, 0.001, 0.001 ) )
				enty:SetPos( npcpos )
				enty:SetAngles( npc:GetAngles() )
				enty:SetColor( npc:GetColor() )
				enty:SetCollisionGroup( 1 )
				enty:SetSkin( npc:GetSkin() )
				enty:Spawn()
				SafeRemoveEntityDelayed( enty, 25 )
				local phys = enty:GetPhysicsObject()

				if phys:IsValid() then
					phys:SetVelocity( vec )
				end
			end
		end
	end )

	hook.Add( "AllowPlayerPickup", "AllowAdminsPickUp", function( ply, ent )
		if ent:GetMaterial() == "models/flesh" and ent:GetCollisionGroup() == 1 or ent:GetCollisionGroup() == 1 then return false end
	end )
end )