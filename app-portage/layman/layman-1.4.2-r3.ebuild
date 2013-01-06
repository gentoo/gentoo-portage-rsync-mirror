# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/layman/layman-1.4.2-r3.ebuild,v 1.9 2012/11/06 07:17:09 dolsen Exp $

EAPI="2"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
PYTHON_USE_WITH="xml"

inherit eutils distutils

DESCRIPTION="Tool to manage Gentoo overlays."
HOMEPAGE="http://layman.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="bazaar cvs darcs git mercurial subversion test"

COMMON_DEPS="dev-lang/python"
DEPEND="${COMMON_DEPS}
	test? ( dev-vcs/subversion )"
RDEPEND="${COMMON_DEPS}
	bazaar? ( dev-vcs/bzr )
	cvs? ( dev-vcs/cvs )
	darcs? ( dev-vcs/darcs )
	git? ( dev-vcs/git )
	mercurial? ( dev-vcs/mercurial )
	subversion? (
		|| (
			>=dev-vcs/subversion-1.5.4[webdav-neon]
			>=dev-vcs/subversion-1.5.4[webdav-serf]
		)
	)"
RESTRICT_PYTHON_ABIS="2.4 3.*"

src_prepare() {
	epatch "${FILESDIR}/${P}-python-compatbility-fix.patch"
	epatch "${FILESDIR}/${P}-manpage-corrections.patch"
}

# Prevent running make
src_compile() {
	:
}

src_test() {
	testing() {
		for suite in layman/tests/{dtest,external}.py ; do
			PYTHONPATH="." "$(PYTHON)" ${suite} \
					|| die "test suite '${suite}' failed"
		done
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	dodir /etc/layman

	cp etc/* "${D}"/etc/layman/

	doman doc/layman.8
	dohtml doc/layman.8.html

	keepdir /var/lib/layman
}

pkg_postinst() {
	distutils_pkg_postinst
	einfo "You are now ready to add overlays into your system."
	einfo
	einfo "  layman -L"
	einfo
	einfo "will display a list of available overlays."
	einfo
	elog  "Select an overlay and add it using"
	elog
	elog  "  layman -a overlay-name"
	elog
	elog  "If this is the very first overlay you add with layman,"
	elog  "you need to append the following statement to your"
	# This relates to #441902 bug.
	if [[ -e "${ROOT}"/etc/portage/make.conf ]] ; then
		elog  "/etc/portage/make.conf file:"
	else
		elog "/etc/make.conf file:"
	fi
	elog
	elog  "  source /var/lib/layman/make.conf"
	elog
	elog  "If you modify the 'storage' parameter in the layman"
	elog  "configuration file (/etc/layman/layman.cfg) you will"
	elog  "need to adapt the path given above to the new storage"
	elog  "directory."
	elog
	ewarn "Please add the 'source' statement to make.conf only AFTER "
	ewarn "you added your first overlay. Otherwise portage will fail."
	epause 5
}
