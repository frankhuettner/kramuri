### A Pluto.jl notebook ###
# v0.19.14

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ e0d09197-fc18-46e9-b0f9-b513ea32596a
begin
	using Plots, Statistics, Images, LaTeXStrings, DataFrames,ShortCodes,QuadGK,Parameters,OrderedCollections, JSON3, Tables, Configurations, Distributions,NewsvendorModel
	import Tar, CodecZlib	, Random, TOML
	md""
end

# ╔═╡ e44321cc-abd9-45ad-b106-e141a7fa086e
using PlutoUI

# ╔═╡ 4535a383-d1a0-454a-8d5a-fd521c6a7fc3
md"# ⚙️ Setup"

# ╔═╡ 440c5757-48c5-4100-b3f8-8b80af572204
yourclassname = "DREAMTEAM"; md"""
**Load the data of your class**
  1. Get the data either...
"""

# ╔═╡ e1248e75-f6b9-440a-857a-4b260f62c3a8
md"""2. Click $(@bind reload_stud_data CounterButton("reload data"))
"""

# ╔═╡ 44537e4c-2a21-402b-aa50-f92f58b3f791
begin
	# Standard data
	# This is what we'll download
    example_data_source_zipped = "https://github.com/frankhuettner/newsvendor/blob/b2566cb1ea28ba7a20614c9a4726bd7a59ed9579/debrief/data.tgz?raw=true"
	
    # Make temp dir
    dir = mktempdir()
 
    # Download example data 
	datatgz = download(example_data_source_zipped)
	
	open(CodecZlib.GzipDecompressorStream,datatgz) do io
	    Tar.extract(io, dir)
	end
    data_path = joinpath(dir, "data")
	md""
end

# ╔═╡ 97826684-aeb4-4f54-8230-722104acbbaf
begin
	reload_stud_data
	classes = readdir(data_path)
	dataexists = length(classes) > 0
	if dataexists
		md"""3. Finally, select you class 👉 $(@bind selected_class Select(classes)) """
	else
		selected_class = ""
		md""
	end
end

# ╔═╡ f67da721-857a-4b24-be85-45b2e35ba707
md"""
# Betting on Uncertain Demand




"""

# ╔═╡ 129fad05-6a71-48f2-81a7-a71a9ab59eb5


# ╔═╡ c0040398-5b76-4d9e-a03c-183759cc18cd
md"""

$(Resource("https://github.com/frankhuettner/newsvendor/raw/main/debrief/img/cheers_1_cakes.jpg", :class=>"center"))



"""

# ╔═╡ b90f9379-f79c-466c-8b47-9439ddb16717


# ╔═╡ 1dd3aa3c-1e8f-4a08-8e28-b1c02befe645
md"""
#  The Newsvendor Problem

"""

# ╔═╡ c890ee87-88f2-46f9-aef5-0f699345a152
Resource("https://github.com/frankhuettner/newsvendor/blob/main/debrief/img/newsvendortimeline.svg?raw=true")

# ╔═╡ 673b1b74-0762-4739-8f57-b15fe72787e3


# ╔═╡ c809c2bc-5d92-4016-84da-f4b77816879d
md"""
## A Problem That Appears Everywhere



"""

# ╔═╡ d0b810a6-7357-4128-b8fb-b13468cf8ce7
Resource("https://raw.githubusercontent.com/frankhuettner/newsvendor/main/debrief/img/scm_mismatch.svg")

# ╔═╡ eb4e0542-5272-4004-a4ff-915211b47af8
md"#### ...with unpleasent consequences..."

# ╔═╡ 9573b788-91ee-45e1-8822-c62a36f6f56f
md"""

!!! danger "Managing mismatch means to manage the Newsvendor Problem"

"""

# ╔═╡ a2ee5bcb-e5ff-4260-81a3-eef389419784


# ╔═╡ 820278c4-8700-47f7-939c-1c91e109c539
md"""
#  The Key to Contemporary OM

"""

# ╔═╡ c9224d1c-5b38-49de-b0d0-42517fc58155
md"""

!!! danger "The Newsvendor Problem is THE model to balance too many vs. too little"
	We face it whenever we 
	+ make quantitative decisions about the future, where we 
	+ balance TOO MANY vs. TOO LITTLE, 
	+ based on some forecast data.

"""

# ╔═╡ 79733c4c-f5c9-4583-9098-58d9fad1a27b
md"""
!!! tip "The problem appears in many situations (in disguise)"
	- **Capcity decisions:** How big should the factory be?
    - **Airline seat overbooking:** How many tickets should we sell so that we balance empty seats against penalty for leaving passengers behind?
	- **Dynamic pricing:** How many hotel rooms should be sold to early birds (at cheap price), how many shall we retain for late travelers (higher price)?
	- **Liquidity planing:** How much credit long-term (low rates) vs. short-term?

"""

# ╔═╡ 43425ad9-8e45-4ecd-a994-83a1a696f145


# ╔═╡ a0b01552-55ec-4522-bdef-adc1a84837ad
md"""
#  Debrief of Patisserie Cheers

"""

# ╔═╡ 8119a6a4-04a4-4ab0-bc1b-b0856d1611c8


# ╔═╡ c0eb24ec-c201-4dbc-95ae-4a8a954750fc
Resource("https://github.com/frankhuettner/newsvendor/blob/main/debrief/img/debrief_kids.jpg?raw=true", :class => "center")

# ╔═╡ b5e48a63-7163-49a4-a3b3-e5ffc828b289


# ╔═╡ af26188e-0a70-49e2-8d09-923467ab7496
md"""
 👉 Change the assumed `fixed cost`: $(@bind fixed_cost Slider(0:1000:9000, default=0, show_value=true))

❗ Strong impact: We improve  [Contribution margin = revenue − variable costs](https://hbr.org/2017/10/contribution-margin-what-it-is-how-to-calculate-it-and-why-you-need-it)
"""

# ╔═╡ 2f99c200-f4e3-4a8c-a24e-59b1e2191145


# ╔═╡ 4ba5c1f0-60b2-47c9-8220-7836e84b9ce8


# ╔═╡ 71faa189-c00b-4092-939e-3f9b8013a8b2
md"""
## How to Win the Simulation? Being Lucky + ...


"""

# ╔═╡ 15108dce-2f56-44b7-affd-b580a738a1dc
md"""

**Intuition**

It was worse to miss a customer (€ 4 lost) than having a cake left over (€ 1 lost) 

➡ Safety stock needed

"""

# ╔═╡ de237b11-25fd-48e5-95fc-b22a7b369f53
md""" 

!!! danger "➡ It is Important to Distinguish Forecasting and Decision Making!" 
	We need forecasts to make an educated decision but we should not automatically stock the expected demand

"""

# ╔═╡ be3fe754-e633-45b1-bc0e-ab1cf3aec3ac


# ╔═╡ 6f1a80c0-3ba3-42dd-9f35-135062b370e4
md"""
## Without the Influence of Luck: Expected Profit

To eliminate the element of luck, I repeated your play for many, many days...
"""

# ╔═╡ 3e73717c-15e3-4697-992d-63e5b428f1a8
md"""
!!! tip "115 promised the best result"	



""" 

# ╔═╡ fc4238a6-94c7-47d0-b2f0-ac89c7e9bbd1


# ╔═╡ 66025ac7-47d6-4c11-83fa-befff248e2ea
md"""
## More Cake? Understood. What Else Went Wrong?
"""

# ╔═╡ 9500bd51-ffa8-431d-a6e9-a9ab91769240


# ╔═╡ b9888d70-399f-4bb7-b817-f623493c5f2a
md"""
## Was There Any New Information About Demand Throughout the Month?

"""

# ╔═╡ be9335a2-1029-4fd6-adeb-d0fc4de935fd


# ╔═╡ cb4431ef-2be4-47cd-a786-4df92c67002f
md"""
## What Justifies Different Quantities Throughout the Game?
"""

# ╔═╡ a984d28e-60d9-48aa-9766-28ee2ab5e58f
md"""
- Cost and price did not change throughout the month
- Every day we dealt with the same demand
"""

# ╔═╡ 09e5f79a-5a68-4ed7-9352-cf0ea8c2aa07
md""" 

!!! danger "➡ The optimal quantity for day 1 was also optimal on every other day" 
	

"""

# ╔═╡ 4d94e0f7-7c87-442f-9f60-4bacb474a484


# ╔═╡ a31d8f99-7487-4935-988b-9717c1ab9289


# ╔═╡ ba5fa42c-345e-4418-823f-b622febde2ee
md""" # I) Quantifying the Cost of Mismatch 
"""

# ╔═╡ 4dbc0052-81bc-4b81-bd0b-c536788ff6bf


# ╔═╡ b267ab57-05e4-494d-9ed4-54d968003e8a
md""" ## Critical Fractile (CF)

!!! tip "Definition "
    $$\qquad \text{CF} = \dfrac{\text{Cost of Underage}}{\text{Cost of Underage + Cost of Overage}} = \dfrac{C_u}{C_u + C_o}$$



"""

# ╔═╡ be019d95-a3b7-4b0b-a047-4100d48ae05f
md"""
**CF** tells us how costly it is to understock if we keep in mind that the alternative is to overstock (underage cost must be seen in relation to the overage cost).
"""

# ╔═╡ 61300264-4844-4925-8c2a-38bec150a759


# ╔═╡ e833c3a2-a91c-424a-8ec8-38fc38022a08
md"""
## Exercise: Co, Cu, CF
"""

# ╔═╡ 32a687c0-c2af-4dec-ad8e-bb5c6ec6a591
md"""Cᵤ = € 4 , Cₒ = € 1, CF = 0.8
"""

# ╔═╡ 100cb7dd-6343-4ef9-ac08-7b57a78c903e
md"""

	What would be Co, Cu, and CF? If...
	
	1. ... we can sell leftover cakes to a bar for € 0.5 per piece, i.e., for a **salvage value = € 0.5**.  All else as in the orginal case.
	
	2. ... we improve forecast: **standard dev.** ↘️ **σ = 20**. All else as in the case.
	
	
	"""

# ╔═╡ a93782c2-61b5-4ab5-a122-eda5a4d8d2c2


# ╔═╡ 4df81f21-d69b-4a2a-93b2-c476cfc80383
md"""
# II) Quantifying the Chance of Mismatch


!!! tip "Definition: Expected Service Level (SL)"
	The **Expected Service Level (SL)** for a chosen quantity is the probability of NOT running out of stock

➡  Chance of running of out stock = 100% -- SL 

"""

# ╔═╡ d5c0d931-92c7-4e62-806e-14bd52c0e9af
md"""
## Quantity Needed to Achieve a Targeted SL
"""

# ╔═╡ aa8798fa-62db-4ecc-8efe-f1eb53411004
md"""
👉 Move this slider to change the desired service level: $(@bind my_SL_percent Slider(1:99, default=50, show_value=true))%"""

# ╔═╡ 8397d2b5-d994-4791-b4bc-3bc07629f506


# ╔═╡ d9485017-6d38-45b0-a9ed-e32ea87e88e7
md"""
# III) Finding the Optimal Quantity

How much quantity should we stock? The answer combines:

##### Critical fractile (CF)
* How costly is understocking compared to overstocking?
* Computed from unit values; not computed from demand
* High CF ➡ you **want** to stock high quantity Q

##### Expected Service level (SL)
* Probability of satisfying all demand if we stock some chosen quantity Q
* Relates chosen quantity Q with demand
* Stocking high quantity Q ➡ you **get** a high SL
"""

# ╔═╡ 933e018f-7229-4e29-b1ae-c07a19772213


# ╔═╡ 33f4e807-5329-4edc-8b5e-a1cd46c60594
md"""
# Optimality Condition and Recipe

!!! danger "Optimality Condition"
	**Critical Fractile (CF)  = Service Level (SL)**


	
!!! tip "Getting the optimal quantity"
	Step 0) Collect demand data and obtain mean μ and standard deviation σ.

	Step 1) **Compute** the cost of underage **Cᵤ** and the cost of overage **Cₒ**.

	Step 2) **Compute** the critical fracile **CF = Cᵤ / (Cᵤ + Cₒ)**.

	Step 3) Find the quantity so that the implied service level equals CF. Excel gives this quantity with the **Formula `=Norm.Inv(CF, μ, σ)`**

"""

# ╔═╡ cfd852f3-1e53-476f-b646-743dde2c6481
md"""
## Rounding Up or Down?
**Slight deviation from the optimal quanitity is still very good**
"""

