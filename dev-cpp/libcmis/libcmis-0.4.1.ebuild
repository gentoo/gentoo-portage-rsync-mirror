# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libcmis/libcmis-0.4.1.ebuild,v 1.4 2014/12/28 21:28:58 dilfridge Exp $

EAPI=5

EGIT_REPO_URI="git://gitorious.org/libcmis/libcmis.git"
[[ ${PV} == 9999 ]] && SCM_ECLASS="git-2"
inherit eutils alternatives autotools ${SCM_ECLASS}
unset SCM_ECLASS

DESCRIPTION="C++ client library for the CMIS interface"
HOMEPAGE="https://sourceforge.net/projects/libcmis/"
[[ ${PV} == 9999 ]] || SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 MPL-1.1 )"
SLOT="0.4"

# Don't move KEYWORDS on the previous line or ekeyword won't work # 399061
[[ ${PV} == 9999 ]] || \
KEYWORDS="amd64 ~arm ~ppc x86 ~amd64-linux ~x86-linux"

IUSE="static-libs man test"

RDEPEND="
	!dev-cpp/libcmis:0
	!dev-cpp/libcmis:0.2
	!dev-cpp/libcmis:0.3
	!dev-cpp/libcmis:0.5
	dev-libs/boost:=
	dev-libs/libxml2
	net-misc/curl
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	man? (
		app-text/docbook2X
		dev-libs/libxslt
	)
	test? ( dev-util/cppunit )
"

src_prepare() {
	[[ ${PV} == 9999 ]] && eautoreconf
}

src_configure() {
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--program-suffix=-${SLOT} \
		--disable-werror \
		$(use_with man) \
		$(use_enable static-libs static) \
		$(use_enable test tests) \
		--disable-long-tests \
		--enable-client
}

src_install() {
	default
	prune_libtool_files --all
}

pkg_postinst() {
	alternatives_auto_makesym /usr/bin/cmis-client "/usr/bin/cmis-client-[0-9].[0-9]"
}

pkg_postrm() {
	alternatives_auto_makesym /usr/bin/cmis-client "/usr/bin/cmis-client-[0-9].[0-9]"
}
