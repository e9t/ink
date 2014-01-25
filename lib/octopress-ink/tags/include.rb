module Octopress
  module Tags
    class IncludeTag < Liquid::Tag
      PLUGIN_SYNTAX = /(.+?):(\S+)/

      def initialize(tag_name, markup, tokens)
        super
        @og_markup = @markup = markup
      end

      def render(context)
        markup = Helpers::Conditional.parse(@markup, context)
        return unless markup
        markup = Helpers::Var.evaluate_ternary(markup, context)
        markup = Helpers::Path.parse(markup, context)

        include_tag = Jekyll::Tags::IncludeTag.new('include', markup, [])

        # If markup references a plugin e.g. plugin-name:include-file.html
        if markup.strip =~ PLUGIN_SYNTAX
          plugin = $1
          path = $2
          begin
            content = Plugins.include(plugin, path).read
          rescue => error
            raise IOError.new "Include failed: {% #{@tag_name} #{@og_markup}%}. The plugin '#{plugin}' does not have an include named '#{path}'."
          end
          partial = Liquid::Template.parse(content)
          context.stack {
            context['include'] = include_tag.parse_params(context)
            partial.render!(context)
          }.strip
          
        # Otherwise, use Jekyll's default include tag
        else
          include_tag.render(context).strip
        end
      end
    end
  end
end

