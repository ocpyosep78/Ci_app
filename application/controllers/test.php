<?php

if (!defined('BASEPATH'))
	exit('No direct script access allowed');

class Test extends CI_Controller {

	function __construct() {
		parent::__construct();
		$this->load->model('user_model', 'user');
	}

	public function get_by_id() {
		$id = $this->input->post('id');

		var_dump($this->user->get_by_id($id));
	}

	public function get_by_username() {
		$username = $this->input->post('username');

		var_dump($this->user->get_by_username($username));
	}

	public function save() {
		$data = array(
			'username' => $this->input->post('username'),
			'password' => $this->input->post('password'),
			'email' => $this->input->post('email'),
			'fullname' => $this->input->post('fullname')
		);


		var_dump($this->user->save($data));
	}

	public function update() {
		$data = array(
			'username' => $this->input->post('username'),
			'password' => $this->input->post('password'),
			'email' => $this->input->post('email'),
			'fullname' => $this->input->post('fullname')
		);
		$id = $this->input->post('id');

		var_dump($this->user->update($id, $data));
	}

	public function delete() {
		$id = $this->input->post('id');
		var_dump($this->user->delete($id));
	}

	public function set_session() {
		$id = $this->input->post('id');
		$user_data = array(
			'name'		=> $this->input->post('name'),
			'profile'	=> $this->input->post('profile')
		);
		var_dump($this->user->set_session($id, $user_data));
	}

	public function del_session() {
		var_dump($this->user->del_session());
	}
	public function is_logged_in() {
		var_dump($this->user->is_logged_in());
	}	
	
	public function check_password(){
		$password	=  $this->input->post('password');
		$password1	= $this->input->post('password1');
		
		$key = $this->config->item('encryption_key');
		$encrypted_password = $this->encrypt->encode($password1, $key);
		
		var_dump($this->user->check_password($password,$encrypted_password));
	}

}
