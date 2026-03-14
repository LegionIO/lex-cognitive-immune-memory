# lex-cognitive-immune-memory

Long-term cognitive threat recognition engine for brain-modeled agentic AI in the LegionIO ecosystem.

## What It Does

Models immunological memory for cognitive security. Memory cells are trained records of past threat encounters — manipulation, deception, coercion, exploitation, and related adversarial patterns. Encountering a known threat triggers a fast secondary response (response speed 0.8); encountering an unknown threat triggers a slower primary response (0.3) and installs a new memory cell. Vaccination artificially creates memory cells without a live encounter. Memory cells decay over time without reinforcement.

## Usage

```ruby
require 'legion/extensions/cognitive_immune_memory'

client = Legion::Extensions::CognitiveImmuneMemory::Client.new

# Vaccinate against a known threat pattern
client.vaccinate(threat_type: :manipulation)
# => { success: true, cell_id: "...", cell: { strength: 0.5, response_speed: 0.3, ... } }

# Encounter a threat — secondary response since vaccination installed a cell
client.encounter_threat(threat_type: :manipulation)
# => { success: true, response_type: :secondary, response_speed: 0.65, cells_activated: 1 }

# Encounter an unknown threat — primary response, installs new memory cell
client.encounter_threat(threat_type: :anchoring)
# => { success: true, response_type: :primary, response_speed: 0.3, cells_activated: 0 }

# Check coverage across all known threats
client.threat_coverage
# => { success: true, coverage: { manipulation: 0.62, anchoring: 0.5, ... } }

# Overall immune health
client.immune_status
# => { success: true, report: { cell_count: 2, health: 0.55, ... } }
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
