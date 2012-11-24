function sum(data)
{
	var sum = 0;
	for (var i = 0; i < data.length; ++i)
	{
		sum += data[i];
	}
	return sum;
}

function ma(data, n)
{
	var dataNum = data.length;
	var output = Array();
	var i;
	for (i = 0; i <= n; ++i){
		output[i] = sum(data.slice(0, i)) / ( i + 1);
	}
	for (i = n+1; i < dataNum; ++i){
		dir = Math.abs(data[i-1]-data[i-n-1]);
		vir = 0;
		for (var k = i - n; k < i; ++k){
			vir = vir + Math.abs(data[k - 1] - data[k - 2]);
		}
		var er = dir / vir;
		var sc = er*(2/3-2/29)+2/29;
		var c = sc*sc;
		output[i-1] = output[i-2]+c*(data[i-1]-output[i-2]);

	}
	return output
}

var ttt = Array(100, 200, 300, 400, 555, 298, 2938, 2983, 2398, 2983, 2389823, 298);
console.log(ma(ttt, 2));