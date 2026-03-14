# lex-cognitive-immune-memory

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Gem**: `lex-cognitive-immune-memory`

## Purpose

Models long-term immunological memory for cognitive threat recognition. Memory cells are trained records of past threats — each encounter with a known threat type produces a primary response and creates or strengthens a memory cell. Subsequent encounters trigger secondary responses that are faster and stronger than primary. Vaccination artificially installs memory cells without requiring a live encounter. Memory cells decay over time if not reinforced. Tracks threat coverage, neutralization rate, and average response speed across the cell population.

## Gem Info

| Field | Value |
|---|---|
| Gem name | `lex-cognitive-immune-memory` |
| Version | `0.1.0` |
| Namespace | `Legion::Extensions::CognitiveImmuneMemory` |
| Ruby | `>= 3.4` |
| License | MIT |
| GitHub | https://github.com/LegionIO/lex-cognitive-immune-memory |

## File Structure

```
lib/legion/extensions/cognitive_immune_memory/
  cognitive_immune_memory.rb        # Top-level require
  version.rb                        # VERSION = '0.1.0'
  client.rb                         # Client class
  helpers/
    constants.rb                    # Threat types, cell types, activation thresholds, response speeds, labels
    memory_cell.rb                  # MemoryCell value object
    immune_memory_engine.rb         # Engine: cells, vaccination, encounters, decay, coverage
  runners/
    cognitive_immune_memory.rb      # Runner module
```

## Key Constants

| Constant | Value | Meaning |
|---|---|---|
| `MAX_MEMORY_CELLS` | 500 | Memory cell cap |
| `T_CELL_ACTIVATION_THRESHOLD` | 0.5 | Strength threshold for T-cell activation |
| `B_CELL_ACTIVATION_THRESHOLD` | 0.4 | Strength threshold for B-cell activation |
| `T_CELL_BOOST` | 0.15 | Strength increase per encounter for T-cells |
| `B_CELL_BOOST` | 0.12 | Strength increase per encounter for B-cells |
| `PRIMARY_RESPONSE_SPEED` | 0.3 | Baseline response speed for primary encounter |
| `SECONDARY_RESPONSE_SPEED` | 0.8 | Elevated response speed for known threats |
| `VACCINATION_STRENGTH` | 0.5 | Starting strength for vaccinated cells |
| `THREAT_TYPES` | array | `[:manipulation, :deception, :coercion, :exploitation, :distraction, :flooding, :anchoring, :mirroring]` |
| `CELL_TYPES` | array | `[:t_cell, :b_cell, :memory_t, :memory_b, :natural_killer]` |
| `IMMUNITY_LABELS` | hash | `immune` (0.8+) through `naive` |
| `RESPONSE_SPEED_LABELS` | hash | `instant` (0.9+) through `slow` |
| `HEALTH_LABELS` | hash | `robust` through `depleted` |
| `MATURITY_LABELS` | hash | `veteran` through `naive` |

## Helpers

### `MemoryCell`

A trained immunological record for a specific threat type.

- `initialize(threat_type:, cell_type:, strength: 0.5, cell_id: nil)`
- `encounter!(boost)` — increases strength by cell-type boost; increments encounter_count; increases response_speed
- `decay!(rate)` — decreases strength, floor 0.0
- `active?` — strength >= cell-type activation threshold
- `veteran?` — encounter_count above veteran threshold
- `response_speed` — starts at PRIMARY_RESPONSE_SPEED; increases toward SECONDARY_RESPONSE_SPEED with encounters
- `to_h`

### `ImmuneMemoryEngine`

- `create_memory_cell(threat_type:, cell_type: :memory_t, strength: 0.5)` — returns `{ created:, cell_id:, cell: }` or capacity error
- `vaccinate(threat_type:)` — creates a memory cell at `VACCINATION_STRENGTH` without a live encounter
- `encounter_threat(threat_type:)` — checks for existing memory cells matching threat_type; if found, triggers secondary response (boosts all matching cells, returns fast response); if not found, triggers primary response and creates new memory cell
- `decay_all!` — decrements all cell strength values
- `secondary_response_rate` — proportion of threats that have established memory cells
- `neutralization_rate` — proportion of active (above-threshold) cells
- `average_response_speed` — mean response_speed across all cells
- `threat_coverage` — hash of threat_type -> strongest cell strength
- `overall_health` — composite score from neutralization, coverage breadth, and mean strength
- `immune_status_report` — full stats

## Runners

**Module**: `Legion::Extensions::CognitiveImmuneMemory::Runners::CognitiveImmuneMemory`

| Method | Key Args | Returns |
|---|---|---|
| `create_memory_cell` | `threat_type:`, `cell_type: :memory_t`, `strength: 0.5` | `{ success:, cell_id:, cell: }` |
| `vaccinate` | `threat_type:` | `{ success:, cell_id:, cell: }` |
| `encounter_threat` | `threat_type:` | `{ success:, response_type:, response_speed:, cells_activated: }` |
| `decay_all` | — | `{ success:, decayed: N }` |
| `immunity_for` | `threat_type:` | `{ success:, strength:, cells: }` |
| `active_cells` | `limit: 20` | `{ success:, cells: }` |
| `veteran_cells` | `limit: 10` | `{ success:, cells: }` |
| `threat_coverage` | — | `{ success:, coverage: { threat_type => strength } }` |
| `immune_status` | — | `{ success:, report: }` |

Private: `immune_memory_engine` — memoized `ImmuneMemoryEngine`. Logs via `log_debug` helper.

## Integration Points

- **`lex-cognitive-immunology`**: `lex-cognitive-immune-memory` handles long-term recognition and learned threat response. `lex-cognitive-immunology` handles live threat detection, quarantine, and inflammatory response. The two complement each other: immunology for acute response, immune-memory for durable recognition.
- **`lex-cognitive-immune-response`**: Immune response generates antibodies; immune memory stores the learned patterns. After a threat encounter in `lex-cognitive-immune-response`, a corresponding vaccination in immune-memory can install durable recognition.
- **`lex-trust`**: Low secondary_response_rate (few threats in memory) corresponds to a naive agent with undeveloped trust discrimination. High memory coverage supports more nuanced trust evaluation.

## Development Notes

- `encounter_threat` distinguishes primary vs. secondary response by whether any memory cell for the threat_type exists and is active. New memory cells are created on primary encounter regardless of capacity (up to MAX_MEMORY_CELLS).
- `vaccinate` creates a new cell at `VACCINATION_STRENGTH` each call — calling vaccinate multiple times for the same threat_type creates multiple cells.
- `decay_all!` decays all cells unconditionally. Cells that decay to 0.0 remain in the store; callers should check `active?` and prune manually.
- In-memory only.

---

**Maintained By**: Matthew Iverson (@Esity)
