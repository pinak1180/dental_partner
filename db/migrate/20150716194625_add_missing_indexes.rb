class AddMissingIndexes < ActiveRecord::Migration
      def change
        add_index :votes, ["votable_id", "votable_type"]
        add_index :votes, ["voter_id", "voter_type"]
        add_index :response_details, :question_id
        add_index :response_details, :answer_id
        add_index :response_details, :response_id
        add_index :responses, :survey_id
        add_index :questions, :survey_id
        add_index :media_files, ["fileable_id", "fileable_type"]
        add_index :comments, ["commentable_id", "commentable_type"]
        add_index :ckeditor_assets, ["assetable_id", "assetable_type"]
        add_index :authentication_tokens, :user_id
        add_index :answers, :question_id
        add_index :views, :user_id
      end
    end
