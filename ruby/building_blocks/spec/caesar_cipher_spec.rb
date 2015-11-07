require 'caesar_cipher'

describe "caesar_cipher" do
	context "empty string" do
		it "returns empty string" do
			expect(caesar_cipher("", 2)).to eql("")
		end
	end
	# one letter
	context "single letter no shift" do
		it "returns the same letter" do
			expect(caesar_cipher("a")).to eql("a")
		end
	end
	context "single letter shift 1" do
		it "returns the next letter" do
			expect(caesar_cipher("a", 1)).to eql("b")
		end
	end
	context "single letter shift -1" do
		it "returns the same letter" do
			expect(caesar_cipher("b", -1)).to eql("a")
		end
	end
	context "capital Z shift 1" do
		it "returns a capital A (same case)" do
			expect(caesar_cipher("Z", 1)).to eql("A")
		end
	end
	# wrapping
	context "single letter wrap z to a" do
		it "returns the same letter" do
			expect(caesar_cipher("z", 1)).to eql("a")
		end
	end
	context "single letter wrap a to z" do
		it "returns the same letter" do
			expect(caesar_cipher("a", -1)).to eql("z")
		end
	end
	context "single letter shift > 26" do
		it "still returns a letter" do
			expect(caesar_cipher("a", 26)).to eql("a")
		end
	end
	# one word
	context "one word no shift" do
		it "returns same word" do
			expect(caesar_cipher("ted")).to eql("ted")
		end
	end
	context "one word with shift" do
		it "returns shifted word" do
			expect(caesar_cipher("ted", 2)). to eql("vgf")
		end
	end
	context "two words with shift" do
		it "returns shifted word with non-letters in place" do
			expect(caesar_cipher("hello, world!", 2)).to eql("jgnnq, yqtnf!")
		end
	end
end