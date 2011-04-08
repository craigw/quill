module ApplicationHelper
  def start_session
    @application = Quill::Application.new :input => StringIO.new,
      :output => StringIO.new
    @application_thread = Thread.new do
      Thread.abort_on_exception = true
      @application.run
    end
  end

  def quit_session
    enter_command :quit
  end

  def enter_command command
    raise "You need to start the application" unless @application
    command_string = command.to_s
    delta = -(command_string.length + 1)
    input.puts command_string
    input.seek delta, IO::SEEK_CUR
    sleep 0.25
  end

  def input
    @application.input
  end

  def output
    @application.output
  end

  def terminated
    raise "You need to start the application" unless @application
    @application_thread.status == false
  end
end

World(ApplicationHelper)
