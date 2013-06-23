# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libdom/libdom-0.0.1.ebuild,v 1.2 2013/06/23 16:44:31 xmw Exp $

EAPI=5

inherit netsurf

DESCRIPTION="implementation of the W3C DOM, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libdom/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="expat test xml"

RDEPEND=">=dev-libs/libparserutils-0.1.2[static-libs?,${MULTILIB_USEDEP}]
	>=dev-libs/libwapcaplet-0.2.0[static-libs?,${MULTILIB_USEDEP}]
	>=net-libs/libhubbub-0.2.0[static-libs?,${MULTILIB_USEDEP}]
	xml? (
		expat? ( dev-libs/expat[static-libs?]
			amd64? ( abi_x86_32? ( app-emulation/emul-linux-x86-baselibs[development] ) ) )
		!expat? ( dev-libs/libxml2[static-libs?]
			amd64? ( abi_x86_32? ( app-emulation/emul-linux-x86-baselibs[development] ) ) )
	)"
DEPEND="${RDEPEND}
	test? ( dev-lang/perl
		dev-perl/XML-XPath
		dev-perl/libxml-perl
		perl-core/Switch )"

REQUIRED_USE="test? ( xml )"

src_configure() {
	netsurf_src_configure

	netsurf_makeconf+=(
		WITH_EXPAT_BINDING=$(usex xml $(usex expat yes no) no)
		WITH_LIBXML_BINDING=$(usex xml $(usex expat no yes) no)
	)
}