# ╔═╡ 94f0412b-6c34-4b64-8365-9d11dfebd055
md"""
1. Mathematically, rounding to the next integer is mostly best
2. Pragmatically, *rounding up* seems better because what really matters is: 
   - The **input data** is tends to be wrong: Cᵤ and σ are usually underestimated
   - There is a tendency to pull to the center
   => Better have some more safety stock
"""

# ╔═╡ bfafe0ac-e369-4914-b75b-c93ac36967f5


# ╔═╡ 31109c8e-14a9-446b-a2ff-ac34dcc12ed1


# ╔═╡ 9a36dbb8-6e14-433c-a691-f61c9fc5b7d0
md"""
	## Solution Exercises (Original Case: Q* = 115)
	
	"""

# ╔═╡ 9c2fd59f-7d1f-4749-afc4-59fc2d345a3f


# ╔═╡ cc1a98e1-c8bc-4810-82f3-8fe9cbbae731
md"""
# Executive Summary
**Managing mismatch means to manage the Newsvendor Problem**

- Ignoring uncertainty is very costly
  - Stocking the expected demand misses on profit
  - Prevents active management with the goal to reduce risk
  - There will be mismatch, one way or the other (better be prepared)


- Quantifying cost of mismatch
  - Co = Money wasted from having stocked a unit more than demaned
  - Cu = Forgone profit if demand ends up being a unit above the stocked quantity
  - CF = Cu / (Cu + Co) 


- Quantifying chance of mismatch
  - SL = probability of NOT running out of stock


- Optimality condition CF = SL  => Optimal quantity `=Norm.Inv(CF, μ, σ)`


"""

# ╔═╡ 8775f400-a638-4cab-9a2f-1cfad27e2dee


# ╔═╡ ebd554c7-60dd-45d3-a367-3651b4a2df8f
md"""
## Food for Thought: How Is This Innovatation Solving the Newsvendor Problem?
**RNA Printer®**: [“assists with a rapid response to outbreaks and can be stationed in hospitals to provide personalized medicine”](https://www.curevac.com/en/technology/production/)
$(Resource("https://www.curevac.com/wp-content/uploads/2017/11/curevac-gallery-03-1536x958.jpg"))
"""

# ╔═╡ 5f3d33b5-c600-452e-a1b6-ffe3953e33e5
md"# Appendix"

# ╔═╡ 19975a48-0f5f-4f8b-903c-3d93181d81a1
md"""
## References

The origin of the Newsvendor model in its moder version
- K. J. Arrow, T. Harris, J. Marshak, Optimal Inventory Policy, Econometrica 1951

Books for diving deeper
- Cachon, G., and Terwiesch, C.  Matching Supply With Demand: An Introduction To Operations Management. McGraw Hill, 2012.
- Nahmias, S. and Olsen, T.L., 2015. Production and operations analysis. Waveland Press.
- $(DOI("10.1007/978-1-4939-9606-3"))

Empirics on stock-outs
- $(DOI("10.1287/mnsc.1060.0577"))

Decision biases
- $(DOI("10.1287/mnsc.1120.1617"))
- $(DOI("10.1287/mnsc.46.3.404.12070"))
- $(DOI("10.1037/0893-164X.13.4.339"))


"""

# ╔═╡ 7f53825b-4c0d-4b0e-9299-202e7bd751e1
md"""
##  Image Sources

- [Cakes](https://pixabay.com/images/id-170437/)
- [Newspaper Room](https://lccn.loc.gov/2017837957)
- [Newspaper Leftover](https://pixabay.com/images/id-2586624/)
- [Play Station 5](https://commons.wikimedia.org/wiki/File:PlayStation_5_and_DualSense_with_transparent_background.png#/media/File:PlayStation_5_and_DualSense_with_transparent_background.png)
- [Powerplant](https://newatlas.com/energy-tower-incinerator/33828/)
- [Soccer](https://pixabay.com/images/id-2444978/)
- [Cluster](https://upload.wikimedia.org/wikipedia/commons/0/0f/RandomPoints.gif)
- [Face of Mars I](https://upload.wikimedia.org/wikipedia/commons/7/77/Martian_face_viking_cropped.jpg/)
- [Face of Mars II](https://upload.wikimedia.org/wikipedia/commons/d/de/Face_on_Mars_with_Inset.jpg/)
- [Gambler's Fallacy](https://upload.wikimedia.org/wikipedia/commons/4/49/Lawoflargenumbersanimation2.gif)
- [Introspection](https://mitulj9.medium.com/how-do-we-introspect-c6cef50d7b58)
- [RNA printer](https://www.curevac.com/wp-content/uploads/2017/11/curevac-gallery-03-1536x958.jpg)
- [Newsvendor boy](http://clipart-library.com/clipart/43301.htm)

"""

# ╔═╡ fe94c8b9-02ea-4613-b7ba-030b4587ac40
md"## 👩👨🧑 📈📉📈 Class Results and Statistics"

# ╔═╡ f6fedebe-0a24-4503-abfd-c0b37155bb6b
# available_scenarios = ["cheers_1", "cheers_2", "cheers_3", "cheers_4", ]; md"""
# Select a scenarios for class performance 👉 $(@bind selected_scenario_agg Select(available_scenarios))
# """; 
selected_scenario_agg = "cheers_1";

# ╔═╡ c8618313-9982-44e0-a110-2d75c69c75e8
begin
	# Foldable
	struct Foldable{C}
		title::String
		content::C
	end

	function Base.show(io, mime::MIME"text/html", fld::Foldable)
		write(io,"<details><summary>$(fld.title)</summary><p>")
		show(io, mime, fld.content)
		write(io,"</p></details>")
	end
	
	# example
	# Foldable("What is the gravitational acceleration?", md"Correct, it's ``\pi^2``.")
	
	
	
	### Two column
	struct TwoColumn{L, R}
		left::L
		right::R
	end

	function Base.show(io, mime::MIME"text/html", tc::TwoColumn)
		write(io, """<div style="display: flex;"><div style="flex: 50%;">""")
		show(io, mime, tc.left)
		write(io, """</div><div style="flex: 50%;">""")
		show(io, mime, tc.right)
		write(io, """</div></div>""")
	end
	# example
	# 	TwoColumn(md"Note the kink at ``x=0``!", plot(-5:5, abs))

	
	html"""
		<style>
	
		@import url('https://fonts.googleapis.com/css2?family=Lexend+Deca:wght@200;300;400&display=swap');
	
		pluto-output table>tbody td {
		font-family: 'Lexend Deca', sans-serif;
		font-size: 1rem;
		}
		select, input   {
		font-family: 'Lexend Deca', sans-serif;
		font-size: 1rem;
		}
		pluto-output, pluto-output div.admonition .admonition-title {
		font-family: 'Lexend Deca', sans-serif;
		}
		pluto-output h1, pluto-output h2, pluto-output h3, pluto-output h4, pluto-output h5, pluto-output h6 {                                                  	font-family: 'Lexend Deca', sans-serif;
		    font-weight: 300    
					   
		}
		pluto-output h1  {                    
		    font-size: 2rem    
		}
		pluto-output h2  {                    
		    font-size: 1.6rem    
		}
		.center {
		  display: block;
		  margin-left: auto;
		  margin-right: auto;
		  width: 60%;
		}
		</style>
	"""
end

# ╔═╡ aac85891-ea00-4421-b90e-8a9d7ce11792
TwoColumn(md"""
... from the internet:  paste the url you received from your instructor below $(@bind yourclass_data_source TextField((35,5); default=""))
"""
, 
md""" 
... or from a file: select the file you got from your instructor from you computer:

$(@bind file_data FilePicker())

"""	
)

# ╔═╡ 41ac0852-3555-48b9-a369-3b617adba62b
TwoColumn(md"""
**Appearance**
- Hide Table of Contents  $(@bind hide_toc html"<input type=checkbox >")
- Reveal hints    $(@bind reveal_hint html"<input type=checkbox >")
- Show mentimeter slides (experimental)   $(@bind want_to_show_menti_slide html"<input type=checkbox >")
"""
, 
md""" 
**For Developers**
- Show code  $(@bind show_ui html"<input type=checkbox >")
"""	
)

# ╔═╡ a99ee910-7091-4aef-ac52-bc84225b9dc1
if want_to_show_menti_slide
md"""
Enter the link to mentimeter below: $(@bind menti_link  TextField((50); default="https://www.menti.com/"))

"""	
else
	md"";
end

# ╔═╡ c8a88597-c465-4509-82e1-4d38ed44cbee
if @isdefined hide_toc 
	if !hide_toc 
		TableOfContents() 
	end
end

# ╔═╡ 47bad2aa-051e-4ef0-97b6-2d94641b1a5d
if show_ui
md"# Source Code
## Packages
"
else
	md""
end

# ╔═╡ 9955422e-769d-442a-b7d7-edea3156e8f1
if show_ui
	md"## Parameters"
else
	md""
end

# ╔═╡ b76aecc2-b80e-446d-958c-9c32c030a085
if show_ui
	md"## Styling and Pluto Sugur"
else
	md""
end

# ╔═╡ 375b5f20-ff08-4d9a-8d41-38214db962de
if !show_ui
	html"""
		<style>
		pluto-input {
			display: none;
		}
		main {
		margin-top: 20px;
		cursor: auto;
		}
	
		#at_the_top,
		#export,
		preamble > button,
		pluto-cell > button,
		pluto-input > button,
		pluto-shoulder,
		footer,
		pluto-runarea,
		#helpbox-wrapper {
			display: none !important;
		}
		</style>
	"""
end

# ╔═╡ b89d8514-2b56-4da9-8f49-e464579c2293
begin
	# Some definitions and helper functions
	bigbreak(n = 4) = HTML("<br>" ^ n);
	
	hints_visible = reveal_hint
	
	
	function hint(text, headline = "Hint") 
		if hints_visible
			Markdown.MD(Markdown.Admonition("note", headline, [text]))
		else
			Markdown.MD(Markdown.Admonition("hint", headline, [text]))
		end
	end
	
	# example
	##  hint(md"""at this""", md"""look here""")
	
	almost(text) = Markdown.MD(Markdown.Admonition("warning", "Almost there!", [text]))
	still_missing(text=md"Replace `missing` with your answer.") = Markdown.MD(Markdown.Admonition("warning", "Here we go!", [text]))
	keep_working(text=md"The answer is not quite right.") = Markdown.MD(Markdown.Admonition("danger", "Keep working on it!", [text]))
	yays = [md"Fantastic!", md"Splendid!", md"Great!", md"Yay ❤", md"Great! 🎉", md"Well done!", md"Keep it up!", md"Good job!", md"Awesome!", md"You got the right answer!", md"Let's move on to the next section."]
	correct(text=rand(yays)) = Markdown.MD(Markdown.Admonition("correct", "Got it!", [text]))
	


	md""
end

# ╔═╡ 31bb5deb-dccd-4d09-9ce6-59ad7b87cdd4
hint(md"""
Without being aware of uncertainty, just ordering what is expected seems quite common. Many companies add some safety stock (usually not enough). 
""",
	
	"""What would you do if no uncertainty was communicated, i.e., if you only have the information: Expected Demand = 90 cakes""")

# ╔═╡ 96ffc209-8a30-48a8-afe7-88e0c5cd0d00


hint(md""" 

...to realize own mistakes, to better understand the trade-off € 4 vs. € 1, and to adjust accordingly. Let's celebrate those who learned throughout the game 🎉 """,
	
	"""The only reason to change the quantity throughout the game was...""")

# ╔═╡ b96affe0-c626-48b7-a9fd-7286636f0813
hint(md"""50%: There is a 50% chance that demand is higher than the mean (and a 50% chance that demand is lower than the mean). This is because the Normal distribution is symmetric.



""", """SL at the mean: How likely do we satisfy all customers if we stock 90 cakes?""")

# ╔═╡ 20f6d71e-d930-4cb6-9656-a355e2a25db1
TwoColumn(md"""
**For Presentation and Printing**
- Show mentimeter reminder   $(@bind show_menti html"<input type=checkbox >")

	"""
, html" Click here to change to <button onclick='present()'>Presentation Mode</button>  (Tip: F11 puts the browser in fullscreen)")

# ╔═╡ 6e11766a-299a-44b0-9f90-4eee775c88d8
if show_menti
	md"""## MENTI: Hello, How Are You?"""
else
	md""
end

# ╔═╡ 6870801a-f028-4de2-a49c-e54288f62306
if show_menti
	md"""## MENTI: Forecasts & CI in Your Company	"""
else
	md""
end

# ╔═╡ 228550fc-0244-4092-845e-51b6a391078d
if show_menti
	md"""## MENTI: Fixed Cost At the Cafe	"""
else
	md""
end

