defmodule PolicrMini.Schema.SchemeTest do
  use ExUnit.Case

  alias PolicrMini.Factory
  alias PolicrMini.Schema.Scheme

  describe "schema" do
    test "schema metadata" do
      assert Scheme.__schema__(:source) == "schemes"

      assert Scheme.__schema__(:fields) ==
               [
                 :id,
                 :chat_id,
                 :verification_mode,
                 :verification_entrance,
                 :verification_occasion,
                 :seconds,
                 :timeout_killing_method,
                 :wrong_killing_method,
                 :is_highlighted,
                 :mention_text,
                 :image_answers_count,
                 :inserted_at,
                 :updated_at
               ]
    end

    assert Scheme.__schema__(:primary_key) == [:id]
  end

  test "changeset/2" do
    scheme = Factory.build(:scheme, chat_id: 123_456_789_011)

    updated_verification_mode = 1
    updated_verification_entrance = 0
    updated_verification_occasion = 0
    updated_seconds = 120
    updated_wrong_killing_method = :kick
    updated_is_highlighted = false

    params = %{
      "verification_mode" => updated_verification_mode,
      "verification_entrance" => updated_verification_entrance,
      "verification_occasion" => updated_verification_occasion,
      "seconds" => updated_seconds,
      "wrong_killing_method" => updated_wrong_killing_method,
      "is_highlighted" => updated_is_highlighted
    }

    changes = %{
      verification_mode: :custom,
      verification_entrance: :unity,
      verification_occasion: :private,
      seconds: updated_seconds,
      wrong_killing_method: :kick,
      is_highlighted: updated_is_highlighted
    }

    changeset = Scheme.changeset(scheme, params)
    assert changeset.params == params
    assert changeset.data == scheme
    assert changeset.changes == changes
    assert changeset.validations == []

    assert changeset.required == [
             :chat_id
           ]

    assert changeset.valid?
  end
end
