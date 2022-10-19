---@meta


---**Scatter**
---
---Randomly chooses a location and generates a cluster of ore.
---
---If `noise_params` is specified, the ore will be placed if the 3D perlin noise at that point is greater than the `noise_threshold`, giving the ability to create a non-equal distribution of ore.
---
---**Sheet**
---
---Creates a sheet of ore in a blob shape according to the 2D perlin noise described by `noise_params` and `noise_threshold`.
---
---This is essentially an improved version of the so-called "stratus" ore seen in some unofficial mods.
---
---This sheet consists of vertical columns of uniform randomly distributed height, varying between the inclusive range `column_height_min` and `column_height_max`.
---
---If `column_height_min` is not specified, this parameter defaults to 1.
---
---If `column_height_max` is not specified, this parameter defaults to `clust_size` for reverse compatibility. New code should prefer `column_height_max`.
---
---The `column_midpoint_factor` parameter controls the position of the column at which ore emanates from.
---
---If 1, columns grow upward. If 0, columns grow downward. If 0.5, columns grow equally starting from each direction.
---
---`column_midpoint_factor` is a decimal number ranging in value from 0 to 1. If this parameter is not specified, the default is 0.5.
---
---The ore parameters `clust_scarcity` and `clust_num_ores` are ignored for this ore type.
---
---**Puff**
---
---Creates a sheet of ore in a cloud-like puff shape.
---
---As with the `sheet` ore type, the size and shape of puffs are described by `noise_params` and `noise_threshold` and are placed at random vertical positions within the currently generated chunk.
---
---The vertical top and bottom displacement of each puff are determined by the noise parameters `np_puff_top` and `np_puff_bottom`, respectively.
---
---**Blob**
---
---Creates a deformed sphere of ore according to 3d perlin noise described by `noise_params`.
---
---The maximum size of the blob is `clust_size`, and `clust_scarcity` has the same meaning as with the `scatter` type.
---
---**Vein**
---
---Creates veins of ore varying in density by according to the intersection of two instances of 3d perlin noise with different seeds, both described by `noise_params`.
---
---`random_factor` varies the influence random chance has on placement of an ore inside the vein, which is `1` by default.
---
---Note that modifying this parameter may require adjusting `noise_threshold`.
---
---The parameters `clust_scarcity`, `clust_num_ores`, and `clust_size` are ignored by this ore type.
---
---This ore type is difficult to control since it is sensitive to small changes.
---
---The following is a decent set of parameters to work from:
---
---```lua
---noise_params = {
---	offset  = 0,
---	scale   = 3,
---	spread  = {x=200, y=200, z=200},
---	seed    = 5390,
---	octaves = 4,
---	persistence = 0.5,
---	lacunarity = 2.0,
---	flags = "eased",
---},
---noise_threshold = 1.6
---```
---
---**WARNING**: Use this ore type *very* sparingly since it is ~200x more computationally expensive than any other ore.
---
---**Stratum**
---
---Creates a single undulating ore stratum that is continuous across mapchunk borders and horizontally spans the world.
---
---The 2D perlin noise described by `noise_params` defines the Y co-ordinate of the stratum midpoint.
---
---The 2D perlin noise described by `np_stratum_thickness` defines the stratum's vertical thickness (in units of nodes).
---
---Due to being continuous across mapchunk borders the stratum's vertical thickness is unlimited.
---
---If the noise parameter `noise_params` is omitted the ore will occur from `y_min` to `y_max` in a simple horizontal stratum.
---
---A parameter `stratum_thickness` can be provided instead of the noise parameter `np_stratum_thickness`, to create a constant thickness.
---
---Leaving out one or both noise parameters makes the ore generation less intensive, useful when adding multiple strata.
---
---`y_min` and `y_max` define the limits of the ore generation and for performance reasons should be set as close together as possible but without clipping the stratum's Y variation.
---
---Each node in the stratum has a 1-in-`clust_scarcity` chance of being ore, so a solid-ore stratum would require a `clust_scarcity` of 1.
---
---The parameters `clust_num_ores`, `clust_size`, `noise_threshold` and `random_factor` are ignored by this ore type.
---@class ore_definition
---@field ore_type '"scatter"'|'"sheet"'|'"puff"'|'"blob"'|'"vein"'|'"stratum"'
---@field ore string
---@field ore_param2 integer Facedir rotation. Default is `0` (unchanged rotation)
---@field wherein string|string[]
---@field clust_scarcity number Ore has a 1 out of clust_scarcity chance of spawning in a node. If the desired average distance between ores is 'd', set this to d * d * d.
---@field clust_num_ores integer Number of ores in a cluster
---@field clust_size integer Size of the bounding box of the cluster
---@field y_min integer Lower limit for ore
---@field y_max integer Upper limit for ore
---@field flags flag_specifier
---@field noise_threshold number If noise is above this threshold, ore is placed. Not needed for a uniform distribution.
---@field noise_params noise_params Describe one of the perlin noises used for ore distribution. Needed by "sheet", "puff", "blob" and "vein" ores. Omit from "scatter" ore for a uniform ore distribution. Omit from "stratum" ore for a simple horizontal strata from y_min to y_max.
---@field biomes string|string[] List of biomes in which this ore occurs. Occurs in all biomes if this is omitted, and ignored if the Mapgen being used does not support biomes.
---@field column_height_min integer **sheet only**
---@field column_height_max integer **sheet only**
---@field column_midpoint_factor number **sheet only**
---@field np_puff_top noise_params **puff only**
---@field np_puff_bottom noise_params **puff only**
---@field random_factor number **vein only**
---@field np_stratum_thickness noise_params **stratum only**
---@field stratum_thickness integer **stratum only**


