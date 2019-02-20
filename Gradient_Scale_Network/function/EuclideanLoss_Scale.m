classdef EuclideanLoss_Scale < dagnn.Loss

  methods
    function outputs = forward(obj, inputs, params)
        c = inputs{2};
        c1 = c(:,:,1:end/2,:);
        c2 = c(:,:,end/2+1:end,:);
        
        delta = c1 - inputs{1}.*c2;
        outputs{1} = sum(delta(:).^2);                           
        obj.accumulateAverage(inputs, outputs);
    end
    
    function accumulateAverage(obj, inputs, outputs)
      if obj.ignoreAverage, return; end
      n = obj.numAveraged;
      m = n + size(inputs{1}, 1) *  size(inputs{1}, 2) * size(inputs{1}, 4);
      obj.average = bsxfun(@plus, n * obj.average, gather(outputs{1})) / m;
      obj.numAveraged = m;
    end

    function [derInputs, derParams] = backward(obj, inputs, params, derOutputs)
        c = inputs{2};
        c1 = c(:,:,1:end/2,:);
        c2 = c(:,:,end/2+1:end,:);
        delta = c1 - inputs{1}.*c2;
        
        derInputs{1} = -2*c2.*delta*derOutputs{1};
        derInputs{2} = [];
        derParams = {};
    end

    function obj = EuclideanLoss_Scale(varargin)
      obj.load(varargin) ;
    end
  end
end
