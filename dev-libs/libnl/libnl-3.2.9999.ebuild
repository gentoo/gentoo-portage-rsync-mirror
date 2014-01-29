# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnl/libnl-3.2.9999.ebuild,v 1.4 2014/01/29 15:43:44 jer Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} python3_{2,3} )
DISTUTILS_OPTIONAL=1
inherit autotools distutils-r1 eutils git-r3 libtool multilib

DESCRIPTION="A collection of libraries providing APIs to netlink protocol based Linux kernel interfaces"
HOMEPAGE="http://www.infradead.org/~tgr/libnl/"
EGIT_REPO_URI="
	https://github.com/tgraf/libnl.git
"
LICENSE="LGPL-2.1 utils? ( GPL-2 )"
SLOT="3"
KEYWORDS=""
IUSE="static-libs python utils"

RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	sys-devel/flex
	sys-devel/bison
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DOCS=( ChangeLog )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.1-vlan-header.patch
	epatch "${FILESDIR}"/${PN}-3.2.20-rtnl_tc_get_ops.patch
	epatch "${FILESDIR}"/${PN}-3.2.20-cache-api.patch

	eautoreconf
}

src_configure() {
	econf \
		--disable-silent-rules \
		$(use_enable static-libs static) \
		$(use_enable utils cli)
}

src_compile() {
	default

	if use python; then
		cd "${S}"/python || die
		distutils-r1_src_compile
	fi
}

src_install() {
	default

	if use python; then
		# Unset DOCS= since distutils-r1.eclass interferes
		DOCS=''
		cd "${S}"/python || die
		distutils-r1_src_install
	fi

	prune_libtool_files $(usex static-libs --modules --all)
}