---
---@param def ore_definition
function minetest.register_ore(def) end

---@class abm_definition
---Descriptive label for profiling purposes (optional).
---
---Definitions with identical labels will be listed as one.
---@field label string
---Apply `action` function to these nodes.
---
---`group:groupname` can also be used here.
---@field nodenames string[]
---Only apply `action` to nodes that have one of, or any combination of, these neighbors.
---
---If left out or empty, any neighbor will do.
---
---`group:groupname` can also be used here.
---@field neighbors string[]
---Operation interval in seconds.
---@field interval number
---Chance of triggering `action` per-node per-interval is 1.0 / this value.
---@field chance number
---Min height levels where ABM will be processed.
---
---Can be used to reduce CPU usage.
---@field min_y integer
---Max height levels where ABM will be processed.
---
---Can be used to reduce CPU usage.
---@field max_y integer
---If true, catch-up behaviour is enabled.
---
---The `chance` value is temporarily reduced when returning to an area to simulate time lost by the area being unattended.
---
---Note that the `chance` value can often be reduced to 1.
---@field catch_up boolean
---Function triggered for each qualifying node.
---* `active_object_count` is number of active objects in the node's mapblock.
---* `active_object_count_wider` is number of active objects in the node's mapblock plus all 26 neighboring mapblocks. If any neighboring mapblocks are unloaded an estimate is calculated for them based on loaded mapblocks.
---@field action fun(pos: Vector, node: node, active_object_count: integer, active_object_count_wider: integer)

---Register a new Active Block Modifier (ABM)
---@param def abm_definition
function minetest.register_abm(def) end

---@type abm_definition[]
minetest.registered_abm = {}


---@class lbm_definition
---Descriptive label for profiling purposes (optional).
---
---Definitions with identical labels will be listed as one.
---@field label string
---@field name string
---List of node names to trigger the LBM on.
---
---Also non-registered nodes will work.
---
---Groups (as of `group:groupname`) will work as well.
---@field nodenames string[]
---Whether to run the LBM's action every time a block gets activated, and not only the first time the block gets activated after the LBM was introduced.
---@field run_at_every_load boolean
---@field action fun(pos: Vector, node: node)

---Register a new Loading Block Modifier (LBM)
---
---A LBM is used to define a function that is called for specific nodes (defined by `nodenames`) when a mapblock which contains such nodes gets activated (not loaded!)
---@param def lbm_definition
function minetest.register_lbm(def) end

