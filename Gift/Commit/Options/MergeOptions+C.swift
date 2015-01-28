extension MergeOptions {
  /**
    Returns a C struct initialized with this options instance's values.
    Used by libgit2 functions.
  */
  internal var cOptions: git_merge_options {
    return git_merge_options(
      version: 1,
      flags: git_merge_tree_flag_t(GIT_MERGE_TREE_FIND_RENAMES.value),
      rename_threshold: renameThreshold,
      target_limit: renameTargetLimit,
      metric: nil,
      file_favor: git_merge_file_favor_t(strategy.rawValue)
    )
  }
}
