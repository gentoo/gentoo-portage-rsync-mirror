# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/asdf/asdf-2.26.ebuild,v 1.1 2012/12/14 12:34:46 grozin Exp $

EAPI=4

DESCRIPTION="ASDF is Another System Definition Facility for Common Lisp"
HOMEPAGE="http://common-lisp.net/project/asdf/"
SRC_URI="http://common-lisp.net/project/${PN}/archives/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="!dev-lisp/cl-${PN}
		!dev-lisp/asdf-binary-locations"

S="${WORKDIR}/${PN}"

CLSOURCEROOT="${ROOT%/}"/usr/share/common-lisp/source
CLSYSTEMROOT="${ROOT%/}"/usr/share/common-lisp/systems
CLPACKAGE="${PN}"

absolute-path-p() {
	[[ $# -eq 1 ]] || die "${FUNCNAME[0]} must receive one argument"
	[[ ${1} == /* ]]
}

common-lisp-install-one-source() {
	[[ $# -eq 3 ]] || die "${FUNCNAME[0]} must receive exactly three arguments"

	local fpredicate=${1}
	local source=${2}
	local target="${CLSOURCEROOT}/${CLPACKAGE}/${3}"

	if absolute-path-p "${source}" ; then
		die "Cannot install files with absolute path: ${source}"
	fi

	if ${fpredicate} "${source}" ; then
		insinto "${target}"
		doins "${source}"
	fi
}

lisp-file-p() {
	[[ $# -eq 1 ]] || die "${FUNCNAME[0]} must receive one argument"

	[[ ${1} =~ \.(lisp|lsp|cl)$ ]]
}

common-lisp-get-fpredicate() {
	[[ $# -eq 1 ]] || die "${FUNCNAME[0]} must receive one argument"

	local ftype=${1}
	case ${ftype} in
		"lisp") echo "lisp-file-p" ;;
		"all" ) echo "true" ;;
		* ) die "Unknown filetype specifier ${ftype}" ;;
	esac
}

common-lisp-install-sources() {
	local ftype="lisp"
	if [[ ${1} == "-t" ]] ; then
		ftype=${2}
		shift ; shift
	fi

	[[ $# -ge 1 ]] || die "${FUNCNAME[0]} must receive one non-option argument"

	local fpredicate=$(common-lisp-get-fpredicate "${ftype}")

	for path in "${@}" ; do
		if [[ -f ${path} ]] ; then
			common-lisp-install-one-source ${fpredicate} "${path}" "$(dirname "${path}")"
		elif [[ -d ${path} ]] ; then
			common-lisp-install-sources -t ${ftype} $(find "${path}" -type f)
		else
			die "${path} it neither a regular file nor a directory"
		fi
	done
}

common-lisp-install-one-asdf() {
	[[ $# != 1 ]] && die "${FUNCNAME[0]} must receive exactly one argument"

	# the suffix «.asd» is optional
	local source=${1/.asd}.asd
	common-lisp-install-one-source true "${source}" "$(dirname "${source}")"
	local target="${CLSOURCEROOT%/}/${CLPACKAGE}/${source}"
	dosym "${target}" "${CLSYSTEMROOT%/}/$(basename ${target})"
}

common-lisp-install-asdf() {
	dodir "${CLSYSTEMROOT}"

	[[ $# = 0 ]] && set - ${CLSYSTEMS}
	[[ $# = 0 ]] && set - $(find . -type f -name \*.asd)
	for sys in "${@}" ; do
		common-lisp-install-one-asdf ${sys}
	done
}

src_install() {
	common-lisp-install-sources {asdf,asdf-ecl,wild-modules}.lisp
	common-lisp-install-asdf asdf.asd
	dodoc README
}
