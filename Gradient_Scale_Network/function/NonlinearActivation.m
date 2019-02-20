classdef NonlinearActivation < dagnn.ElementWise

  methods
    function outputs = forward(obj, inputs, params)
        outputs{1} = 4*vl_nnsigmoid(inputs{1})-2;        
    end

    function [derInputs, derParams] = backward(obj, inputs, params, derOutputs)
        derInputs{1} = 4*vl_nnsigmoid(inputs{1},derOutputs{1});  
        derParams = {} ;
    end

    function obj = NonlinearActivation(varargin)
      obj.load(varargin) ;
    end
  end
end
