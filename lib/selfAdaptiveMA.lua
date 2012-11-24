require('math')
require('lib/common')

function selfAdaptiveMA( data, N, fastLen, showLen )
	--%SELFADAPTIVEMA 自适应均线
	--%   
	fastLen = fastLen or 2
	slowLen = slowLen or 10
	local fast = 2 / (fastLen + 1)
	local slow = 2 / (slowLen + 1)
	local numRow = #data;
	local output = {}
	output [numRow] = 0

	--%output(1) = data(1);

	for i = 1,N do
		output[i] = Matlab.sum(Matlab.arrayslice(data, 1, i)) / i;
	end

	for i = N+1,numRow do
		local dir = math.abs(data[i]-data[i-N]);
		local volatility = 0;
		for k = i-N+1,i do
			volatility = volatility + math.abs(data[k]-data[k-1]);
		end
		local er = dir/volatility;
		local sc = er*(fast - slow) + slow;
		local c = sc*sc;
		output[i] = output[i-1] + c * (data[i]-output[i-1]);
		
	end
	return output
end
