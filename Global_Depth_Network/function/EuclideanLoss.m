classdef EuclideanLoss < dagnn.Loss

  methods
    function outputs = forward(obj, inputs, params)
      delta = inputs{1} - inputs{2} ;
      outputs{1} = sum(delta(:).^2) ;                                  
      obj.accumulateAverage(inputs, outputs);
    end
    
    function accumulateAverage(obj, inputs, outputs)
      if obj.ignoreAverage, return; end
      n = obj.numAveraged ;
      m = n + size(inputs{1}, 1) *  size(inputs{1}, 2) * size(inputs{1}, 4);
      obj.average = bsxfun(@plus, n * obj.average, gather(outputs{1})) / m ;
      obj.numAveraged = m ;
    end

    function [derInputs, derParams] = backward(obj, inputs, params, derOutputs)
      derInputs{1} = 2 * derOutputs{1} * (inputs{1} - inputs{2}) ;
      derInputs{2} = [] ;
      derParams = {} ;
    end

    function obj = EuclideanLoss(varargin)
      obj.load(varargin) ;
    end
  end
end
