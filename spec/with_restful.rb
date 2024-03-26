# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_context 'with restful', shared_context: :metadata do
  let(:obj) { described_class.new }

  describe '#http_method_for' do
    specify do
      expect(obj.http_method_for('index')).to eq('get')
    end

    specify do
      expect(obj.http_method_for('show')).to eq('get')
    end

    specify do
      expect(obj.http_method_for('new')).to eq('get')
    end

    specify do
      expect(obj.http_method_for('edit')).to eq('get')
    end

    specify do
      expect(obj.http_method_for('create')).to eq('put')
    end

    specify do
      expect(obj.http_method_for('update')).to eq('patch')
    end

    specify do
      expect(obj.http_method_for('destroy')).to eq('delete')
    end
  end
end
