BLOODYGIBS = BLOODYGIBS or {}
BLOODYGIBS.HeadshotsEnabled = true
BLOODYGIBS.PropKillEnabled = true
BLOODYGIBS.ImpactSound = "Flesh_Bloody.ImpactHard"

-- Gibs Config
BLOODYGIBS.Gibs = {}
BLOODYGIBS.Gibs.Enabled = true
BLOODYGIBS.Gibs.Lifetime = 25
BLOODYGIBS.Gibs.Material = "models/flesh"

-- Trails Config
BLOODYGIBS.Trails = {}
BLOODYGIBS.Trails.Enabled = true
BLOODYGIBS.Trails.TrailsEnabled = true
BLOODYGIBS.Trails.Lifetime = 7
BLOODYGIBS.Trails.StartWidth = 10
BLOODYGIBS.Trails.EndWidth = 1
BLOODYGIBS.Trails.Material = "effects/bloodstream"
BLOODYGIBS.Trails.Color = Color( 102, 0, 0 )
BLOODYGIBS.Trails.TextureRes = 0.1

local m = 1000
local x = 2
local bl = 1

local whitelistmodel = {
    ["models/zombie/fast.mdl"]              = true,
    ["models/zombie/zombie_soldier.mdl"]    = true,
    ["models/zombie/classic.mdl"]           = true,
    ["models/zombie/poison.mdl"]            = true,
    ["models/vortigaunt_doctor.mdl"]        = true,
    ["models/vortigaunt.mdl"]               = true,
    ["models/vortigaunt_slave.mdl"]         = true,
}

local blacklistmodel = {
    ["models/pigeon.mdl"]   = true,
    ["models/seagull.mdl"]  = true,
    ["models/crow.mdl"]     = true,
}

local function bloodtouch( ent, data )
    if IsValid( ent ) and data.Speed > 20 and data.DeltaTime > 0.1 then
        local trace = {}
        trace.filter = { ent }

        ent:EmitSound( BLOODYGIBS.ImpactSound )

        data.HitNormal = data.HitNormal * -1 -- make it negative

        local start = data.HitPos + data.HitNormal
        local endpos = data.HitPos - data.HitNormal
        local effectdata = EffectData()
        effectdata:SetOrigin( start )
        util.Effect( "BloodImpact", effectdata )
        util.Decal( "Blood", start, endpos )
    end
end

concommand.Add( "bloodygibs_disable_gib_trails", function( ply, _, _ )
    if ply:IsSuperAdmin() then
        BLOODYGIBS.Trails.Enabled = false
    end
end )

concommand.Add( "bloodygibs_enable_gib_trails", function( ply, _, _ )
    if ply:IsSuperAdmin() then
        BLOODYGIBS.Trails.Enabled = true
    end
end )

concommand.Add( "bloodygibs_enable_headshot_effect", function( ply, _, _ )
    if ply:IsSuperAdmin() then
        BLOODYGIBS.HeadshotsEnabled = true
    end
end )

concommand.Add( "bloodygibs_disable_headshot_effect", function( ply, _, _ )
    if ply:IsSuperAdmin() then
        BLOODYGIBS.HeadshotsEnabled = false
    end
end )

local function applyTrail( ent )
    if not BLOODYGIBS.Trails.Enabled then return end

    local col = BLOODYGIBS.Trails.Color
    local sw = BLOODYGIBS.Trails.StartWidth
    local ew = BLOODYGIBS.Trails.EndWidth
    local lifetime = BLOODYGIBS.Trails.Lifetime
    local res = BLOODYGIBS.Trails.TextureRes
    local mat = BLOODYGIBS.Trails.Material

    util.SpriteTrail( ent, 0, col, false, sw, ew, lifetime, res, mat )
end

local function spawnGib( pos, mdl, offset, shouldScale )
    if not offset then offset = Vector( 0, 0, 0 ) end

    local ent = ents.Create( "prop_physics" )
    ent:SetModel( mdl )

    if shouldScale then
        ent:SetModelScale( math.Rand( 0.2, 0.5 ), 0 )
    end

    if ent:IsValid() then
        local dir = pos * x + VectorRand( m, x )
        dir:Normalize()

        ent:SetMaterial( BLOODYGIBS.Gibs.Material )
        ent:SetPos( pos + offset )
        ent:SetCollisionGroup( 1 )
        ent:AddCallback( "PhysicsCollide", bloodtouch )
        ent:Spawn()
        applyTrail( ent )

        SafeRemoveEntityDelayed( ent, BLOODYGIBS.Gibs.Lifetime )
    end

    return ent
