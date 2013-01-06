# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/stgit/stgit-0.16-r1.ebuild,v 1.3 2012/11/20 20:59:17 ago Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit eutils distutils bash-completion-r1

DESCRIPTION="Manage a stack of patches using GIT as a backend"
HOMEPAGE="http://www.procode.org/stgit/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-missing-patches.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="doc"

RDEPEND=">=dev-vcs/git-1.6.3.3"

# NOTE: It seems to be quite important which asciidoc version to use.
# So keep an eye on it for the future.
DEPEND="$RDEPEND
	doc? (
		app-text/asciidoc
		app-text/xmlto
		dev-lang/perl
	)"

pkg_setup () {
	if ! use doc; then
		echo
		ewarn "Manpages will not be built and installed."
		ewarn "Enable the 'doc' useflag, if you want them."
		echo
	fi

	python_set_active_version 2
	python_pkg_setup
}

src_prepare () {
	epatch "${FILESDIR}/${P}-asciidoc-compat.patch"
	epatch "${FILESDIR}/${P}-man-linkfix.patch"

	# this will be a noop, as we are working with a tarball,
	# but throws git errors --> just get rid of it
	sed -i -e 's/version\.write_builtin_version()//' setup.py

	distutils_src_prepare
}

src_compile() {
	# do not call normal 'emake' s.t. Gentoo's Python handling
	# can do its work
	# NB: run before doc-building to avoid double-build
	distutils_src_compile

	if use doc; then
		emake DESTDIR="${D}" \
			htmldir="${ROOT}usr/share/doc/${PF}/html/" \
			mandir="${ROOT}usr/share/man/" \
			doc || die "emake doc failed"
	fi
}

src_install() {
	if use doc; then
		emake DESTDIR="${D}" \
			htmldir="${ROOT}usr/share/doc/${PF}/html/" \
			mandir="${ROOT}usr/share/man/" \
			install-doc install-html || die "emake install-doc install-html failed"
	fi

	# NB: run after installing docs to avoid double-build
	distutils_src_install

	newbashcomp stgit-completion.bash ${PN} || die
}
