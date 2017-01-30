using ImageCore, Colors, FixedPointNumbers, OffsetArrays, Base.Test

@testset "show" begin
    rgb32 = rand(RGB{Float32}, 3, 5)
    a = ChannelView(rgb32)
    @test summary(a) == "3×3×5 ChannelView(::Array{RGB{Float32},2}) with element type Float32"
    num64 = rand(3,5)
    b = ColorView{RGB}(num64)
    @test summary(b) == "5-element ColorView{RGB}(::Array{Float64,2}) with element type ColorTypes.RGB{Float64}"
    rgb8 = rand(RGB{N0f8}, 3, 5)
    c = rawview(ChannelView(rgb8))
    @test summary(c) == "3×3×5 rawview(ChannelView(::Array{RGB{N0f8},2})) with element type UInt8"
    @test summary(rgb8) == "3×5 Array{RGB{N0f8},2}"
    rand8 = rand(UInt8, 3, 5)
    d = normedview(permuteddimsview(rand8, (2,1)))
    @test summary(d) == "5×3 normedview(N0f8, permuteddimsview(::Array{UInt8,2}, (2,1))) with element type FixedPointNumbers.Normed{UInt8,8}"
    e = permuteddimsview(normedview(rand8), (2,1))
    @test summary(e) == "5×3 permuteddimsview(::Array{N0f8,2}, (2,1)) with element type FixedPointNumbers.Normed{UInt8,8}"
    f = permuteddimsview(normedview(N0f16, rand(UInt16, 3, 5)), (2,1))
    @test summary(f) == "5×3 permuteddimsview(::Array{N0f16,2}, (2,1)) with element type FixedPointNumbers.Normed{UInt16,16}"
    g = channelview(rgb8)
    @test summary(g) == "3×3×5 Array{N0f8,3}"
    h = OffsetArray(rgb8, -1:1, -2:2)
    @test summary(h) == "-1:1×-2:2 OffsetArray{RGB{N0f8},2}"
    i = channelview(h)
    @test summary(i) == "1:3×-1:1×-2:2 ChannelView(::OffsetArray{RGB{N0f8},2}) with element type FixedPointNumbers.Normed{UInt8,8}"
end

nothing