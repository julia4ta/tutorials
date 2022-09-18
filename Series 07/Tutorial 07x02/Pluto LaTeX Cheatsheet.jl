### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ d42bb9b0-354e-11ed-1003-0d7099c02144
md"# Pluto $\LaTeX$ Cheatsheet"

# ╔═╡ 4f5c334a-6fed-40f1-9a56-b23396dac986
md"## Basic Syntax"

# ╔═╡ 769d3962-ebc0-4944-bf31-63cba2ca07b7
md"
* Text Mode vs. Math Mode
* \$\$ for Math Mode
* Inline vs. Display
* \ for symbols and function
* {} used with functions
* Whitespace is important (unlike KaTeX)
"

# ╔═╡ aa0e4dea-3402-4986-afba-25b9b0a772ac
md"This is Text Mode."

# ╔═╡ ddbf7e2d-20ee-434f-b0b9-c3d03d791f2a
md"$This is what text looks like inside of Math Mode.$"

# ╔═╡ a153b012-31fd-45d8-91fe-39097ff6ad5c
md"$\text{This is how to display text in Math Mode.}$"

# ╔═╡ d1818495-9d07-429c-a937-046411d6ae2c
md"Text Mode: 1 + 1 = 2"

# ╔═╡ c98d166e-118a-4a63-bf0b-8eec9c330fa8
md"Math Mode:"

# ╔═╡ 5fab6852-6044-4e41-8977-5503450a2788
md"$1 + 1 = 2$"

# ╔═╡ 734c29bc-1121-4d81-b7b5-135c096564e8
md"Left-justified Math Mode:"

# ╔═╡ 64977cd8-7fea-4803-9696-9a56dea9d1d0
md" $1 + 1 = 2$"

# ╔═╡ cd82b02b-e6a1-49b1-98ba-0804c9efb80f
md"Inline Math Mode: $1 + 1 = 2$"

# ╔═╡ 41608cfd-aaff-42f5-9871-959f9f6438d5
md"$2 x 3 = 6$"

# ╔═╡ 2693ca34-0e4e-4a44-88f2-55a096d3c108
md"$2 \times 3 = 6$"

# ╔═╡ df30e4ee-193f-4059-8ccd-074ef6c1990b
md"$5 \div 2 = 2.5$"

# ╔═╡ d183f867-e123-40b2-b14f-c2d9e621fb23
md"$\frac{3}{4} = 0.75$"

# ╔═╡ 9f4bc9e8-f3c4-4a4b-a21b-84a5d26257f7
md"$\sqrt{4} = 2$"

# ╔═╡ 50748e03-ac96-43ef-a8c0-cd5ff1b54bf1
md"$\sqrt[3]{8} = 2$"

# ╔═╡ 6b61f7b9-a1fa-4fd2-8be8-9c4f9db9eaaa
md"$x^2$"

# ╔═╡ 4f3860b0-018f-44cd-822e-a3374ab79bbc
md"$t_0$"

# ╔═╡ 22ac5016-0b00-416f-a1fd-dd9dd952cdbc
md"\$100"

# ╔═╡ 675b3b2a-8dc6-4115-b311-0ec32524432c
md"$\textdollar100$"

# ╔═╡ c7b5f8dd-9a99-4b5f-88a9-709fceb4af36
md"o O 0 $0$"

# ╔═╡ 1ec886ab-c0a5-4fd6-aa19-824760ff1b1b
md"$\begin{gather}
this is one line of text \\
\text{and this is another line of text}
\end{gather}$"

# ╔═╡ 3bef0608-290c-4716-93d6-8d310327f91c
md"## Example Equations"

# ╔═╡ 6dc8eed3-088f-4be7-adf6-6c072c98bd6c
md"$a^2 + b^2 = c^2$"

# ╔═╡ 5393101f-4fdf-479c-bcb5-48cb02a94ed9
md"$A = \pi r^2$"

# ╔═╡ a654ddbb-eb18-4403-b245-fe7d412e55a0
md"$\sin A = \frac{\text{opposite}}{\text{hypotenuse}}$"

