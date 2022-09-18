### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 60529b50-3547-11ed-1f77-054afbffe8b9
md"# Pluto Markdown Cheatsheet"

# ╔═╡ 0b26e6e3-e288-4c8b-b9fd-00be2412251f
md"## Keyboard Shortcuts"

# ╔═╡ 4b104850-e3dd-49b6-9758-a43e692be7b3
md"Use F1 to see a list of keyboard shortcuts."

# ╔═╡ 04bce752-5e83-47e9-bb91-80099acf3cf9
md"This is a test."

# ╔═╡ 79045846-64db-4844-91e6-ccd6bb9c53ff
md"""
This is a triple-quote test.
"""

# ╔═╡ 25ca9d0a-414f-4d57-84c2-3d1f7fd02c8d
md"## Headers"

# ╔═╡ d2f9ad64-fcb6-46ac-b964-3a022217a31b
md"#### H4 Header"

# ╔═╡ 826081a8-cbe3-4a78-9d37-c5fff61e4884
md"###### H6 Header"

# ╔═╡ 7f724ec3-31d6-4ae2-8726-2fa6abbd8011
md"## Formatting"

# ╔═╡ 35a57141-e4a8-44f3-a2f9-fb8b2b2bdd0b
md"*italicized text*"

# ╔═╡ 183749d0-6269-4d13-af70-95f4162574f9
md"**bold text**"

# ╔═╡ da5bb48d-5e5c-4dd5-b27b-75246f8fa8cb
md"## Blockquote"

# ╔═╡ ac503808-7a78-481c-a6cb-b2b3cf8bc2e8
md">A Pluto notebook is made up of small blocks of Julia code (cells) and together they form a reactive notebook. When you change a variable, Pluto automatically re-runs the cells that refer to it. Cells can even be placed in arbitrary order - intelligent syntax analysis figures out the dependencies between them and takes care of execution."

# ╔═╡ 13d1fdb4-cc24-4a48-b80d-835c47b97d26
md"## Code Block"

# ╔═╡ 6458bd86-1b7a-46b1-9541-4f9fb350a40d
md"```julia
function myadd(x, y)
    return x + y
