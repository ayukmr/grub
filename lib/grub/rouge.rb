module Grub
  # rouge theme
  class RougeTheme < Rouge::CSSTheme
    name 'github'
    extend Rouge::HasModes

    # set light mode
    def self.light!
      mode  :dark
      mode! :light
    end

    # set dark mode
    def self.dark!
      mode  :light
      mode! :dark
    end

    # light mode
    def self.make_light!
      palette red:         '#cf222e'
      palette gray:        '#6e7781'
      palette normal:      '#24292f'
      palette cyan:        '#0550ae'
      palette blue:        '#0a3069'
      palette orange:      '#953800'
      palette magenta:     '#8250df'
      palette deleted:     '#82071e'
      palette deleted_bg:  '#e1ebe9'
      palette inserted:    '#116329'
      palette inserted_bg: '#dafbe1'
    end

    # dark mode
    def self.make_dark!
      palette red:         '#ff7b72'
      palette gray:        '#8b949e'
      palette normal:      '#c9d1d9'
      palette cyan:        '#a5d6ff'
      palette blue:        '#a5d6ff'
      palette orange:      '#ffa657'
      palette magenta:     '#d2a8ff'
      palette deleted:     '#ffdcd7'
      palette deleted_bg:  '#67060c'
      palette inserted:    '#aff5b4'
      palette inserted_bg: '#033a16'
    end

    light!

    style Generic::Emph,     fg: :magenta,  bold: true
    style Generic::Deleted,  fg: :deleted,  bg: :deleted_bg
    style Generic::Inserted, fg: :inserted, bg: :inserted_bg
    style Generic::Strong,   bold: false

    style \
      Generic::Output,
      Generic::Prompt,
      Comment::Multiline,
      Comment::Preproc,
      Comment::Single,
      Comment::Special,
      Comment, fg: :gray

    style \
      Generic::Heading,
      Generic::Subheading, fg: :cyan, bold: true

    style \
      Error,
      Generic::Error,
      Generic::Traceback,
      Keyword::Namespace,
      Keyword::Pseudo,
      Keyword, fg: :red

    style \
      Keyword::Constant,
      Keyword::Declaration,
      Keyword::Reserved,
      Keyword::Type,
      Name::Constant, fg: :orange

    style \
      Literal::Number::Float,
      Literal::Number::Hex,
      Literal::Number::Integer::Long,
      Literal::Number::Integer,
      Literal::Number::Oct,
      Literal::Number, fg: :cyan

    style \
      Literal::String::Char,
      Literal::String::Escape,
      Literal::String::Symbol,
      Literal::String::Doc,
      Literal::String::Double,
      Literal::String::Backtick,
      Literal::String::Regex,
      Literal::String::Heredoc,
      Literal::String::Interpol,
      Literal::String::Other,
      Literal::String::Single,
      Literal::String, fg: :blue

    style \
      Name::Attribute,
      Name::Class,
      Name::Decorator,
      Name::Builtin,
      Name::Tag,
      Name::Exception,
      Name::Label,
      Name::Function, fg: :magenta

    style \
      Name::Variable::Class,
      Name::Namespace,
      Name::Entity,
      Name::Builtin::Pseudo,
      Name::Variable::Global,
      Name::Variable::Instance,
      Name::Variable,
      Text::Whitespace,
      Operator::Word,
      Operator,
      Text,
      Name, fg: :normal
  end
end
