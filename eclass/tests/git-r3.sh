#!/bin/bash

source tests-common.sh

inherit git-r3

testdir=${pkg_root}/git
mkdir "${testdir}" || die "unable to mkdir testdir"
cd "${testdir}" || die "unable to cd to testdir"

EGIT3_STORE_DIR=store
mkdir "${EGIT3_STORE_DIR}" || die "unable to mkdir store"

# 1) Test cleaning up canonical repo URI
test_repouri() {
	local uri=${1}
	local expect=${2}
	local -x GIT_DIR

	tbegin "GIT_DIR for ${uri}"

	_git-r3_set_gitdir "${uri}" &>/dev/null
	local got=${GIT_DIR#${EGIT3_STORE_DIR}/}

	[[ ${expect} == ${got} ]]
	tend ${?} || eerror "Expected: ${expect}, got: ${got}"
}

test_repouri git://git.overlays.gentoo.org/proj/portage.git proj_portage.git
test_repouri https://git.overlays.gentoo.org/gitroot/proj/portage.git proj_portage.git
test_repouri git+ssh://git@git.overlays.gentoo.org/proj/portage.git proj_portage.git

test_repouri git://anongit.freedesktop.org/mesa/mesa mesa_mesa.git
test_repouri ssh://git.freedesktop.org/git/mesa/mesa mesa_mesa.git
test_repouri http://anongit.freedesktop.org/git/mesa/mesa.git mesa_mesa.git
test_repouri http://cgit.freedesktop.org/mesa/mesa/ mesa_mesa.git

test_repouri https://code.google.com/p/snakeoil/ snakeoil.git

test_repouri git://git.code.sf.net/p/xournal/code xournal_code.git
test_repouri http://git.code.sf.net/p/xournal/code xournal_code.git

test_repouri git://git.gnome.org/glibmm glibmm.git
test_repouri https://git.gnome.org/browse/glibmm glibmm.git
test_repouri ssh://USERNAME@git.gnome.org/git/glibmm glibmm.git

test_repouri git://git.kernel.org/pub/scm/git/git.git git_git.git
test_repouri http://git.kernel.org/pub/scm/git/git.git git_git.git
test_repouri https://git.kernel.org/pub/scm/git/git.git git_git.git
test_repouri https://git.kernel.org/cgit/git/git.git/ git_git.git

#test_repouri git@github.com:gentoo/identity.gentoo.org.git gentoo_identity.gentoo.org.git
test_repouri https://github.com/gentoo/identity.gentoo.org.git gentoo_identity.gentoo.org.git

#test_repouri git@bitbucket.org:mgorny/python-exec.git mgorny_python-exec.git
test_repouri https://mgorny@bitbucket.org/mgorny/python-exec.git mgorny_python-exec.git


# 2) real repo tests
test_file() {
	local message=${1}
	local fn=${2}
	local expect=${3}

	tbegin "${message}"
	if [[ ! -f ${fn} ]]; then
		tend 1
		eerror "${fn} does not exist (not checked out?)"
	else
		local got=$(<"${fn}")

		if [[ ${got} != ${expect} ]]; then
			tend 1
			eerror "${fn}, expected: ${expect}, got: ${got}"
		else
			tend 0
			return 0
		fi
	fi
	return 1
}

test_repo_clean() {
	(
		mkdir repo
		cd repo
		git init -q
		echo test > file
		git add file
		git commit -m 1 -q
		echo other-text > file
		git add file
		git commit -m 2 -q
	) || die "unable to prepare repo"

	# we need to use an array to preserve whitespace
	EGIT_REPO_URI=(
		'ext::git daemon --export-all --base-path=. --inetd %G/repo'
	)

	tbegin "fetching from a simple repo"
	( git-r3_fetch ) &> fetch.log
	if tend ${?}; then
		tbegin "checkout of a simple repo"
		( git-r3_checkout ) &>> fetch.log
		if tend ${?}; then
			test_file "results of checking out a simple repo" \
				"${WORKDIR}/${P}/file" other-text \
				&& return 0
		fi
	fi

	cat fetch.log
	return 1
}

test_repo_clean

texit
