# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/gitosis-gentoo/gitosis-gentoo-0.2_p20100721.ebuild,v 1.3 2012/06/04 20:57:17 zmedico Exp $

EAPI=3
PYTHON_DEPEND="2"

inherit eutils distutils user

DESCRIPTION="gitosis -- software for hosting git repositories, Gentoo fork"
HOMEPAGE="http://git.overlays.gentoo.org/gitweb/?p=proj/gitosis-gentoo.git"
# This is a snapshot taken from the Gentoo overlays gitweb.
MY_GITREV="9f39956b8b10e4952cdf0efb8462efd55c71926b"
MY_PV="${PV}"
MY_P="${PN}-${MY_PV}" # identical to P for now
SRC_URI="http://git.overlays.gentoo.org/gitweb/?p=proj/gitosis-gentoo.git;a=snapshot;h=refs/tags/${PV};sf=tbz2 -> ${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""
DEPEND_GIT=">=dev-vcs/git-1.5.6.4"
DEPEND="${DEPEND_GIT}
		>=dev-python/setuptools-0.6_rc5"
RDEPEND="${DEPEND}
		!dev-vcs/gitosis"

S="${WORKDIR}/${MY_P}"

DOCS="example.conf gitweb.conf lighttpd-gitweb.conf TODO.rst"
PYTHON_MODNAME="gitosis"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	enewgroup git
	enewuser git -1 /bin/sh /var/spool/gitosis git
}

src_install() {
	distutils_src_install
	keepdir /var/spool/gitosis
	fowners git:git /var/spool/gitosis
}

# We should handle more of this, but it requires the input of an SSH public key
# from the user, and they may want to set up more configuration first.
#pkg_config() {
#}

pkg_postinst() {
	distutils_pkg_postinst
	einfo "If you need to actually use gitosis, you must unlock the git user."
}