end

local function spawnMeat( pos, vec )
    local ent = spawnGib( pos, "models/props_junk/Rock001a.mdl", Vector( -10, 0, 45 ) )
    local phys = ent:GetPhysicsObject()

    if phys:IsValid() then
        phys:SetMaterial( "zombieflesh" )
        phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
        phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
        phys:SetMass( phys:GetMass() * bl )
    end
end

local function spawnMeat2( pos, vec )
    local ent = spawnGib( pos, "models/props_junk/Rock001a.mdl", Vector( -10, 0, 45 ) )
    local phys = ent:GetPhysicsObject()

    if phys:IsValid() then
        phys:SetMaterial( "zombieflesh" )
        phys:SetVelocityInstantaneous( vec )
        phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
        phys:SetMass( phys:GetMass() * bl )
    end
end

local function spawnMeat3( pos, vec )
    local ent = spawnGib( pos, "models/props_junk/watermelon01_chunk01b.mdl", Vector( 0, 0, 55 ) )
    local phys = ent:GetPhysicsObject()

    if phys:IsValid() then
        phys:SetMaterial( "zombieflesh" )
        phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
        phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
        phys:SetMass( phys:GetMass() * bl )
    end
end

local function spawnMeat4( pos, vec )
    local ent = spawnGib( pos, "models/props_junk/watermelon01_chunk01a.mdl", Vector( 0, 0, 30 ) )
    local phys = ent:GetPhysicsObject()

    if phys:IsValid() then
        phys:SetMaterial( "zombieflesh" )
        phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
        phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
        phys:SetMass( phys:GetMass() * bl )
    end
end

local function spawnMeat5( pos, vec )
    local ent = spawnGib( pos, "models/gibs/hgibs_spine.mdl", Vector( 0, 0, 30 ) )
    local phys = ent:GetPhysicsObject()

    if phys:IsValid() then
        phys:SetMaterial( "zombieflesh" )
        phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
        phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
        phys:SetMass( phys:GetMass() * bl )
    end
end

local function legs( pos, vec )
    local ent = spawnGib( pos, "models/gibs/fast_zombie_legs.mdl" )
    local phys = ent:GetPhysicsObject()

    if phys:IsValid() then
        phys:SetMaterial( "zombieflesh" )
        phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
        phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
        phys:SetMass( phys:GetMass() * bl )
    end
end

local function legs2( pos, vec )
    local ent = spawnGib( pos, "models/gibs/fast_zombie_legs.mdl" )
    local phys = ent:GetPhysicsObject()

    if phys:IsValid() then
        phys:SetMaterial( "zombieflesh" )
        phys:SetVelocityInstantaneous( vec )
        phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
        phys:SetMass( phys:GetMass() * bl )
    end
end

local function torso( pos, vec )
    local ent = spawnGib( pos, "models/gibs/fast_zombie_torso.mdl", Vector( 0, 0, 15 ) )
    local phys = ent:GetPhysicsObject()

    if phys:IsValid() then
        phys:SetMaterial( "zombieflesh" )
        phys:SetVelocityInstantaneous( vec )
        phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
        phys:SetMass( phys:GetMass() * bl )
    end
end

local function spawnSkull( pos, vec )
    local ent = spawnGib( pos, "models/gibs/hgibs.mdl" )
    local phys = ent:GetPhysicsObject()

    if phys:IsValid() then
        phys:SetMaterial( "zombieflesh" )
        phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
        phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
        phys:SetMass( phys:GetMass() * bl )
    end
end

local function spawnSkull2( pos, vec )
    local ent = spawnGib( pos, "models/gibs/hgibs.mdl" )
    local phys = ent:GetPhysicsObject()

    if phys:IsValid() then
        phys:SetMaterial( "zombieflesh" )
        phys:SetVelocityInstantaneous( vec )
    end
end

