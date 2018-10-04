defmodule RobotSimulator do
  use Agent

  @valid_direction [:north, :east, :south, :west]
  @valid_instruction ["L", "R", "A"]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create, do: create(:north, {0, 0})

  def create(direction, _position) when direction not in @valid_direction do
    {:error, "invalid direction"}
  end

  def create(direction, {x, y} = position) when is_integer(x) and is_integer(y) do
    {:ok, robot} = Agent.start_link(fn -> %{direction: direction, position: position} end)
    robot
  end

  def create(_direction, _position) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    String.graphemes(instructions)
    |> do_simulate(robot)
  end

  defp do_simulate([instruction | _rest], _robot) when instruction not in @valid_instruction do
    {:error, "invalid instruction"}
  end

  defp do_simulate([], robot), do: robot

  defp do_simulate([instruction | rest], robot) do
    process_instruction(robot, instruction)
    do_simulate(rest, robot)
  end

  defp process_instruction(robot, "R"), do: turn_right(robot)
  defp process_instruction(robot, "L"), do: turn_left(robot)
  defp process_instruction(robot, "A"), do: advance(robot)

  defp turn_right(robot), do: do_turn(robot, :right)
  defp turn_left(robot), do: do_turn(robot, :left)

  defp do_turn(robot, mode) do
    %{direction: direction} = Agent.get(robot, fn state -> state end)
    new_direction = change_direction(mode, direction)
    Agent.update(robot, fn state -> Map.put(state, :direction, new_direction) end)
  end

  defp change_direction(:right, :north), do: :east
  defp change_direction(:right, :east), do: :south
  defp change_direction(:right, :south), do: :west
  defp change_direction(:right, :west), do: :north
  defp change_direction(:left, :north), do: :west
  defp change_direction(:left, :west), do: :south
  defp change_direction(:left, :south), do: :east
  defp change_direction(:left, :east), do: :north

  defp advance(robot) do
    %{direction: direction, position: position} = Agent.get(robot, fn state -> state end)
    new_position = move(direction, position)
    Agent.update(robot, fn state -> Map.put(state, :position, new_position) end)
  end

  defp move(:north, {x, y}), do: {x, y + 1}
  defp move(:east, {x, y}), do: {x + 1, y}
  defp move(:south, {x, y}), do: {x, y - 1}
  defp move(:west, {x, y}), do: {x - 1, y}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    Agent.get(robot, fn %{direction: direction} -> direction end)
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    Agent.get(robot, fn %{position: position} -> position end)
  end
end