# ╔═╡ b7aefb70-4636-45fc-a3e8-6927c543e8f6
if show_menti
	md"""## MENTI: Forecast = Decision?	"""
else
	md""
end

# ╔═╡ a0be9a35-cdca-4302-aa6f-72204dbea363
if show_menti
	md"""## MENTI: New Info About Demand?"""
else
	md""
end

# ╔═╡ d26eba94-a2aa-4929-9920-e72b60bbd719
if show_menti
	md"""## MENTI: SL at the Mean	"""
else
	md""
end

# ╔═╡ bb8560ff-6834-41ed-951a-4c3d9a880bb8
if show_menti
	md"""## MENTI: Vary SL Across Products?	In Your Firm?"""
else
	md""
end

# ╔═╡ b1a22d84-2c8d-438f-b198-428a9675efb4
TwoColumn(Resource("https://raw.githubusercontent.com/frankhuettner/newsvendor/main/debrief/img/ps5_sold.svg", :height => 150),
	Resource("https://raw.githubusercontent.com/frankhuettner/newsvendor/main/debrief/img/hm_burn.svg", :height => 150)
)

# ╔═╡ e0b1a878-d4ae-4a6a-99b5-0b5791e9defc
Foldable("
Note that tracing the demand is always a good idea" 
	,md"""
- In reality, we might want to update our forecast
- But even if we update our belief from what we see, we also have to keep in mind the information about the 365 days before the simulation
=> Your update should have small impact unless you learn something really new
""")

# ╔═╡ d700218c-605d-47c2-b3f2-fcebfad8d633
if show_ui
md"## Functions
###  Computation Helper
"
else
	md""
end

# ╔═╡ ca7a33bf-7198-4161-a3f8-39e432db2623
begin
	"""
		my_round(x::Real; [sigdigits::Int=3])		
	Return x rounded with #sigdigits significiant digits.
	"""
	function my_round(x::Real; sigdigits::Int=3)
		x = round(x, sigdigits=sigdigits)
		if x >= 10^(sigdigits-1)
			Int(x)
		else
			x
		end
	end
	function percentup(old, new; stringed = true)
		res = my_round(100 * (new - old)/old)
		if stringed
			return string(res) * "%"
		else
			return res
		end
	end

	md""
end

# ╔═╡ b2c19571-95b1-4b7f-9ec1-ed83ba7b8aef
begin # Default parameters
	μ = 90	 
	σ = 30
	# distr = TruncatedNormal(μ, σ, 0, μ+3*σ)
	distr = Normal(μ, σ)
	
	selling_p = 5
	wholesale_p = 1  
	salvage_val = 0

	nvm = NVModel(demand=distr, price = selling_p, cost = wholesale_p, salvage = salvage_val);
	
	Co = overage_cost(nvm)
	Cu = underage_cost(nvm)
	CF = critical_fractile(nvm)
	CF_percent = my_round(100*CF)	
	
	
	md""
end

# ╔═╡ 7d6dfb80-5a6c-4559-a325-490af3da2263
Foldable("Click here to see the calculation",
	begin
	qs = [90.0, 100, 115]
	monthly_profits = [NewsvendorModel.profit(nvm, q) * 30 for q in qs]
	
	# push!(qs, mean(df_res[:,:AvgStock]))
	# push!(monthly_profits, 30*mean(df_res[:,:ExpProfit]))
	monthly_incomes = monthly_profits .- fixed_cost 
	fixed = [ fixed_cost for i in monthly_incomes]
	df = DataFrame("# Cakes Made" => qs, "Expected Monthly Profit Contributon" => monthly_profits, "Fixed Cost (Rent + Staff)" => fixed, "Owners' Income" => monthly_incomes)
	end
)

# ╔═╡ bc6f34b2-6909-4de0-8666-f80b04359061
md"""
## Ignorance Is Bliss?
Optimal quantity instead of $(μ) (expected demand) ➡ Increases profit by $(percentup(monthly_incomes[1], monthly_incomes[3])) 
"""

# ╔═╡ 58994e41-e952-42b8-9c44-3e59236dff93
let
	gr()
	Plots.bar(qs, monthly_incomes, xlabel="Profit per Month (Assuming Fix Cost = $(fixed_cost))", legend = false, orientation = :h, yaxis = nothing,
# 		title="Stock optimal quantity instead of $(μ) (expected demand) \n  ➡ Increases profit by $(percentup(monthly_incomes[1], monthly_incomes[3])) 

# ", 
		size = (600, 290)
	)
	annotate!(200, 115, text("Optimal Quantity",14, :white, :left))
	annotate!(200, 100, text("Status Quo (100)",14, :white, :left))
	annotate!(200, 90, text("Ignorant of Uncertainty (90)",14, :white, :left))
end

# ╔═╡ b4dbec80-c66d-49ae-8736-e48b40982cd5
hint(md"""Stocking more than $(μ) units performed mostly better """,
	
	"""Was it better to stock more or less than the expected demand ($(μ))?""" )

# ╔═╡ 8bf3211d-e009-4b34-8d18-48ef398b0d9c
md"

## Why Was Stocking $(μ) Cakes Not Enough?



"

# ╔═╡ 5b45b95e-77d8-4ff4-8b18-08638346013e
begin
# needed parameters
wholesale_p
Co
salvage_val
selling_p
Cu

md"""

#####  Too Many: Cost of Overage (Cₒ)
Money wasted from having stocked a unit more than demaned


"""
end

# ╔═╡ 90b4050f-84ef-42f5-9c77-e48b49bd997e
begin
	# needed parameters
	wholesale_p
	Co
	salvage_val
	hint(md""" ➡  Having a cake left over wastes €1: Cₒ =   $(wholesale_p)  --   $(salvage_val) =   $(Co)   $("😣"^Co)
	
	""", """You stocked for € $(wholesale_p), salvaged for  € $(salvage_val)  """)
end

# ╔═╡ a5689c64-3dd0-4bf4-b26b-5b91791e6d68
begin
# needed parameters
wholesale_p
Co
salvage_val
selling_p
Cu

md"""

##### Too Little: Cost of Underage (Cᵤ)

Forgone profit if demand ends up being one unit above the stocked quantity

"""
end

# ╔═╡ 604f54bd-c02f-4eed-8852-9e47172667fa
begin
	# needed parameters
	wholesale_p
	Co
	salvage_val
	hint(md"""➡ Missing a customer looses €4:  Cᵤ =    $(selling_p ) --   $(wholesale_p) =  $(Cu )   $("😣"^Cu)
	
	""", """You stocked for € $(wholesale_p) and sold for  € $(selling_p ) """)
end

# ╔═╡ 942f3e3d-8eee-46bf-a919-7f8c3ef2d85a
gr();TwoColumn(md"""Our example with 
	* Cᵤ = € $(Cu) and 
	* Cₒ = € $(Co), we get 
	➡ CF = ``\frac{\qquad}{\qquad + \qquad}``  = $(CF_percent)%. 
	
	➡ CF greater than 50% means: Missing a customer hurts more than a leftover unit. 
	
	
	""",	
	Plots.pie(["Cost of Overage","Cost of Underage"], [1-CF, CF ],  legend=:outertop, size=(250,250), color = [ :darkorange,  :lightblue])
	)

# ╔═╡ 865c2380-dc7b-4f64-99b5-b34d5bc067d5
TwoColumn(	md"""
Recall:

Demand
   - Mean = $(μ)
   - Sigma = $(σ)
""",
md"""
Cost
   - Selling price = $(selling_p)
   - Unit cost = $(wholesale_p)
   - Salvage value = $(salvage_val)
""")


# ╔═╡ 6258d6a2-3df6-46c5-a728-027a3d533e6f
let
	gr()
	xs = 0:1:μ+3*σ
	p = plot(xlim=(0,μ+3*σ), 
		ylabel=" \n How likely is this demand", yaxis=nothing)
	
	my_SL = my_SL_percent / 100
	x_lower = 0
	x_upper = quantile(distr, my_SL)
	interval = x_lower:x_upper
	
	plot!(p, xs, pdf.(distr,xs), lw=5)
	plot!(p, x_lower:x_upper, x->-0.00005, lw=5, c=:green)
	plot!(p, interval, x->0, fillrange = pdf.(distr,interval),
		size = (680,300),
		fillalpha = 0.35, 
		 c = :purple,
		legend=:false, 
			# xlabel="Number of cakes", 
			label="Probability of \nsatisfying demand" )
	
	annotate!(p, x_upper, 0.0006, text("$(round(Int,x_upper))",10, :green))
	annotate!(p, x_upper, -0.000, text("|",10, :green))
	
	annotate!(p, 10, 0.945*pdf.(distr,μ), 
		text("Suppose you order $(round(Int,x_upper)): Then,\nyou satisfy all demand if\ndemand falls to the\nleft of $(round(Int,x_upper)) ",10, :green, :left))
	
	annotate!(p, μ+3.1*σ, 0.89*pdf.(distr,μ), 
		text("The purple area covers\n $(my_SL_percent)% of the area under\n the blue curve,\ni.e., demand\n is to the left of $(round(Int,x_upper))\n with prob. $(my_SL_percent)%",10, :purple, :right))
end

# ╔═╡ 04175c8b-fb50-4ad4-99c5-3b519a8b0da9
md"""
If we stock $(round(Int,quantile(distr, my_SL_percent / 100))), then the chance to not run out of stock is $(my_SL_percent)% , i.e., **stocking $(round(Int,quantile(distr, my_SL_percent / 100))) gives an Expected Service Level SL = $(my_SL_percent)%**

"""

# ╔═╡ ac888d85-cb85-44da-94b3-bf7095d1714b
TwoColumn(md"""
**Example Patisserie Cheers!**

We learn mean μ = $μ and standard deviation σ = $σ from the case.


""",
	md"""
	

1. **Cᵤ** = \$$(selling_p)--\$$(wholesale_p) = **\$$(Cu)**;  **Cₒ** = \$$(wholesale_p)--\$$(salvage_val) = **\$$(Co)**.
2. This gives   **CF = \$$(Cu) / (\$$(Cu) + \$$(Co)) = $CF**.
3. We target a service level of $(CF). Excel: `=Norm.Inv(0.8, 90, 30)` =  **115.2**. 
	"""
)

# ╔═╡ 59a24e9b-24f6-4b5b-b41d-88da790b1b02
let
	qopt = NewsvendorModel.q_opt(nvm) 
	xs = range(qopt-std(nvm.demand), qopt+std(nvm.demand), 100)
	plot(xs, [NewsvendorModel.profit(nvm, x) for x in xs], lw=4,
		xlabel="Quantity Stocked",
		ylabel="Expected Profit",
		legend=false,
		size=(520,250),
		title="Robust Optimum: Similar Profits Q=110...120"
	)
end

# ╔═╡ 0cfedd8f-c04f-40eb-bab9-7fcc79f8ab85
begin
	nvm1 = NewsvendorModel.NVModel(demand=Truncated(Normal(90, 30), 0, 180), price = 5, cost = 1, salvage = .5)
	nvm2 = NewsvendorModel.NVModel(demand=Truncated(Normal(90, 30), 0, 180), cost = 1, price = 5, substitute = 1) 
	nvm3 = NewsvendorModel.NVModel(demand=Truncated(Normal(90, 20), 0, 180), price = 5, cost = 1)
	nvm4 = NewsvendorModel.NVModel(demand=Truncated(Normal(90, 20), 0, 180), price = 5, cost = 1, salvage = .5, substitute = 1)
	dprofit = my_round(NewsvendorModel.profit(nvm) )
	dprofit1 = my_round(NewsvendorModel.profit(nvm1) )
	dprofit2 = my_round(NewsvendorModel.profit(nvm2) )
	dprofit3 = my_round(NewsvendorModel.profit(nvm3) )
	dprofit4 = my_round(NewsvendorModel.profit(nvm4) )
		

	mprofit90 = my_round(30 * NewsvendorModel.profit(nvm, 90) - 5000 )
	mprofit100 = my_round(30 * NewsvendorModel.profit(nvm, 100) - 5000 )
	mprofitopt = my_round(30 * NewsvendorModel.profit(nvm) - 5000 )
	mprofit4 = my_round(30 * NewsvendorModel.profit(nvm4) - 5000 )

	lo90 = round(Int, leftover(nvm, 90))
	lo100 = round(Int, leftover(nvm, 100))
	loopt = round(Int, leftover(nvm, q_opt(nvm)))
	lo4 = round(Int, leftover(nvm4, q_opt(nvm4)))
	
	md"""
	## Exercises (Original Case: Q* = 115)

	Should we stock more or less? What would be the optimal quantity? If...
	
	1. ... we can sell leftover cakes to a bar for € 0.5 per piece, i.e., for a **salvage value = € 0.5**.  All else as in the orginal case.
	
	2. ... customers buy durable pralines if we stock-out. These only yield a margin of  € 1 but do not perish, i.e., **substitute margin = € 1**.  All else as in the case.

	3. ... we improve forecast: **standard dev.** ↘️ **σ = 20**. All else as in the case.

	4. ... a **combination of the above**: standard deviation is only σ = 20, salvage value = € 0.5, and substitue margin = € 1. All else as in the case.
	
	
	"""
