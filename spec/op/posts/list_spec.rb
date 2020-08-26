RSpec.describe "List posts operation" do 
  describe "with empty params variable" do
    before { @signal, (@ctx, _) = Op::Posts::List.(params:{}) }

    it "shoud fail with invalid signal" do
      expect(@signal.to_h[:semantic]).to eq(:invalid)
    end

    it "shoud return errors hash in ctx" do
      expect(@ctx[:errors]).to be_an_instance_of(Hash)
    end
  end

  describe "with wrong params variable" do
    before { @signal, (@ctx, _) = Op::Posts::List.(params:{count: 'string'}) }
    
    it "shoud fail with invalid signal" do
      expect(@signal.to_h[:semantic]).to eq(:invalid)
    end

    it "shoud return errors hash in ctx" do
      expect(@ctx[:errors]).to be_an_instance_of(Hash)
    end

    it "error hash should include :count key" do
      expect(@ctx[:errors][:count]).to be_an_instance_of(Array)
    end
  end

  describe "with normal params variable and empty post table" do
    before { @signal, (@ctx, _) = Op::Posts::List.(params:{count: 10}) }

    it "should return empty array model in ctx" do
      expect(@ctx[:model]).to be_an_instance_of(Array)
    end
  end

  describe "with normal params variable and filled post table" do
    before do
      create(:post)
      @signal, (@ctx, _) = Op::Posts::List.(params:{count: 10}) 
    end

    it "should return array model in ctx" do
      expect(@ctx[:model]).to be_an_instance_of(Array)
    end

    it "should include one post in ctx[:model]" do
      expect(@ctx[:model].length).to be(1)
    end

    it "should have params" do
      expect(@ctx[:model].first.attributes).to include('id', 'title', 'content', 'author_ip', 'rate', 'login')
    end
  end
end