local function spawnFlesh( pos, vec )
    local ent = spawnGib( pos, "models/props_junk/Rock001a.mdl", nil, true )
    local phys = ent:GetPhysicsObject()

    if phys:IsValid() then
        phys:SetMaterial( "zombieflesh" )
        phys:SetVelocityInstantaneous( vec )
    end
end

local function spawnSpine( pos, vec )
    local ent = spawnGib( pos, "models/gibs/hgibs_spine.mdl" )
    local phys = ent:GetPhysicsObject()

    if phys:IsValid() then
        phys:SetVelocityInstantaneous( vec + Vector( math.Rand( -250, 500 ), math.Rand( -250, 500 ), math.Rand( 250, 500 ) ) )
        phys:AddAngleVelocity( VectorRand( m, x ) * 3000 )
    end
end

local function spawnPlayerBody( ply )
    local ragdoll = ply:GetRagdollEntity()
    local pos = ply:GetPos()
    local vec = ply:GetVelocity()

    spawnSkull( ply:EyePos(), vec )
    spawnSpine( pos, vec )
    spawnSpine( pos, vec )
    spawnMeat( pos, vec )
    spawnMeat( pos, vec )
    spawnMeat3( pos, vec )
    spawnMeat3( pos, vec )
    spawnMeat3( pos, vec )
    spawnMeat4( pos, vec )
    spawnMeat4( pos, vec )
    spawnMeat4( pos, vec )
    spawnMeat4( pos, vec )
    spawnMeat5( pos, vec )
    spawnMeat5( pos, vec )
    legs( pos, vec )

    for i = 1, 2 do
        if ragdoll:IsValid() then
            timer.Create( "checkcooldown", 0.01, 1, function()
                ragdoll:Remove()
            end )
        end
    end
end

local function wasHeadShot( ply, dmg )
    local inHead = ply:LastHitGroup() == HITGROUP_HEAD
    local alive = ply:Alive()
    local wasBullet = dmg:IsDamageType( DMG_BULLET )
    local bloodRed = ply:GetBloodColor() == BLOOD_COLOR_RED

    return wasBullet and inHead and not alive and bloodRed
end

local function wasPropKilled( ply, dmg )
    if ply:IsNPC() then
        return dmg:IsDamageType( DMG_CRUSH ) and target:GetBloodColor() == BLOOD_COLOR_RED
    end

    return not ply:Alive() and dmg:IsDamageType( DMG_CRUSH ) and ply:GetBloodColor() == BLOOD_COLOR_RED
end

