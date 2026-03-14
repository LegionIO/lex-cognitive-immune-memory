# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_immune_memory/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-cognitive-immune-memory'
  spec.version       = Legion::Extensions::CognitiveImmuneMemory::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']
  spec.summary       = 'Long-term adaptive immune memory for LegionIO agents'
  spec.description   = 'T-cell/B-cell persistent threat recognition with secondary response ' \
                       'amplification for the LegionIO cognitive architecture'
  spec.homepage      = 'https://github.com/LegionIO/lex-cognitive-immune-memory'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata = {
    'homepage_uri'          => spec.homepage,
    'source_code_uri'       => spec.homepage,
    'documentation_uri'     => "#{spec.homepage}/blob/origin/README.md",
    'changelog_uri'         => "#{spec.homepage}/blob/origin/CHANGELOG.md",
    'bug_tracker_uri'       => "#{spec.homepage}/issues",
    'rubygems_mfa_required' => 'true'
  }

  spec.files = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }
  spec.require_paths = ['lib']
end
