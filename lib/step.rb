require 'erector'
require 'big_checkbox'
require 'erector_scss'
require 'markdown_renderer'
require 'titleizer'
require 'active_support/core_ext/string/strip'
require 'erb'

class Step < Erector::Widget
  needs :src
  needs :doc_path
  needs :container_page_name => false
  needs :step_stack => false

  def initialize options
    super
    @step_stack = options[:step_stack] || []
  end

  def next_step_number
    @step_stack << 0 if @step_stack.empty?
    @step_stack[-1] = @step_stack.last + 1
    @step_stack.join('.')
  end

  def prefix s
    span s, :class => "prefix"
  end

  def current_anchor_num
    nested_steps = @step_stack.dup
    nested_steps.pop if nested_steps.last == 0
    nested_steps.join("-")
  end

  # todo: move into proper Doc class
  def page_name
    @container_page_name || @doc_path.split('/').last.split('.').first
  end

  def insert file
    # todo: unify into common 'find & process a document file' unit
    dir = File.dirname(@doc_path)

    possible_paths = ['step', 'md'].each_with_object([]) do |ext, paths|
      paths << File.join(dir, "#{file}.#{ext}")
      path_dir, path_file = file.match(%r{(.*/)?(.*)}).captures
      paths << File.join(dir, "#{path_dir}_#{path_file}.#{ext}")
    end

    possible_paths.each do |path|
      if File.exist?(path)
        src = File.read(path)
        if path.end_with?('.step')
          step = Step.new(src: src, doc_path: path, container_page_name: page_name, step_stack: @step_stack)
          return widget step
        else
          return message src
        end
      end
    end

    raise "Couldn't find a partial for #{file}! Searched in #{possible_paths}"
  end

  ## steps

  %w[
    steps explanation overview discussion hints challenge
    tools_and_references requirements
  ].each do |type|
    define_method type.to_sym do |&block|
      div :class => type do
        h1 I18n.t(type, :scope => "header_section")
        blockquote do
          block.call if block
        end
      end
    end
  end

  def step name = nil, options = {}, &block
    num = next_step_number
    a(:name => "step#{current_anchor_num}")
    a(:name => options[:anchor_name]) if options[:anchor_name]
    div :class => "step", :title => name do
      h1 do
        widget BigCheckbox
        prefix I18n.t("general.step_title", :num => num) +
              (!name.nil? ? I18n.t("general.step_title_suffix") : '')
        text name
      end
      _render_inner_content(&block) if block_given?
    end
  end


  def link name, options = {}
    options = {caption: I18n.t("captions.link")}.merge(options)
    p :class => "link" do
      text options[:caption]
      text " "
      simple_link(name, class: :link)
    end
  end

  def link_without_toc name
    link name
  end

  def _escaped str
    ERB::Util.u(str)
  end

  def simple_link name, options={}
    require 'uri'
    href = "#{_escaped(name)}?back=#{_escaped(page_name)}"
    if @step_stack.length > 1
      href += URI.escape('#') + "step#{current_anchor_num}"
    end
    if block_given?
      a({:href => href}.merge(options)) do
        yield
      end
    else
      a Titleizer.title_for_page(name), {:href => href}.merge(options)
    end
  end

  def next_step name
    div :class => "step next_step" do
      h1 do
        prefix I18n.t("general.next_step")
      end
      # FIXME: Translate with i18n. Currently it is hard to get site_name.
      link name
    end
  end

  def situation name, &block
    h1 name
    _render_inner_content(&block) if block_given?
  end

  def option name, &block
    num = next_step_number
    a(:name => "step#{current_anchor_num}")
    h1 :class => "option" do
      span I18n.t("general.option", :num => num)
      text name
    end
    _render_inner_content(&block) if block_given?
  end

  def option_half title
    div class: 'half-width' do
      strong title
      yield
    end
  end
  alias_method :half_width, :option_half

  def section text
    div do
      h1 text
      blockquote do
        yield
      end
    end
  end

  def verify text = nil
    div :class=> "verify" do
      h1 I18n.t("general.verify", :text => text)
      blockquote do
        yield
      end
    end
  end

  def goals
    div :class => "goals" do
      h1 I18n.t("general.goals")
      ul do
        yield
      end
    end
  end

  def goal *args
    li do
      message *args
    end
  end

  def site_desc site_name, description
    div class: 'site-desc' do
      h2 do
        a href: "/#{site_name}" do
          text Titleizer.title_for_page(site_name)
        end
      end
      div raw(md2html description)
    end
  end

  ## message

  def message text = nil, options = {}
    text = text.strip_heredoc if text
    classes = (["message"] + [options[:class]]).compact
    div :class => classes do
      i :class => "fa fa-#{options[:icon]} fa-3x" if options[:icon]
      if options[:inner_class]
        div class: options[:inner_class] do
          unless text.nil?
            text = "**#{text}**" if block_given?
            rawtext(md2html text)
          end
          yield if block_given?
        end
      else
        rawtext(md2html text) unless text.nil?
        yield if block_given?
      end
    end
  end
  alias_method :markdown, :message

  def important text = nil, &block
    message text, class: "important vertical-centerer", inner_class: "vertically-centered", icon: "exclamation-circle", &block
  end

  def tip text = nil, &block
    message text, class: "tip vertical-centerer", inner_class: "vertically-centered", icon: "info-circle", &block
  end

  def discussion_box(title, content)
    div class: "discussion_box" do
      h4 "Discussion: #{title}"
      hr
      message content
    end
  end

  def error_box(error)
    div class: "error_box" do
      h4 "Error! Woo!!!"
      p error
    end
  end

  def cloud9_instruction
    p do
      i :class => "fa fa-cloud"
      span " For Cloud9:"
      yield if block_given?
    end
  end

  ## special

  def console(commands)
    console_with_message(I18n.t('captions.terminal'), commands)
  end

  def console_with_message(msg, commands)
    div class: "console terminal" do
      message(msg)
      div class: "wrapper" do
        span "Terminal", class: "label"
        pre commands.strip_heredoc
      end
    end
  end

  def console_without_message(commands)
    console_with_message("", commands)
  end

  def source_code_with_message(text, *args)
    message(text)
    source_code(*args)
  end

  def irb commands
    irb_with_message(I18n.t("captions.irb"), commands)
  end

  def irb_with_message msg, commands
    div class: "console irb" do
      message(msg)
      div class: "wrapper" do
        span "IRB", class: "label"
        pre commands.strip_heredoc
      end
    end
  end

  def irb_without_message commands
    irb_with_message('', commands)
  end

  def type_in_file filename, msg
    div do
      span I18n.t("general.type_in_file", :filename => filename)
      source_code :ruby, msg
    end
  end

  def further_reading
    div :class => "further-reading" do
      h1 I18n.t("general.further_reading")
      blockquote do
        yield
      end
    end
  end

  def result text
    div :class => "result" do
      span I18n.t("captions.result")
      pre text.strip_heredoc
    end
  end

  def fuzzy_result fuzzed_text
    fuzzed_text = fuzzed_text.strip_heredoc
    div :class => "result fuzzy-result" do
      span I18n.t("captions.fuzzy_result")
      remaining_text = fuzzed_text
      pre do
        while match = remaining_text.match(/(.*?)\{FUZZY}(.*?)\{\/FUZZY}(.*)/m)
          text match[1]
          span match[2], :class => 'fuzzy-lightened'
          remaining_text = match[3]
        end
        text remaining_text
      end
      div I18n.t("general.fuzzy_hint"), :class => 'fuzzy-hint'
    end
  end

  def content
    eval @src, binding, @doc_path, 1
  end

  def source_code *args
    src = args.pop.strip_heredoc
    lang = args.pop
    src = "\n:::#{lang}\n#{src}" if lang
    pre src, :class => "code"
  end

  def md2html text
    MarkdownRenderer.render(text)
  end

  def model_diagram options
    header = options.delete(:header)
    fields = options.delete(:fields)
    table(options.merge(class: 'model-diagram')) do
      thead do
        tr do
          th header
        end
      end
      tbody do
        fields.each do |field|
          tr do
            td field
          end
        end
      end
    end
  end

  def js_expected_results(lesson)
    h3 'Expected Results'

    h4 'What your snake.js file should look like:'

    src_path = File.join(File.dirname(@doc_path), 'js', "#{lesson}.js")

    source_code :js, File.read(src_path)

    h4 'How the game should work:'

    canvas id: 'chunk-game', height: '600', width: '800'

    script src: 'js/chunk.js'

    script src: "js/#{lesson}.js"
  end

  private

  def _render_inner_content(&block)
    blockquote do
      @step_stack.push 0
      yield(block)
      @step_stack.pop
    end
  end
end