hook.Add( "DoPlayerDeath", "gibcheck", function( ply, _, dmg )
    --Explosion
    if dmg:IsExplosionDamage() and not ply:Alive() and ply:GetBloodColor() == 0 then
        timer.Create( "checkgibcooldown", 0.0005, 1, function()
            spawnPlayerBody( ply )
        end )
    end

    --Headshot
    local vec = ply:GetVelocity()
    local plyPos = ply:GetPos()

    if BLOODYGIBS.HeadshotsEnabled and wasHeadShot( ply, dmg ) then
        local eyePos = ply:EyePos()

        timer.Create( "headgonecheck", 0.005, 1, function()
            local ragdoll = ply:GetRagdollEntity()
            spawnSkull2( eyePos, vec )

            for i = 1, 3 do
                spawnFlesh( eyePos, vec + Vector( math.Rand( 25, 50 ), math.Rand( 25, 50 ), math.Rand( 25, 50 ) ) )
                spawnFlesh( eyePos, vec + Vector( math.Rand( 25, 50 ), math.Rand( 25, 50 ), math.Rand( 25, 50 ) ) )
                spawnFlesh( eyePos, vec + Vector( math.Rand( 25, 50 ), math.Rand( 25, 50 ), math.Rand( 25, 50 ) ) )
            end

            local headbone = ragdoll:LookupBone( "ValveBiped.Bip01_Head1" )

            if headbone then
                local ent = ents.Create( "prop_ragdoll" )
                ent:SetModel( ply:GetModel() )
                ent:ManipulateBoneScale( headbone, Vector( 0.001, 0.001, 0.001 ) )
                ent:SetPos( plyPos )
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
    if wasPropKilled( ply, dmg ) then
        timer.Create( "checkcooldown001", 0.05, 1, function()
            legs2( plyPos, vec )
            torso( plyPos, vec )
            spawnMeat2( plyPos, vec )
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
        spawnFlesh( dmg:GetDamagePosition(), Vector( 0, 0, 0 ) )
        sound.Play( "physics/body/body_medium_break" .. math.random( 2, 4 ) .. ".wav", dmg:GetDamagePosition(), 77, 100, 255 )
    end

    -- NPC
    -- PROPKILL
    if wasPropKilled( target, dmg ) then
        if target:Health() - dmg:GetDamage() < 1 then
            if not target:IsNextBot() then
                target:DropWeapon( nil, nil, Vector( 9999999 * math.random( -1, 1 ), 9999999 * math.random( -1, 1 ), 9999999 ) )
            end

            target:Remove()
            legs2( target:GetPos(), target:GetVelocity() )
            torso( target:GetPos(), target:GetVelocity() )
            spawnMeat2( target:GetPos(), target:GetVelocity() )
            target:Remove()
        end
    end

    -- GIB
    if target:GetModel() and not table.KeyFromValue( blacklistmodel, tostring( target:GetModel() ) ) and target:IsNPC() and dmg:IsExplosionDamage() and target:GetBloodColor() == 0 or target:GetModel() and target:IsNPC() and dmg:IsExplosionDamage() and target:GetBloodColor() == 2 and whitelistmodel[tostring( target:GetModel() )] or target:GetModel() and target:IsNPC() and dmg:IsExplosionDamage() and target:GetBloodColor() == 5 and not table.KeyFromValue( whitelistmodel, tostring( target:GetModel() ) ) or target:GetModel() and target:IsNPC() and dmg:IsExplosionDamage() and target:GetBloodColor() == 1 and table.KeyFromValue( whitelistmodel, tostring( target:GetModel() ) ) then
        if target:Health() - dmg:GetDamage() < 1 then
            if not target:IsNextBot() then
                target:DropWeapon( nil, nil, Vector( 9999999, 9999999, 9999999 ) )
            end

            target:Remove()
            local ent = target
            local entPos = ent:GetPos()
            local vec = ent:GetVelocity()
            spawnSkull( ent:EyePos(), vec )
            spawnSpine( entPos, vec )
            spawnSpine( entPos, vec )
            spawnMeat( entPos, vec )
            spawnMeat( entPos, vec )
            spawnMeat3( entPos, vec )
            spawnMeat3( entPos, vec )
            spawnMeat3( entPos, vec )
            spawnMeat4( entPos, vec )
            spawnMeat4( entPos, vec )
            spawnMeat4( entPos, vec )
            spawnMeat4( entPos, vec )
            spawnMeat5( entPos, vec )
            spawnMeat5( entPos, vec )
            legs( ent:GetPos(), vec )
            target:Remove()
        end
    end

    -- HEADSHOT
    hook.Add( "ScaleNPCDamage", "NPCGIB", function( npc, hitgroup, dmginfo )
        local vec = npc:GetVelocity()
        local npcpos = npc:GetPos()
        local healthcur = npc:Health() - dmginfo:GetDamage()

        if healthcur < 1 and dmginfo:GetDamageType() == 2 and npc:GetBloodColor() == 0 and hitgroup == 1 and BLOODYGIBS.HeadshotsEnabled then
            local pos = npc:EyePos()

            if not npc:IsNextBot() then
                npc:DropWeapon( nil, nil, Vector( 9999999, 9999999, 9999999 ) )
            end

            npc:Remove()
            spawnSkull2( pos, vec )

            for i = 1, 3 do
                spawnFlesh( pos, vec + Vector( math.Rand( 25, 50 ), math.Rand( 25, 50 ), math.Rand( 25, 50 ) ) )
                spawnFlesh( pos, vec + Vector( math.Rand( 25, 50 ), math.Rand( 25, 50 ), math.Rand( 25, 50 ) ) )
                spawnFlesh( pos, vec + Vector( math.Rand( 25, 50 ), math.Rand( 25, 50 ), math.Rand( 25, 50 ) ) )
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
        if ent:GetMaterial() == BLOODYGIBS.Gibs.Material and ent:GetCollisionGroup() == 1 or ent:GetCollisionGroup() == 1 then return false end
    end )
end )