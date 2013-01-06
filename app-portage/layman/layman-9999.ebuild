# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/layman/layman-9999.ebuild,v 1.27 2012/11/19 02:45:55 dolsen Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.6"
RESTRICT_PYTHON_ABIS="2.4 3.*"
PYTHON_USE_WITH="xml"

inherit eutils distutils git-2 prefix

DESCRIPTION="Tool to manage Gentoo overlays"
HOMEPAGE="http://layman.sourceforge.net"
SRC_URI=""
EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/layman.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="bazaar cvs darcs +git gpg mercurial subversion test"

COMMON_DEPS="dev-lang/python"
DEPEND="${COMMON_DEPS}
	test? ( dev-vcs/subversion )
	app-text/asciidoc"
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
	)
	gpg? ( =dev-python/pyGPG-9999 )
	"

src_prepare() {
	eprefixify etc/layman.cfg layman/config.py
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

src_compile() {
	distutils_src_compile
	# override MAKEOPTS to prevent build failure
	emake -j1 -C doc || die "emake -C doc failed"
}

src_install() {
	distutils_src_install

	insinto /etc/layman
	doins etc/layman.cfg || die

	doman doc/layman.8
	dohtml doc/layman.8.html

	keepdir /var/lib/layman
	keepdir /etc/layman/overlays
}

pkg_postinst() {
	distutils_pkg_postinst

	# now run layman's update utility
	einfo "Running layman-updater..."
	"${EROOT}"/usr/bin/layman-updater
	einfo
}
