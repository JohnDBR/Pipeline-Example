class Pipe
  attr_accessor :str

  def initialize
    @str = 'Hello World'
    @process = []
  end

  # --- With block syntax! ---
  def execute
    @process.each { |blk| @str = blk.call(@str) } if @process

    self
  end

  def instance_exec
    @process.each { |blk| @str = instance_eval(&blk) } if @process

    self
  end

  def s_1(&block)
    @process << block

    self
  end

  def s_2(&block)
    s_1 { "#{@str} How are you?" }
    @process << block

    self
  end

  # --- With yield syntax! ---
  def step_1
    @str = yield(@str) if block_given?

    self
  end

  def step_2
    @str = "#{yield(@str)} How are you?" if block_given?

    self
  end
end

# --- With yield syntax!

pipe = Pipe.new
# pipe.step_1 { |str| "#{str} John!" }
# pp pipe.str
# pipe.step_2 { |str| "#{str} I'm from Colombia!" }
# pp pipe.str
# pipe.step_1 { |str| pp str }
# pp pipe
#    .step_1 { |str| "#{str} John!" }
#    .step_2 { |str| "#{str} I'm from Colombia!" }
#    .str

# --- With block syntax!

pp pipe
  .s_1 { |str| "#{str} John!" }
  .s_2 { |str| "#{str} I'm from Colombia!" }
  # .s_1 { "#{@str} John!" }
  # .s_2 { "#{@str} I'm from Colombia!" }
  .str
# pp pipe.instance_exec.str
pp pipe.execute.str