end

# ╔═╡ 159a7ab5-5216-47c8-8bd4-56db4765afe6
begin

	
Markdown.MD(Markdown.Admonition("tip", "♻️ More Waste?", [
	
md""" 
Leftover increases with profit  **➡ Requires active management of mismatch**

from daily $lo90 🍰 (when ignoring risk and stocking the forecasted **90** cakes) 

↗️ $(percentup(lo90, lo100)) to $lo100 🍰 (when stocking **100** cakes) 

↗️ $(percentup(lo100, loopt)) to $loopt 🍰 (when stocking **profit-optimal** quantity 115) 

↘️ 0 🍰 (when **selling** $lo4 🍰 leftover to a bar as in question 1)
"""

]))
end

# ╔═╡ 42dc3b20-2778-48b1-8c8f-f88eb90b3083
TwoColumn(
hint(md"""More. Having left over hurts less than before. Cₒ = 1 - 0.5 = 0.5, Cᵤ = 4, CF =  0.89; Q* `=Norm.Inv(0.89, 90, 30)` = **127** (expected profit  increases $(dprofit) ↗️ $(dprofit1))""", """Answer Exercise 1""")
	,

hint(md"""Less. Not having enough cake hurts less than before. Cₒ = 1, Cᵤ = 5 - 2 = 3, CF =  0.75; Q* `=Norm.Inv(0.75, 90, 30)` = **110** (exp. profit increases $(dprofit)↗️ $(dprofit2))""", """Answer Exercise 2""")
)

# ╔═╡ 0c1fb50f-4b75-4449-93b6-f1163af266a5
TwoColumn(
hint(md"""Better forecast ➡ optimal quantity gets closer to expected demand, i.e., we need less safety stock in our case. CF =  0.8; Q* `=Norm.Inv(0.8, 90, 20)` = **107** (exp. profit increases $(dprofit) ↗️ $(dprofit3))""", """Answer Exercise 3""")
	,
hint(md"""Cₒ = 0.5, Cᵤ = 3, CF =  0.86; Q* `=Norm.Inv(0.86, 90, 20)` = **114**  (expected profit increases $(dprofit) ↗️ $(dprofit4)). 

""", """Answer Exercise 4""")	
)

# ╔═╡ f3efb8b3-8788-49e8-862d-5fc8fb85f115
Foldable( "$(percentup(4020, 5320)) Higher Income from Reducing Mismatch Cost (Q = 90 in original vs. Ex. 4)",
	
md""" 
Assuming 30 days a month and € 5000 fixed cost, the owners' income increases
from monthly € $(mprofit90) (when ignoring risk and stocking the forecasted **90** cakes) 

↗️ $(percentup(mprofit90, mprofit100)) to € $(mprofit100) (when stocking **100** cakes with insufficient safety stock) 

↗️ $(percentup(mprofit100, mprofitopt)) to € $(mprofitopt) (when stocking **optimal** quantity) 

↗️ $(percentup(mprofitopt, mprofit4)) to € $(mprofit4) (when **improving** situation as in Ex. 4 **and** stocking **optimally**)
"""

)

# ╔═╡ 33c2ea5e-ed01-442b-aa77-30d36ebfcd3a
if show_ui
	md"### Get data function"
else
	md""
end

# ╔═╡ c15d570f-4701-4354-b0a7-5e5feef78a9a
if show_ui
	md"### Data Structs and Conversion"
else
	md""
end

# ╔═╡ 5ea60b57-f735-41c2-86cf-de6601573719
begin
	@with_kw struct Scenario
		name::String    # name of the scenario
			
		l::Real = 0 	# lower bound
		u::Real 		# upper bound
		μ::Real = (u - l)/2	 # mean demand
		σ::Real = sqrt((u - l)^2/12) 	# standard deviation of demand
		distr = TruncatedNormal(μ, σ, l, u) 	# Type of the demand distribution
		
		c::Real  # cost of creating one unit
		p::Real   # selling price
		s::Real = 0   # salvage value
		
		Co::Real = c - s   # Overage cost
		Cu::Real = p - c   # Underage cost
		CF::Real = Cu / (Cu + Co)  # Critical fractile
		
		q_opt::Real = quantile(distr, CF)  # profit optimal order quantity
		
		max_num_days::Int = 30  # Maximal number of rounds to play
		delay::Int = 300    # ms it takes for demand to show after stocking decision 
		allow_reset::Bool = true
			
		title::String  # A title to refer to this scenario
		story::String = ""    # An md string explaining the story of the scenario
		story_url::String = ""    # An url indicating md file of the story story 
	end
	
	Base.@kwdef mutable struct SimData
		scenario::Scenario    # The scenario of the simulation
			
		demands::Vector{Int64}
		qs::Vector{<:Number} = Vector{Int64}()
		
		days_played::Int = length(qs)
		
		sales::Vector{<:Number} = Vector{Int64}()
		lost_sales::Vector{<:Number} = Vector{Int64}()
		left_overs::Vector{<:Number} = Vector{Int64}()
		revenues::Vector{<:Number} = Vector{Float64}()
		costs::Vector{<:Number} = Vector{Float64}()
		profits::Vector{<:Number} = Vector{Float64}()
		
		total_demand::Int64 = 0
		total_q::Int64 = 0
		total_sale::Int64 = 0
		total_lost_sale::Int64 = 0
		total_left_over::Int64 = 0
		total_revenue::Float64 = 0.0
		total_cost::Float64 = 0.0
		total_profit::Float64 = 0.0
		
		avg_demand::Float64 = 0.0
		avg_q::Float64 = 0.0
		avg_sale::Float64 = 0.0
		avg_lost_sale::Float64 = 0.0
		avg_left_over::Float64 = 0.0
		avg_revenue::Float64 = 0.0
		avg_cost::Float64 = 0.0
		avg_profit::Float64 = 0.0
		
		expected_lost_sales::Float64 = 0.0
		expected_sales::Float64 = 0.0
		expected_left_overs::Float64 = 0.0
		expected_profits::Float64 = 0.0
	end; 
	
	function update_sim_data!(sd::SimData)
		sd.days_played = length(sd.qs)
		
		sd.sales = min.(sd.qs, sd.demands[1:sd.days_played])
		sd.lost_sales = sd.demands[1:sd.days_played] - sd.sales
		sd.left_overs = sd.qs - sd.sales
		sd.revenues = sd.scenario.p .* sd.sales + sd.scenario.s .* sd.left_overs
		sd.costs = sd.scenario.c .* sd.qs
		sd.profits = sd.revenues - sd.costs
		
		sd.total_demand = sum(sd.demands[1:sd.days_played])
		sd.total_q = sum(sd.qs)
		sd.total_sale = sum(sd.sales)
		sd.total_lost_sale = sum(sd.lost_sales)
		sd.total_left_over = sum(sd.left_overs)
		sd.total_revenue = sum(sd.revenues)
		sd.total_cost = sum(sd.costs)
		sd.total_profit = sum(sd.profits)
		
		if sd.days_played > 0
			sd.avg_demand = sd.total_demand / sd.days_played
			sd.avg_q = sd.total_q / sd.days_played
			sd.avg_sale = sd.total_sale / sd.days_played
			sd.avg_lost_sale = sd.total_lost_sale / sd.days_played
			sd.avg_left_over = sd.total_left_over / sd.days_played
			sd.avg_revenue = sd.total_revenue / sd.days_played
			sd.avg_cost = sd.total_cost / sd.days_played
			sd.avg_profit = sd.total_profit / sd.days_played
		end
		
		sd.expected_lost_sales, sd.expected_sales, sd.expected_left_overs, sd.expected_profits = 	compute_expected_values(sd.qs, sd.scenario)
		
	end

	function compute_expected_values(q::Number, scenario::Scenario) 
		sc = scenario
	
		
		expected_lost_sale = L(x->pdf(sc.distr, x), min(q, sc.u), sc.u)
		expected_sale = mean(sc.distr) - expected_lost_sale
		expected_left_over = q - expected_sale
		expected_profit = (sc.p - sc.c) * expected_sale - (sc.c - sc.s) * expected_left_over
		
		return [expected_lost_sale,
				expected_sale,
				expected_left_over,
				expected_profit]
	end

	function compute_expected_values(qs::Vector{<:Number}, scenario::Scenario) 
		n_days = length(qs)
		if n_days == 0 return zeros(1,4) end
	
		expected_values = Matrix{Number}(undef, n_days, 4)
	
		for i in 1:n_days
			expected_values[i,:] = compute_expected_values(qs[i], scenario) 
		end
	
		return mean(expected_values, dims=1)
	end	
	function L(f, x, u)
		L, _ = quadgk(y -> (y - x) * f(y), x, u, rtol=1e-8)
		return L
	end; md" L(f, x) = ∫ₓᵘ (y - x)f(y)dy"

	
	function data_table(table)
		d = Dict(
	        "headers" => [Dict("text" => string(name), "value" => string(name)) for name in Tables.columnnames(table)],
	        "data" => [Dict(string(name) => row[name] for name in Tables.columnnames(table)) for row in Tables.rows(table)]
	    )
		djson = JSON3.write(d)
		
		return HTML("""
			<link href="https://cdn.jsdelivr.net/npm/@mdi/font@5.x/css/materialdesignicons.min.css" rel="stylesheet">
	
	
		  <div id="app">
			<v-app>
			  <v-data-table
			  :headers="headers"
			  :items="data"
			></v-data-table>
			</v-app>
		  </div>
	
		  <script src="https://cdn.jsdelivr.net/npm/vue@2.x/dist/vue.js"></script>
		  <script src="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.js"></script>
		
		<script>
			new Vue({
			  el: '#app',
			  vuetify: new Vuetify(),
			  data () {
					return $djson
				}
			})
		</script>
		<style>
			.v-application--wrap {
				min-height: 10vh;
			}
			.v-data-footer__select {
				display: none;
			}
		</style>
		""")
	end


	function update_plot_panel_1(sim_data::SimData)
		sd = sim_data
		gr()
		
		Plots.scatter(sd.sales,  label="Sales", markerstrokewidth=3.5,c=:white, markersize=7,  markerstrokecolor = 3, bar_width=sd.days_played*0.01)	
	
		scatter!(sd.demands[1:sd.days_played], label = "Demanded", c = 1, msw = 0, 
			xlabel = "Day", xticks=1:sd.days_played, xrotation=60, size=(700, 450),
			right_margin=-8Plots.mm)
		plot!(sd.demands[1:sd.days_played], lw=1, ls=:dash, label="", c = 1)
	
		plot!([sd.avg_demand], seriestype="hline", 
			c=1,lw=2,ls=:dot,label="Observed\naverage\ndemand\n($(my_round(sd.avg_demand)))")
	
		scatter!(sd.qs, label = "You stocked", c = 2,  msw = 0)
		plot!(sd.qs, lw=1, ls=:dash, label="", c = 2, legend = :outertopright)
	
		plot!([sd.avg_q], seriestype="hline", 
			c=2,lw=2, ls=:dot,label="Your average\ndecision ($(my_round(sd.avg_q)))")
			
	
	end
	
	function update_plot_panel_2(sd::SimData)
		
		days = 1:sd.days_played
		Plots.bar(days, sd.revenues, label="Revenue", lw=0,  c = :green, fillalpha = 0.61, bar_width=0.17, 
			size=(750, 150), xticks=days, xrotation=60, legend=:outertopright)
		bar!(days.+0.17, sd.profits, label="Profit", lw=0,c = 5, fillalpha = 0.95, bar_width=0.17,)
		bar!(days, 0 .- sd.costs, label="Cost", lw=0,c = 2, fillalpha = 0.81, bar_width=0.17, )
		plot!(x->0, label="",  c = :black, left_margin=-2Plots.mm, right_margin=-6Plots.mm, bottom_margin=2Plots.mm)
	end
	
	@option struct PlayLog
		demands::Vector{<:Number} = round.(Int, rand(TruncatedNormal(90, 30, 0, 180), 30))
		qs::Vector{<:Number} = Vector{Int64}()
	end
	
	@option struct StoryLog
		title::String = "Patisserie Cheers!"
		url::String = "https://raw.githubusercontent.com/frankhuettner/newsvendor/main/scenarios/cheers_1_story.md"
	end
	
	@option struct UnitValueLog
		c::Real = 1 	# cost of creating one unit
		p::Real = 5  	# selling price
		s::Real = 0    # salvage value
	end
	
	@option struct DistributionLog
		typus = "Truncated Normal"
		l::Real = 0 	# lower bound
		u::Real = 180		# upper bound
		μ::Real = (u - l)/2	 # mean demand
		σ::Real = (u - l)/6 	# standard deviation of demand
		discrete_probs = [pdf(TruncatedNormal(90, 30, 0, 180), x) / 
					sum(pdf.(TruncatedNormal(90, 30, 0, 180), 1:180))  for x in 1:180]
	end
	
	@option struct SimConfLog
		max_num_days::Int = 30  # Maximal number of rounds to play
		delay::Int = 300    # ms it takes for demand to show after stocking decision 
		allow_reset::Bool = false
	end
	
	@option struct ScenarioLog
		name::String="cheers_1"
		unit_value::UnitValueLog = UnitValueLog()
		distribution::DistributionLog = DistributionLog()
		story::StoryLog = StoryLog()	
		sim_conf::SimConfLog = SimConfLog()
	end
	
	@option struct SimLog
		play::PlayLog = PlayLog()
		scenario::ScenarioLog = ScenarioLog()
	end
	
	function scenariolog_to_scenario(scenariolog)
		scl = scenariolog
		c = scl.unit_value.c
		p = scl.unit_value.p
		s = scl.unit_value.s
		Co = c - s   # Overage cost
		Cu = p - c   # Underage cost
		CF = Cu / (Cu + Co)  # Critical fractile
		l = scl.distribution.l 	
		u = scl.distribution.u		
		μ = scl.distribution.μ	 
		σ = scl.distribution.σ 	
		distr = if scl.distribution.typus == "Uniform"  
				 	Uniform(l, u) 
				elseif scl.distribution.typus == "DiscreteNonParametric"  
					DiscreteNonParametric(l:u, discrete_probs)
				else
					TruncatedNormal(μ, σ, l, u)
				end
		
		Scenario(				
			name = scl.name,
			l = scl.distribution.l, 	
			u = scl.distribution.u,		
			μ = scl.distribution.μ,	 
			σ = scl.distribution.σ, 	
			distr = distr,		
			c = c,  
			p = p,   
			s = s,   
			Co = Co,   
			Cu = Cu,   
			CF = CF,  
			max_num_days = scl.sim_conf.max_num_days,
			delay = scl.sim_conf.delay,
			allow_reset = scl.sim_conf.allow_reset,
			title = scl.story.title,
			story_url = scl.story.url,  
		)
	end
	
	function simlog_to_simdata(simlog)
		sd = SimData(				
			scenario = scenariolog_to_scenario(simlog.scenario),
			demands = simlog.play.demands,
			qs =  simlog.play.qs,
		)
		update_sim_data!(sd)
		return sd
	end
	
	function scenario_to_scenariolog(scenario)
		sc = scenario
		typus = if typeof(sc.distr) == typeof(Uniform(0, 60))
					"Uniform"  
				elseif typeof(sc.distr) == DiscreteNonParametric([0, 1, 2],[.3,.5,.2]) 
					"DiscreteNonParametric"
				else
					"Truncated Normal"
				end
		discrete_probs = [pdf(sc.distr, i)/
							sum(pdf.(sc.distr, sc.l:sc.u))  for i in 1:length(sc.l:sc.u)]
		
		from_kwargs(ScenarioLog, 
			name = sc.name,
			unit_value_c = sc.c,
			unit_value_p = sc.p,
			unit_value_s = sc.s,
			distribution_l = sc.l, 	
			distribution_u = sc.u,		
			distribution_μ = sc.μ,	 
			distribution_σ = sc.σ,
			distribution_typus = typus,
			distribution_discrete_probs = discrete_probs,	
			sim_conf_max_num_days = sc.max_num_days,
			sim_conf_delay = sc.delay,
			sim_conf_allow_reset = sc.allow_reset,
			story_title = sc.title,
			story_url = sc.story_url,  
		)	
	end
	
	function simdata_to_simlog(simdata) 
		playlog = from_kwargs(PlayLog, qs = simdata.qs, demands = simdata.demands)
		scl = scenario_to_scenariolog(simdata.scenario)
		
		return SimLog(player_id = my_ID(), play = playlog, scenario = scl)
	end
	
	function read_available_scenario_conf(path="",fname="available_scenario_confs.toml")	
		available_scenarios = Vector{Scenario}()
		if isfile(path*fname)
			available_scenario_confs = TOML.parsefile(path*fname)
		
			for (scl_name, f) in available_scenario_confs
				if isfile(f)
					scl = from_toml(ScenarioLog, f)
					push!(available_scenarios, scenariolog_to_scenario(scl))
				end
			end
		end
		available_scenarios
	end
	
	function save_available_scenario_conf(available_scenarios=available_scenarios, path="")	
		d = Dict([sc.name => sc.name*"_conf.toml"  for sc in available_scenarios])
		
		open(path*"available_scenario_confs.toml", "w") do io
			TOML.print(to_toml, io, d)
		end
		
		for sc in available_scenarios
			to_toml(path*sc.name*"_conf.toml", sc |> scenario_to_scenariolog)
		end
	end


	md""
	
	