# ╔═╡ b893115f-4482-4553-a702-7825ba911032
md"$x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$"

# ╔═╡ 680e2cca-a4c5-403b-b069-8df0eebae1f6
md"$\lim_{h \rightarrow 0} \frac{f(a + h) - f(a)}{h}$"

# ╔═╡ 75c2273e-a9db-43e3-9e46-067c66972cae
md"$\begin{align}
x + 2 = 5 \\
x = 5 - 2 \\
x = 3
\end{align}$"

# ╔═╡ 96a54c9e-3988-491a-a0ca-7d7b1d2d08a3
md"## Greek Alphabet: Markdown vs. $\LaTeX$"

# ╔═╡ f33ab677-3878-47ca-a5fd-c521cfc0bcfd
md"\alpha<Tab> \beta<Tab> \delta<Tab> displays as α β δ"

# ╔═╡ 2d424b9b-58a3-4e9b-8734-2473e0d9ef03
md"$\alpha \space \beta \space \delta$"

# ╔═╡ 5092f2ee-3e87-4e5b-9e41-670700b115b8


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
# ╠═d42bb9b0-354e-11ed-1003-0d7099c02144
# ╠═4f5c334a-6fed-40f1-9a56-b23396dac986
# ╠═769d3962-ebc0-4944-bf31-63cba2ca07b7
# ╠═aa0e4dea-3402-4986-afba-25b9b0a772ac
# ╠═ddbf7e2d-20ee-434f-b0b9-c3d03d791f2a
# ╠═a153b012-31fd-45d8-91fe-39097ff6ad5c
# ╠═d1818495-9d07-429c-a937-046411d6ae2c
# ╠═c98d166e-118a-4a63-bf0b-8eec9c330fa8
# ╠═5fab6852-6044-4e41-8977-5503450a2788
# ╠═734c29bc-1121-4d81-b7b5-135c096564e8
# ╠═64977cd8-7fea-4803-9696-9a56dea9d1d0
# ╠═cd82b02b-e6a1-49b1-98ba-0804c9efb80f
# ╠═41608cfd-aaff-42f5-9871-959f9f6438d5
# ╠═2693ca34-0e4e-4a44-88f2-55a096d3c108
# ╠═df30e4ee-193f-4059-8ccd-074ef6c1990b
# ╠═d183f867-e123-40b2-b14f-c2d9e621fb23
# ╠═9f4bc9e8-f3c4-4a4b-a21b-84a5d26257f7
# ╠═50748e03-ac96-43ef-a8c0-cd5ff1b54bf1
# ╠═6b61f7b9-a1fa-4fd2-8be8-9c4f9db9eaaa
# ╠═4f3860b0-018f-44cd-822e-a3374ab79bbc
# ╠═22ac5016-0b00-416f-a1fd-dd9dd952cdbc
# ╠═675b3b2a-8dc6-4115-b311-0ec32524432c
# ╠═c7b5f8dd-9a99-4b5f-88a9-709fceb4af36
# ╠═1ec886ab-c0a5-4fd6-aa19-824760ff1b1b
# ╠═3bef0608-290c-4716-93d6-8d310327f91c
# ╠═6dc8eed3-088f-4be7-adf6-6c072c98bd6c
# ╠═5393101f-4fdf-479c-bcb5-48cb02a94ed9
# ╠═a654ddbb-eb18-4403-b245-fe7d412e55a0
# ╠═b893115f-4482-4553-a702-7825ba911032
# ╠═680e2cca-a4c5-403b-b069-8df0eebae1f6
# ╠═75c2273e-a9db-43e3-9e46-067c66972cae
# ╠═96a54c9e-3988-491a-a0ca-7d7b1d2d08a3
# ╠═f33ab677-3878-47ca-a5fd-c521cfc0bcfd
# ╠═2d424b9b-58a3-4e9b-8734-2473e0d9ef03
# ╠═5092f2ee-3e87-4e5b-9e41-670700b115b8
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
