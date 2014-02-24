# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/git-r3.eclass,v 1.25 2014/02/24 08:43:34 mgorny Exp $

# @ECLASS: git-r3.eclass
# @MAINTAINER:
# Michał Górny <mgorny@gentoo.org>
# @BLURB: Eclass for fetching and unpacking git repositories.
# @DESCRIPTION:
# Third generation eclass for easing maitenance of live ebuilds using
# git as remote repository.

case "${EAPI:-0}" in
	0|1|2|3|4|5)
		;;
	*)
		die "Unsupported EAPI=${EAPI} (unknown) for ${ECLASS}"
		;;
esac

if [[ ! ${_GIT_R3} ]]; then

inherit eutils

fi

EXPORT_FUNCTIONS src_unpack

if [[ ! ${_GIT_R3} ]]; then

if [[ ! ${_INHERITED_BY_GIT_2} ]]; then
	DEPEND="dev-vcs/git"
fi

# @ECLASS-VARIABLE: EGIT3_STORE_DIR
# @DESCRIPTION:
# Storage directory for git sources.
#
# EGIT3_STORE_DIR=${DISTDIR}/git3-src

# @ECLASS-VARIABLE: EGIT_REPO_URI
# @REQUIRED
# @DESCRIPTION:
# URIs to the repository, e.g. git://foo, https://foo. If multiple URIs
# are provided, the eclass will consider them as fallback URIs to try
# if the first URI does not work.
#
# It can be overriden via env using ${PN}_LIVE_REPO variable.
#
# Can be a whitespace-separated list or an array.
#
# Example:
# @CODE
# EGIT_REPO_URI="git://a/b.git https://c/d.git"
# @CODE

# @ECLASS-VARIABLE: EVCS_OFFLINE
# @DEFAULT_UNSET
# @DESCRIPTION:
# If non-empty, this variable prevents any online operations.

# @ECLASS-VARIABLE: EGIT_BRANCH
# @DEFAULT_UNSET
# @DESCRIPTION:
# The branch name to check out. If unset, the upstream default (HEAD)
# will be used.
#
# It can be overriden via env using ${PN}_LIVE_BRANCH variable.

# @ECLASS-VARIABLE: EGIT_COMMIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# The tag name or commit identifier to check out. If unset, newest
# commit from the branch will be used. If set, EGIT_BRANCH will
# be ignored.
#
# It can be overriden via env using ${PN}_LIVE_COMMIT variable.

# @ECLASS-VARIABLE: EGIT_CHECKOUT_DIR
# @DESCRIPTION:
# The directory to check the git sources out to.
#
# EGIT_CHECKOUT_DIR=${WORKDIR}/${P}

