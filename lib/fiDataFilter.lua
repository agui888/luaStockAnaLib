require('math')
require('common')

function fiDataFilter( data, n )
	--FINANFILTER �����˲���
	--   n:�˲����ڼ�����n���ڼ����ڵ��𵴽�������
	--   �����ڼ����ڱ�����ߵ㣬��͵�ͱ߽�㣬������ֱ�����ӣ�����ɨ����

	local output = TableUtil.clone(data)
	
	--����ֵ��output
	if n>=#output then
		return output
	end

	for i = n+1,#output do
		--��ǰ��n�����ڵ����ݽ��д���
		max_p,max_i = Matlab.max(Matlab.arrayslice(output, i-n, i));
		max_i = max_i-1+(i-n);
		min_p,min_i = Matlab.min(Matlab.arrayslice(output, i-n, i));
		min_i = min_i-1+(i-n);
		--�������ڵ�����������֣���-��-��-�գ���-��-��-��
		if max_i < min_i then --��-��-��-��
		  for k = i-n, max_i-1 do
			  output[k] = (max_p - output[i-n])/(max_i-i+n)*(k-i+n)+output[i-n];--��ֱ�߷�����
		  end
		  for k = max_i+1, min_i-1 do
			  output[k] = (min_p - max_p)/(min_i-max_i)*(k-max_i)+max_p;
		  end
		  for k = min_i+1, i-1 do
			  output[k] = (output[i] - min_p)/(i-min_i)*(k-min_i)+min_p;
		  end
			
		else  --��-��-��-��
		  for k = i-n,min_i-1 do
			  output[k] = (min_p - output[i-n])/(min_i-i+n)*(k-i+n)+output[i-n];--��ֱ�߷�����
		  end
		  for k = min_i+1,max_i-1 do
			  output[k] = (max_p - min_p)/(max_i-min_i)*(k-min_i)+min_p;
		  end
		  for k = max_i+1,i do
			  output[k] = (output[i] - max_p)/(i-max_i)*(k-max_i)+max_p;
		  end
		end
	end
	return output
end



local data = {
	100,
	200,
	840,
	400,
	500,
	100,
	200,
	100,
	200,
	840,
	400,
	500,
	100,
	200,
	100,
	200,
	840,
	400,
	500,
	100,
	200,
	100,
	200,
	840,
	400,
	500,
	100,
	200,
	100,
	200,
	840,
	400,
	500,
	100,
	200,
	100,
	200,
	840,
	400,
	500,
	100,
	200,
	100,
	200,
	840,
	400,
	500,
	100,
	200,
	100,
	200,
	840,
	400,
	500,
	100,
	200,
	100,
	200,
	840,
	400,
	500,
	100,
	200,
	100,
	200,
	840,
	400,
	500,
	100,
	200,
	100,
	200,
	840,
	400,
	500,
	100,
	200,
	100,
	200,
	840,
	400,
	500,
	100,
	200,
	100,
	200,
	840,
	400,
	500,
	100,
	200,
	500,
}

local result = fiDataFilter(data, 20)
for _, v in ipairs(result) do
	print(result[_])
end

