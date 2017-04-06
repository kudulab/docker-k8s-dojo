require_relative './spec_helper'
require 'English'
require 'open3'

context 'operations' do

  before :all do
    generate_idefiles()
  end

  after :all do
    rm_idefiles()
  end

  context 'when full identity' do
    it 'is correctly initialized; pwd shows /ide/work' do
      cmd = "cd #{test_ide_work} && ide \"pwd && whoami\""

      output, exit_status = run_cmd(cmd)

      expect(output).to include('ide init finished')
      expect(output).to include('/ide/work')
      expect(output).to include('ide')
      expect(output).to include('using k8s-ide')
      expect(output).not_to include('root')
      expect(exit_status).to eq 0
    end
    it 'correct kubectl version is installed' do
      cmd = "cd #{test_ide_work} && ide \"kubectl version\""

      output, exit_status = run_cmd(cmd)

      expect(output).to include('1.5.3')
      expect(exit_status).to eq 0
    end
    it 'Remote Kubernetes cluster is accessible' do
      cmd = "cd #{test_ide_work} && ide \"kubectl cluster-info\""

      output, exit_status = run_cmd(cmd)

      expect(output).to include('Kubernetes master')
      expect(output).to include('http://k8s.ai-traders.com:8080')
      expect(exit_status).to eq 0
    end
    it 'correct Helm version is installed' do
      cmd = "cd #{test_ide_work} && ide \"helm version\""

      output, exit_status = run_cmd(cmd)

      expect(output).to include('2.2.3')
      expect(exit_status).to eq 0
    end
    it 'Helm was correctly initialized' do
      cmd = "cd #{test_ide_work} && ide \"ls -la /home/ide\""

      output, exit_status = run_cmd(cmd)

      expect(output).to include('.helm')
      expect(exit_status).to eq 0
    end
    it 'ssh client is installed' do
      cmd = "cd #{test_ide_work} && ide \"ssh\""

      output, exit_status = run_cmd(cmd)

      expect(output).to include('usage: ssh')
      expect(exit_status).to eq 255
    end
  end
end