end

# ╔═╡ bad8e83c-c419-45fa-ba39-7477ac62cb7c
if want_to_show_menti_slide && menti_link !=""
	show_menti_slide = true
else
	show_menti_slide = false
end;

# ╔═╡ 00940350-7e28-4caf-8da1-a705b47e6c6a
if show_menti_slide
"""<iframe src="$(menti_link)" width="680px" height="425px"></iframe>	""" |> HTML
else
	md""
end

# ╔═╡ 760bcbea-484b-4c79-ac9b-458aaeb8a083
if show_menti_slide
"""<iframe src="$(menti_link)" width="680px" height="425px"></iframe>	""" |> HTML
else
	md""
end

# ╔═╡ e7c530e8-9ac7-4b3f-9c5b-2b03aaa80900
if show_menti_slide
"""<iframe src="$(menti_link)" width="680px" height="425px"></iframe>	""" |> HTML
else
	md""
end

# ╔═╡ 372b0340-ac99-4a68-9dd2-974ce51137ff
if show_menti_slide
"""<iframe src="$(menti_link)" width="680px" height="425px"></iframe>	""" |> HTML
else
	md""
end

# ╔═╡ d988b0c5-1544-4b9e-954f-dd8720f6f145
if show_menti_slide
"""<iframe src="$(menti_link)" width="680px" height="425px"></iframe>	""" |> HTML
else
	md""
end

# ╔═╡ 366266d9-7cff-44b7-9f2e-8151b2d25f07
if show_menti_slide
"""<iframe src="$(menti_link)" width="680px" height="425px"></iframe>	""" |> HTML
else
	md""
end

# ╔═╡ a8f9c09c-93be-4a4f-9883-5432204f0ba8
if show_menti_slide
"""<iframe src="$(menti_link)" width="680px" height="425px"></iframe>	""" |> HTML
else
	md""
end

# ╔═╡ 5f7cf638-cbf8-48f8-a8bb-b1ebf5ba88ab
begin
	function cor_Qₜ_Dₜ₋₁(sd)
		n = sd.days_played
		if n < 2
			return 0.0
		end	
		if var(sd.qs[2:n]) ≈ 0 || var(sd.demands[1:n-1]) ≈ 0 
			return 0.0
		end
		return	Statistics.cor(sd.qs[2:n], sd.demands[1:n-1])
	end; 
	
	function fluctuationloss(logfile)
		dict_simlogs_ind = TOML.parsefile(logfile)
		simlog_ind = from_dict(SimLog, dict_simlogs_ind["log"]["cheers_1"])
		sim_data_ind = simlog_to_simdata(simlog_ind)
		sim_data_ind_const = simlog_to_simdata(simlog_ind)
		update_sim_data!(sim_data_ind)
		sim_data_ind_const.qs = ones(length(sim_data_ind.qs)) * round(Int,sim_data_ind.avg_q)
		update_sim_data!(sim_data_ind_const)
		return percentup(sim_data_ind.avg_profit, sim_data_ind_const.avg_profit, stringed=false)
	end; 
	md""
end

# ╔═╡ d04db0f4-1e2d-4c60-ace7-df4500ff6a79
if selected_class != ""
	simlog_path = joinpath(data_path, selected_class, "simlog")
	simlog_dir = readdir(simlog_path)
	simlogs = simlog_dir[occursin.(r".*\.toml", simlog_dir)]


	cheers_1 = NVModel(cost = 1, price = 5, demand = truncated(Normal(90, 30), 0, 180) )   
	cheers_2 = cheers_2 = NVModel(cost = 4, price = 5.5, demand =  Uniform(0, 60))	
	cheers_3 = NVModel(cost = 1.5, price = 9, demand = truncated(Normal(90, 30), 0, 180), salvage = .5 )   
	cheers_4 = NVModel(cost = 10, price = 42, demand = DiscreteNonParametric([0,1,2],[.3,.5,.2]))

	selected_cheers = Dict("cheers_1" => cheers_1, "cheers_2" => cheers_2, "cheers_3" => cheers_3, "cheers_4" => cheers_4)[selected_scenario_agg]
	
	
	df_res = DataFrame(:FileName => simlogs)
	insertcols!(df_res, 		:ID => "", 
								:DaysPlayed => 0, 
								:ExpProfit => 0.0,
								:AvgStock => 0.0, 
								:AvgDemand => 0.0, 
								:TotalProfit => 0.0, 
								:Cor_Qₜ_Dₜ₋₁ => 0.0, 
								:FluctuationLoss => 0.0, 
								:Std_Q => 0.0, 
								:Cor_Qₜ_Dₜ₋₁xFluctuationLoss => 0.0, 
								)
	for row in eachrow(df_res)
		logfile = joinpath(simlog_path, string(row.FileName)) 
		if isfile(logfile)
			dict_simlogs = TOML.parsefile(logfile)
			simlog = from_dict(SimLog, dict_simlogs["log"][selected_scenario_agg])
			row.ID = dict_simlogs["player_id"]	
			if length(simlog.play.qs) > 0
				sd = simlog_to_simdata(simlog)
				update_sim_data!(sd)				
				row.DaysPlayed = sd.days_played
				row.ExpProfit = sd.expected_profits |> my_round
				row.AvgStock = sd.avg_q |> my_round
				row.AvgDemand = sd.avg_demand |> my_round
				row.TotalProfit = sd.total_profit	
				row.Cor_Qₜ_Dₜ₋₁ = cor_Qₜ_Dₜ₋₁(sd) |> my_round
				row.FluctuationLoss = fluctuationloss(logfile)
				row.Std_Q = Statistics.std(sd.qs) |> my_round
				row.Cor_Qₜ_Dₜ₋₁xFluctuationLoss = row.Cor_Qₜ_Dₜ₋₁ .* row.FluctuationLoss   |> my_round
			end
		end
	end	
	df_res = df_res[df_res[!, :DaysPlayed].!=0,:]  # filter players who didn't play 
	df_res = df_res[df_res[!, :DaysPlayed].==30,:]  # filter players who didn't play 30 days
	df_res = df_res[df_res[!, :ID].!="jqzFXGha",:]  # filter specific player
	
	
	# df_res[!, filter(x->x !="link" , names(df_res))]
	df_res[!, filter(x->x !="link" , names(df_res))]  |> data_table
end

# ╔═╡ e4c09f88-35c6-4382-9b44-6998f5402cb6
TwoColumn(let
if @isdefined df_res 
	if nrow(df_res) > 0
		gr()
		ymax = 1.1 * maximum(df_res[!,:TotalProfit])
		plot(xlabel="Decision (Average Stock)", ylabel="Outcome (Total Profit)",legend=false,
			xlims=(minimum(selected_cheers.demand),maximum(selected_cheers.demand)), ylims=(0,ymax),
			size = (450,300)
		)
		vline!([mean(selected_cheers.demand)], lw=3)
		# vline!([q_opt(selected_cheers)], lw=1)
		scatter!(df_res[!,:AvgStock], df_res[!,:TotalProfit], markersize = 8, marker_z=df_res[!,:AvgDemand])
	end
else
	
md"""
$(Resource("https://github.com/frankhuettner/newsvendor/blob/main/debrief/img/avg_order_vs_realized_profit_students.png?raw=true",  :class => "center"))
"""
end
end,
	md"""
- Each point represents a student
- The luckier you were => The higher was the demand in your play => The brighter your color


""")

