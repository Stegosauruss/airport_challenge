require 'airport'
describe Airport do
  it 'planes can land at airport' do
    expect(subject).to respond_to :land
  end

  it 'planes can take off from airport' do
    expect(subject).to respond_to :take_off
  end

  it 'when a plane takes off there should be one less plane in the airport' do
    subject.land(Plane.new)
    subject.take_off
    expect(subject.planes.count).to eq(0)
  end

  it 'there should be a method to set the weather at the airport' do
    expect(subject).to respond_to :weather
  end

  it 'A plane should not take off if weather is stormy' do
    subject.weather("stormy")
    expect{subject.take_off}.to raise_error("cannot take off while weather is stormy")
  end

  it 'A plane should not land when weather is stormy' do
    subject.weather("stormy")
    expect{subject.land(Plane.new)}.to raise_error("cannot land while weather is stormy")
  end

  it 'when a plane tries to land in a full airport' do
    10.times{subject.land(Plane.new)}
    expect{subject.land(Plane.new)}.to raise_error("cannot land while airport is full")
  end

  it 'when setting the capacity of an airport' do
    heathrow = Airport.new(30)
    30.times{heathrow.land(Plane.new)}
    expect{heathrow.land(Plane.new)}.to raise_error("cannot land while airport is full")
  end

  it 'when attempting to take off a plane which is already in transit' do
    plane = Plane.new
    plane.location = "in transit"
    subject.land(plane)
    expect{subject.take_off}.to raise_error 'cannot take off while plane is in transit'
  end
end