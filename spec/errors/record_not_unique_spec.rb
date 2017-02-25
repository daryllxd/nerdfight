RSpec.describe Errors::RecordNotUnique do
  subject do
    Errors::RecordNotUnique.new(
      double(
        cause: double(
          message: "stuff about the error\nDETAIL: Key (team_id, match_id) already exists."
        )
      )
    )
  end

  it { should be_a_kind_of(StandardError) }

  it 'prints an error message that includes the cause and the possible cause of the cause' do
    expect(subject.message).to include 'Unique constraint'
    expect(subject.message).to include 'team_id'
    expect(subject.message).to include 'match_id'

    # It should also have a reference to the original exception
    expect(subject).to respond_to(:original_exception)
  end
end
