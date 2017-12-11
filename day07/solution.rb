require 'rb-readline'
require 'pry'

class CircusData

  attr_reader :nodes

  def initialize(file)
    @file  = file
    @nodes = {}

    load
  end

  def bottom_node
    @nodes.reject { |_, v| v.include? :parent }
  end

  def weight(node_name = :all)
    return weight(bottom_node.keys[0]) if node_name == :all

    children_names = @nodes[node_name][:children]

    if children_names.empty?
      @nodes[node_name][:weight]
    else
      children_weight = children_names.map { |cn| weight(cn) }.reduce(&:+)
      @nodes[node_name][:weight] + children_weight
    end
  end

  def unbalanced_child(node_name = :all)
    return unbalanced_child(bottom_node.keys[0]) if node_name == :all
    
    # continue here
  end

  private

  def load
    File.open(@file, 'r') do |f|
      f.each_line do |line|
        add_node(*parse_line(line))
      end
    end
  end

  def parse_line(line)
    name, weight, *children = line.scan(/\w+/)

    [name.to_sym, weight.to_i, children.map(&:to_sym)]
  end

  def add_node(name, weight, children = nil)
    if @nodes[name]
      @nodes[name].merge!({ weight: weight, children: children })
    else
      @nodes[name] = { weight: weight, children: children }
    end

    children.each do |child|
      if @nodes[child]
        @nodes[child].merge!({ parent: name })
      else
        @nodes[child] = { parent: name }
      end
    end
  end
end

cd_test = CircusData.new('test_input.txt')
p cd_test.bottom_node.keys[0] # tknk
p cd_test.weight

cd = CircusData.new('input.txt')
p cd.bottom_node.keys[0]
p cd.weight