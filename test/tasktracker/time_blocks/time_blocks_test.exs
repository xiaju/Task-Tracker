defmodule Tasktracker.TimeBlocksTest do
  use Tasktracker.DataCase

  alias Tasktracker.TimeBlocks

  describe "timeblocks" do
    alias Tasktracker.TimeBlocks.TimeBlock

    @valid_attrs %{end: 42, start: 42}
    @update_attrs %{end: 43, start: 43}
    @invalid_attrs %{end: nil, start: nil}

    def time_block_fixture(attrs \\ %{}) do
      {:ok, time_block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TimeBlocks.create_time_block()

      time_block
    end

    test "list_timeblocks/0 returns all timeblocks" do
      time_block = time_block_fixture()
      assert TimeBlocks.list_timeblocks() == [time_block]
    end

    test "get_time_block!/1 returns the time_block with given id" do
      time_block = time_block_fixture()
      assert TimeBlocks.get_time_block!(time_block.id) == time_block
    end

    test "create_time_block/1 with valid data creates a time_block" do
      assert {:ok, %TimeBlock{} = time_block} = TimeBlocks.create_time_block(@valid_attrs)
      assert time_block.end == 42
      assert time_block.start == 42
    end

    test "create_time_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeBlocks.create_time_block(@invalid_attrs)
    end

    test "update_time_block/2 with valid data updates the time_block" do
      time_block = time_block_fixture()
      assert {:ok, %TimeBlock{} = time_block} = TimeBlocks.update_time_block(time_block, @update_attrs)
      assert time_block.end == 43
      assert time_block.start == 43
    end

    test "update_time_block/2 with invalid data returns error changeset" do
      time_block = time_block_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeBlocks.update_time_block(time_block, @invalid_attrs)
      assert time_block == TimeBlocks.get_time_block!(time_block.id)
    end

    test "delete_time_block/1 deletes the time_block" do
      time_block = time_block_fixture()
      assert {:ok, %TimeBlock{}} = TimeBlocks.delete_time_block(time_block)
      assert_raise Ecto.NoResultsError, fn -> TimeBlocks.get_time_block!(time_block.id) end
    end

    test "change_time_block/1 returns a time_block changeset" do
      time_block = time_block_fixture()
      assert %Ecto.Changeset{} = TimeBlocks.change_time_block(time_block)
    end
  end
end
