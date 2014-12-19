

require_relative 'sqlspecificparser'
require 'test/unit'

class TestSqlSpecificParser < Test::Unit::TestCase

  def test_parse1()
    sql = "select 1 as X"
    parsed = instance().parse(sql, "X")
    assert_equal("1", parsed)


    sql = "select ((1)) as X"
    parsed = instance().parse(sql, "X")
    assert_equal("((1))", parsed)

    sql = "select ((1)) X"
    parsed = instance().parse(sql, "X")
    assert_equal("((1))", parsed)
  end

  def test_parse2()
    sql = "select (select X from (SELECT 2 as X) as T) as POD_ZAPYTANIE"
    parsed = instance().parse(sql, "POD_ZAPYTANIE")
    assert_equal("(select X from (SELECT 2 as X) as T)", parsed)
  end

  def test_parse3()
    sql = "select (select X+Y from (SELECT 2 as X, 3 as Y) as T) as POD_ZAPYTANIE"
    parsed = instance().parse(sql, "POD_ZAPYTANIE")
    assert_equal("(select X+Y from (SELECT 2 as X, 3 as Y) as T)", parsed)
  end

  def test_parse4()

    sql = "select 
      1 as TX1,
      (select X+Y from (SELECT 2 as X, 3 as Y) as T) as Tx2"
    parsed = instance().parse(sql, "Tx2")
    assert_equal("(select X+Y from (SELECT 2 as X, 3 as Y) as T)", parsed)

    sql = "select 
      1 as TX1,
      (select X+Y from (SELECT 2 as X, 3 as Y) as T) as Tx2,
      2 as Tx3"
    parsed = instance().parse(sql, "Tx2")
    assert_equal("(select X+Y from (SELECT 2 as X, 3 as Y) as T)", parsed)

  end  

  def test_parse5()
    sql = "Select 1 as X, 2 as Y"
    parsed = instance().parse(sql, "Z")
    assert_equal("", parsed)
  end

  def instance()
    return SqlSpecificParser.new
  end
end

