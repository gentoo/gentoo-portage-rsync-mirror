# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cedet/cedet-1.0.1.ebuild,v 1.5 2012/02/01 17:17:10 ranger Exp $

EAPI=4
NEED_EMACS=22

inherit elisp

MY_P=${P/_}
DESCRIPTION="CEDET: Collection of Emacs Development Environment Tools"
HOMEPAGE="http://cedet.sourceforge.net/"
SRC_URI="mirror://sourceforge/cedet/${MY_P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris"
IUSE=""

S="${WORKDIR}/${MY_P}"
SITEFILE="50${PN}-gentoo.el"
EMACSFLAGS="${EMACSFLAGS} -L ${S}/eieio -L ${S}/semantic -L ${S}/srecode \
	-L ${S}/ede -L ${S}/speedbar -L ${S}/cogre"

src_compile() {
	emake -j1 \
		EMACS="${EMACS}" \
		EMACSFLAGS="${EMACSFLAGS}"
}

src_test() {
	emake -j1 \
		EMACS="${EMACS}" \
		EMACSFLAGS="${EMACSFLAGS}" \
		utest
}

src_install() {
	local target file dir
	find . -type d -name tests -prune -o -type f -print | while read target
	do
		file=${target##*/}
		dir=${target%/*}; dir=${dir#./}
		case "${file}" in
			*~ | Makefile | *.texi | *-script | PRERELEASE_CHECKLIST \
				| Project.ede | USING_CEDET_FROM_CVS | grammar-fw-ov.txt)
				;;
			ChangeLog | README | AUTHORS | *NEWS | INSTALL \
				| renamelist.txt | semanticdb.sh)
				docinto "${dir}"
				dodoc "${target}" ;;
			*.el | *.by | *.wy)
				# install grammar sources along with the elisp files, since
				# the location where semantic expects them is not configurable
				insinto "${SITELISP}/${PN}/${dir}"
				doins "${target}" ;;
			*.elc)
				# we are in a subshell, so collecting in a variable won't work
				echo "${target}" >>"${T}/elc-list.txt" ;;
			*.srt | *.xpm)
				insinto "${SITEETC}/${PN}/${dir}"
				doins "${target}" ;;
			*.info* | grammar-fw-ov.png)
				doinfo "${target}" ;;
			*)
				die "Unrecognised file ${target}" ;;
		esac
	done

	# make sure that the compiled elisp files have a later time stamp than
	# the corresponding sources, in order to suppress warnings at run time
	while read target; do
		dir=${target%/*}; dir=${dir#./}
		insinto "${SITELISP}/${PN}/${dir}"
		doins "${target}"
	done <"${T}/elc-list.txt"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}