# ╔═╡ 896d3c47-2ca0-4022-811b-ab4b5bb7af3d
TwoColumn(let
if @isdefined df_res 
	if nrow(df_res) > 0
		gr()
		ymax = 1.1 * maximum(df_res[!,:ExpProfit])
		plot( 
			xlabel="Decision (Average Stock)", ylabel="Decision Quality \n(Expected Profit)",legend=false,
			xlims=(minimum(selected_cheers.demand),maximum(selected_cheers.demand)), ylims=(0,ymax),
			size = (450,250)
		)
		vline!([mean(selected_cheers.demand)], lw=3)
		vline!([q_opt(selected_cheers)], lw=3)
		scatter!(df_res[!,:AvgStock], df_res[!,:ExpProfit], markersize = 8, marker_z=df_res[!,:AvgDemand])
	end
else
	md"""

$(Resource("https://github.com/frankhuettner/newsvendor/blob/main/debrief/img/avg_order_vs_expected_profit_students.png?raw=true", :class => "center"))
"""
end
end,
	md"""
- Each point represents a student
- The luckier you were => The higher was the demand in your play => The brighter your color


""")

# ╔═╡ cea3f4ee-5ba2-4317-ab62-8a949abf7a33
md"""
Show expected result had you always ordered $(round(Int,mean(df_res[:,:AvgStock]))) (your class avg.) 👉  $(@bind no_variation html"<input type=checkbox >")

"""

# ╔═╡ bbaff929-0f20-4e58-8930-430be3f03d71
begin
	qss = copy(qs)
	push!(qss, mean(df_res[:,:AvgStock]))
	monthly_incomess = copy(monthly_incomes)
	gr()
	if no_variation
		push!(monthly_incomess, 30*profit(nvm, qss[end])-fixed_cost)
	else
		push!(monthly_incomess, 30*mean(df_res[:,:ExpProfit])-fixed_cost)
	end
	potential =percentup(monthly_incomess[end],monthly_incomess[3])
	Plots.bar(qss, monthly_incomess, ylabel="# Cakes Made", xlabel="Profit per Month (Assuming Fix Cost = $(fixed_cost))", legend = false, orientation = :h, title="$(potential) Higher Profit Possible"
	)
	
	annotate!(200, qss[end], text("Your Class Average",14, :white, :left))
	annotate!(200, 115, text("Optimal Quantity",14, :white, :left))
	annotate!(200, 100, text("Status Quo",14, :white, :left))
	annotate!(200, 90, text("Ignorant of Uncertainty",14, :white, :left))
end

# ╔═╡ 7f5c31e6-a362-46ec-abc5-0ef459d17d3b
let
if @isdefined df_res 
	demand_chaser = findfirst(==(maximum(df_res.Cor_Qₜ_Dₜ₋₁xFluctuationLoss)), df_res.Cor_Qₜ_Dₜ₋₁xFluctuationLoss)
	demand_chaser_file = df_res[findmax(df_res.Cor_Qₜ_Dₜ₋₁xFluctuationLoss)[2], :FileName]
	profit = df_res[findall(df_res.FileName .== demand_chaser_file) , :TotalProfit][1]
	logfile_toml_chaser = joinpath(simlog_path, string(demand_chaser_file)) 
	if isfile(logfile_toml_chaser)
		dict_simlogs_chaser = TOML.parsefile(logfile_toml_chaser)
		simlog_chaser = from_dict(SimLog, dict_simlogs_chaser["log"][selected_scenario_agg])
		sim_demand_chaser_const = simlog_to_simdata(simlog_chaser)
		update_sim_data!(sim_demand_chaser_const)
		demand_chaser_avg_q = sim_demand_chaser_const.avg_q
		
		for i in 1:length(sim_demand_chaser_const.qs)
			sim_demand_chaser_const.qs[i] = round(Int, demand_chaser_avg_q)
			# sim_demand_chaser_const.qs[i] = round(Int, 90)
		end
		update_sim_data!(sim_demand_chaser_const)
		const_profit = sim_demand_chaser_const.total_profit        
		for i in 1:length(sim_demand_chaser_const.qs)
			sim_demand_chaser_const.qs[i] = 115
		end
		update_sim_data!(sim_demand_chaser_const)
		opt_profit = sim_demand_chaser_const.total_profit        

md"""
## Chasing Demand Did Not Work
Always stocking $(round(Int,demand_chaser_avg_q)) (their average) **➡ $(percentup(profit - fixed_cost, const_profit - fixed_cost)) more profit** [assuming fix cost = $(fixed_cost)]

"""
	end
end
end

# ╔═╡ 7fa8651e-4db4-4809-9c1c-4586a66c9e50
begin
if @isdefined df_res 
	demand_chaser = findfirst(==(maximum(df_res.Cor_Qₜ_Dₜ₋₁xFluctuationLoss)), df_res.Cor_Qₜ_Dₜ₋₁xFluctuationLoss)
	demand_chaser_file = df_res[findmax(df_res.Cor_Qₜ_Dₜ₋₁xFluctuationLoss)[2], :FileName]
	logfile_toml_chaser = joinpath(simlog_path, string(demand_chaser_file)) 
	if isfile(logfile_toml_chaser)
		dict_simlogs_chaser = TOML.parsefile(logfile_toml_chaser)
		simlog_chaser = from_dict(SimLog, dict_simlogs_chaser["log"][selected_scenario_agg])
		sim_demand_chaser = simlog_to_simdata(simlog_chaser)
		update_sim_data!(sim_demand_chaser)
		update_plot_panel_1(sim_demand_chaser)
	end

end
end

# ╔═╡ 51d6ebc7-ea05-4d37-8487-264ff7d8834d
TwoColumn(
md"""
**No**, we did not learn substantial **news about the demand.**
- Every day we faced the same distribution
- Indeed, the simulation generated perfectly normal random demands for you
""",
let
if selected_class !=  ""
	alldemands = []
	for row in eachrow(df_res)
		logfile = joinpath(simlog_path, string(row.FileName)) 
		if isfile(logfile)
			dict_simlogs = TOML.parsefile(logfile)
			simlog = from_dict(SimLog, dict_simlogs["log"]["cheers_1"])
			row.ID = dict_simlogs["player_id"]	
			if length(simlog.play.qs) > 0
				sd = simlog_to_simdata(simlog)
				append!(alldemands, sd.demands)
			end
		end
	end	
	n = length(alldemands)
	emp_mean = my_round(mean(alldemands))
	emp_std = my_round(std(alldemands))
	xticks = [emp_mean-emp_std, emp_mean-2*emp_std, emp_mean, emp_mean+emp_std, emp_mean+2*emp_std]
	gr()
	Plots.histogram(alldemands, ylabel = "Frequency", legend = false, title = " (n = $(n))", size = (410, 350), xticks = xticks)
	vline!([emp_mean], lw = 3, c = :orange)
	annotate!(emp_mean, 0.99, text("Average = $(emp_mean)",15, :orange, rotation = 90 , :left, :bottom))
	vline!([emp_mean-emp_std], lw = 1, c = :green)
	vline!([emp_mean+emp_std], lw = 1, c = :green)
	annotate!(emp_mean, - n / 90, text("Std Dev = $(emp_std)",10, :green,  :center, :top), )

else
	md"No data loaded."
end
end)

# ╔═╡ 6c9cb78a-4aa0-4b81-9ee3-9f934234d6fc
md""" ## Summary Debrief
- **Ignoring uncertainty is very costly**
  - Opt. quantity 115 instead of exp. demand $(μ) increases profit by  $(percentup(monthly_incomes[1], monthly_incomes[3])) 
  - Unawareness prevents active managment
- We are not used to work with uncertainty 😟
  - Roughly 50% of Korean firms work only with point forecasts


- Here, **too litte (€ $(Cu) lost)** was **worse than** having a cake **left over (€ $(Co) lost)**   $~~$
  ➡ Safety stock needed
- We had not enough safety stock ($(my_round(qss[end])) on average instead of 115)
  - "Pull to the center effect" is a common and widely observed in practice
  - **Do we underestimate the importance of uncertainty?**


- **Unnecessary gambling and demand chasing** instead of clear strategy 
  - Constantly ordering $(my_round(qss[end])) would have increased profit by $(percentup(30*mean(df_res[:,:ExpProfit])-fixed_cost, 30*profit(nvm, qss[end])-fixed_cost ))
   - Ask yourself when making changes: Do you have any new information?

"""

# ╔═╡ 53b86fb2-3fe6-4670-b56e-a67dade1d0a4
describe(df_res)

# ╔═╡ 8c2118a5-7a85-4eac-a455-f1e7b6dc5917
function get_data!(source, datadir)
	td = mktempdir()
	
	if source == "from_file"
		try	
			# Extract tgz
			tar = CodecZlib.GzipDecompressorStream(IOBuffer(file_data["data"]))
			tardir = Tar.extract(tar, td)
			close(tar)
			# uploadedsimlogs = readdir(tardir)
			# for s in uploadedsimlogs
			# 	try
			# 		dst = mkpath(joinpath(data_path, yourclassname, "simlog", s))
			# 		cp(joinpath(tardir, s), dst, force=true)
			# 	catch
			# 	end
			# end
		catch
		end
		try	
			# Extract tarball
			tardir = Tar.extract(IOBuffer(file_data["data"]), td)
			# uploadedsimlogs = readdir(tardir)
			# for s in uploadedsimlogs
			# 	try
			# 		dst = mkpath(joinpath(data_path, yourclassname, s))
			# 		cp(joinpath(tardir, s), dst, force=true)
			# 	catch
			# 	end
			# end
		catch
		end
	else
		# Download data 
		data = download(source)
		
		
		try
			# Extract tgz
			open(CodecZlib.GzipDecompressorStream, data) do io
			    Tar.extract(io, td)
			end
	    catch e
			# println("Not a tgz")
	    end
		
		try
			# Extract tarball
		    Tar.extract(data, td)
	    catch e
			# println("Not a tar")
	    end
	end
	
	# Copy to target

	# Data is in a "data" folder?
	td_data = joinpath(td, "data")
	if isdir(td_data)
		classes = readdir(td_data)
		for c in classes
			dst = mkpath(joinpath(datadir, "data", c))
			cp(joinpath(td_data, c), dst, force=true)
		end
	end
	# Data is in a simlog folder?
	td_simlog = joinpath(td, "simlog")
	if isdir(td_simlog)
		simlogs = readdir(td_simlog)
		for s in simlogs
			try
				dst = mkpath(joinpath(datadir, "data", yourclassname,"simlog", s))
				cp(joinpath(td_simlog, s), dst, force=true)
			catch
			end
		end
	end
end;

# ╔═╡ d8b8f592-8af4-4cc7-8fe1-9b79ba8a306b
reload_stud_data; get_data!(example_data_source_zipped, dir); get_data!("from_file", dir);

# ╔═╡ e4197c2b-704a-4279-8727-ea6b97572710
try
	get_data!(yourclass_data_source, dir)
	reload_stud_data
	md""
catch e
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CodecZlib = "944b1d66-785c-5afd-91f1-9de20f533193"
Configurations = "5218b696-f38b-4ac9-8b61-a12ec717816d"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
JSON3 = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
NewsvendorModel = "63d3702b-073a-45e6-b43c-f47e8b08b809"
OrderedCollections = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
Parameters = "d96e819e-fc66-5662-9728-84c9c7592b0a"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
QuadGK = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
ShortCodes = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
TOML = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
Tables = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
Tar = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[compat]
CodecZlib = "~0.7.0"
Configurations = "~0.17.3"
DataFrames = "~1.3.3"
Distributions = "~0.25.76"
Images = "~0.25.2"
JSON3 = "~1.9.4"
LaTeXStrings = "~1.3.0"
NewsvendorModel = "~0.2.2"
OrderedCollections = "~1.4.1"
Parameters = "~0.12.3"
Plots = "~1.35.5"
PlutoUI = "~0.7.38"
QuadGK = "~2.6.0"
ShortCodes = "~0.3.3"
Tables = "~1.10.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.2"
manifest_format = "2.0"
project_hash = "1b237eb6c5d6a26a96a03e9b5502312faf37540c"