---@type lbm_definition[]
minetest.registered_lbm = {}

---@class biome_definition
---@field name string
---Node dropped onto upper surface after all else is generated
---@field node_dust string
---Node forming surface layer of biome
---@field node_top string
---Thickness of the surface layer
---@field depth_top integer
---Node forming lower layer of biome
---@field node_filler string
---Thickness of the lower layer
---@field depth_filler integer
---Node that replaces all stone nodes between roughly `y_min` and `y_max`
---@field node_stone string
---Node forming a surface layer in seawater
---@field node_water_top string
---Thickness of the seawater surface layer
---@field depth_water_top integer
---Node that replaces all seawater nodes not in the surface layer
---@field node_water string
---Node that replaces river water in mapgens that use it
---@field node_river_water string
---Node placed under river water
---@field node_riverbed string
---Thickness of layer under river water
---@field depth_riverbed integer
---Nodes placed inside 50% of the medium size caves.
---
---Multiple nodes can be specified, each cave will use a randomly chosen node from the list.
---
---If this field is left out or `nil`, cave liquids fall back to classic behaviour of lava and water distributed using 3D noise.
---
---For no cave liquid, specify `"air"`.
---@field node_cave_liquid string|string[]
---Node used for primary dungeon structure.
---
---If absent, dungeon nodes fall back to the `mapgen_cobble` mapgen alias, if that is also absent, dungeon nodes fall back to the biome `node_stone`.
---@field node_dungeon string
---Node used for randomly-distributed alternative structure nodes.
---
---If alternative structure nodes are not wanted leave this absent for performance reasons.
---@field node_dungeon_alt string
---Node used for dungeon stairs.
---
---If absent, stairs fall back to `node_dungeon`.
---@field node_dungeon_stair string
---Upper limit for biome.
---
---Alternatively you can use the `max_pos` limit.
---@field y_max integer
---Lower limit for biome.
---
---Alternatively you can use the `min_pos` limit.
---@field y_min integer
---Pos limit for biome, an alternative to using `y_min` and `y_max`.
---
---Biome is limited to a cuboid defined by `max_pos` and `min_pos`.
---@field max_pos Vector
---Pos limit for biome, an alternative to using `y_min` and `y_max`.
---
---Biome is limited to a cuboid defined by `max_pos` and `min_pos`.
---@field min_pos Vector
---Vertical distance in nodes above 'y_max' over which the biome will blend with the biome above.
---
---Set to 0 for no vertical blend. Defaults to 0.
---@field vertical_blend integer
---Characteristic temperature for the biome.
---
---`heat_point` and `humidity_point` create `biome points` on a voronoi diagram with heat and humidity as axes.
---
---The resulting voronoi cells determine the distribution of the biomes.
---
---Heat and humidity have average values of 50, vary mostly between 0 and 100 but can exceed these values.
---@field heat_point integer
---Characteristic humidity for the biome.
---
---`heat_point` and `humidity_point` create `biome points` on a voronoi diagram with heat and humidity as axes.
---
---The resulting voronoi cells determine the distribution of the biomes.
---
---Heat and humidity have average values of 50, vary mostly between 0 and 100 but can exceed these values.
---@field humidity_point integer

---Returns an integer object handle uniquely identifying the registered biome on success.
---
---To get the biome ID, use `minetest.get_biome_id`.
---
---The maximum number of biomes that can be used is 65535.
---
---However, using an excessive number of biomes will slow down map generation.
---
---Depending on desired performance and computing power the practical limit is much lower.
---@param def biome_definition
---@return integer
function minetest.register_biome(def) end

---Array of biome definition tables
---@type biome_definition[]
minetest.registered_biomes = {}

---Unregisters the biome from the engine, and deletes the entry with key `name` from `minetest.registered_biomes`.
---
---**Warning:** This alters the biome to biome ID correspondences, so any decorations or ores using the 'biomes' field must afterwards be cleared and re-registered.
---@param name string
function minetest.unregister_biome(name) end
