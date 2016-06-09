require "dry-monads.cr/dry/monads/either"
require "../spec_helper"

Spec2.describe Dry::ResultMatcher::Matcher do
  subject { Dry::ResultMatcher::Matcher.new("result") }

  describe "#result" do
    it "must be 'result'" { expect(subject.result).to be("result") }
  end

  describe "#success" do
    context "when result is Right(T)" do
      subject { Dry::ResultMatcher::Matcher.new(Dry::Monads::Either::Right.new("a success")) }

      it "must yield" do
        @yielded = false
        subject.success do |v|
          @yielded = true
          expect(v).to eq("a success")
        end
        expect(@yielded).to be_true
      end

      it "must not yeild for #failure" do
        @yielded = false
        subject.failure do
          @yielded = true
        end
        expect(@yielded).to be_false
      end
    end
  end

  describe "#failure" do
    context "when result is Left(T)" do
      subject { Dry::ResultMatcher::Matcher.new(Dry::Monads::Either::Left.new("a failure")) }

      it "must yield" do
        @yielded = false
        subject.failure do |v|
          @yielded = true
          expect(v).to eq("a failure")
        end
        expect(@yielded).to be_true
      end

      it "must not yeild for #success" do
        @yielded = false
        subject.success do
          @yielded = true
        end
        expect(@yielded).to be_false
      end
    end
  end
end
