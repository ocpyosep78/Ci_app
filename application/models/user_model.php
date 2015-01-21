<?php

if (!defined('BASEPATH'))
	exit('No direct script access allowed');

class User_model extends CI_Model {

	var $TABLE = 'users';
	var $SESSION_TIMEOUT = 300; //300 secs = 5 minute

	function __construct() {
		parent::__construct();
	}

	//Get user by id
	function get_by_id($id) {
		$query = $this->db->get_where($this->TABLE, array('id' => $id), 1);
		if ($query->num_rows() > 0) {
			return $query->row_array();
		}
		return false;
	}

	//Get users username
	function get_by_username($username) {
		$query = $this->db->get_where($this->TABLE, array('username' => $username), 1);
		if ($query->num_rows() > 0) {
			return $query->row_array();
		}
		return false;
	}

	//Create a new user
	function save($data) {
		if ($this->db->insert($this->TABLE, $data)) {
			return $this->db->insert_id();
		}
		return false;
	}

	//Update an existing user
	function update($id, $data) {
		$this->db->where('id', $id);
		if ($this->db->update($this->TABLE, $data)) {
			return $this->db->affected_rows();
		}
		return false;
	}

	//Delete user
	function delete($id) {
		$this->db->where('id', $id);
		if ($this->db->delete($this->TABLE)) {
			return $this->db->affected_rows();
		}
		return false;
	}

	//--------------------------------------------------------------------------------------------------------------------
	//Create or Update session
	function set_session($user_data) {
		$this->session->set_userdata(array(
			'last_activity' => time(),
			'logged_in' => 'yes',
			'user' => $user_data
		));
		return true;
	}

	//Delete session
	function del_session() {
		$this->session->unset_userdata(array(
			'last_activity' => '',
			'logged_in' => '',
			'user' => ''
		));
		return true;
	}

	// Check if user is logged in and update session
	function is_logged_in() {
		$last_activity = $this->session->userdata('last_activity');
		$logged_in = $this->session->userdata('logged_in');
		$user = $this->session->userdata('user');

		if ($logged_in == 'yes' && ((time() - $last_activity) < $this->SESSION_TIMEOUT)) {
			$this->set_session($user);
			return true;
		} else {
			$this->del_session();
			return false;
		}
	}

	//-------------------------------------------------------------------------------------------------------------------
	// Check match password
	function check_password($password, $encrypted_password) {
		$key = $this->config->item('encryption_key');
		$decrypted_password = $this->encrypt->decode($encrypted_password, $key);

		return ($password == $decrypted_password);
	}

}
