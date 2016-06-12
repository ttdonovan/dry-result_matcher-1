require "../spec_helper"

Spec2.describe "Integration: Dry::ResultMatcher" do
  describe "external matching" do
    subject(match) {
      Dry::ResultMatcher.match(result) do |m|
        m.success do |v|
          return "Matched success: #{v}"
        end

        m.failure do |v|
          return "Matched failure: #{v}"
        end
      end
    }

    describe "successful result" do
      let(result) { Dry::Monads::Either::Right.new("a success") }

      it "matches on success" do
        expect(match).to eq "Matched success: a success"
      end
    end

    describe "failed result" do
      let(result) { Dry::Monads::Either::Left.new("a failure") }

      it "matches on failure" do
        expect(match).to eq "Matched failure: a failure"
      end
    end
  end
end
