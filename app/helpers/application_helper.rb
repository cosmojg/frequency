module ApplicationHelper
  def title(title = nil)
    if !title.blank?
      content_for(:title) { title }
    else
      if content_for?(:title)
        title = content_for(:title)
      else
        title = params[:controller].capitalize
      end

      title
    end
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :autolink => true, :space_after_headers => true)
    return markdown.render(text).html_safe
  end

  @@smileys = { ":("    =>   'frown.png',
                ":)"    =>   'smile.png',
                ":/"    =>   'unsure.png',
                "O.o"   =>   'confused.png',
                ":D"    =>   'grin.png',
                ":P"    =>   'tongue.png',
                ":o"    =>   'gasp.png',
                ":O"    =>   'gasp.png',
                ";)"    =>   'wink.png',
                "^_^"   =>   'kiki.png',
                ":*"    =>   'kiss.png',
                "&lt;3"    =>   'heart.png',
                ":&apos;("   =>   'cry.png',
                ":3"    =>   'curlylips.png',
                "&gt;_&lt;"   =>   'grumpy.png',
                "D:"    =>   'inverse-d.png'
  }

  def add_smileys(text)
    regex = smiley_regex

    (text).gsub regex do |match|
      image_tag(image_path("smileys/" + @@smileys[match]))
    end
  end

  @@bbcode_parser = nil
  def bbcode_to_html(text)
    @@bbcode_parser ||= BBCodeParser.new
    @@bbcode_parser.convert(text)
  end

  private

  @@smiley_regex = nil
  def smiley_regex
    return @@smiley_regex unless @@smiley_regex.nil?

    # The created regex matches smileys that are surrounded by whitespace or an html tag
    smiley_regexes = @@smileys.keys.map { |smiley| "(?:%s)" % Regexp.escape(smiley) }
    regex = Regexp.new("(?<=^|>|\s|\n|\r)(%s)(?=$|<|\s|\n|\r)" % smiley_regexes.join("|"))
    @@smiley_regex = regex

    regex
  end

  # TODO: Move to a more appropriate place
  # TODO: Move rule generation to some sort of static constructor or one time thing.
  class BBCodeParser
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::UrlHelper

    def initialize()
      @rules = {}

      add_rule :b do |text|
        "<strong>#{text}</strong>"
      end

      add_rule :i do |text|
        "<em>#{text}</em>"
      end

      add_rule :u do |text|
        "<span style=underline>#{text}</span>"
      end

      add_rule :s do |text|
        "<del>#{text}</del>"
      end

      add_rule :ul do |text|
        "<ul>#{text}</ul>"
      end

      add_rule :li do |text|
        "<li>#{text}</li>"
      end

      add_rule :ol do |text|
        "<ol>#{text}</ol>"
      end

      add_rule :img, autolink: false do |text|
        "<img src=\"#{text.strip}\">"
      end

      add_rule :url, autolink: false do |text, arg|
        if text.strip == ""
          ""
        else
          link = (arg || text).gsub(" ", "%20")
          auto_link link, html: { target: "_blank" } do
            text
          end
        end
      end

      add_rule :quote do |text, arg|
        result = "<div class=quote>"
        if arg
          result += "<div class=quote-author>#{arg.strip} said:</div>"
        end
        result += "<div class=quote-body>#{text}</div>" + "</div>"
        result
      end
    end

    def add_rule(name, options={}, &rule)
      name = name.to_s.downcase
      options = { autolink: true }.merge(options)
      @rules[name] = {
        options: options,
        function: rule
      }
    end

    def rule_for(tag_name)
      @rules[tag_name.to_s.downcase]
    end

    def has_tag?(tag_name)
      return @rules.key?(tag_name.to_s.downcase)
    end

    def convert(text)
      text = ERB::Util.html_escape text
      text = text.gsub("\n", "<br/>") # TODO: use <p> instead
      convert_recursive(nil, text)[0]
    end

    private

    # Parses a tag. This function is used internally
    # tag - the name of the tag that's currently being parsed
    # remainder - All of the text that comes after the tag
    # tag_argument - the argument in [tagname=arg]
    # depth - the current recursion depth
    # Returns: an array containing [converted, unparsed_remainder]
    def convert_recursive(tag, remainder, tag_argument=nil, depth=0)
      start_regex = /\[([a-zA-Z]+)(?:=([-\\\/_'`.!?,$#:()*&;%=^\w\s]+))?\]/
      end_regex = /\[\/([a-zA-Z]+)\]/
      tag_regex = Regexp.new(start_regex.to_s + "|" + end_regex.to_s)

      rule = rule_for(tag) unless tag.nil?
      autolink = rule.nil? || rule[:options][:autolink]
      tag_function = rule[:function]  unless rule.nil?

      text, next_tag, remainder = remainder.partition(tag_regex)
      text = auto_link(text, html: { target: '_blank' }) if autolink

      while not next_tag.empty?
        if next_tag.match start_regex
          # This is a nested tag
          match = next_tag.match(start_regex)
          tag_name = match[1]
          argument = match[2]
          if has_tag?(tag_name)
            result, remainder = convert_recursive(tag_name, remainder, argument, depth + 1)
            text += result
          else
            # Ignore this tag
            text += next_tag
          end
        else
          # This is a closing tag. Nil tags can't be closed
          tag_name = next_tag.match(end_regex)[1]
          if tag.nil? or tag_name.downcase != tag.downcase
            # This is a user error. We ignore this tag
            text += next_tag
          else
            # This closes this tag. Run the rule and then return
            return [tag_function.call(text, tag_argument).html_safe, remainder]
          end
        end

        prefix, next_tag, remainder = remainder.partition(tag_regex)
        prefix = auto_link(prefix, html: { target: '_blank' }) if autolink
        text += prefix
      end

      # If this tag wasn't closed, we close it ourselves
      unless tag.nil?
        return [tag_function.call(text, tag_argument).html_safe, remainder]
      end

      [text, remainder]
    end
  end
end
