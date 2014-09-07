class AddIndexesOnIdeas < ActiveRecord::Migration
  def change
    execute "
    create index on ideas using gin(to_tsvector('english', title));
    create index on ideas using gin(to_tsvector('english', materials));
    create index on ideas using gin(to_tsvector('english', tags));
    create index on ideas using gin(to_tsvector('english', description));"
  end
end
