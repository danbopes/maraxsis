-- Native 2.1 "view from orbit" backdrop for maraxsis.
--
-- In 2.1 platform_surface_render_parameters moved off the space-platform hub and
-- onto the planet prototype, so a platform parked in a planet's orbit renders
-- that planet's own backdrop. maraxsis never defined one, so the engine fell back
-- to the default and drew a generic Nauvis-looking sphere below any platform in
-- maraxsis orbit.
--
-- We base ours on Gleba's fully specified parameters (Space Age sets those during
-- data-updates, so they exist by data-final-fixes) and swap in a bespoke
-- equirectangular ocean surface that matches the planet's own deep electric-blue
-- art. Gleba's separate cloud/normal/reflectivity layers are dropped (our clouds
-- are baked into the surface map), and the lighting is retuned bluer and darker so
-- the sphere reads as a deep ocean world rather than a bright cyan one.

local planet = data.raw.planet.maraxsis
local gleba = data.raw.planet.gleba

if planet and gleba and gleba.platform_surface_render_parameters then
    local params = table.deepcopy(gleba.platform_surface_render_parameters)
    local backdrop = params.platform_backdrop

    backdrop.planet_surface = {
        filename = "__maraxsis__/graphics/planets/maraxsis-planet-surface.png",
        width = 2048,
        height = 1024,
    }
    backdrop.planet_normal = nil
    backdrop.planet_reflectivity = nil
    backdrop.global_cloud = nil
    backdrop.global_cloud_normal = nil
    backdrop.global_cloud_flow = nil
    backdrop.cloudiness = 0
    backdrop.atmosphere_color = {0.03, 0.10, 0.35, 0.16}
    backdrop.light_color = {0.62, 0.78, 1.0}
    backdrop.light_intensity_contrast = 0.6
    backdrop.specular_intensity = 0.7

    planet.platform_surface_render_parameters = params
end
