RSpec.describe "Create posts operation" do 
  describe "with empty params" do
    before { @signal, (@ctx, _) = Op::Posts::New.(params:{}) }

    it "shoud return invalid signal" do
      expect(@signal.to_h[:semantic]).to eq(:invalid)
    end

    it "shoud return errors hash in ctx" do
      expect(@ctx[:errors]).to be_an_instance_of(Hash)
    end
  end

  describe "with valid params" do
    before do
      @params = {
        "title": Faker::Lorem.word,
        "content": Faker::Lorem.sentence(word_count: rand(100)),
        "author_ip": Faker::Internet.ip_v4_address,
        "login": Faker::Name.first_name
      }
      @signal, (@ctx, _) = Op::Posts::New.(params: @params) 
    end

    it "shoud return success signal" do
      expect(@signal.to_h[:semantic]).to eq(:success)
    end

    it "model should have ['id', 'title', 'content', 'author_ip', 'login']" do
      expect(@ctx[:model].attributes).to include('id', 'title', 'content', 'author_ip', 'login')
    end

  end
end
