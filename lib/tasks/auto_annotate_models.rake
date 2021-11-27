if Rails.env.development?
  task :set_annotation_options do
    # You can override any of these by setting an environment variable of the
    # same name.
    Annotate.set_defaults(
      'routes' => 'false',
      'position_in_routes' => 'after',
      'position_in_class' => 'after',
      'position_in_test' => 'after',
      'position_in_fixture' => 'after',
      'position_in_factory' => 'after',
      'position_in_serializer' => 'after',
      'show_foreign_keys' => 'true',
      'show_indexes' => 'true',
      'simple_indexes' => 'false',
      'model_dir' => 'app/models',
      'root_dir' => '',
      'include_version' => 'false',
      'require' => '',
      'exclude_tests' => 'true',
      'exclude_fixtures' => 'true',
      'exclude_factories' => 'true',
      'exclude_serializers' => 'true',
      'exclude_scaffolds' => 'true',
      'exclude_controllers' => 'true',
      'exclude_helpers' => 'false',
      'ignore_model_sub_dir' => 'false',
      'ignore_columns' => nil,
      'ignore_unknown_models' => 'false',
      'hide_limit_column_types' => 'integer,boolean',
      'skip_on_db_migrate' => 'false',
      'format_bare' => 'true',
      'format_rdoc' => 'false',
      'format_markdown' => 'false',
      'sort' => 'false',
      'force' => 'false',
      'trace' => 'false',
      'wrapper_open' => nil,
      'wrapper_close' => nil,
      'models' => true
    )
  end

  Annotate.load_tasks

  data_migrate_tasks = %w(
    db:migrate:with_data
    db:migrate:up:with_data
    db:migrate:down:with_data
    db:migrate:redo:with_data
    db:rollback:with_data
  )

  data_migrate_tasks.each do |task|
    Rake::Task[task].enhance do
      Rake::Task[Rake.application.top_level_tasks.last].enhance do
        annotation_options_task = if Rake::Task.task_defined?('app:set_annotation_options')
                                    'app:set_annotation_options'
                                  else
                                    'set_annotation_options'
                                  end
        Rake::Task[annotation_options_task].invoke
        Annotate::Migration.update_annotations
      end
    end
  end
end
