# Development assistance

OpenAI Codex and cloud AI models assisted with planning, documentation, licensing research, implementation and automated verification of the counter prototype. Native rendering, synthetic interaction and AT-SPI event delivery have agent-produced evidence; physical scaling and audible screen-reader acceptance remain unverified.

## Recorded tools

- **Upstream:** [OpenAI Codex](https://github.com/openai/codex).
- **Observed CLI version:** 0.164.0 on 27 October 2026.
- **Cloud model revision:** unavailable.
- **Skill invoked:** OpenAI Docs (`openai-docs`), provided with [OpenAI Codex](https://github.com/openai/codex), accessed 27 October 2026; immutable skill revision unavailable. Used to check official CLI sandbox and approval flag documentation for the development workflow update. Installed skills do not count as use.
- **Official reference:** [Codex CLI reference](https://learn.chatgpt.com/docs/developer-commands?surface=cli), accessed 27 October 2026. Documentation establishes flag meanings, not independent verification of a running sandbox.

Local tool inventories, internal plans and session records remain Git-ignored.

## Implementation skills

Invoked for implementation and stabilization on 27 October 2026; revisions are from the retained installation provenance. Skill guidance was applied without importing upstream implementation code.

| Skill | Upstream revision | Concrete purpose |
| --- | --- | --- |
| Rust Best Practices, version 1.1.2 | [apollographql/skills](https://github.com/apollographql/skills/tree/5a62472a19f6d39abc727ffbe36e3dac7c747641), `5a62472a19f6d39abc727ffbe36e3dac7c747641` | Counter ownership, documented API, saturation tests and Clippy checks |
| Qt QML, version 1.2 | [TheQtCompanyRnD/agent-skills](https://github.com/TheQtCompanyRnD/agent-skills/tree/6845f02d41171a6df8b6e6fe225b7f5d1a6f4adf), `6845f02d41171a6df8b6e6fe225b7f5d1a6f4adf` | Native controls, layout, translation, accessibility properties and count announcement handling |
| Qt Quick Test, version 1.0 | [TheQtCompanyRnD/agent-skills](https://github.com/TheQtCompanyRnD/agent-skills/tree/6845f02d41171a6df8b6e6fe225b7f5d1a6f4adf), `6845f02d41171a6df8b6e6fe225b7f5d1a6f4adf` | QML interaction, binding, notification, focus, disabled input, larger-font layout and instance-isolation tests |

The stabilization continuation also used GDB to seed private Rust state in an isolated debug test process for the integer-limit integration check. Production state initialization and the public API were unchanged. An optional Python GObject/AT-SPI inspector supports native evidence collection and was exercised against a uniquely named consumer. It supports application-name matching when host and sandbox PID namespaces differ. Native light/dark captures, synthetic keyboard/resize probes and AT-SPI action/announcement checks were performed without changing desktop settings. Audible speech remains unverified.

## Documentation references

Consulted on 27 October 2026 for concise introductions, practical structure and contributor guidance:

- [Bane Sullivan's README guide](https://github.com/banesullivan/README/tree/2c039664a006be634cbd245f12104e8e4bb84fbb), revision `2c039664a006be634cbd245f12104e8e4bb84fbb`.
- [Make a README](https://www.makeareadme.com/).
- [README discussion on r/learnprogramming](https://www.reddit.com/r/learnprogramming/comments/vxfku6/how_to_write_a_readme/).
- [freeCodeCamp's README guide](https://www.freecodecamp.org/news/how-to-write-a-good-readme-file/), published 8 December 2021.

No guide prose or templates were copied. Web references without immutable revisions are identified by access date.

## Licensing research

The [licensing decision](DECISIONS.md#licensing) records the sources and rationale for MIT OR Apache-2.0. Standard licence texts were reproduced for the grant; no upstream implementation code or assets were imported.
