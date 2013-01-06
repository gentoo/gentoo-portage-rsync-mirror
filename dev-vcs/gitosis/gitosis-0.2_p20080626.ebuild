# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/gitosis/gitosis-0.2_p20080626.ebuild,v 1.4 2012/06/04 20:58:28 zmedico Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit eutils distutils user

DESCRIPTION="gitosis -- software for hosting git repositories"
HOMEPAGE="http://eagain.net/gitweb/?p=gitosis.git;a=summary"
# This is a snapshot taken from the upstream gitweb.
MY_PV="20080626-72c754b2f03a139122dc4a3877b05704fa88f751"
MY_PN="${PN}.git"
MY_P="${MY_PN}-${MY_PV}"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND_GIT=">=dev-vcs/git-1.5.3.6"
DEPEND="${DEPEND_GIT}
		>=dev-python/setuptools-0.6_rc5"
RDEPEND="${DEPEND}
		!dev-vcs/gitosis-gentoo"

S=${WORKDIR}/gitosis

DOCS="example.conf gitweb.conf lighttpd-gitweb.conf TODO.rst"

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
