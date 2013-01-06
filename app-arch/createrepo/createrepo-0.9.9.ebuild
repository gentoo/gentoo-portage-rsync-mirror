# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/createrepo/createrepo-0.9.9.ebuild,v 1.1 2012/05/15 08:55:21 pacho Exp $

EAPI="4"
PYTHON_DEPEND="2:2.7"
PYTHON_USE_WITH="xml"

inherit python eutils

DESCRIPTION="Creates a common metadata repository"
HOMEPAGE="http://createrepo.baseurl.org/"
SRC_URI="http://createrepo.baseurl.org/download/${P}.tar.gz
	http://dev.gentoo.org/~pacho/maintainer-needed/${PN}-0.9.9-head.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/urlgrabber-2.9.0
	>=app-arch/rpm-4.1.1[python]
	dev-libs/libxml2[python]
	>=app-arch/deltarpm-3.6_pre20110223[python]
	dev-python/pyliblzma
	>=sys-apps/yum-3.4.3"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${WORKDIR}/${PN}-0.9.9-head.patch"
	epatch "${FILESDIR}/${PN}-0.9.9-ten-changelog-limit.patch"

	sed -i -e '/^sysconfdir/s:=.*/:=/:' Makefile || die
}

src_compile() { :; }

src_install() {
	emake install DESTDIR="${D}"
	dodoc ChangeLog README
	python_convert_shebangs -r 2 "${ED}"
}
