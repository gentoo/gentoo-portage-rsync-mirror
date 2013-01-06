# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/stgit/stgit-0.15-r1.ebuild,v 1.7 2011/10/12 17:48:52 mgorny Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils bash-completion-r1

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
# So keep an eye on it for the future. Reference should be the online
# man pages. (As of this writing, they use 8.2.7).
DEPEND="$RDEPEND
	doc? (
		=app-text/asciidoc-8.2*
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

src_prepare() {
	# setup.cfg defaults to ~ ... delete it instead of sed'ing
	rm setup.cfg
	distutils_src_prepare
}

src_compile() {
	# git throws errors if it cannot write its config file
	# thus feed it a dummy one
	touch gitconfig
	export GIT_CONFIG="${S}/gitconfig"

	# preparation stuff done in the makefile
	emake build || die "emake build failed"

	if use doc; then
		emake doc || die "emake doc failed"
	fi

	# do not call normal 'emake' s.t. Gentoo's Python handling
	# can do its work
	distutils_src_compile
}

src_install() {
	distutils_src_install

	if use doc; then
		# do not use 'emake install-*' as the pathes are wrong
		# and fixing them is more work than just using the following
		doman Documentation/*.1 || die "doman failed"
		dohtml Documentation/*.html || die "dohtml failed"
	fi

	newbashcomp stgit-completion.bash ${PN} || die
}
