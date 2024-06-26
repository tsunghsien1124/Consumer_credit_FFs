using JLD2
using Plots
using LaTeXStrings
using Measures
using LatexPrint
using Dierckx
using StatsPlots
using Parameters

cd(homedir() * "\\Dropbox\\Dissertation\\Chapter 3 - Consumer Bankruptcy with Financial Frictions\\")

#========================================#
# Bond price across persistent endowment #
#========================================#
plot_col = 1
plot_row = 1
plot_q_e_1_index = 2
plot_q_index = findall(parameters.a_grid .<= 0.0) # findall(-3.0 .<= parameters.a_grid .<= 0.0)
plot_q = plot(
    size = (plot_col * 800, plot_row * 500),
    box = :on,
    # legend = :topleft,
    legend = :none,
    ylimit = [0.0, 1.0],
    yticks = 0.0:0.2:1.0,
    # xlimit = [-6.0, 0.0],
    xtickfont = font(18, "Computer Modern", :black),
    ytickfont = font(18, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(18, "Computer Modern", :black),
    legendfont = font(18, "Computer Modern", :black),
    # ylabel = "\$ q(a',e) \$",
    ylabel = "q(a',e)",
    # xlabel = "\$ \\textrm{Loan\\ choice\\ } a'<0 \$"
    xlabel = "Loan choice a'<0"
)
plot_q = plot!(
    parameters.a_grid[plot_q_index],
    variables.q[plot_q_index, plot_q_e_1_index, 1],
    linecolor = :blue,
    linewidth = 3,
    # label = "\$ \\textrm{Low\\ persistent\\ productivity}\$",
    # label = "Low persistent productivity",
    margin = 4mm,
)
plot_q = plot!(
    parameters.a_grid[plot_q_index],
    variables.q[plot_q_index, plot_q_e_1_index, 2],
    linecolor = :red,
    linestyle = :dash,
    linewidth = 3,
    # label = "\$ \\textrm{Median\\ persistent\\ productivity} \$",
    # label = "Median persistent productivity",
    margin = 4mm,
)
plot_q = plot!(
    parameters.a_grid[plot_q_index],
    variables.q[plot_q_index, plot_q_e_1_index, 3],
    linecolor = :black,
    linestyle = :dashdot,
    linewidth = 3,
    # label = "\$ \\textrm{High\\ persistent\\ productivity} \$",
    # label = "High persistent productivity",
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
)
plot_q
Plots.savefig(plot_q, pwd() * "\\figures\\plot_q_high_permanent.pdf")

#===============================================================#
# Risky discounted borrowing amount across persistent endowment #
#===============================================================#
plot_col = 1
plot_row = 1
plot_qa_index = findall(-4.0 .<= parameters.a_grid .<= 0.0)
plot_qa = plot(
    size = (plot_col * 800, plot_row * 500),
    box = :on,
    legend = :none,
    ylimit = [0.0, 1.1],
    yticks = 0.0:0.2:2.0,
    xtickfont = font(18, "Computer Modern", :black),
    ytickfont = font(18, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(18, "Computer Modern", :black),
    legendfont = font(18, "Computer Modern", :black),
    ylabel = "\$ q(b',e) \\cdot b'\$",
    xlabel = "\$ \\textrm{Loan\\ choice\\ } b'<0 \$"
)
plot_qa = plot!(
    parameters.a_grid[plot_qa_index],
    - variables.q[plot_qa_index, 2] .* parameters.a_grid[plot_qa_index],
    linecolor = :blue,
    linewidth = 3,
    label = "\$ \\textrm{High Endowment } (e_p = $(round(parameters.e_grid[2],digits=1))) \$",
    margin = 4mm,
)
# plot_qa = vline!([variables.rbl[2, 1]], linecolor = :blue, linewidth = 2, linestyle = :dot, label = "")
plot_qa = plot!(
    parameters.a_grid[plot_qa_index],
    - variables.q[plot_qa_index, 5] .* parameters.a_grid[plot_qa_index],
    linecolor = :red,
    linestyle = :dash,
    linewidth = 3,
    label = "\$ \\textrm{Median Endowment } (e_p = $(round(parameters.e_grid[5],digits=1))) \$",
    margin = 4mm,
)
# plot_qa = vline!([variables.rbl[5, 1]], linecolor = :red, linewidth = 2, linestyle = :dot, label = "")
plot_qa = plot!(
    parameters.a_grid[plot_qa_index],
    - variables.q[plot_qa_index, end-1] .* parameters.a_grid[plot_qa_index],
    linecolor = :black,
    linestyle = :dashdot,
    linewidth = 3,
    label = "\$ \\textrm{Low Endowment } (e_p = $(round(parameters.e_grid[end-1],digits=1))) \$",
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
)
# plot_qa = vline!([variables.rbl[end-1, 1]], linecolor = :black, linewidth = 2, linestyle = :dot, label = "")
plot_qa
savefig(plot_qa, "figures/plot_qa.pdf")


#=============#
# Default set #
#=============#
plot(parameters.a_grid_neg, parameters.w * exp.(variables.threshold_e[1:parameters.a_ind_zero, 2, 2] .+ parameters.t_grid[2]))
plot(variables.rbl[], parameters.e_grid)

parameters_NFF_η_20 = parameters_function(λ = 0.0, η = 0.20)
variables_NFF_η_20 = variables_function(parameters_NFF_η_20)
solve_economy_function!(variables_NFF_η_20, parameters_NFF_η_20)

parameters_NFF_η_30 = parameters_function(λ = 0.0, η = 0.30)
variables_NFF_η_30 = variables_function(parameters_NFF_η_30)
solve_economy_function!(variables_NFF_η_30, parameters_NFF_η_30)

parameters_NFF_η_40 = parameters_function(λ = 0.0, η = 0.40)
variables_NFF_η_40 = variables_function(parameters_NFF_η_40)
solve_economy_function!(variables_NFF_η_40, parameters_NFF_η_40)

parameters_NFF_η_50 = parameters_function(λ = 0.0, η = 0.50)
variables_NFF_η_50 = variables_function(parameters_NFF_η_50)
solve_economy_function!(variables_NFF_η_50, parameters_NFF_η_50)

parameters_NFF_η_60 = parameters_function(λ = 0.0, η = 0.60)
variables_NFF_η_60 = variables_function(parameters_NFF_η_60)
solve_economy_function!(variables_NFF_η_60, parameters_NFF_η_60)

results_filers_NFF = zeros(3, 5)

(variables_FF.aggregate_variables.share_of_filers - variables_NFF_η_355.aggregate_variables.share_of_filers) * 100 / variables_NFF_η_355.aggregate_variables.share_of_filers
(variables_FF.aggregate_variables.share_of_involuntary_filers - variables_NFF_η_355.aggregate_variables.share_of_involuntary_filers) * 100 /
variables_FF.aggregate_variables.share_of_involuntary_filers
(
    (variables_FF.aggregate_variables.share_of_filers - variables_FF.aggregate_variables.share_of_involuntary_filers) -
    (variables_NFF_η_355.aggregate_variables.share_of_filers - variables_NFF_η_355.aggregate_variables.share_of_involuntary_filers)
) * 100 / (variables_NFF_η_355.aggregate_variables.share_of_filers - variables_NFF_η_355.aggregate_variables.share_of_involuntary_filers)


#================#
# Checking plots #
#================#
e_label = round.(exp.(parameters.e_grid), digits = 2)'
a_plot_index = findall(-0.5 .<= parameters.a_grid .<= 0.0)
plot(parameters.a_grid[a_plot_index], variables.q[a_plot_index, :], legend = :topleft, label = e_label)
# plot(parameters.a_grid, variables.q, legend = :topleft, label = e_label)

e_plot_i = 1
q_itp = Akima(parameters.a_grid, variables.q[:, e_plot_i])
a_grid_plot = findall(-0.5 .<= parameters.a_grid .<= 0.0)
plot(parameters.a_grid[a_grid_plot], q_itp.(parameters.a_grid[a_grid_plot]), legend = :topleft, label = "e = $(parameters.e_grid[e_plot_i])")
plot!(parameters.a_grid[a_grid_plot], variables.q[a_grid_plot, e_plot_i], seriestype = :scatter, label = "")

plot(parameters.a_grid_neg, variables.q[1:parameters.a_size_neg, :] .* parameters.a_grid_neg, legend = :left, label = e_label)
plot!(variables.rbl[:, 1], variables.rbl[:, 2], label = "rbl", seriestype = :scatter)
# plot!(parameters.a_grid_neg, parameters.a_grid_neg, lc = :black, label = "")

plot(parameters.a_grid, variables.q .* parameters.a_grid, legend = :bottomright, label = e_label)
plot!(variables.rbl[:, 1], variables.rbl[:, 2], label = "rbl", seriestype = :scatter)
plot!(parameters.a_grid, parameters.a_grid, lc = :black, label = "")

e_plot_i = 1
qa_itp = Akima(parameters.a_grid, variables.q[:, e_plot_i] .* parameters.a_grid)
a_grid_plot = findall(-2.0 .<= parameters.a_grid .<= 0.5)
plot(parameters.a_grid[a_grid_plot], qa_itp.(parameters.a_grid[a_grid_plot]), legend = :topleft, label = "e = $(parameters.e_grid[e_plot_i])")
plot!(parameters.a_grid[a_grid_plot], variables.q[a_grid_plot, e_plot_i] .* parameters.a_grid[a_grid_plot], seriestype = :scatter, label = "")
plot!(parameters.a_grid[a_grid_plot], parameters.a_grid[a_grid_plot], lc = :black, label = "")
hline!([0.0], lc = :black, label = "")
vline!([0.0], lc = :black, label = "")


t_plot_i = 1
ν_plot_i = 2
plot(parameters.a_grid_neg, variables.V[1:parameters.a_ind_zero, :, t_plot_i, ν_plot_i], legend = :bottomleft, label = e_label)
plot!(variables.threshold_a[:, t_plot_i, ν_plot_i], variables.V_d[:, t_plot_i, ν_plot_i], label = "defaulting debt level", seriestype = :scatter)
hline!([0.0], lc = :black, label = "")
vline!([0.0], lc = :black, label = "")

plot(parameters.a_grid, variables.V[:, :, 2, 2], legend = :bottomleft, label = e_label)
plot!(variables.threshold_a[:, 2, 2], variables.V_d[:, 2, 2], label = "defaulting debt level", seriestype = :scatter)
hline!([0.0], lc = :black, label = "")
vline!([0.0], lc = :black, label = "")

any(variables.V .< 0.0)

plot(-variables.threshold_a[:, 1], parameters.w * exp.(parameters.e_grid), legend = :none, markershape = :circle, xlabel = "defaulting debt level", ylabel = "w*exp(e)")

plot(parameters.a_grid_neg, variables.threshold_e[1:parameters.a_ind_zero, 1], legend = :none, xlabel = "debt level", ylabel = "defaulting e level")
plot!(variables.threshold_a[:, 1], parameters.e_grid, seriestype = :scatter)

plot(parameters.a_grid_neg, parameters.w .* exp.(variables.threshold_e[1:parameters.a_ind_zero, 1]), legend = :none, xlabel = "debt level", ylabel = "defaulting w*exp(e) level")
plot!(variables.threshold_a[:, 1], parameters.w * exp.(parameters.e_grid), seriestype = :scatter)

plot(parameters.a_grid, parameters.w .* exp.(variables.threshold_e[:, 1]), legend = :none, xlabel = "debt level", ylabel = "defaulting w*exp(e) level")
plot!(variables.threshold_a[:, 1], parameters.w * exp.(parameters.e_grid), seriestype = :scatter)

#====================#
# Average loanb rate #
#====================#
plot_col = 1
plot_row = 1
plot_loan_rate = plot(
    size = (plot_col * 800, plot_row * 500),
    box = :on,
    legend = :topleft,
    # ylimit = [0.0,1.0],
    # yticks = 0.0:0.25:1.0,
    xticks = 0.1:0.1:0.8,
    xtickfont = font(18, "Computer Modern", :black),
    ytickfont = font(18, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(18, "Computer Modern", :black),
    legendfont = font(18, "Computer Modern", :black),
)
plot_loan_rate = plot!(
    η_grid,
    results_A_NFF[end, :] * 100,
    markershapes = :circle,
    markercolor = :blue,
    markersize = 7,
    linecolor = :blue,
    linewidth = 3,
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
    legend = :topright,
    label = "",
    xlabel = "\$ \\textrm{Wage\\ garnishment\\ rate\\ } \\eta \$",
    ylabel = "\$ \\% \$"
)
savefig(plot_loan_rate, "figures/plot_loan_rate.pdf")

#===========================#
# Agreegate unsecured loans #
#===========================#
plot_col = 1
plot_row = 1
plot_aggregate_loan = plot(
    size = (plot_col * 800, plot_row * 500),
    box = :on,
    legend = :topleft,
    # ylimit = [0.0,1.0],
    # yticks = 0.0:0.25:1.0,
    xticks = 0.1:0.1:0.8,
    xtickfont = font(18, "Computer Modern", :black),
    ytickfont = font(18, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(18, "Computer Modern", :black),
    legendfont = font(18, "Computer Modern", :black),
)
plot_aggregate_loan = plot!(
    η_grid,
    results_A_NFF[6, :],
    markershapes = :circle,
    markercolor = :blue,
    markersize = 7,
    linecolor = :blue,
    linewidth = 3,
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
    legend = :topright,
    label = "",
    xlabel = "\$ \\textrm{Wage\\ garnishment\\ rate\\ } \\eta \$",
    ylabel = "\$ \\textrm{Amount} \$"
)
savefig(plot_aggregate_loan, "figures/plot_aggregate_loan.pdf")

#====================#
# Agreegate deposits #
#====================#
plot_col = 1
plot_row = 1
plot_deposit= plot(
    size = (plot_col * 800, plot_row * 500),
    box = :on,
    legend = :topleft,
    # ylimit = [0.0,1.0],
    # yticks = 0.0:0.25:1.0,
    xticks = 0.1:0.1:0.8,
    xtickfont = font(18, "Computer Modern", :black),
    ytickfont = font(18, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(18, "Computer Modern", :black),
    legendfont = font(18, "Computer Modern", :black),
)
plot_deposit = plot!(
    η_grid,
    results_A_NFF[7, :],
    markershapes = :circle,
    markercolor = :blue,
    markersize = 7,
    linecolor = :blue,
    linewidth = 3,
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
    legend = :topright,
    label = "",
    xlabel = "\$ \\textrm{Wage\\ garnishment\\ rate\\ } \\eta \$",
    ylabel = "\$ \\textrm{Amount} \$"
)
savefig(plot_deposit, "figures/plot_deposit.pdf")

#================#
# Leverage ratio #
#================#
plot_col = 1
plot_row = 1
plot_leverage_ratio= plot(
    size = (plot_col * 800, plot_row * 500),
    box = :on,
    legend = :topleft,
    # ylimit = [0.0,1.0],
    # yticks = 0.0:0.25:1.0,
    xticks = 0.1:0.1:0.8,
    xtickfont = font(18, "Computer Modern", :black),
    ytickfont = font(18, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(18, "Computer Modern", :black),
    legendfont = font(18, "Computer Modern", :black),
)
plot_leverage_ratio = plot!(
    η_grid,
    results_A_NFF[9, :],
    markershapes = :circle,
    markercolor = :blue,
    markersize = 7,
    linecolor = :blue,
    linewidth = 3,
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
    legend = :topright,
    label = "",
    xlabel = "\$ \\textrm{Wage\\ garnishment\\ rate\\ } \\eta \$",
    ylabel = "\$ \\textrm{Ratio} \$"
)
savefig(plot_leverage_ratio, "figures/plot_leverage_ratio.pdf")

#==================#
# Leverage premium #
#==================#
plot_col = 1
plot_row = 1
plot_leverage_premium = plot(
    size = (plot_col * 800, plot_row * 500),
    box = :on,
    legend = :topleft,
    # ylimit = [0.0,1.0],
    # yticks = 0.0:0.25:1.0,
    xticks = 0.1:0.1:0.8,
    xtickfont = font(18, "Computer Modern", :black),
    ytickfont = font(18, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(18, "Computer Modern", :black),
    legendfont = font(18, "Computer Modern", :black),
)
plot_leverage_premium = plot!(
    η_grid,
    results_A_NFF[4, :] * 100,
    markershapes = :circle,
    markercolor = :blue,
    markersize = 7,
    linecolor = :blue,
    linewidth = 3,
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
    legend = :topright,
    label = "\$ \\textrm{Without\\ financial\\ frictions} \$",
    xlabel = "\$ \\textrm{Wage\\ garnishment\\ rate\\ } \\eta \$",
    ylabel = "\$ \\% \$"
)
plot_leverage_premium = plot!(
    η_grid,
    results_A_FF[4, :] * 100,
    markershapes = :square,
    markercolor = :red,
    markersize = 6,
    markerstrokecolor = :red,
    linecolor = :red,
    linestyle = :dash,
    linewidth = 3,
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
    legend = :topright,
    label = "\$ \\textrm{With\\ financial\\ frictions} \$",
    xlabel = "\$ \\textrm{Wage\\ garnishment\\ rate\\ } \\eta \$",
    ylabel = "\$ \\% \$"
)
savefig(plot_leverage_premium, "figures/plot_leverage_premium.pdf")

#=============#
# Rental rate #
#=============#
plot_col = 1
plot_row = 1
plot_renta_rate = plot(
    size = (plot_col * 800, plot_row * 500),
    box = :on,
    legend = :topleft,
    # ylimit = [0.0,1.0],
    # yticks = 0.0:0.25:1.0,
    xticks = 0.1:0.1:0.8,
    xtickfont = font(18, "Computer Modern", :black),
    ytickfont = font(18, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(18, "Computer Modern", :black),
    legendfont = font(18, "Computer Modern", :black),
)
plot_renta_rate = plot!(
    η_grid,
    results_A_NFF[2, :] * 100,
    markershapes = :circle,
    markercolor = :blue,
    markersize = 7,
    linecolor = :blue,
    linewidth = 3,
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
    legend = :topright,
    label = "\$ \\textrm{Without\\ financial\\ frictions} \$",
    xlabel = "\$ \\textrm{Wage\\ garnishment\\ rate\\ } \\eta \$",
    ylabel = "\$ \\% \$"
)
plot_renta_rate = plot!(
    η_grid,
    results_A_FF[2, :] * 100,
    markershapes = :square,
    markercolor = :red,
    markersize = 6,
    markerstrokecolor = :red,
    linecolor = :red,
    linestyle = :dash,
    linewidth = 3,
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
    legend = :topright,
    label = "\$ \\textrm{With\\ financial\\ frictions} \$",
    xlabel = "\$ \\textrm{Wage\\ garnishment\\ rate\\ } \\eta \$",
    ylabel = "\$ \\% \$"
)
savefig(plot_renta_rate, "figures/plot_renta_rate.pdf")

#==================#
# Physical capital #
#==================#
plot_col = 1
plot_row = 1
plot_capital = plot(
    size = (plot_col * 800, plot_row * 500),
    box = :on,
    legend = :topleft,
    # ylimit = [0.0,1.0],
    # yticks = 0.0:0.25:1.0,
    xticks = 0.1:0.1:0.8,
    xtickfont = font(18, "Computer Modern", :black),
    ytickfont = font(18, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(18, "Computer Modern", :black),
    legendfont = font(18, "Computer Modern", :black),
)
plot_capital = plot!(
    η_grid,
    results_A_NFF[5, :],
    markershapes = :circle,
    markercolor = :blue,
    markersize = 7,
    linecolor = :blue,
    linewidth = 3,
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
    legend = :topright,
    label = "\$ \\textrm{Without\\ financial\\ frictions} \$",
    xlabel = "\$ \\textrm{Wage\\ garnishment\\ rate\\ } \\eta \$",
    ylabel = "\$ \\% \$"
)
plot_capital = plot!(
    η_grid,
    results_A_FF[5, :],
    markershapes = :square,
    markercolor = :red,
    markersize = 6,
    markerstrokecolor = :red,
    linecolor = :red,
    linestyle = :dash,
    linewidth = 3,
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
    legend = :bottomright,
    label = "\$ \\textrm{With\\ financial\\ frictions} \$",
    xlabel = "\$ \\textrm{Wage\\ garnishment\\ rate\\ } \\eta \$",
    ylabel = "\$ \\% \$"
)
savefig(plot_capital, "figures/plot_capital.pdf")

#==========================#
# Welfare comparison (CEV) #
#==========================#
parameters = parameters_function()
results_CEV_NFF = results_CEV_function(parameters, results_A_NFF, results_V_NFF, results_V_pos_NFF)
results_CEV_FF = results_CEV_function(parameters, results_A_FF, results_V_FF, results_V_pos_FF)
η_grid = results_A_NFF[1, :]
η_size = length(η_grid)
CEV_comparison_NFF = zeros(η_size)
CEV_comparison_FF = zeros(η_size)
for η_i in 1:η_size
    CEV_comparison_NFF[η_i] = sum(results_μ_NFF[:,:,:,:,:,:,η_i] .* results_CEV_NFF[:,:,:,:,:,:,η_i])
    CEV_comparison_FF[η_i] = sum(results_μ_FF[:,:,:,:,:,:,η_i] .* results_CEV_FF[:,:,:,:,:,:,η_i])
end
plot_col = 1
plot_row = 1
plot_welfare = plot(
    size = (plot_col * 800, plot_row * 500),
    box = :on,
    legend = :bottomleft,
    # ylimit = [0.0,6.0],
    # yticks = 0.0:0.5:6.0,
    xticks = 0.1:0.1:0.9,
    xtickfont = font(18, "Computer Modern", :black),
    ytickfont = font(18, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(18, "Computer Modern", :black),
    legendfont = font(18, "Computer Modern", :black),
)
plot_welfare = plot!(
    η_grid,
    CEV_comparison_NFF,
    markershapes = :circle,
    markercolor = :blue,
    markersize = 7,
    markerstrokecolor = :blue,
    linecolor = :blue,
    linewidth = 3,
    # label = "\$ \\textrm{Without\\ financial\\ frictions} \$",
    label = "without financial frictions",
    # xlabel = "\$ \\textrm{Wage\\ garnishment\\ rate\\ } \\eta \$",
    xlabel = "wage garnishment rate",
    # ylabel = "\$ \\% \$",
    ylabel = "%",
    margin = 4mm,
)
# plot_welfare = vline!([η_grid[argmax(CEV_comparison_NFF)]], linecolor = :blue, linewidth = 3, linestyle = :dot, label = "")
plot_welfare = plot!(
    η_grid,
    CEV_comparison_FF,
    markershapes = :square,
    markercolor = :red,
    markersize = 6,
    markerstrokecolor = :red,
    linecolor = :red,
    linestyle = :dash,
    linewidth = 3,
    # label = "\$ \\textrm{With\\ financial\\ frictions} \$",
    label = "with financial frictions",
    # title = "Welfare (CEV)",
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
)
# plot_welfare = vline!([η_grid[argmax(CEV_comparison_FF)]], linecolor = :red, linewidth = 3, linestyle = :dot, label = "")

savefig(plot_welfare, "figures/plot_welfare.pdf")

#==============================#
# Welfare comparison (Newborn) #
#==============================#
parameters = parameters_function()
η_grid = results_A_NFF[1, :]
η_size = length(η_grid)
newborn_comparison_NFF = zeros(η_size)
newborn_comparison_FF = zeros(η_size)
for η_i in 1:η_size
    for e_2_i in 1:parameters.e_2_size, e_1_i in 1:parameters.e_1_size
        newborn_comparison_NFF[η_i] += parameters.G_e_1[e_1_i] * parameters.G_e_2[e_2_i] * results_V_NFF[parameters.a_ind_zero, e_1_i, e_2_i, 2, 2, η_i]
        newborn_comparison_FF[η_i] += parameters.G_e_1[e_1_i] * parameters.G_e_2[e_2_i] * results_V_FF[parameters.a_ind_zero, e_1_i, e_2_i, 2, 2, η_i]
    end
end
plot_col = 1
plot_row = 1
plot_welfare_newborn = plot(
    size = (plot_col * 800, plot_row * 500),
    box = :on,
    legend = :topleft,
    # ylimit = [0.0,6.0],
    # yticks = 0.0:0.5:6.0,
    xticks = 0.1:0.1:0.9,
    xtickfont = font(18, "Computer Modern", :black),
    ytickfont = font(18, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(18, "Computer Modern", :black),
    legendfont = font(18, "Computer Modern", :black),
)
plot_welfare_newborn = plot!(
    η_grid,
    newborn_comparison_NFF,
    markershapes = :circle,
    markercolor = :blue,
    markersize = 7,
    markerstrokecolor = :blue,
    linecolor = :blue,
    linewidth = 3,
    # label = "\$ \\textrm{Without\\ financial\\ frictions} \$",
    label = "without financial frictions",
    # xlabel = "\$ \\textrm{Wage\\ garnishment\\ rate\\ } \\eta \$",
    xlabel = "wage garnishment rate",
    # ylabel = "\$ \\% \$",
    # ylabel = "%",
    margin = 4mm,
)
# plot_welfare_newborn = vline!([η_grid[argmax(newborn_comparison_NFF)]], linecolor = :blue, linewidth = 3, linestyle = :dot, label = "")
plot_welfare_newborn = plot!(
    η_grid,
    newborn_comparison_FF,
    markershapes = :square,
    markercolor = :red,
    markersize = 6,
    markerstrokecolor = :red,
    linecolor = :red,
    linestyle = :dash,
    linewidth = 3,
    # label = "\$ \\textrm{With\\ financial\\ frictions} \$",
    label = "with financial frictions",
    # title = "Welfare (CEV)",
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
)
# plot_welfare_newborn = vline!([η_grid[argmax(newborn_comparison_FF)]], linecolor = :red, linewidth = 3, linestyle = :dot, label = "")

savefig(plot_welfare_newborn, "figures/plot_welfare_newborn.pdf")

#================================#
# Welfare comparison (HHs favor) #
#================================#
parameters = parameters_function()
results_HHs_favor_NFF = results_HHs_favor_function(parameters, results_A_NFF, results_V_NFF, results_V_pos_NFF)
results_HHs_favor_FF = results_HHs_favor_function(parameters, results_A_FF, results_V_FF, results_V_pos_FF)
η_grid = results_A_NFF[1, :]
η_size = length(η_grid)
HHs_favor_comparison_NFF = zeros(η_size)
HHs_favor_comparison_FF = zeros(η_size)
for η_i in 1:η_size
    HHs_favor_comparison_NFF[η_i] = sum(results_μ_NFF[:,:,:,:,:,:,η_i] .* results_HHs_favor_NFF[:,:,:,:,:,:,η_i])
    HHs_favor_comparison_FF[η_i] = sum(results_μ_FF[:,:,:,:,:,:,η_i] .* results_HHs_favor_FF[:,:,:,:,:,:,η_i])
end
plot_col = 1
plot_row = 1
plot_welfare_HHs_favor = plot(
    size = (plot_col * 800, plot_row * 500),
    box = :on,
    legend = :bottomleft,
    # ylimit = [0.0,6.0],
    # yticks = 0.0:0.5:6.0,
    xticks = 0.1:0.1:0.9,
    xtickfont = font(18, "Computer Modern", :black),
    ytickfont = font(18, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(18, "Computer Modern", :black),
    legendfont = font(18, "Computer Modern", :black),
)
plot_welfare_HHs_favor = plot!(
    η_grid,
    HHs_favor_comparison_NFF,
    markershapes = :circle,
    markercolor = :blue,
    markersize = 7,
    markerstrokecolor = :blue,
    linecolor = :blue,
    linewidth = 3,
    # label = "\$ \\textrm{Without\\ financial\\ frictions} \$",
    label = "without financial frictions",
    # xlabel = "\$ \\textrm{Wage\\ garnishment\\ rate\\ } \\eta \$",
    xlabel = "wage garnishment rate",
    # ylabel = "\$ \\% \$",
    ylabel = "%",
    margin = 4mm,
)
# plot_welfare = vline!([η_grid[argmax(CEV_comparison_NFF)]], linecolor = :blue, linewidth = 3, linestyle = :dot, label = "")
plot_welfare_HHs_favor = plot!(
    η_grid,
    HHs_favor_comparison_FF,
    markershapes = :square,
    markercolor = :red,
    markersize = 6,
    markerstrokecolor = :red,
    linecolor = :red,
    linestyle = :dash,
    linewidth = 3,
    # label = "\$ \\textrm{With\\ financial\\ frictions} \$",
    label = "with financial frictions",
    # title = "Welfare (CEV)",
    margin = 4mm,
    titlefontsize=18,
    tickfontsize=18,
    guidefontsize=18,
    legendfontsize=16,
)

savefig(plot_welfare_HHs_favor, "figures/plot_welfare_HHs_favor.pdf")

#============#
# Equilibria #
#============#
plot_row = 2
plot_col = 2
plot_size = plot_row * plot_col
# plot_ordering = [4, 2, 9, 5]
plot_ordering = [13, 7, 9, 4]
plot_title = [var_names[i] for i in plot_ordering]
plot_equilibria = plot(
    layout = (plot_row, plot_col),
    size = (plot_col * 700, plot_row * 400),
    box = :on,
    xlimit = [0.1, 0.8],
    xticks = 0.1:0.1:0.8,
    xtickfont = font(12, "Computer Modern", :black),
    ytickfont = font(12, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(16, "Computer Modern", :black),
    legendfont = font(14, "Computer Modern", :black),
)
for sp_i = 1:plot_size
    plot_index = plot_ordering[sp_i]
    plot_equilibria = plot!(
        subplot = sp_i,
        η_grid,
        results_A_NFF[plot_index, :],
        markershapes = :circle,
        markercolor = :blue,
        markersize = 7,
        markerstrokecolor = :blue,
        linecolor = :blue,
        linewidth = 4,
        label = "Without Financial Frictions",
        legend = :none,
        margin = 8mm,
    )
    plot_equilibria = plot!(
        subplot = sp_i,
        η_grid,
        results_A_FF[plot_index, :],
        title = plot_title[sp_i],
        markershapes = :square,
        markercolor = :red,
        markersize = 5,
        markerstrokecolor = :red,
        linecolor = :red,
        linewidth = 3,
        label = "With Financial Frictions",
        legend = :none,
        margin = 4mm,
    )
    if sp_i > (plot_row - 1) * plot_col
        plot_equilibria = plot!(subplot = sp_i, xlabel = "\$ \\textrm{wage garnishment rate } (\\eta) \$")
    end
    if sp_i == plot_row * plot_col
        plot_equilibria = plot!(subplot = sp_i, legend = :topright)
    end
end
plot_equilibria
savefig(plot_equilibria, "figures/plot_equilibria.pdf")

#===============================#
# Premium and average loan rate #
#===============================#
plot_row = 2
plot_col = 1
plot_size = plot_row * plot_col
plot_ordering = [4, 13]
plot_title = [var_names[i] for i in plot_ordering]
plot_leverage = plot(
    layout = (plot_row, plot_col),
    size = (plot_col * 700, plot_row * 400),
    box = :on,
    xlimit = [0.1, 0.8],
    xticks = 0.1:0.1:0.8,
    xtickfont = font(12, "Computer Modern", :black),
    ytickfont = font(12, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(16, "Computer Modern", :black),
    legendfont = font(14, "Computer Modern", :black),
)
for sp_i = 1:plot_size
    plot_index = plot_ordering[sp_i]
    plot_leverage = plot!(
        subplot = sp_i,
        η_grid,
        results_A_NFF[plot_index, :],
        markershapes = :circle,
        markercolor = :blue,
        markersize = 7,
        markerstrokecolor = :blue,
        linecolor = :blue,
        linewidth = 4,
        label = "Without Financial Frictions",
        legend = :none,
        margin = 8mm,
    )
    plot_leverage = plot!(
        subplot = sp_i,
        η_grid,
        results_A_FF[plot_index, :],
        title = plot_title[sp_i],
        markershapes = :square,
        markercolor = :red,
        markersize = 5,
        markerstrokecolor = :red,
        linecolor = :red,
        linewidth = 3,
        label = "With Financial Frictions",
        legend = :none,
        margin = 4mm,
    )
    if sp_i > (plot_row - 1) * plot_col
        plot_leverage = plot!(subplot = sp_i, xlabel = "\$ \\textrm{wage garnishment rate } (\\eta) \$")
    end
    if sp_i == plot_row * plot_col
        plot_leverage = plot!(subplot = sp_i, legend = :topright)
    end
end
plot_leverage
savefig(plot_leverage, "figures/plot_leverage.pdf")

#=========================#
# Rental rate and capital #
#=========================#
plot_row = 2
plot_col = 1
plot_size = plot_row * plot_col
plot_ordering = [2, 5]
plot_title = [var_names[i] for i in plot_ordering]
plot_divestment = plot(
    layout = (plot_row, plot_col),
    size = (plot_col * 700, plot_row * 400),
    box = :on,
    xlimit = [0.1, 0.8],
    xticks = 0.1:0.1:0.8,
    xtickfont = font(12, "Computer Modern", :black),
    ytickfont = font(12, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(16, "Computer Modern", :black),
    legendfont = font(14, "Computer Modern", :black),
)
for sp_i = 1:plot_size
    plot_index = plot_ordering[sp_i]
    plot_divestment = plot!(
        subplot = sp_i,
        η_grid,
        results_A_NFF[plot_index, :],
        markershapes = :circle,
        markercolor = :blue,
        markersize = 7,
        markerstrokecolor = :blue,
        linecolor = :blue,
        linewidth = 4,
        label = "Without Financial Frictions",
        legend = :none,
        margin = 8mm,
    )
    plot_divestment = plot!(
        subplot = sp_i,
        η_grid,
        results_A_FF[plot_index, :],
        title = plot_title[sp_i],
        markershapes = :square,
        markercolor = :red,
        markersize = 5,
        markerstrokecolor = :red,
        linecolor = :red,
        linewidth = 3,
        label = "With Financial Frictions",
        legend = :none,
        margin = 4mm,
    )
    if sp_i > (plot_row - 1) * plot_col
        plot_divestment = plot!(subplot = sp_i, xlabel = "\$ \\textrm{wage garnishment rate } (\\eta) \$")
    end
    if sp_i == plot_row * plot_col
        plot_divestment = plot!(subplot = sp_i, legend = :bottomright)
    end
end
plot_divestment
savefig(plot_divestment, "figures/plot_divestment.pdf")

#==========#
# Deposits #
#==========#
function parameters_function_fixed_wage(;
    β::Real = 0.94,                 # discount factor (households)
    β_f::Real = 0.96,               # discount factor (bank)
    r_f::Real = 1.0 / β_f - 1.0,    # risk-free rate
    τ::Real = 0.04,                 # transaction cost
    σ::Real = 2.00,                 # CRRA coefficient
    η::Real = 0.355,                # garnishment rate
    δ::Real = 0.08,                 # depreciation rate
    α::Real = 1.0 / 3.0,            # capital share
    ψ::Real = 0.972,                # exogenous retention ratio
    λ::Real = 0.00,                 # multiplier of incentive constraint
    θ::Real = 0.381,                # diverting fraction
    e_ρ::Real = 0.9630,             # AR(1) of persistent endowment shock
    e_σ::Real = 0.1300,             # s.d. of persistent endowment shock
    e_size::Integer = 9,            # number of persistent endowment shock
    t_σ::Real = 0.35,               # s.d. of transitory endowment shock
    t_size::Integer = 3,            # number oftransitory endowment shock
    ν_s::Real = 0.00,               # scale of patience
    ν_p::Real = 0.01,               # probability of patience
    ν_size::Integer = 2,            # number of preference shock
    a_min::Real = -8.0,             # min of asset holding
    a_max::Real = 300.0,            # max of asset holding
    a_size_neg::Integer = 201,      # number of grid of negative asset holding for VFI
    a_size_pos::Integer = 51,       # number of grid of positive asset holding for VFI
    a_degree::Integer = 3,          # curvature of the positive asset gridpoints
    a_size_pos_μ::Integer = 751,    # number of grid of positive asset holding for distribution
)
    """
    contruct an immutable object containg all paramters
    """

    # persistent endowment shock
    e_MC = tauchen(e_size, e_ρ, e_σ, 0.0, 3)
    e_Γ = e_MC.p
    e_grid = collect(e_MC.state_values)
    e_SD = stationary_distributions(e_MC)[]
    e_SS = sum(e_SD .* e_grid)

    # transitory endowment shock
    t_grid = quantile.(Normal(0.0, t_σ), collect(range(0.0, 1.0; step = 1.0 / (t_size + 1))))
    t_grid = t_grid[2:(end-1)]
    t_Γ = repeat([1.0 / t_size], inner = t_size)
    t_SS = sum(t_Γ .* t_grid)

    # preference schock
    ν_grid = [ν_s, 1.0]
    ν_Γ = [ν_p, 1.0 - ν_p]

    # idiosyncratic state
    x_grid = gridmake(e_grid, t_grid, ν_grid)
    x_ind = gridmake(1:e_size, 1:t_size, 1:ν_size)
    x_size = e_size * t_size * ν_size

    # asset holding grid for VFI
    a_grid_neg = collect(range(a_min, 0.0, length = a_size_neg))
    a_grid_pos = ((range(0.0, stop = a_size_pos - 1, length = a_size_pos) / (a_size_pos - 1)) .^ a_degree) * a_max
    a_grid = cat(a_grid_neg[1:(end-1)], a_grid_pos, dims = 1)
    a_size = length(a_grid)
    a_ind_zero = findall(iszero, a_grid)[]

    # asset holding grid for μ
    a_size_neg_μ = a_size_neg
    a_grid_neg_μ = collect(range(a_min, 0.0, length = a_size_neg_μ))
    a_grid_pos_μ = collect(range(0.0, a_max, length = a_size_pos_μ))
    a_grid_μ = cat(a_grid_neg_μ[1:(end-1)], a_grid_pos_μ, dims = 1)
    a_size_μ = length(a_grid_μ)
    a_ind_zero_μ = findall(iszero, a_grid_μ)[]

    # compute equilibrium prices and quantities
    ξ = (1.0 - ψ) / (1 - λ - ψ)
    Λ = β_f * (1.0 - ψ + ψ * ξ)
    LR = ξ / θ
    KL_to_D_ratio = LR / (LR - 1.0)
    ι = λ * θ / Λ
    r_k = r_f + ι
    E = exp(e_SS + t_SS)
    K = E * ((r_k + δ) / α)^(1.0 / (α - 1.0))
    K_fixed_wage = E * ((r_f + δ) / α)^(1.0 / (α - 1.0))
    w = (1.0 - α) * (K_fixed_wage / E)^α

    # return values
    return (
        β = β,
        β_f = β_f,
        r_f = r_f,
        τ = τ,
        σ = σ,
        η = η,
        δ = δ,
        α = α,
        ψ = ψ,
        λ = λ,
        θ = θ,
        a_degree = a_degree,
        e_ρ = e_ρ,
        e_σ = e_σ,
        e_size = e_size,
        e_Γ = e_Γ,
        e_grid = e_grid,
        t_σ = t_σ,
        t_size = t_size,
        t_Γ = t_Γ,
        t_grid = t_grid,
        ν_s = ν_s,
        ν_p = ν_p,
        ν_size = ν_size,
        ν_Γ = ν_Γ,
        ν_grid = ν_grid,
        x_grid = x_grid,
        x_ind = x_ind,
        x_size = x_size,
        a_grid = a_grid,
        a_grid_neg = a_grid_neg,
        a_grid_pos = a_grid_pos,
        a_size = a_size,
        a_size_neg = a_size_neg,
        a_size_pos = a_size_pos,
        a_ind_zero = a_ind_zero,
        a_grid_μ = a_grid_μ,
        a_grid_neg_μ = a_grid_neg_μ,
        a_grid_pos_μ = a_grid_pos_μ,
        a_size_μ = a_size_μ,
        a_size_neg_μ = a_size_neg_μ,
        a_size_pos_μ = a_size_pos_μ,
        a_ind_zero_μ = a_ind_zero_μ,
        ξ = ξ,
        Λ = Λ,
        LR = LR,
        KL_to_D_ratio = KL_to_D_ratio,
        ι = ι,
        r_k = r_k,
        E = E,
        K = K,
        w = w,
    )
end
deposits_fixed_wage = zeros(η_size)
results_V_FF_fixed_wage = similar(results_V_FF)
results_μ_FF_fixed_wage = similar(results_μ_FF)
for η_i = 1:η_size
    parameters = parameters_function_fixed_wage(η = η_grid[η_i], λ = results_A_FF[3, η_i])
    variables = variables_function(parameters)
    solve_economy_function!(variables, parameters)
    results_V_FF_fixed_wage[:,:,:,:,η_i] = variables.V
    results_μ_FF_fixed_wage[:,:,:,:,η_i] = variables.μ
end
parameters_CEV, results_CEV_NFF = results_CEV_function(results_V_NFF)
parameters_CEV, results_CEV_FF = results_CEV_function(results_V_FF)
parameters_CEV, results_CEV_FF_fixed_wage = results_CEV_function(results_V_FF_fixed_wage)
η_grid = results_A_NFF[1, :]
η_size = length(η_grid)
CEV_comparison_NFF = zeros(η_size)
CEV_comparison_FF = zeros(η_size)
CEV_comparison_FF_fixed_wage = zeros(η_size)
for η_i = 1:η_size
    @inbounds CEV_comparison_NFF[η_i] = sum(results_CEV_NFF[:, :, :, :, η_i] .* results_μ_NFF[:, :, :, :, η_i])
    @inbounds CEV_comparison_FF[η_i] = sum(results_CEV_FF[:, :, :, :, η_i] .* results_μ_FF[:, :, :, :, η_i])
    @inbounds CEV_comparison_FF_fixed_wage[η_i] = sum(results_CEV_FF_fixed_wage[:, :, :, :, η_i] .* results_μ_FF_fixed_wage[:, :, :, :, η_i])
end
plot_col = 1
plot_row = 1
plot_welfare = plot(
    size = (plot_col * 700, plot_row * 500),
    box = :on,
    legend = :topleft,
    ylimit = [0.0, 0.01],
    yticks = 0.0:0.0025:0.01,
    xticks = 0.1:0.1:0.8,
    xtickfont = font(12, "Computer Modern", :black),
    ytickfont = font(12, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(16, "Computer Modern", :black),
    legendfont = font(14, "Computer Modern", :black),
)
plot_welfare = plot!(
    η_grid,
    CEV_comparison_NFF,
    markershapes = :circle,
    markercolor = :blue,
    markersize = 7,
    markerstrokecolor = :blue,
    linecolor = :blue,
    linewidth = 3,
    label = "Without Financial Frictions",
    margin = 4mm,
)
plot_welfare = vline!([η_grid[argmax(CEV_comparison_NFF)]], linecolor = :blue, linewidth = 3, linestyle = :dot, label = "")
plot_welfare = plot!(
    η_grid,
    CEV_comparison_FF,
    markershapes = :square,
    markercolor = :red,
    markersize = 5,
    markerstrokecolor = :red,
    linecolor = :red,
    linewidth = 3,
    label = "With Financial Frictions",
    xlabel = "\$ \\textrm{wage garnishment rate } (\\eta) \$",
    title = "Welfare (CEV)",
    margin = 4mm,
)
plot_welfare = vline!([η_grid[argmax(CEV_comparison_FF)]], linecolor = :red, linewidth = 3, linestyle = :dot, label = "")
plot_welfare = plot!(
    η_grid,
    CEV_comparison_FF_fixed_wage,
    markershapes = :square,
    markercolor = :black,
    markersize = 5,
    markerstrokecolor = :red,
    linecolor = :red,
    linewidth = 3,
    label = "With Financial Frictions",
    xlabel = "\$ \\textrm{wage garnishment rate } (\\eta) \$",
    title = "Welfare (CEV)",
    margin = 4mm,
)
plot_welfare = vline!([η_grid[argmax(CEV_comparison_FF_fixed_wage)]], linecolor = :black, linewidth = 3, linestyle = :dot, label = "")

savefig(plot_welfare, "figures/plot_welfare.pdf")

#=
plot_row = 1
plot_col = 1
plot_size = plot_row * plot_col
plot_all = plot(
    layout = (plot_row, plot_col),
    size = (plot_col * 700, plot_row * 500),
    box = :on,
    xlimit = [0.1, 0.8],
    xticks = 0.1:0.1:0.8,
    xtickfont = font(12, "Computer Modern", :black),
    ytickfont = font(12, "Computer Modern", :black),
    titlefont = font(18, "Computer Modern", :black),
    guidefont = font(16, "Computer Modern", :black),
    legendfont = font(14, "Computer Modern", :black),
)
plot_all = plot!(
    η_grid,
    results_A_NFF[7, :],
    seriestype = :path,
    markershapes = :auto,
    markercolor = :auto,
    markersize = 5,
    markerstrokecolor = :auto,
    lw = 3,
    label = "Without Financial Frictions",
    legend = :none,
    margin = 4mm,
)
plot_all = plot!(
    η_grid,
    results_A_FF[7, :],
    seriestype = :path,
    markershapes = :auto,
    markercolor = :auto,
    markerstrokecolor = :auto,
    # lc = :red,
    lw = 3,
    label = "With Financial Frictions",
    legend = :none,
    margin = 4mm,
)
plot_all = plot!(
    η_grid,
    deposits_fixed_wage,
    seriestype = :path,
    markershapes = :auto,
    markercolor = :auto,
    markerstrokecolor = :auto,
    color = 2,
    lw = 3,
    ls = :dot,
    label = "With Financial Frictions (fixed wage)",
    legend = :none,
    margin = 4mm,
)
plot_all = plot!(xlabel = "\$ \\textrm{garnishment rate } (\\eta) \$")
plot_all = plot!(legend = :bottomleft)

plot_all
savefig(plot_all, "plot_D_two_channels.pdf")
=#