[[deps.AbstractFFTs]]
deps = ["ChainRulesCore", "LinearAlgebra"]
git-tree-sha1 = "69f7020bd72f069c219b5e8c236c1fa90d2cb409"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.2.1"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "195c5505521008abea5aee4f96930717958eac6f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.4.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "62e51b39331de8911e4a7ff6f5aaf38a5f4cc0ae"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.2.0"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "1dd4d9f5beebac0c03446918741b1a03dc5e5788"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.6"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.CEnum]]
git-tree-sha1 = "eb4cb44a499229b3b8426dcfb5dd85333951ff90"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.2"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "e7ff6cadf743c098e08fca25c91103ee4303c9bb"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.6"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "38f7a08f19d8810338d4f5085211c7dfa5d5bdd8"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.4"

[[deps.Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "Random", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "64df3da1d2a26f4de23871cd1b6482bb68092bd5"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.14.3"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "1fd869cc3875b57347f7027521f561cf46d1fcd8"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.19.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "d08c20eef1f2cbc6e60fd3612ac4340b89fea322"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.9"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "3ca828fe1b75fa84b021a7860bd039eaea84d2f2"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.3.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.Configurations]]
deps = ["ExproniconLite", "OrderedCollections", "TOML"]
git-tree-sha1 = "62a7c76dbad02fdfdaa53608104edf760938c4ca"
uuid = "5218b696-f38b-4ac9-8b61-a12ec717816d"
version = "0.17.4"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "681ea870b918e7cff7111da58791d7f718067a19"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.2"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

[[deps.DataAPI]]
git-tree-sha1 = "46d2680e618f8abd007bce0c3026cb0c4a8f2032"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.12.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "db2a9cb664fcea7836da4b414c3278d71dd602d2"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.6"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DensityInterface]]
deps = ["InverseFunctions", "Test"]
git-tree-sha1 = "80c3e8639e3353e5d2912fb3a1916b8455e2494b"
uuid = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
version = "0.4.0"

[[deps.Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "3258d0659f812acde79e8a74b11f17ac06d0ca04"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.7"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["ChainRulesCore", "DensityInterface", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "04db820ebcfc1e053bd8cbb8d8bccf0ff3ead3f7"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.76"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "c36550cb29cbe373e95b3f40486b9a4148f89ffd"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.2"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.ExproniconLite]]
git-tree-sha1 = "09dcb4512e103b2b8ad45aa35199633797654f47"
uuid = "55351af7-c7e9-48d6-89ff-24e801d99491"
version = "0.7.1"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "90630efff0894f8142308e334473eba54c433549"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.5.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "7be5f99f7d15578798f338f5433b6c432ea8037b"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "802bfc139833d2ba893dd9e62ba1767c88d708ae"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.5"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "00a9d4abadc05b9476e937a5557fcce476b9e547"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.69.5"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "bc9f7725571ddb4ab2c4bc74fa397c1c5ad08943"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.69.1+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "fb83fbe02fe57f2c068013aa94bcdf6760d3a7a7"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+1"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "ba2d094a88b6b287bd25cfa86f301e7693ffae2f"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.7.4"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions", "Test"]
git-tree-sha1 = "709d864e3ed6e3545230601f94e11ebc65994641"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.11"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "c54b581a83008dc7f292e205f4c409ab5caa0f04"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.10"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "b51bb8cae22c66d0f6357e3bcb6363145ef20835"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.5"

[[deps.ImageContrastAdjustment]]
deps = ["ImageCore", "ImageTransformations", "Parameters"]
git-tree-sha1 = "0d75cafa80cf22026cea21a8e6cf965295003edc"
uuid = "f332f351-ec65-5f6a-b3d1-319c6670881a"
version = "0.3.10"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "acf614720ef026d38400b3817614c45882d75500"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.4"

[[deps.ImageDistances]]
deps = ["Distances", "ImageCore", "ImageMorphology", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "b1798a4a6b9aafb530f8f0c4a7b2eb5501e2f2a3"
uuid = "51556ac3-7006-55f5-8cb3-34580c88182d"
version = "0.2.16"

[[deps.ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageBase", "ImageCore", "LinearAlgebra", "OffsetArrays", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "8b251ec0582187eff1ee5c0220501ef30a59d2f7"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.2"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "342f789fd041a55166764c351da1710db97ce0e0"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.6"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "ca8d917903e7a1126b6583a097c5cb7a0bedeac1"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.2.2"

[[deps.ImageMagick_jll]]
deps = ["JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1c0a2295cca535fabaf2029062912591e9b61987"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "6.9.10-12+3"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "36cbaebed194b292590cba2593da27b34763804a"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.8"

[[deps.ImageMorphology]]
deps = ["ImageCore", "LinearAlgebra", "Requires", "TiledIteration"]
git-tree-sha1 = "e7c68ab3df4a75511ba33fc5d8d9098007b579a8"
uuid = "787d08f9-d448-5407-9aad-5290dd7ab264"
version = "0.3.2"

[[deps.ImageQualityIndexes]]
deps = ["ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "LazyModules", "OffsetArrays", "Statistics"]
git-tree-sha1 = "0c703732335a75e683aec7fdfc6d5d1ebd7c596f"
uuid = "2996bd0c-7a13-11e9-2da2-2f5ce47296a9"
version = "0.3.3"

[[deps.ImageSegmentation]]
deps = ["Clustering", "DataStructures", "Distances", "Graphs", "ImageCore", "ImageFiltering", "ImageMorphology", "LinearAlgebra", "MetaGraphs", "RegionTrees", "SimpleWeightedGraphs", "StaticArrays", "Statistics"]
git-tree-sha1 = "36832067ea220818d105d718527d6ed02385bf22"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.7.0"

[[deps.ImageShow]]
deps = ["Base64", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "b563cf9ae75a635592fc73d3eb78b86220e55bd8"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.6"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "ColorVectorSpace", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "8717482f4a2108c9358e5c3ca903d3a6113badc9"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.9.5"

[[deps.Images]]
deps = ["Base64", "FileIO", "Graphics", "ImageAxes", "ImageBase", "ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "ImageIO", "ImageMagick", "ImageMetadata", "ImageMorphology", "ImageQualityIndexes", "ImageSegmentation", "ImageShow", "ImageTransformations", "IndirectArrays", "IntegralArrays", "Random", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "StatsBase", "TiledIteration"]
git-tree-sha1 = "03d1301b7ec885b266c0f816f338368c6c0b81bd"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.25.2"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "87f7662e03a649cffa2e05bf19c303e168732d3e"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.2+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "5cd07aab533df5170988219191dfad0519391428"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.3"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.IntegralArrays]]
deps = ["ColorTypes", "FixedPointNumbers", "IntervalSets"]
git-tree-sha1 = "be8e690c3973443bec584db3346ddc904d4884eb"
uuid = "1d092043-8f09-5a30-832f-7509e371ab51"
version = "0.1.5"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "842dd89a6cb75e02e85fdd75c760cdc43f5d6863"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.14.6"

[[deps.IntervalSets]]
deps = ["Dates", "Random", "Statistics"]
git-tree-sha1 = "3f91cd3f56ea48d4d2a75c2a65455c5fc74fa347"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.3"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "49510dfcb407e572524ba94aeae2fced1f3feb0f"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.8"

[[deps.InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLD2]]
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "Pkg", "Printf", "Reexport", "TranscodingStreams", "UUIDs"]
git-tree-sha1 = "1c3ff7416cb727ebf4bab0491a56a296d7b8cf1d"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.4.25"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "f377670cda23b6b7c1c0b3893e37451c5c1a2185"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.5"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JSON3]]
deps = ["Dates", "Mmap", "Parsers", "StructTypes", "UUIDs"]
git-tree-sha1 = "fd6f0cae36f42525567108a42c1c674af2ac620d"
uuid = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
version = "1.9.5"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "a77b273f1ddec645d1b7c4fd5fb98c8f90ad10a5"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.1"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b53380851c6e6664204efb2e62cd24fa5c47e4ba"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.2+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "ab9aa169d2160129beb241cb2750ca499b4e90e9"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.17"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "94d9c52ca447e23eac0c0f074effbcd38830deb5"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.18"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "2ce8695e1e699b68702c03402672a69f54b8aca9"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2022.2.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.MappedArrays]]
git-tree-sha1 = "e8b359ef06ec72e8c030463fe02efe5527ee5142"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.1"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Memoize]]
deps = ["MacroTools"]
git-tree-sha1 = "2b1dfcba103de714d31c033b5dacc2e4a12c7caa"
uuid = "c03570c3-d221-55d1-a50c-7939bbd78826"
version = "0.4.4"

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "2af69ff3c024d13bde52b34a2a7d6887d4e7b438"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.7.1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "b34e3bc3ca7c94914418637cb10cc4d1d80d877d"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.3"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "a7c3d1da1189a1c2fe843a3bfa04d18d20eb3211"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.1"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "440165bf08bc500b8fe4a7be2dc83271a00c0716"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.12"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore"]
git-tree-sha1 = "18efc06f6ec36a8b801b23f076e3c6ac7c3bf153"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.NewsvendorModel]]
deps = ["Distributions", "Printf", "QuadGK"]
git-tree-sha1 = "73aafd452d06c8be9cb5d279714b6f2f5871e6c8"
uuid = "63d3702b-073a-45e6-b43c-f47e8b08b809"
version = "0.2.2"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "f71d8950b724e9ff6110fc948dff5a329f901d64"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.12.8"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "923319661e9a22712f24596ce81c54fc0366f304"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.1.1+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e60321e3f2616584ff98f0a4f18d98ae6f89bbb3"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.17+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.40.0+0"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "cf494dca75a69712a72b80bc48f59dcf3dea63ec"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.16"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "f809158b27eba0c18c269cf2a2be6ed751d3e81d"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.3.17"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "03a7a85b76381a3d04c7a1656039197e70eda03d"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.11"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "6c01a9b494f6d2a9fc180a08b182fcb06f0958a0"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.2"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f6cf8e7944e50901594838951729a1861e668cb8"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.2"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "SnoopPrecompile", "Statistics"]
git-tree-sha1 = "21303256d239f6b484977314674aef4bb1fe4420"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.1"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SnoopPrecompile", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "0a56829d264eb1bc910cf7c39ac008b5bcb5a0d9"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.35.5"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "efc140104e6d0ae3e7e30d56c98c4a927154d684"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.48"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a6062fe4063cdafe78f4a0a81cfffb89721b30e7"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "d7a7aef8f8f2d537104f170139553b14dfe39fe9"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.2"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "c6c0f690d0cc7caddb74cef7aa847b824a16b256"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+1"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "97aa253e65b784fd13e83774cadc95b38011d734"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.6.0"

[[deps.Quaternions]]
deps = ["LinearAlgebra", "Random"]
git-tree-sha1 = "fd78cbfa5f5be5f81a482908f8ccfad611dca9a9"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.6.0"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "dc84268fe0e3335a62e315a3a7cf2afa7178a734"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.3"

[[deps.RecipesBase]]
deps = ["SnoopPrecompile"]
git-tree-sha1 = "d12e612bba40d189cead6ff857ddb67bd2e6a387"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.1"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase", "SnoopPrecompile"]
git-tree-sha1 = "9b1c0c8e9188950e66fc28f40bfe0f8aac311fe0"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.7"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays", "Statistics"]
git-tree-sha1 = "793b6ef92f9e96167ddbbd2d9685009e200eb84f"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.3.3"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "f94f779c94e58bf9ea243e77a37e16d9de9126bd"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.ShortCodes]]
deps = ["Base64", "CodecZlib", "HTTP", "JSON3", "Memoize", "UUIDs"]
git-tree-sha1 = "0fcc38215160e0a964e9b0f0c25dcca3b2112ad1"
uuid = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"
version = "0.3.3"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.SimpleWeightedGraphs]]
deps = ["Graphs", "LinearAlgebra", "Markdown", "SparseArrays", "Test"]
git-tree-sha1 = "a6f404cc44d3d3b28c793ec0eb59af709d827e4e"
uuid = "47aef6b3-ad0c-573a-a1e2-d07658019622"
version = "1.2.1"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "8fb59825be681d451c246a795117f317ecbcaa28"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.2"

