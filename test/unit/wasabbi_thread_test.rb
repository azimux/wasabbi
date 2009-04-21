$:.unshift 'test'
require 'test_helper'

class WasabbiThreadTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "can get to general forum via norms thread" do
    id1 = WasabbiThread.find(wasabbi_threads(:norms_thread).id).forum.id
    assert id1

    assert_equal id1, wasabbi_forums(:general_forum).id
  end

  test "move" do
    thread = WasabbiThread.find(wasabbi_threads(:norms_thread).id)

    tle = thread.thread_list_entries.select {|t|t.moved_to}

    assert tle.empty?

    new_forum = WasabbiForum.find(wasabbi_forums(:football).id)
    thread.move_to(new_forum)

    tle = thread.thread_list_entries.select {|t|t.moved_to}
    assert !tle.empty?
    assert tle.size == 1
    assert tle[0].moved_to == new_forum
    assert_not_nil tle[0].moved_to

    tle = thread.thread_list_entries.select {|t|!t.moved_to}
    assert !tle.empty?
    assert tle.size >= 1
    tle.each do |t|
      assert_nil t.moved_to
    end
  end

  test "bump" do
    forum = WasabbiForum.find(wasabbi_forums(:general_forum).id)

    pre = forum.thread_list_entries
    last = pre.last

    assert_equal last.thread.id, wasabbi_threads(:norms_thread).id

    forum.reload

    assert_equal pre, forum.thread_list_entries
    assert pre.size >= 2

    forum.thread_list_entries.last.thread.bump!
    forum.reload

    assert_not_equal pre, forum.thread_list_entries
    assert_equal last, forum.thread_list_entries.first
  end

  test "bump threads" do
    forum = WasabbiForum.find(wasabbi_forums(:general_forum).id)

    pre = forum.threads
    last = pre.last

    assert_equal last.id, wasabbi_threads(:norms_thread).id

    forum.reload

    assert_equal pre, forum.threads
    assert pre.size >= 2

    forum.threads.last.bump!
    forum.reload

    assert_not_equal pre, forum.threads
    assert_equal last, forum.threads.first
  end
end
