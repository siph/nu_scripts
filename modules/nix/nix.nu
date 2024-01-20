# Search nixpkgs and provide table output
export def ns [
    term: string # Search target.
] {
    nix search --json nixpkgs $term
        | from json
        | transpose package description
        | flatten
        | select package description version
        | update package {|row| $row.package | str replace $"legacyPackages.($nu.os-info.arch)-($nu.os-info.name)." ""}
}