[[deps.SnoopPrecompile]]
git-tree-sha1 = "f604441450a3c0569830946e5b33b78c928e1a85"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.1"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "d75bda01f8c31ebb72df80a46c88b25d1c79c56d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.7"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "f86b3a049e5d05227b10e15dbb315c5b90f14988"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.9"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6b7ba252635a5eff6a0b0664a41ee140a1c9e72a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f9af7f195fb13589dd2e2d57fdb401717d2eb1f6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.5.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StatsFuns]]
deps = ["ChainRulesCore", "HypergeometricFunctions", "InverseFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "5783b877201a82fc0014cbf381e7e6eb130473a4"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.0.1"

[[deps.StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "ca4bccb03acf9faaf4137a9abc1881ed1841aa70"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.10.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "c79322d36826aa2f4fd8ecfa96ddb47b174ac78d"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.10.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "UUIDs"]
git-tree-sha1 = "70e6d2da9210371c927176cb7a56d41ef1260db7"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.6.1"

[[deps.TiledIteration]]
deps = ["OffsetArrays"]
git-tree-sha1 = "5683455224ba92ef59db72d10690690f4a8dc297"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.3.1"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "8a75929dcd3c38611db2f8d08546decb514fcadf"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.9"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.URIs]]
git-tree-sha1 = "e59ecc5a41b000fa94423a578d29290c7266fc10"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "58443b63fb7e465a8a7210828c91c08b92132dff"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.14+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e45044cd873ded54b6a5bac0eb5c971392cf1927"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.2+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "868e669ccb12ba16eaf50cb2957ee2ff61261c56"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.29.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "d4f63314c8aa1e48cd22aa0c17ed76cd1ae48c3c"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

# ╔═╡ Cell order:
# ╟─4535a383-d1a0-454a-8d5a-fd521c6a7fc3
# ╟─440c5757-48c5-4100-b3f8-8b80af572204
# ╟─aac85891-ea00-4421-b90e-8a9d7ce11792
# ╟─e1248e75-f6b9-440a-857a-4b260f62c3a8
# ╟─97826684-aeb4-4f54-8230-722104acbbaf
# ╟─d8b8f592-8af4-4cc7-8fe1-9b79ba8a306b
# ╟─41ac0852-3555-48b9-a369-3b617adba62b
# ╟─a99ee910-7091-4aef-ac52-bc84225b9dc1
# ╟─bad8e83c-c419-45fa-ba39-7477ac62cb7c
# ╟─20f6d71e-d930-4cb6-9656-a355e2a25db1
# ╟─e4197c2b-704a-4279-8727-ea6b97572710
# ╟─44537e4c-2a21-402b-aa50-f92f58b3f791
# ╟─c8a88597-c465-4509-82e1-4d38ed44cbee
# ╟─6e11766a-299a-44b0-9f90-4eee775c88d8
# ╟─00940350-7e28-4caf-8da1-a705b47e6c6a
# ╟─f67da721-857a-4b24-be85-45b2e35ba707
# ╟─129fad05-6a71-48f2-81a7-a71a9ab59eb5
# ╟─c0040398-5b76-4d9e-a03c-183759cc18cd
# ╟─b90f9379-f79c-466c-8b47-9439ddb16717
# ╟─1dd3aa3c-1e8f-4a08-8e28-b1c02befe645
# ╟─c890ee87-88f2-46f9-aef5-0f699345a152
# ╟─673b1b74-0762-4739-8f57-b15fe72787e3
# ╟─c809c2bc-5d92-4016-84da-f4b77816879d
# ╟─d0b810a6-7357-4128-b8fb-b13468cf8ce7
# ╟─eb4e0542-5272-4004-a4ff-915211b47af8
# ╟─b1a22d84-2c8d-438f-b198-428a9675efb4
# ╟─9573b788-91ee-45e1-8822-c62a36f6f56f
# ╟─a2ee5bcb-e5ff-4260-81a3-eef389419784
# ╟─820278c4-8700-47f7-939c-1c91e109c539
# ╟─c9224d1c-5b38-49de-b0d0-42517fc58155
# ╟─79733c4c-f5c9-4583-9098-58d9fad1a27b
# ╟─43425ad9-8e45-4ecd-a994-83a1a696f145
# ╟─a0b01552-55ec-4522-bdef-adc1a84837ad
# ╟─8119a6a4-04a4-4ab0-bc1b-b0856d1611c8
# ╟─c0eb24ec-c201-4dbc-95ae-4a8a954750fc
# ╟─b5e48a63-7163-49a4-a3b3-e5ffc828b289
# ╟─6870801a-f028-4de2-a49c-e54288f62306
# ╟─760bcbea-484b-4c79-ac9b-458aaeb8a083
# ╟─bc6f34b2-6909-4de0-8666-f80b04359061
# ╟─58994e41-e952-42b8-9c44-3e59236dff93
# ╟─af26188e-0a70-49e2-8d09-923467ab7496
# ╟─7d6dfb80-5a6c-4559-a325-490af3da2263
# ╟─2f99c200-f4e3-4a8c-a24e-59b1e2191145
# ╟─228550fc-0244-4092-845e-51b6a391078d
# ╟─e7c530e8-9ac7-4b3f-9c5b-2b03aaa80900
# ╟─4ba5c1f0-60b2-47c9-8220-7836e84b9ce8
# ╟─71faa189-c00b-4092-939e-3f9b8013a8b2
# ╟─e4c09f88-35c6-4382-9b44-6998f5402cb6
# ╟─b4dbec80-c66d-49ae-8736-e48b40982cd5
# ╟─b7aefb70-4636-45fc-a3e8-6927c543e8f6
# ╟─372b0340-ac99-4a68-9dd2-974ce51137ff
# ╟─8bf3211d-e009-4b34-8d18-48ef398b0d9c
# ╟─15108dce-2f56-44b7-affd-b580a738a1dc
# ╟─de237b11-25fd-48e5-95fc-b22a7b369f53
# ╟─31bb5deb-dccd-4d09-9ce6-59ad7b87cdd4
# ╟─be3fe754-e633-45b1-bc0e-ab1cf3aec3ac
# ╟─6f1a80c0-3ba3-42dd-9f35-135062b370e4
# ╟─896d3c47-2ca0-4022-811b-ab4b5bb7af3d
# ╟─3e73717c-15e3-4697-992d-63e5b428f1a8
# ╟─fc4238a6-94c7-47d0-b2f0-ac89c7e9bbd1
# ╟─66025ac7-47d6-4c11-83fa-befff248e2ea
# ╟─bbaff929-0f20-4e58-8930-430be3f03d71
# ╟─cea3f4ee-5ba2-4317-ab62-8a949abf7a33
# ╟─9500bd51-ffa8-431d-a6e9-a9ab91769240
# ╟─7f5c31e6-a362-46ec-abc5-0ef459d17d3b
# ╟─7fa8651e-4db4-4809-9c1c-4586a66c9e50
# ╟─a0be9a35-cdca-4302-aa6f-72204dbea363
# ╟─d988b0c5-1544-4b9e-954f-dd8720f6f145
# ╟─b9888d70-399f-4bb7-b817-f623493c5f2a
# ╟─51d6ebc7-ea05-4d37-8487-264ff7d8834d
# ╟─e0b1a878-d4ae-4a6a-99b5-0b5791e9defc
# ╟─be9335a2-1029-4fd6-adeb-d0fc4de935fd
# ╟─cb4431ef-2be4-47cd-a786-4df92c67002f
# ╟─a984d28e-60d9-48aa-9766-28ee2ab5e58f
# ╟─09e5f79a-5a68-4ed7-9352-cf0ea8c2aa07
# ╟─96ffc209-8a30-48a8-afe7-88e0c5cd0d00
# ╟─4d94e0f7-7c87-442f-9f60-4bacb474a484
# ╟─6c9cb78a-4aa0-4b81-9ee3-9f934234d6fc
# ╟─a31d8f99-7487-4935-988b-9717c1ab9289
# ╟─ba5fa42c-345e-4418-823f-b622febde2ee
# ╟─5b45b95e-77d8-4ff4-8b18-08638346013e
# ╟─90b4050f-84ef-42f5-9c77-e48b49bd997e
# ╟─a5689c64-3dd0-4bf4-b26b-5b91791e6d68
# ╟─604f54bd-c02f-4eed-8852-9e47172667fa
# ╟─4dbc0052-81bc-4b81-bd0b-c536788ff6bf
# ╟─b267ab57-05e4-494d-9ed4-54d968003e8a
# ╟─be019d95-a3b7-4b0b-a047-4100d48ae05f
# ╟─942f3e3d-8eee-46bf-a919-7f8c3ef2d85a
# ╟─61300264-4844-4925-8c2a-38bec150a759
# ╟─e833c3a2-a91c-424a-8ec8-38fc38022a08
# ╟─865c2380-dc7b-4f64-99b5-b34d5bc067d5
# ╟─32a687c0-c2af-4dec-ad8e-bb5c6ec6a591
# ╟─100cb7dd-6343-4ef9-ac08-7b57a78c903e
# ╟─a93782c2-61b5-4ab5-a122-eda5a4d8d2c2
# ╟─4df81f21-d69b-4a2a-93b2-c476cfc80383
# ╟─b96affe0-c626-48b7-a9fd-7286636f0813
# ╟─d26eba94-a2aa-4929-9920-e72b60bbd719
# ╟─366266d9-7cff-44b7-9f2e-8151b2d25f07
# ╟─d5c0d931-92c7-4e62-806e-14bd52c0e9af
# ╟─6258d6a2-3df6-46c5-a728-027a3d533e6f
# ╟─04175c8b-fb50-4ad4-99c5-3b519a8b0da9
# ╟─aa8798fa-62db-4ecc-8efe-f1eb53411004
# ╟─8397d2b5-d994-4791-b4bc-3bc07629f506
# ╟─d9485017-6d38-45b0-a9ed-e32ea87e88e7
# ╟─bb8560ff-6834-41ed-951a-4c3d9a880bb8
# ╟─a8f9c09c-93be-4a4f-9883-5432204f0ba8
# ╟─933e018f-7229-4e29-b1ae-c07a19772213
# ╟─33f4e807-5329-4edc-8b5e-a1cd46c60594
# ╟─ac888d85-cb85-44da-94b3-bf7095d1714b
# ╟─cfd852f3-1e53-476f-b646-743dde2c6481
# ╟─59a24e9b-24f6-4b5b-b41d-88da790b1b02
# ╟─94f0412b-6c34-4b64-8365-9d11dfebd055
# ╟─bfafe0ac-e369-4914-b75b-c93ac36967f5
# ╟─0cfedd8f-c04f-40eb-bab9-7fcc79f8ab85
# ╟─159a7ab5-5216-47c8-8bd4-56db4765afe6
# ╟─31109c8e-14a9-446b-a2ff-ac34dcc12ed1
# ╟─9a36dbb8-6e14-433c-a691-f61c9fc5b7d0
# ╟─42dc3b20-2778-48b1-8c8f-f88eb90b3083
# ╟─0c1fb50f-4b75-4449-93b6-f1163af266a5
# ╟─f3efb8b3-8788-49e8-862d-5fc8fb85f115
# ╟─9c2fd59f-7d1f-4749-afc4-59fc2d345a3f
# ╟─cc1a98e1-c8bc-4810-82f3-8fe9cbbae731
# ╟─8775f400-a638-4cab-9a2f-1cfad27e2dee
# ╟─ebd554c7-60dd-45d3-a367-3651b4a2df8f
# ╟─5f3d33b5-c600-452e-a1b6-ffe3953e33e5
# ╟─19975a48-0f5f-4f8b-903c-3d93181d81a1
# ╟─7f53825b-4c0d-4b0e-9299-202e7bd751e1
# ╟─5f7cf638-cbf8-48f8-a8bb-b1ebf5ba88ab
# ╟─fe94c8b9-02ea-4613-b7ba-030b4587ac40
# ╟─f6fedebe-0a24-4503-abfd-c0b37155bb6b
# ╟─d04db0f4-1e2d-4c60-ace7-df4500ff6a79
# ╟─53b86fb2-3fe6-4670-b56e-a67dade1d0a4
# ╟─47bad2aa-051e-4ef0-97b6-2d94641b1a5d
# ╟─e0d09197-fc18-46e9-b0f9-b513ea32596a
# ╟─e44321cc-abd9-45ad-b106-e141a7fa086e
# ╟─9955422e-769d-442a-b7d7-edea3156e8f1
# ╟─b2c19571-95b1-4b7f-9ec1-ed83ba7b8aef
# ╟─b76aecc2-b80e-446d-958c-9c32c030a085
# ╟─375b5f20-ff08-4d9a-8d41-38214db962de
# ╟─b89d8514-2b56-4da9-8f49-e464579c2293
# ╟─c8618313-9982-44e0-a110-2d75c69c75e8
# ╟─d700218c-605d-47c2-b3f2-fcebfad8d633
# ╟─ca7a33bf-7198-4161-a3f8-39e432db2623
# ╟─33c2ea5e-ed01-442b-aa77-30d36ebfcd3a
# ╟─8c2118a5-7a85-4eac-a455-f1e7b6dc5917
# ╟─c15d570f-4701-4354-b0a7-5e5feef78a9a
# ╟─5ea60b57-f735-41c2-86cf-de6601573719
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
