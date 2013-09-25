#!/bin/bash

source tests-common.sh

inherit git-r3

testdir=${pkg_root}/git
mkdir "${testdir}" || die "unable to mkdir testdir"
cd "${testdir}" || die "unable to cd to testdir"

EGIT3_STORE_DIR=store
mkdir "${EGIT3_STORE_DIR}" || die "unable to mkdir store"

test_file() {
	local fn=${1}
	local expect=${2}

	if [[ ! -f ${fn} ]]; then
		eerror "${fn} does not exist (not checked out?)"
	else
		local got=$(<"${fn}")

		if [[ ${got} != ${expect} ]]; then
			eerror "${fn}, expected: ${expect}, got: ${got}"
		else
			return 0
		fi
	fi
	return 1
}

test_no_file() {
	local fn=${1}

	if [[ -f ${fn} ]]; then
		eerror "${fn} exists (wtf?!)"
	else
		return 0
	fi
	return 1
}

test_repo_clean() {
	local repo=${FUNCNAME#test_}
	local P=${P}_${repo}

	(
		mkdir ${repo}
		cd ${repo}
		git init -q
		echo test > file
		git add file
		git commit -m 1 -q
		echo other-text > file
		git add file
		git commit -m 2 -q
	) || die "unable to prepare repo"

	# we need to use an array to preserve whitespace
	local EGIT_REPO_URI=(
		"ext::git daemon --export-all --base-path=. --inetd %G/${repo}"
	)

	tbegin "fetching from a simple repo"
	(
		git-r3_src_unpack
		test_file "${WORKDIR}/${P}/file" other-text
	) &>fetch.log

	eend ${?} || cat fetch.log
}

test_repo_revert() {
	local repo=${FUNCNAME#test_}
	local P=${P}_${repo}

	(
		mkdir ${repo}
		cd ${repo}
		git init -q
		echo test > file
		git add file
		git commit -m 1 -q
		echo other-text > file2
		git add file2
		git commit -m 2 -q
		git revert -n HEAD^
		git commit -m 3 -q
	) || die "unable to prepare repo"

	# we need to use an array to preserve whitespace
	local EGIT_REPO_URI=(
		"ext::git daemon --export-all --base-path=. --inetd %G/${repo}"
	)

	tbegin "fetching from a repo with reverted commit"
	(
		git-r3_src_unpack
		test_file "${WORKDIR}/${P}/file2" other-text \
			&& test_no_file "${WORKDIR}/${P}/file"
	) &>fetch.log

	eend ${?} || cat fetch.log
}

test_repo_merge() {
	local repo=${FUNCNAME#test_}
	local P=${P}_${repo}

	(
		mkdir ${repo}
		cd ${repo}
		git init -q
		echo test > file
		git add file
		git commit -m 1 -q
		git checkout -q -b other
		echo other-text > file2
		git add file2
		git commit -m 2 -q
		git checkout -q master
		echo some-more-text > file
		git add file
		git commit -m 3 -q
		git merge -m 4 -q other
	) || die "unable to prepare repo"

	# we need to use an array to preserve whitespace
	local EGIT_REPO_URI=(
		"ext::git daemon --export-all --base-path=. --inetd %G/${repo}"
	)

	tbegin "fetching from a repository with a merge commit"
	(
		git-r3_src_unpack
		test_file "${WORKDIR}/${P}/file" some-more-text \
			&& test_file "${WORKDIR}/${P}/file2" other-text
	) &>fetch.log

	eend ${?} || cat fetch.log
}

test_repo_merge_revert() {
	local repo=${FUNCNAME#test_}
	local P=${P}_${repo}

	(
		mkdir ${repo}
		cd ${repo}
		git init -q
		echo test > file
		git add file
		git commit -m 1 -q
		git checkout -q -b other
		echo other-text > file2
		git add file2
		git commit -m 2 -q
		git checkout -q master
		echo some-more-text > file
		git add file
		git commit -m 3 -q
		git merge -m 4 -q other
		git revert -n -m 1 HEAD
		git commit -m 5 -q
	) || die "unable to prepare repo"

	# we need to use an array to preserve whitespace
	local EGIT_REPO_URI=(
		"ext::git daemon --export-all --base-path=. --inetd %G/${repo}"
	)

	tbegin "fetching from a repository with a reverted merge commit"
	(
		git-r3_src_unpack
		test_file "${WORKDIR}/${P}/file" some-more-text \
			&& test_no_file "${WORKDIR}/${P}/file2"
	) &>fetch.log

	eend ${?} || cat fetch.log
}

test_repo_merge_revert2() {
	local repo=${FUNCNAME#test_}
	local P=${P}_${repo}

	(
		mkdir ${repo}
		cd ${repo}
		git init -q
		echo test > file
		git add file
		git commit -m 1 -q
		git checkout -q -b other
		echo other-text > file2
		git add file2
		git commit -m 2 -q
		git checkout -q master
		echo some-more-text > file
		git add file
		git commit -m 3 -q
		git merge -m 4 -q other
		git revert -n -m 2 HEAD
		git commit -m 5 -q
	) || die "unable to prepare repo"

	# we need to use an array to preserve whitespace
	local EGIT_REPO_URI=(
		"ext::git daemon --export-all --base-path=. --inetd %G/${repo}"
	)

	tbegin "fetching from a repository with a reverted merge commit (other way)"
	(
		git-r3_src_unpack
		test_file "${WORKDIR}/${P}/file" test \
			&& test_file "${WORKDIR}/${P}/file2" other-text
	) &>fetch.log

	eend ${?} || cat fetch.log
}

test_repo_clean
test_repo_revert
test_repo_merge
test_repo_merge_revert
test_repo_merge_revert2

texit
