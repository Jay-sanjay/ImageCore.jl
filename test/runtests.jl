module ImagesCoreTests

include("colorchannels.jl")
include("views.jl")
include("convert_reinterpret.jl")

# run these last
@test isempty(detect_ambiguities(ImagesCore,Base,Core))
if Base.JLOptions().can_inline == 1
    include("benchmarks.jl")  # these fail if inlining is off
end

end