end
```"

# ╔═╡ 31415143-8c92-4ccb-bd72-ccaff0057c4e
md"You can insert code inline like `println()` by using single backticks."

# ╔═╡ 1cdd684f-94c6-4c8b-86a5-9a92d9d80ed0
md"## Lists"

# ╔═╡ 55a927ec-5d37-4927-b4b5-d4448c30a8db
md"
1. First
2. Second
3. Third
"

# ╔═╡ 2cad88bb-3a66-4fbc-8501-aeb4f70c4924
md"
* First
* Second
* Third
"

# ╔═╡ ca188785-ddc1-4800-b9fd-1265446a053f
md"## Table"

# ╔═╡ 492c736a-6227-4ff6-90b3-e2753b9a6a50
md"
| Name | Title |
| ---- | ----- |
| doggo | CEO |
"

# ╔═╡ 5b07f1eb-9cf3-4054-9ab6-c5cf1595ec55
md"## Horizontal Rule"

# ╔═╡ 83b928e5-8a99-486a-857f-78d16eea99bd
md"---"

# ╔═╡ 4cb521a9-1f92-402a-8776-e8ab6ba73a48
md"## Escape Characters"

# ╔═╡ 97ad0202-c831-42ba-aadf-a0969ad14655
md"This is a \"great\" tutorial."

# ╔═╡ 5a19d58a-a647-41f9-aa6b-690cf284e6d8
md"This is a dollar sign: \$"

# ╔═╡ 244c2c20-495e-44cd-b247-c31004f36c1c
md"
This is how to add \
a new line.
"

# ╔═╡ 3f35c096-c484-44d4-b05a-be83b1fe5c4e
md"## Unicode"

# ╔═╡ 50f871de-1181-4579-b7ff-ab33d0db0b16
md"H\_2<Tab>O displays as H₂O"

# ╔═╡ 7aac7520-7242-4c05-99fc-36a6b909ec9e
md"\:dog:<Tab> displays as 🐶"

# ╔═╡ 39c40faf-22b3-4cdf-8219-8365ed6930fe
md"## HTML/CSS"

# ╔═╡ 01f56e06-d2a8-4994-bc0a-52541e880f20
html"""
<p style="text-align:center">You can use HTML/CSS to center your text.</p>
"""

# ╔═╡ bceef5ef-162a-43ab-bbf7-cd0c06a6f7a4
md"## Multimedia"

# ╔═╡ 1c47ef8c-bf20-44ab-96ec-5820ee5cdb4c
md"### Link"

# ╔═╡ 3830f0c2-86eb-4c8e-9019-4e48bab40b81
md"Here's the link to [Pluto.jl](https://github.com/fonsp/Pluto.jl) on GitHub."

# ╔═╡ f0251d6f-baf1-4281-8a5b-73f5f2b42398
md"### Static Image"

# ╔═╡ 76472181-eec3-4521-8a6b-0a238e54f4ad
md"![Pluto Logo](https://raw.githubusercontent.com/fonsp/Pluto.jl/dd0ead4caa2d29a3a2cfa1196d31e3114782d363/frontend/img/logo_white_contour.svg)"

# ╔═╡ 50176bf5-9bb3-413f-a111-72d9aa3f23d7
md"[![Pluto Logo](https://raw.githubusercontent.com/fonsp/Pluto.jl/dd0ead4caa2d29a3a2cfa1196d31e3114782d363/frontend/img/logo_white_contour.svg)](https://github.com/fonsp/Pluto.jl)"

# ╔═╡ b810549c-0734-4f69-96b4-133ae8719941
md"### YouTube Video"

# ╔═╡ 75388f2d-6870-4897-b356-00cc3805b2ed
html"""
<iframe width="640" height="360" src="https://www.youtube.com/embed/IAF8DjrQSSk" title="JuliaCon 2020 | Interactive notebooks ~ Pluto.jl | Fons van der Plas" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
"""

# ╔═╡ 2065a3a1-44bf-4e08-b294-39065a237cd2


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╠═60529b50-3547-11ed-1f77-054afbffe8b9
# ╠═0b26e6e3-e288-4c8b-b9fd-00be2412251f
# ╠═4b104850-e3dd-49b6-9758-a43e692be7b3
# ╠═04bce752-5e83-47e9-bb91-80099acf3cf9
# ╠═79045846-64db-4844-91e6-ccd6bb9c53ff
# ╠═25ca9d0a-414f-4d57-84c2-3d1f7fd02c8d
# ╠═d2f9ad64-fcb6-46ac-b964-3a022217a31b
# ╠═826081a8-cbe3-4a78-9d37-c5fff61e4884
# ╠═7f724ec3-31d6-4ae2-8726-2fa6abbd8011
# ╠═35a57141-e4a8-44f3-a2f9-fb8b2b2bdd0b
# ╠═183749d0-6269-4d13-af70-95f4162574f9
# ╠═da5bb48d-5e5c-4dd5-b27b-75246f8fa8cb
# ╠═ac503808-7a78-481c-a6cb-b2b3cf8bc2e8
# ╠═13d1fdb4-cc24-4a48-b80d-835c47b97d26
# ╠═6458bd86-1b7a-46b1-9541-4f9fb350a40d
# ╠═31415143-8c92-4ccb-bd72-ccaff0057c4e
# ╠═1cdd684f-94c6-4c8b-86a5-9a92d9d80ed0
# ╠═55a927ec-5d37-4927-b4b5-d4448c30a8db
# ╠═2cad88bb-3a66-4fbc-8501-aeb4f70c4924
# ╠═ca188785-ddc1-4800-b9fd-1265446a053f
# ╠═492c736a-6227-4ff6-90b3-e2753b9a6a50
# ╠═5b07f1eb-9cf3-4054-9ab6-c5cf1595ec55
# ╠═83b928e5-8a99-486a-857f-78d16eea99bd
# ╠═4cb521a9-1f92-402a-8776-e8ab6ba73a48
# ╠═97ad0202-c831-42ba-aadf-a0969ad14655
# ╠═5a19d58a-a647-41f9-aa6b-690cf284e6d8
# ╠═244c2c20-495e-44cd-b247-c31004f36c1c
# ╠═3f35c096-c484-44d4-b05a-be83b1fe5c4e
# ╠═50f871de-1181-4579-b7ff-ab33d0db0b16
# ╠═7aac7520-7242-4c05-99fc-36a6b909ec9e
# ╠═39c40faf-22b3-4cdf-8219-8365ed6930fe
# ╠═01f56e06-d2a8-4994-bc0a-52541e880f20
# ╠═bceef5ef-162a-43ab-bbf7-cd0c06a6f7a4
# ╠═1c47ef8c-bf20-44ab-96ec-5820ee5cdb4c
# ╠═3830f0c2-86eb-4c8e-9019-4e48bab40b81
# ╠═f0251d6f-baf1-4281-8a5b-73f5f2b42398
# ╠═76472181-eec3-4521-8a6b-0a238e54f4ad
# ╠═50176bf5-9bb3-413f-a111-72d9aa3f23d7
# ╠═b810549c-0734-4f69-96b4-133ae8719941
# ╠═75388f2d-6870-4897-b356-00cc3805b2ed
# ╠═2065a3a1-44bf-4e08-b294-39065a237cd2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
