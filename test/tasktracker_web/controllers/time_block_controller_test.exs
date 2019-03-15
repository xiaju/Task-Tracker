defmodule TasktrackerWeb.TimeBlockControllerTest do
  use TasktrackerWeb.ConnCase

  alias Tasktracker.TimeBlocks
  alias Tasktracker.TimeBlocks.TimeBlock

  @create_attrs %{
    end: 42,
    start: 42
  }
  @update_attrs %{
    end: 43,
    start: 43
  }
  @invalid_attrs %{end: nil, start: nil}

  def fixture(:time_block) do
    {:ok, time_block} = TimeBlocks.create_time_block(@create_attrs)
    time_block
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all timeblocks", %{conn: conn} do
      conn = get(conn, Routes.time_block_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create time_block" do
    test "renders time_block when data is valid", %{conn: conn} do
      conn = post(conn, Routes.time_block_path(conn, :create), time_block: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.time_block_path(conn, :show, id))

      assert %{
               "id" => id,
               "end" => 42,
               "start" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.time_block_path(conn, :create), time_block: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update time_block" do
    setup [:create_time_block]

    test "renders time_block when data is valid", %{conn: conn, time_block: %TimeBlock{id: id} = time_block} do
      conn = put(conn, Routes.time_block_path(conn, :update, time_block), time_block: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.time_block_path(conn, :show, id))

      assert %{
               "id" => id,
               "end" => 43,
               "start" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, time_block: time_block} do
      conn = put(conn, Routes.time_block_path(conn, :update, time_block), time_block: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete time_block" do
    setup [:create_time_block]

    test "deletes chosen time_block", %{conn: conn, time_block: time_block} do
      conn = delete(conn, Routes.time_block_path(conn, :delete, time_block))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.time_block_path(conn, :show, time_block))
      end
    end
  end

  defp create_time_block(_) do
    time_block = fixture(:time_block)
    {:ok, time_block: time_block}
  end
end