# @FUNCTION: _git-r3_env_setup
# @INTERNAL
# @DESCRIPTION:
# Set the eclass variables as necessary for operation. This can involve
# setting EGIT_* to defaults or ${PN}_LIVE_* variables.
_git-r3_env_setup() {
	debug-print-function ${FUNCNAME} "$@"

	local esc_pn livevar
	esc_pn=${PN//[-+]/_}

	livevar=${esc_pn}_LIVE_REPO
	EGIT_REPO_URI=${!livevar:-${EGIT_REPO_URI}}
	[[ ${!livevar} ]] \
		&& ewarn "Using ${livevar}, no support will be provided"

	livevar=${esc_pn}_LIVE_BRANCH
	EGIT_BRANCH=${!livevar:-${EGIT_BRANCH}}
	[[ ${!livevar} ]] \
		&& ewarn "Using ${livevar}, no support will be provided"

	livevar=${esc_pn}_LIVE_COMMIT
	EGIT_COMMIT=${!livevar:-${EGIT_COMMIT}}
	[[ ${!livevar} ]] \
		&& ewarn "Using ${livevar}, no support will be provided"

	# Migration helpers. Remove them when git-2 is removed.

	if [[ ${EGIT_SOURCEDIR} ]]; then
		eerror "EGIT_SOURCEDIR has been replaced by EGIT_CHECKOUT_DIR. While updating"
		eerror "your ebuild, please check whether the variable is necessary at all"
		eerror "since the default has been changed from \${S} to \${WORKDIR}/\${P}."
		eerror "Therefore, proper setting of S may be sufficient."
		die "EGIT_SOURCEDIR has been replaced by EGIT_CHECKOUT_DIR."
	fi

	if [[ ${EGIT_MASTER} ]]; then
		eerror "EGIT_MASTER has been removed. Instead, the upstream default (HEAD)"
		eerror "is used by the eclass. Please remove the assignment or use EGIT_BRANCH"
		eerror "as necessary."
		die "EGIT_MASTER has been removed."
	fi

	if [[ ${EGIT_HAS_SUBMODULES} ]]; then
		eerror "EGIT_HAS_SUBMODULES has been removed. The eclass no longer needs"
		eerror "to switch the clone type in order to support submodules and therefore"
		eerror "submodules are detected and fetched automatically."
		die "EGIT_HAS_SUBMODULES is no longer necessary."
	fi

	if [[ ${EGIT_PROJECT} ]]; then
		eerror "EGIT_PROJECT has been removed. Instead, the eclass determines"
		eerror "the local clone path using path in canonical EGIT_REPO_URI."
		eerror "If the current algorithm causes issues for you, please report a bug."
		die "EGIT_PROJECT is no longer necessary."
	fi

	if [[ ${EGIT_BOOTSTRAP} ]]; then
		eerror "EGIT_BOOTSTRAP has been removed. Please create proper src_prepare()"
		eerror "instead."
		die "EGIT_BOOTSTRAP has been removed."
	fi

	if [[ ${EGIT_NOUNPACK} ]]; then
		eerror "EGIT_NOUNPACK has been removed. The eclass no longer calls default"
		eerror "unpack function. If necessary, please declare proper src_unpack()."
		die "EGIT_NOUNPACK has been removed."
	fi
}

# @FUNCTION: _git-r3_set_gitdir
# @USAGE: <repo-uri>
# @INTERNAL
# @DESCRIPTION:
# Obtain the local repository path and set it as GIT_DIR. Creates
# a new repository if necessary.
#
# <repo-uri> may be used to compose the path. It should therefore be
# a canonical URI to the repository.
_git-r3_set_gitdir() {
	debug-print-function ${FUNCNAME} "$@"

	local repo_name=${1#*://*/}

	# strip the trailing slash
	repo_name=${repo_name%/}

	# strip common prefixes to make paths more likely to match
	# e.g. git://X/Y.git vs https://X/git/Y.git
	# (but just one of the prefixes)
	case "${repo_name}" in
		# gnome.org... who else?
		browse/*) repo_name=${repo_name#browse/};;
		# cgit can proxy requests to git
		cgit/*) repo_name=${repo_name#cgit/};;
		# pretty common
		git/*) repo_name=${repo_name#git/};;
		# gentoo.org
		gitroot/*) repo_name=${repo_name#gitroot/};;
		# google code, sourceforge
		p/*) repo_name=${repo_name#p/};;
		# kernel.org
		pub/scm/*) repo_name=${repo_name#pub/scm/};;
	esac
	# ensure a .git suffix, same reason
	repo_name=${repo_name%.git}.git
	# now replace all the slashes
	repo_name=${repo_name//\//_}

	local distdir=${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}
	: ${EGIT3_STORE_DIR:=${distdir}/git3-src}

	GIT_DIR=${EGIT3_STORE_DIR}/${repo_name}

	if [[ ! -d ${EGIT3_STORE_DIR} ]]; then
		(
			addwrite /
			mkdir -m0755 -p "${EGIT3_STORE_DIR}" || die
		) || die "Unable to create ${EGIT3_STORE_DIR}"
	fi

	addwrite "${EGIT3_STORE_DIR}"
	if [[ -e ${GIT_DIR}/shallow ]]; then
		einfo "${GIT_DIR} was a shallow clone, recreating..."
		rm -r "${GIT_DIR}" || die
	fi
	if [[ ! -d ${GIT_DIR} ]]; then
		mkdir "${GIT_DIR}" || die
		git init --bare || die
	fi
}

# @FUNCTION: _git-r3_set_submodules
# @USAGE: <file-contents>
# @INTERNAL
# @DESCRIPTION:
# Parse .gitmodules contents passed as <file-contents>
# as in "$(cat .gitmodules)"). Composes a 'submodules' array that
# contains in order (name, URL, path) for each submodule.
_git-r3_set_submodules() {
	debug-print-function ${FUNCNAME} "$@"

	local data=${1}

	# ( name url path ... )
	submodules=()

	local l
	while read l; do
		# submodule.<path>.path=<path>
		# submodule.<path>.url=<url>
		[[ ${l} == submodule.*.url=* ]] || continue

		l=${l#submodule.}
		local subname=${l%%.url=*}

		# skip modules that have 'update = none', bug #487262.
		local upd=$(echo "${data}" | git config -f /dev/fd/0 \
			submodule."${subname}".update)
		[[ ${upd} == none ]] && continue

		submodules+=(
			"${subname}"
			"$(echo "${data}" | git config -f /dev/fd/0 \
				submodule."${subname}".url || die)"
			"$(echo "${data}" | git config -f /dev/fd/0 \
				submodule."${subname}".path || die)"
		)
	done < <(echo "${data}" | git config -f /dev/fd/0 -l || die)
}

# @FUNCTION: _git-r3_is_local_repo
# @USAGE: <repo-uri>
# @INTERNAL
# @DESCRIPTION:
# Determine whether the given URI specifies a local (on-disk)
# repository.
_git-r3_is_local_repo() {
	debug-print-function ${FUNCNAME} "$@"

	local uri=${1}

	[[ ${uri} == file://* || ${uri} == /* ]]
}

# @FUNCTION: git-r3_fetch
# @USAGE: [<repo-uri> [<remote-ref> [<local-id>]]]
# @DESCRIPTION:
# Fetch new commits to the local clone of repository.
#
# <repo-uri> specifies the repository URIs to fetch from, as a space-
# -separated list. The first URI will be used as repository group
# identifier and therefore must be used consistently. When not
# specified, defaults to ${EGIT_REPO_URI}.
#
# <remote-ref> specifies the remote ref or commit id to fetch.
# It is preferred to use 'refs/heads/<branch-name>' for branches
# and 'refs/tags/<tag-name>' for tags. Other options are 'HEAD'
# for upstream default branch and hexadecimal commit SHA1. Defaults
# to the first of EGIT_COMMIT, EGIT_BRANCH or literal 'HEAD' that
# is set to a non-null value.
#
# <local-id> specifies the local branch identifier that will be used to
# locally store the fetch result. It should be unique to multiple
# fetches within the repository that can be performed at the same time
# (including parallel merges). It defaults to ${CATEGORY}/${PN}/${SLOT%/*}.
# This default should be fine unless you are fetching multiple trees
# from the same repository in the same ebuild.
#
# The fetch operation will affect the EGIT_STORE only. It will not touch
# the working copy, nor export any environment variables.
# If the repository contains submodules, they will be fetched
# recursively.
git-r3_fetch() {
	debug-print-function ${FUNCNAME} "$@"

	[[ ${EVCS_OFFLINE} ]] && return

	local repos
	if [[ ${1} ]]; then
		repos=( ${1} )
	elif [[ $(declare -p EGIT_REPO_URI) == "declare -a"* ]]; then
		repos=( "${EGIT_REPO_URI[@]}" )
	else
		repos=( ${EGIT_REPO_URI} )
	fi

	local branch=${EGIT_BRANCH:+refs/heads/${EGIT_BRANCH}}
	local remote_ref=${2:-${EGIT_COMMIT:-${branch:-HEAD}}}
	local local_id=${3:-${CATEGORY}/${PN}/${SLOT%/*}}
	local local_ref=refs/git-r3/${local_id}/__main__

	[[ ${repos[@]} ]] || die "No URI provided and EGIT_REPO_URI unset"

	local -x GIT_DIR
	_git-r3_set_gitdir "${repos[0]}"

	# try to fetch from the remote
	local r success
	for r in "${repos[@]}"; do
		einfo "Fetching ${r} ..."

		local fetch_command=(
			git fetch --prune "${r}"
			# mirror the remote branches as local branches
			"refs/heads/*:refs/heads/*"
			# pull tags explicitly in order to prune them properly
			"refs/tags/*:refs/tags/*"
			# notes in case something needs them
			"refs/notes/*:refs/notes/*"
		)

		set -- "${fetch_command[@]}"
		echo "${@}" >&2
		if "${@}"; then
			# now let's see what the user wants from us
			local full_remote_ref=$(
				git rev-parse --verify --symbolic-full-name "${remote_ref}"
			)

			if [[ ${full_remote_ref} ]]; then
				# when we are given a ref, create a symbolic ref
				# so that we preserve the actual argument
				set -- git symbolic-ref "${local_ref}" "${full_remote_ref}"
			else
				# otherwise, we were likely given a commit id
				set -- git update-ref --no-deref "${local_ref}" "${remote_ref}"
			fi

			echo "${@}" >&2
			if ! "${@}"; then
				die "Referencing ${remote_ref} failed (wrong ref?)."
			fi

			success=1
			break
		fi
	done
	[[ ${success} ]] || die "Unable to fetch from any of EGIT_REPO_URI"

	# recursively fetch submodules
	if git cat-file -e "${local_ref}":.gitmodules &>/dev/null; then
		local submodules
		_git-r3_set_submodules \
			"$(git cat-file -p "${local_ref}":.gitmodules || die)"

		while [[ ${submodules[@]} ]]; do
			local subname=${submodules[0]}
			local url=${submodules[1]}
			local path=${submodules[2]}
			local commit=$(git rev-parse "${local_ref}:${path}")

			if [[ ! ${commit} ]]; then
				die "Unable to get commit id for submodule ${subname}"
			fi
			if [[ ${url} == ./* || ${url} == ../* ]]; then
				local subrepos=( "${repos[@]/%//${url}}" )
			else
				local subrepos=( "${url}" )
			fi

			git-r3_fetch "${subrepos[*]}" "${commit}" "${local_id}/${subname}"

			submodules=( "${submodules[@]:3}" ) # shift
		done
	fi
}

# @FUNCTION: git-r3_checkout
# @USAGE: [<repo-uri> [<checkout-path> [<local-id>]]]
# @DESCRIPTION:
# Check the previously fetched tree to the working copy.
#
# <repo-uri> specifies the repository URIs, as a space-separated list.
# The first URI will be used as repository group identifier
# and therefore must be used consistently with git-r3_fetch.
# The remaining URIs are not used and therefore may be omitted.
# When not specified, defaults to ${EGIT_REPO_URI}.
#
# <checkout-path> specifies the path to place the checkout. It defaults
# to ${EGIT_CHECKOUT_DIR} if set, otherwise to ${WORKDIR}/${P}.
#
# <local-id> needs to specify the local identifier that was used
# for respective git-r3_fetch.
#
# The checkout operation will write to the working copy, and export
# the repository state into the environment. If the repository contains
# submodules, they will be checked out recursively.
git-r3_checkout() {
	debug-print-function ${FUNCNAME} "$@"

	local repos
	if [[ ${1} ]]; then
		repos=( ${1} )
	elif [[ $(declare -p EGIT_REPO_URI) == "declare -a"* ]]; then
		repos=( "${EGIT_REPO_URI[@]}" )
	else
		repos=( ${EGIT_REPO_URI} )
	fi

	local out_dir=${2:-${EGIT_CHECKOUT_DIR:-${WORKDIR}/${P}}}
	local local_id=${3:-${CATEGORY}/${PN}/${SLOT%/*}}

	local -x GIT_DIR
	_git-r3_set_gitdir "${repos[0]}"

	einfo "Checking out ${repos[0]} to ${out_dir} ..."

	if ! git cat-file -e refs/git-r3/"${local_id}"/__main__; then
		if [[ ${EVCS_OFFLINE} ]]; then
			die "No local clone of ${repos[0]}. Unable to work with EVCS_OFFLINE."
		else
			die "Logic error: no local clone of ${repos[0]}. git-r3_fetch not used?"
		fi
	fi
	local remote_ref=$(
		git symbolic-ref --quiet refs/git-r3/"${local_id}"/__main__
	)
	local new_commit_id=$(
		git rev-parse --verify refs/git-r3/"${local_id}"/__main__
	)

	set -- git clone --quiet --shared --no-checkout "${GIT_DIR}" "${out_dir}"/
	echo "${@}" >&2
	"${@}" || die "git clone (for checkout) failed"

	git-r3_sub_checkout() {
		local orig_repo=${GIT_DIR}
		local -x GIT_DIR=${out_dir}/.git
		local -x GIT_WORK_TREE=${out_dir}

		# pull notes
		git fetch "${orig_repo}" "refs/notes/*:refs/notes/*" || die

		set -- git checkout --quiet
		if [[ ${remote_ref} ]]; then
			set -- "${@}" "${remote_ref#refs/heads/}"
		else
			set -- "${@}" "${new_commit_id}"
		fi
		echo "${@}" >&2
		"${@}" || die "git checkout ${remote_ref:-${new_commit_id}} failed"
	}
	git-r3_sub_checkout

	local old_commit_id=$(
		git rev-parse --quiet --verify refs/git-r3/"${local_id}"/__old__
	)
	if [[ ! ${old_commit_id} ]]; then
		echo "GIT NEW branch -->"
		echo "   repository:               ${repos[0]}"
		echo "   at the commit:            ${new_commit_id}"
	else
		# diff against previous revision
		echo "GIT update -->"
		echo "   repository:               ${repos[0]}"
		# write out message based on the revisions
		if [[ "${old_commit_id}" != "${new_commit_id}" ]]; then
			echo "   updating from commit:     ${old_commit_id}"
			echo "   to commit:                ${new_commit_id}"

			git --no-pager diff --stat \
				${old_commit_id}..${new_commit_id}
		else
			echo "   at the commit:            ${new_commit_id}"
		fi
	fi
	git update-ref --no-deref refs/git-r3/"${local_id}"/{__old__,__main__} || die

	# recursively checkout submodules
	if [[ -f ${out_dir}/.gitmodules ]]; then
		local submodules
		_git-r3_set_submodules \
			"$(<"${out_dir}"/.gitmodules)"

		while [[ ${submodules[@]} ]]; do
			local subname=${submodules[0]}
			local url=${submodules[1]}
			local path=${submodules[2]}

			if [[ ${url} == ./* || ${url} == ../* ]]; then
				url=${repos[0]%%/}/${url}
			fi

			git-r3_checkout "${url}" "${out_dir}/${path}" \
				"${local_id}/${subname}"

			submodules=( "${submodules[@]:3}" ) # shift
		done
	fi

	# keep this *after* submodules
	export EGIT_DIR=${GIT_DIR}
	export EGIT_VERSION=${new_commit_id}
}

# @FUNCTION: git-r3_peek_remote_ref
# @USAGE: [<repo-uri> [<remote-ref>]]
# @DESCRIPTION:
# Peek the reference in the remote repository and print the matching
# (newest) commit SHA1.
#
# <repo-uri> specifies the repository URIs to fetch from, as a space-
# -separated list. When not specified, defaults to ${EGIT_REPO_URI}.
#
# <remote-ref> specifies the remote ref to peek.  It is preferred to use
# 'refs/heads/<branch-name>' for branches and 'refs/tags/<tag-name>'
# for tags. Alternatively, 'HEAD' may be used for upstream default
# branch. Defaults to the first of EGIT_COMMIT, EGIT_BRANCH or literal
# 'HEAD' that is set to a non-null value.
#
# The operation will be done purely on the remote, without using local
# storage. If commit SHA1 is provided as <remote-ref>, the function will
# fail due to limitations of git protocol.
#
# On success, the function returns 0 and writes hexadecimal commit SHA1
# to stdout. On failure, the function returns 1.
git-r3_peek_remote_ref() {
	debug-print-function ${FUNCNAME} "$@"

	local repos
	if [[ ${1} ]]; then
		repos=( ${1} )
	elif [[ $(declare -p EGIT_REPO_URI) == "declare -a"* ]]; then
		repos=( "${EGIT_REPO_URI[@]}" )
	else
		repos=( ${EGIT_REPO_URI} )
	fi

	local branch=${EGIT_BRANCH:+refs/heads/${EGIT_BRANCH}}
	local remote_ref=${2:-${EGIT_COMMIT:-${branch:-HEAD}}}

	[[ ${repos[@]} ]] || die "No URI provided and EGIT_REPO_URI unset"

	local r success
	for r in "${repos[@]}"; do
		einfo "Peeking ${remote_ref} on ${r} ..." >&2

		local is_branch lookup_ref
		if [[ ${remote_ref} == refs/heads/* || ${remote_ref} == HEAD ]]
		then
			is_branch=1
			lookup_ref=${remote_ref}
		else
			# ls-remote by commit is going to fail anyway,
			# so we may as well pass refs/tags/ABCDEF...
			lookup_ref=refs/tags/${remote_ref}
		fi

		# split on whitespace
		local ref=(
			$(git ls-remote "${r}" "${lookup_ref}")
		)

		if [[ ${ref[0]} ]]; then
			echo "${ref[0]}"
			return 0
		fi
	done

	return 1
}

git-r3_src_fetch() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ ! ${EGIT3_STORE_DIR} && ${EGIT_STORE_DIR} ]]; then
		ewarn "You have set EGIT_STORE_DIR but not EGIT3_STORE_DIR. Please consider"
		ewarn "setting EGIT3_STORE_DIR for git-r3.eclass. It is recommended to use"
		ewarn "a different directory than EGIT_STORE_DIR to ease removing old clones"
		ewarn "when git-2 eclass becomes deprecated."
	fi

	_git-r3_env_setup
	git-r3_fetch
}

git-r3_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	_git-r3_env_setup
	git-r3_src_fetch
	git-r3_checkout
}

# https://bugs.gentoo.org/show_bug.cgi?id=482666
git-r3_pkg_outofdate() {
	debug-print-function ${FUNCNAME} "$@"

	local new_commit_id=$(git-r3_peek_remote_ref)
	ewarn "old: ${EGIT_VERSION}"
	ewarn "new: ${new_commit_id}"
	[[ ${new_commit_id} && ${old_commit_id} ]] || return 2

	[[ ${EGIT_VERSION} != ${new_commit_id} ]]
}

_GIT_R3=1
fi
