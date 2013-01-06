# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/flaggie/flaggie-0.2.ebuild,v 1.7 2012/08/31 09:13:52 mgorny Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

inherit base bash-completion-r1 distutils

DESCRIPTION="A smart CLI mangler for package.* files"
HOMEPAGE="https://bitbucket.org/mgorny/flaggie/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~mips x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=sys-apps/portage-2.1.8.3"

src_prepare() {
	base_src_prepare
	distutils_src_prepare
}

src_install() {
	distutils_src_install

	newbashcomp contrib/bash-completion/${PN}.bash-completion ${PN}
}

pkg_postinst() {
	distutils_pkg_postinst

	ewarn "Please denote that flaggie creates backups of your package.* files"
	ewarn "before performing each change through appending a single '~'."
	ewarn "If you'd like to keep your own backup of them, please use another"
	ewarn "naming scheme (or even better some VCS)."
	elog
	elog "bash-completion support requires:"
	elog "	app-shells/gentoo-bashcomp"
	has_version app-shells/gentoo-bashcomp && \
		elog "(installed already)"
}
