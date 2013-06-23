# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/yajl/yajl-2.0.4-r2.ebuild,v 1.1 2013/06/23 22:19:25 xmw Exp $

EAPI=5

inherit eutils cmake-multilib vcs-snapshot

DESCRIPTION="Small event-driven (SAX-style) JSON parser"
HOMEPAGE="http://lloyd.github.com/yajl/"
SRC_URI="http://github.com/lloyd/yajl/tarball/${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-fix_static_linking.patch
	if ! use static-libs ; then
		epatch "${FILESDIR}"/${P}-remove_static_lib.patch
	fi
}

src_test() {
	multilib_foreach_abi run_in_build_dir emake test
}
